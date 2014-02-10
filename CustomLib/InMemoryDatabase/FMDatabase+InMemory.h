//
//  FMDatabase+InMemory.h
//  DatabaseInMem
//
//  Created by El Nino on 7/1/13.
//  Copyright (c) 2013 El Nino. All rights reserved.
//

#import <FMDB/FMDatabase.h>

@interface FMDatabase (InMemory)


// Loads an on-disk representation into memory.
- (BOOL)readFromFile:(NSString*)filePath;

// Saves an in-memory representation to disk
- (BOOL)writeToFile:(NSString *)filePath;

@end
