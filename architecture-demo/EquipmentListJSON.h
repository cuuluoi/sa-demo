//
//  EquipmentListJSON.h
//  architecture-demo
//
//  Created by Cừu Lười on 2/18/14.
//  Copyright (c) 2014 Cừu Lười. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EquipmentListJSON : NSObject

@property (nonatomic, strong) NSNumber *success;
@property (nonatomic, strong) NSNumber *total;
@property (nonatomic, strong) NSString *requestDate;
@property (nonatomic, strong) NSArray *equipment;

@end
