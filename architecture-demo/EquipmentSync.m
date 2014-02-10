//
//  EquipmentSync.m
//  architecture-demo
//
//  Created by Cừu Lười on 2/10/14.
//  Copyright (c) 2014 Cừu Lười. All rights reserved.
//

#import "EquipmentSync.h"
#import "EquipmentSAO.h"
#import "EquipmentDAO.h"
#import "UtilManager.h"

@implementation EquipmentSync

- (void)syncObjects {
    [[UtilManager manager] addExecuteLogicBlock:^{
        EquipmentSAO *eSao = [[EquipmentSAO alloc] init];
        [eSao getObjectFromServer];
        eSao.didDownloadObjects = ^(EquipmentSAO *sender) {
            [[UtilManager manager] addExecuteWriteDataBlock:^{
                sleep(5);
                NSArray *equipments = sender.equipments;
                if (equipments) {
                    EquipmentDAO *eDao = [[EquipmentDAO alloc] init];
                    BOOL val = [eDao importObjectList:equipments];
                    if (val) {
                        NSLog(@"sync equipments complete");
                    } else {
                        NSLog(@"sync equipment fail");
                    }
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (_objectsDidSyncComplete) {
                        _objectsDidSyncComplete(self);
                    }
                });
            }];
            
        };
    }];
    
}

@end
