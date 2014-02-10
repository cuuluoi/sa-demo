//
//  EquipmentDAO.m
//  architecture-demo
//
//  Created by Cừu Lười on 2/10/14.
//  Copyright (c) 2014 Cừu Lười. All rights reserved.
//

#import "EquipmentDAO.h"
#import "UtilManager.h"
#import "Equipment.h"
#import "ResulSetComposion.h"
#import "EquipmentModel.h"
@interface EquipmentDAO()

@property (nonatomic, strong) FMDatabaseQueue *databaseQueue;

@end

@implementation EquipmentDAO

- (id)init
{
    self = [super init];
    if (self) {
        _databaseQueue = [UtilManager manager].databaseQueue;
    }
    return self;
}

- (BOOL)importObjectList:(NSArray *)array {
    __block BOOL val = NO;
    [_databaseQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        for (Equipment *equipment in array) {
            BOOL checkEquipment = [self checkExist:equipment inDB:db];
            if (checkEquipment) {
                val = [self updateObject:equipment inDB:db];
            } else {
                val = [self insertObject:equipment inDB:db];
            }
        }
        [db closeOpenResultSets];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"EquipmentChangedDatabase" object:nil];
        });
    }];
    return val;
}

- (BOOL)checkExist:(Equipment *)equipment inDB:(FMDatabase *)db {
    NSString *stm = [NSString stringWithFormat:@"select equipmentid from equipment where equipmentwebid = %@", equipment.equipmentWebId];
    FMResultSet *r = [db executeQuery:stm];
    ResulSetComposion *rc = [[ResulSetComposion alloc] initWithResulSet:r];
    if ([rc next]) {
        equipment.equipmentId = [rc objectForColumnIndex:0];
    }
    [rc close];
    return (equipment.equipmentId)? YES:NO;
}

- (BOOL)updateObject:(Equipment *)equipment inDB:(FMDatabase *)db {
    NSString *stm = [equipment updateStmString];
    return [db executeUpdate:stm];
}

- (BOOL)insertObject:(Equipment *)equipment inDB:(FMDatabase *)db {
    NSString *stm = [equipment insertStmString];
    BOOL val = [db executeUpdate:stm];
    equipment.equipmentId = @([db lastInsertRowId]);
    return val;
}

- (NSArray *)equipmentsList {
    __block NSMutableArray *array = [NSMutableArray array];
    [_databaseQueue inDatabase:^(FMDatabase *db) {
        NSString *stm = @"select * from equipment";
        FMResultSet *r = [db executeQuery:stm];
        ResulSetComposion *rc = [[ResulSetComposion alloc] initWithResulSet:r];
        while ([rc next]) {
            Equipment *equipment = [[Equipment alloc] init];
            equipment.equipmentId = [rc objectForColumnIndex:0];
            equipment.equipmentWebId = [rc objectForColumnIndex:1];
            equipment.serial = [rc objectForColumnIndex:2];
            equipment.product = [rc objectForColumnIndex:3];
            equipment.equipmentDescription = [rc objectForColumnIndex:4];
            equipment.modelYear = [rc objectForColumnIndex:5];
            equipment.lastPMDate = [rc objectForColumnIndex:6];
            EquipmentModel *eqModel = [[EquipmentModel alloc] init];
            eqModel.entity = equipment;
            [array addObject:eqModel];
        }
    }];
    return array;
}

@end
