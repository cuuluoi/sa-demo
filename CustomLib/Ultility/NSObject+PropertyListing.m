//
//  NSObject+PropertyListing.m
//  DSL462_iOS
//
//  Created by El Nino on 4/4/13.
//  Copyright (c) 2013 El Nino. All rights reserved.
//

#import "NSObject+PropertyListing.h"
#import <objc/runtime.h>

@implementation NSObject (PropertyListing)

-(NSDictionary *)propertiesListAndValue {
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc] initWithFormat:@"%s",property_getName(property)];
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        if (propertyValue) [props setObject:propertyValue forKey:propertyName];
    }
    free(properties);
    return props;
}

-(NSArray *)propertiesArray {
    NSMutableArray *props = [[NSMutableArray alloc] init];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc] initWithFormat:@"%s",property_getName(property)];
        [props addObject:propertyName];
    }
    free(properties);
    return props;
}

@end
