//
//  EquipmentListJSON.m
//  architecture-demo
//
//  Created by Cừu Lười on 2/18/14.
//  Copyright (c) 2014 Cừu Lười. All rights reserved.
//

#import "EquipmentListJSON.h"
#import "EquipmentJSON.h"

@implementation EquipmentListJSON

+ (NSDictionary *)classMaping {
    return @{@"equipment":NSStringFromClass([EquipmentJSON class])};
}

@end
