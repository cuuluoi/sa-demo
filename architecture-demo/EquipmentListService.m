//
//  EquipmentListService.m
//  architecture-demo
//
//  Created by Cừu Lười on 2/10/14.
//  Copyright (c) 2014 Cừu Lười. All rights reserved.
//

#import "EquipmentListService.h"
#import "EquipmentModel.h"
#import "EquipmentListCellInfo.h"
#import "UtilManager.h"
#import "EquipmentDAO.h"

@interface EquipmentListService()

@property (nonatomic) NSInteger currentOffset;
@property (nonatomic) NSInteger limited;
@property (nonatomic, strong) NSMutableDictionary *equipmentDict;

@end

@implementation EquipmentListService

- (id)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(equipmentsChangedDatabase:)
                                                     name:@"EquipmentChangedDatabase"
                                                   object:nil];
        _currentOffset = 0;
        _limited = 100;
        _equipments = [NSMutableArray array];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"EquipmentChangedDatabase" object:nil];
}

- (void)loadData {// Load 100 first element
    _equipments = [NSMutableArray array];
    _currentOffset = 0;
    _equipmentDict = [NSMutableDictionary dictionary];
    [self loadMoreEquipment];
}

- (void)equipmentsChangedDatabase:(NSNotification *)noti {
    [[UtilManager manager] addExecuteLogicBlock:^{
        NSDictionary *dict = [noti object];
        NSArray *updatedObject = [dict objectForKey:@"DatabaseUpdatedObject"];
        if (updatedObject && updatedObject.count) {
            for (Equipment *equipment in updatedObject) {
                EquipmentModel *model = [[EquipmentModel alloc] init];
                model.entity = equipment;
                EquipmentListCellInfo *infoModel = [_equipmentDict objectForKey:model.equipmentIdentifierString];
                if (infoModel) {
                    [infoModel setModel:model];
                    [_equipmentDict setObject:infoModel forKey:model.equipmentIdentifierString];
                }
            }
        }
        
        _equipments = [[[_equipmentDict allValues] sortedArrayUsingComparator:^NSComparisonResult(EquipmentListCellInfo *obj1, EquipmentListCellInfo *obj2) {
            return [obj1.model.equipmentIdentifierString compare:obj2.model.equipmentIdentifierString];
        }] mutableCopy];
        _currentOffset = _equipments.count;
        if (_equipmentListDidLoad) {
            dispatch_async(dispatch_get_main_queue(), ^{
                _equipmentListDidLoad(self);
            });
        }
    }];
}

- (NSString *)equipmentListTitle {
    NSInteger count = 0;
    if (_equipments) {
        count = _equipments.count;
    }
    return [NSString stringWithFormat:@"Equipments (%i)", count];
}

- (void)loadMoreEquipment {
    [[UtilManager manager] addExecuteLogicBlock:^{
        EquipmentDAO *eDao = [[EquipmentDAO alloc] init];
        NSArray *array = [eDao equipmentsListOffset:_currentOffset limit:_limited];
        for (EquipmentModel *eqModel in array) {
            EquipmentListCellInfo *eqInfo = [[EquipmentListCellInfo alloc] init];
            eqInfo.model = eqModel;
            [_equipmentDict setObject:eqInfo forKey:eqInfo.model.equipmentIdentifierString];
        }
        _equipments = [[[_equipmentDict allValues] sortedArrayUsingComparator:^NSComparisonResult(EquipmentListCellInfo *obj1, EquipmentListCellInfo *obj2) {
            return [obj1.model.equipmentIdentifierString compare:obj2.model.equipmentIdentifierString];
        }] mutableCopy];
        _currentOffset = _equipments.count;
        if (_equipmentListDidLoad) {
            dispatch_async(dispatch_get_main_queue(), ^{
                _equipmentListDidLoad(self);
            });
        }
    }];
}

@end
