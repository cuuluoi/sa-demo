//
//  ServerManager.m
//  architecture-demo
//
//  Created by Cừu Lười on 2/10/14.
//  Copyright (c) 2014 Cừu Lười. All rights reserved.
//

#import "ServerManager.h"
#import "EquipmentSync.h"
#import "UtilManager.h"

@implementation ServerManager

+ (instancetype)manager {
	static dispatch_once_t predicate;
	static ServerManager *instance = nil;
	dispatch_once(&predicate, ^{instance = [[self alloc] init];});
	return instance;
}

- (void)syncObjectsFromServer {
    [[UtilManager manager] fakeServerChanged];
    EquipmentSync *eSync = [[EquipmentSync alloc] init];
    [eSync syncObjects];
    eSync.objectsDidSyncComplete = ^(EquipmentSync *sender) {
       NSLog(@"sync complete");
    };
}

@end
