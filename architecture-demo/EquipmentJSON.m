//
//  EquipmentJSON.m
//  architecture-demo
//
//  Created by Cừu Lười on 2/18/14.
//  Copyright (c) 2014 Cừu Lười. All rights reserved.
//

#import "EquipmentJSON.h"
#import "ProductJSON2.h"
#import "Equipment.h"

@interface EquipmentJSON()
@end

@implementation EquipmentJSON

+ (NSDictionary *)classMaping {
    return @{@"product":NSStringFromClass([ProductJSON2 class])};
}

- (Equipment *)entityMaping {
    Equipment *equipment = [[Equipment alloc] init];
    equipment.equipmentWebId = self.webId;
    equipment.serial = self.serial;
    equipment.equipmentDescription = self.description;
    equipment.modelYear = self.modelYear;
    equipment.lastPMDate = self.lastPMDate;
    equipment.product = [self.product jsonString];
    return equipment;
}
@end
