//
//  NSDictionary+Additional.m
//  jsonkit-app
//
//  Created by Cừu Lười on 2/17/14.
//  Copyright (c) 2014 Cừu Lười. All rights reserved.
//

#import "NSDictionary+Additional.h"
#import "NSObject+Additional.h"
#import "NSArray+Additional.h"
#import <objc/runtime.h>

NSString * const ktransformClass = @"kNewPropertyKey";

@implementation NSDictionary (Additional)

@dynamic transformClass;

- (id)transFormObject {
    
    Class type = [self transformClass];
    
    id object = [[type alloc] init];
    
    if (object) {
        NSArray *properties = [object propertiesArray];
        for (NSString *property in properties) {
            id value = [self objectForKey:property];
            if ([value isKindOfClass:[NSArray class]]) {
                NSString *class = [[type classMaping] objectForKey:property];
                if (class && ![class isKindOfClass:[NSNull class]] && class.length) {
                    [(NSArray *)value setChildClass:NSClassFromString(class)];
                }
                value = [(NSArray *)value childList];
            }
            if ([value isKindOfClass:[NSDictionary class]]) {
                NSString *class = [[type classMaping] objectForKey:property];
                if (class && ![class isKindOfClass:[NSNull class]] && class.length) {
                    [(NSDictionary *)value setTransformClass:NSClassFromString(class)];
                }
                value = [(NSDictionary *)value transFormObject];
            }
            [object setValue:value forKey:property];
        }
    } else {
        object = self;
    }
    return object;
}

- (void)setTransformClass:(Class)transformClass {
    objc_setAssociatedObject(self, (__bridge const void *)(ktransformClass), transformClass, OBJC_ASSOCIATION_ASSIGN);
}

- (Class)transformClass {
    return objc_getAssociatedObject(self, (__bridge const void *)(ktransformClass));
}

@end
