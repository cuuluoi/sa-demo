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

@implementation EquipmentListService

- (id)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(equipmentsChangedDatabase:)
                                                     name:@"EquipmentChangedDatabase"
                                                   object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"EquipmentChangedDatabase" object:nil];
}

- (void)loadData {
    [[UtilManager manager] addExecuteLogicBlock:^{
        EquipmentDAO *eDao = [[EquipmentDAO alloc] init];
        NSArray *array = [eDao equipmentsList];
        NSMutableArray *tmpArray = [NSMutableArray array];
        for (EquipmentModel *eqModel in array) {
            EquipmentListCellInfo *eqInfo = [[EquipmentListCellInfo alloc] init];
            eqInfo.model = eqModel;
            [tmpArray addObject:eqInfo];
        }
        _equipments = [tmpArray copy];
        if (_equipmentListDidLoad) {
            dispatch_async(dispatch_get_main_queue(), ^{
                _equipmentListDidLoad(self);
            });
        }
    }];
}

- (void)equipmentsChangedDatabase:(id)sender {
    [self loadData];
}

@end
