//
//  ResulSetComposion.m
//  Customer
//
//  Created by Cừu Lười on 12/26/13.
//  Copyright (c) 2013 El Nino. All rights reserved.
//

#import "ResulSetComposion.h"

#import <FMDB/FMResultSet.h>

@implementation ResulSetComposion

- (instancetype)initWithResulSet:(FMResultSet *)set {
    if (self = [super init]) {
        _resulSet = set;
    }
    return self;
}

- (BOOL)next {
    return [_resulSet next];
}

- (id)objectForColumnIndex:(NSInteger)index {
    id object = [_resulSet objectForColumnIndex:index];
    if ([object isKindOfClass:[NSNull class]]) {
        object = nil;
    }
    return object;
}

- (id)objectForColumnName:(NSString *)string {
    id object = [_resulSet objectForColumnName:string];
    if ([object isKindOfClass:[NSNull class]]) {
        object = nil;
    }
    return object;
}

- (void)close {
    [_resulSet close];
}

@end
