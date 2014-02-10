//
//  NSObject+PropertyListing.h
//  DSL462_iOS
//
//  Created by El Nino on 4/4/13.
//  Copyright (c) 2013 El Nino. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ObjectEntityProtocol <NSObject>

@end


@interface NSObject (PropertyListing)

- (NSDictionary *)propertiesListAndValue;
- (NSArray *)propertiesArray;

@end
