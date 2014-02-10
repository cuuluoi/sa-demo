//
//  DBEnviroment.h
//  LocalStorage
//
//  Created by El Nino on 6/22/13.
//  Copyright (c) 2013 El Nino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabaseQueue+InMemory.h"

@interface DBEnviroment : NSObject

@property (nonatomic, strong) NSString *databasePath;
@property (nonatomic, strong) FMDatabaseQueue *databaseQueue;

- (BOOL)loadScriptFile:(NSString *)filePath;
- (BOOL)loadScriptFile:(NSString *)filePath delimiter:(NSString *)delimiter;

- (NSArray *)classifyQuerry:(NSString *)scriptString ;
@end
