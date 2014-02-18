//
//  Equipment.m
//  architecture-demo
//
//  Created by Cừu Lười on 2/10/14.
//  Copyright (c) 2014 Cừu Lười. All rights reserved.
//

#import "Equipment.h"

@implementation Equipment

- (NSString *)insertStmString {
    NSMutableString *stm = [[NSMutableString alloc] initWithFormat:@"insert into equipment("];
    NSArray *propertyArray = [self propertiesArray];
    NSMutableArray *proArrays = [NSMutableArray array];
    NSMutableArray *valArrays = [NSMutableArray array];
    NSString *primaryKey = @"equipmentId";
    for (int i = 0; i < propertyArray.count; i ++) {
        NSString *property = [propertyArray objectAtIndex:i];
        if ([property isEqualToString:primaryKey]) {
            continue;
        }
        id value = [self valueForKeyPath:property];
        if (value) {
            [proArrays addObject:property];
            if ([value isKindOfClass:[NSString class]]) {
                value = [(NSString *)value stringByReplacingOccurrencesOfString:@"'" withString:@"''"];
            }
            NSString *valString;
            if ([value isKindOfClass:[NSNumber class]]) {
                valString = [NSString stringWithFormat:@"%@", value];
            } else {
                valString = [NSString stringWithFormat:@"'%@'", value];
            }
            [valArrays addObject:valString];
        }
    }
    
    NSString *keyString = [proArrays componentsJoinedByString:@","];
    NSString *valueString = [valArrays componentsJoinedByString:@","];
    
    [stm appendFormat:@" %@) values( %@ )", keyString, valueString];
    return stm;
}

- (NSString *)updateStmString {
    NSString *priKey = @"equipmentId";
    NSMutableString *stm = [[NSMutableString alloc] initWithFormat:@"update equipment set "];
    NSArray *propertyArray = [self propertiesArray];
    NSMutableArray *valueArray = [NSMutableArray array];
    for (int i = 0; i < propertyArray.count; i ++) {
        NSString *property = [propertyArray objectAtIndex:i];
        if ([property isEqualToString:priKey]) {
            continue;
        }
        
        id value = [self valueForKeyPath:property];
        if (value) {
            if ([value isKindOfClass:[NSString class]]) {
                value = [(NSString *)value stringByReplacingOccurrencesOfString:@"'" withString:@"''"];
            }
            
            NSString *valString;
            if ([value isKindOfClass:[NSNumber class]]) {
                valString = [NSString stringWithFormat:@" %@ = %@", property, value];
            } else {
                valString = [NSString stringWithFormat:@" %@ = '%@'", property, value];
            }
            [valueArray addObject:valString];
        } else {
            NSString *valString = [NSString stringWithFormat:@" %@ = NULL", property];
            [valueArray addObject:valString];
        }
    }
    
    NSString *arrayString = [valueArray componentsJoinedByString:@","];
    [stm appendFormat:@" %@", arrayString];
    
    id keyValue = [self valueForKeyPath:priKey];
    [stm appendFormat:@" where %@ = '%@'", priKey, keyValue];
    return stm;
}

@end
