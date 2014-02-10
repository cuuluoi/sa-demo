//
//  EquipmentSAO.h
//  architecture-demo
//
//  Created by Cừu Lười on 2/10/14.
//  Copyright (c) 2014 Cừu Lười. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EquipmentSAO : NSObject

- (void)getObjectFromServer;

@property (nonatomic, copy, readwrite) void(^didDownloadObjects)(EquipmentSAO *sender);

@property (nonatomic, strong) NSArray *equipments;

@end
