//
//  FMDatabaseQueue+InMemory.m
//  DatabaseInMem
//
//  Created by El Nino on 7/1/13.
//  Copyright (c) 2013 El Nino. All rights reserved.
//

#import "FMDatabaseQueue+InMemory.h"
#import "FMDatabase+InMemory.h"

@implementation FMDatabaseQueue (InMemory)

-(id)initInMemoryWithPath:(NSString *)path {
    if (self = [self initWithPath:path]) {
        _db = [[FMDatabase alloc] initWithPath:nil];
        if ([_db open]) {
            if ([_db readFromFile:path]) {
            }
        }
    }
    return self;
}

-(BOOL)saveToDisk {
    BOOL val = [_db writeToFile:_path];
    [self close];
    return val;
}

@end
