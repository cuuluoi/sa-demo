//
//  NSObject+Additional.h
//  jsonkit-app
//
//  Created by Cừu Lười on 2/17/14.
//  Copyright (c) 2014 Cừu Lười. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Additional)

- (NSDictionary *)propertiesListAndValue;

- (NSArray *)propertiesArray;

+ (NSDictionary *)classMaping;

- (NSString *)jsonString;

@end
