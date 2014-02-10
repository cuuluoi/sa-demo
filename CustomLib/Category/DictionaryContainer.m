//
//  DictionaryContainer.m
//  Service Logistics
//
//  Created by El Nino on 9/7/13.
//  Copyright (c) 2013 El Nino. All rights reserved.
//

#import "DictionaryContainer.h"

@interface DictionaryContainer()

@property (strong) NSMutableDictionary *privateDict;

@end


@implementation DictionaryContainer

@synthesize privateDict = _privateDict;

- (id)init
{
    self = [super init];
    if (self) {
        _privateDict = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    DictionaryContainer *sut = [[DictionaryContainer alloc] init];
    sut.dictionary = dict;
    return sut;
}

- (void)setDictionary:(NSDictionary *)aDictionary {
    _privateDict = [aDictionary mutableCopy];
}

- (void)addDictionary:(NSDictionary *)aDictionary{
    [_privateDict setValuesForKeysWithDictionary:aDictionary];
}

- (NSDictionary *)dictionary {
    return [_privateDict copy];
}

- (void)setObject:(id)object forKey:(id<NSCopying>)aKey {
    if (!object) {
        object = [NSNull null];
    }
    [_privateDict setObject:object forKey:aKey];
}

- (id)objectForKey:(id<NSCopying>)aKey {
    id object = [_privateDict objectForKey:aKey];
    if ([object isEqual:[NSNull null]]) {
        object = nil;
    }
    return object;
}

@end
