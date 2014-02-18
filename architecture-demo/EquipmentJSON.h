//
//  EquipmentJSON.h
//  architecture-demo
//
//  Created by Cừu Lười on 2/18/14.
//  Copyright (c) 2014 Cừu Lười. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ProductJSON2;
@class Equipment;

@interface EquipmentJSON : NSObject

@property (nonatomic, strong) NSNumber *webId;
@property (nonatomic, strong) NSString *serial;
@property (nonatomic, strong) ProductJSON2 *product;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *modelYear;
@property (nonatomic, strong) NSString *lastPMDate;

- (Equipment *)entityMaping;

@end
