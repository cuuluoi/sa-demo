//
//  Equipment.h
//  architecture-demo
//
//  Created by Cừu Lười on 2/10/14.
//  Copyright (c) 2014 Cừu Lười. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Equipment : NSObject

@property (nonatomic, strong) NSNumber *equipmentId;
@property (nonatomic, strong) NSNumber *equipmentWebId;
@property (nonatomic, strong) NSString *serial;
@property (nonatomic, strong) NSString *product;
@property (nonatomic, strong) NSString *equipmentDescription;
@property (nonatomic, strong) NSString *modelYear;
@property (nonatomic, strong) NSString *lastPMDate;

- (NSString *)updateStmString;
- (NSString *)insertStmString;

@end
