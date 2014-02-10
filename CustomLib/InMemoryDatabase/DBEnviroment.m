//
//  DBEnviroment.m
//  LocalStorage
//
//  Created by El Nino on 6/22/13.
//  Copyright (c) 2013 El Nino. All rights reserved.
//

#import "DBEnviroment.h"
#import "QuerryStatement.h"
#import <FMDB/FMDatabase.h>
#import <FMDB/FMDatabaseQueue.h>

@interface DBEnviroment()

@property (nonatomic, strong) NSString *delimiter;

@end

@implementation DBEnviroment

@synthesize databaseQueue = _dbQueue;
@synthesize databasePath = _databasePath;
@synthesize delimiter = _delimiter;

#define EmptyDatabaseName @"EmptyDatabase.db"

-(id)init{
    if (self = [super init]) {
        NSString *lastComFromDBPath = EmptyDatabaseName;
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        
        NSString *dbPathDestination = [documentsDirectory stringByAppendingPathComponent:lastComFromDBPath];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        if ([fileManager fileExistsAtPath:dbPathDestination]) {
            [fileManager removeItemAtPath:dbPathDestination error:nil];
        }
        
        [fileManager createFileAtPath:dbPathDestination contents:nil attributes:nil];
        
        if ([fileManager fileExistsAtPath:dbPathDestination]) {
            _databasePath = dbPathDestination;
            _dbQueue = [[FMDatabaseQueue alloc] initInMemoryWithPath:dbPathDestination];
        }
        _delimiter = @";";
    }
    return self;
}

- (void)dealloc {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:_databasePath]) {
        [fileManager removeItemAtPath:_databasePath error:nil];
    }
}

-(BOOL )loadScriptFile:(NSString *)filePath {
    __block BOOL loadScriptSuccess = NO;
    [_dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        NSString *script = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        NSArray *querry = [self classifyQuerry:script];
        for (QuerryStatement *qstm in querry) {
            if (qstm.type == QuerryStatementTypeQuery) {
                [db executeQuery:qstm.stm];
            } else {
                loadScriptSuccess = [db executeUpdate:qstm.stm];
            }
        }
        
    }];
    return loadScriptSuccess;
}

- (NSArray *)classifyQuerry:(NSString *)scriptString {
    NSArray *queries = [scriptString componentsSeparatedByString:_delimiter];
    NSMutableArray *stmQuery = [[NSMutableArray alloc] init];
    for (NSString *query in queries) {
        if (query.length) {
            QuerryStatement *qStm = [[QuerryStatement alloc] init];
            if (([query rangeOfString:@"insert" options:NSCaseInsensitiveSearch].length == 6) ||
                ([query rangeOfString:@"update" options:NSCaseInsensitiveSearch].length == 6) ||
                ([query rangeOfString:@"delete" options:NSCaseInsensitiveSearch].length == 6) ||
                ([query rangeOfString:@"create" options:NSCaseInsensitiveSearch].length == 6)) {
                qStm.stm = [query copy];
                qStm.type = QuerryStatementTypeUpdate;
                [stmQuery addObject:qStm];
            }
            if (([query rangeOfString:@"select" options:NSCaseInsensitiveSearch].length == 6 )) {
                qStm.stm = [query copy];
                qStm.type = QuerryStatementTypeQuery;
                [stmQuery addObject:qStm];
            }
        }
    }
    return stmQuery;
}
+ (NSBundle *)frameworkBundle {
    static NSBundle* frameworkBundle = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        NSString* mainBundlePath = [[NSBundle mainBundle] resourcePath];
        NSString* frameworkBundlePath = [mainBundlePath stringByAppendingPathComponent:@"LocalStorageResouce.bundle"];
        frameworkBundle = [NSBundle bundleWithPath:frameworkBundlePath];
    });
    return frameworkBundle;
}

-(BOOL)loadScriptFile:(NSString *)filePath delimiter:(NSString *)delimiter {
    _delimiter = [delimiter copy];
    return [self loadScriptFile:filePath];
}
                            

@end
