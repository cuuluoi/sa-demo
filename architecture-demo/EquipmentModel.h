//
//  EquipmentModel.h
//  architecture-demo
//
//  Created by Cừu Lười on 2/10/14.
//  Copyright (c) 2014 Cừu Lười. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Equipment;

@interface EquipmentModel : NSObject

@property (nonatomic, strong) NSString *serialString;
@property (nonatomic, strong) NSString *productCodeString;
@property (nonatomic, strong) NSString *makeString;
@property (nonatomic, strong) NSString *equipmentDescriptionString;
@property (nonatomic, strong) NSString *modelYearString;
@property (nonatomic, strong) NSString *lastPMDateString;

@property (nonatomic, strong) Equipment *entity;
@property (nonatomic, strong) NSDictionary *productDict;

@end
