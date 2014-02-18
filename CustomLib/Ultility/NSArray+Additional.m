//
//  NSArray+Additional.m
//  jsonkit-app
//
//  Created by Cừu Lười on 2/17/14.
//  Copyright (c) 2014 Cừu Lười. All rights reserved.
//

#import "NSArray+Additional.h"
#import "NSDictionary+Additional.h"
#import <objc/runtime.h>

NSString * const kchildClass = @"kNewPropertyKey";

@implementation NSArray (Additional)

@dynamic childClass;

- (NSArray *)childList {
    NSMutableArray *array = [NSMutableArray array];
    for (id object in self) {
        id realObject;
        if ([object isKindOfClass:[NSDictionary class]]) {
            Class class = self.childClass;
            if (class) {
                [(NSDictionary *)object setTransformClass:class];
            }
            realObject = [(NSDictionary *)object transFormObject];
        }
        if ([object isKindOfClass:[NSArray class]]) {
            realObject = [(NSArray *)object childList];
        }
        if (!realObject) {
            realObject = object;
        }
        [array addObject:realObject];
    }
    return array;
}

- (void)setChildClass:(Class)childClass {
    objc_setAssociatedObject(self, (__bridge const void *)(kchildClass), childClass, OBJC_ASSOCIATION_ASSIGN);
}

- (Class)childClass {
    return objc_getAssociatedObject(self, (__bridge const void *)(kchildClass));
}

@end
