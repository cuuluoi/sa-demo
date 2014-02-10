//
//  EquipmentSync.h
//  architecture-demo
//
//  Created by Cừu Lười on 2/10/14.
//  Copyright (c) 2014 Cừu Lười. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EquipmentSync : NSObject

- (void)syncObjects;

@property (nonatomic, copy, readwrite) void (^objectsDidSyncComplete)(EquipmentSync *sender);

@end
