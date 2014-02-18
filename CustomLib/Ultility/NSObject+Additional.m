//
//  NSObject+Additional.m
//  jsonkit-app
//
//  Created by Cừu Lười on 2/17/14.
//  Copyright (c) 2014 Cừu Lười. All rights reserved.
//

#import "NSObject+Additional.h"
#import <objc/runtime.h>

@implementation NSObject (Additional)

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

+ (NSDictionary *)classMaping {
    return nil;
}

- (NSString *)jsonString {
    NSData *data = [NSJSONSerialization dataWithJSONObject:[self propertiesListAndValue] options:NSJSONWritingPrettyPrinted error:NULL];
    NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return result;
}

@end
