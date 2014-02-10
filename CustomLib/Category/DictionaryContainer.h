

//
//  DictionaryContainer.h
//  Service Logistics
//
//  Created by El Nino on 9/7/13.
//  Copyright (c) 2013 El Nino. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DictionaryContainer : NSObject

- (void)setObject:(id)object forKey:(id<NSCopying>)aKey;

- (id)objectForKey:(id<NSCopying>)aKey;

- (void)setDictionary:(NSDictionary *)aDictionary;
- (void)addDictionary:(NSDictionary *)aDictionary;

- (NSDictionary *)dictionary;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
