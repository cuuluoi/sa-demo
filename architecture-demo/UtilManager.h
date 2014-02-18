//
//  UtilManager.h
//  architecture-demo
//
//  Created by Cừu Lười on 2/10/14.
//  Copyright (c) 2014 Cừu Lười. All rights reserved.
//

@interface UtilManager : NSObject

#define LOCAL_TIME_FORMAT @"MM/dd/yyyy HH:mm:ss"
#define LOCAL_DATE_FORMAT @"MM/dd/yyyy"
#define UTC_TIME_FORMAT @"yyyy-MM-dd'T'HH:mm:ss'Z'"

+ (instancetype)manager;

@property (nonatomic, strong) FMDatabaseQueue *databaseQueue;
@property (nonatomic, strong) AFURLSessionManager *sessionManager;

- (void)addExecuteLogicBlock:(void(^)())block;
- (void)addExecuteWriteDataBlock:(void(^)())block;

@property (nonatomic, strong) NSDateFormatter *serverFormater;
@property (nonatomic, strong) NSDateFormatter *localFormater;

- (void)fakeServerChanged;

@end