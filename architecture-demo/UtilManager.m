//
//  UtilManager.m
//  architecture-demo
//
//  Created by Cừu Lười on 2/10/14.
//  Copyright (c) 2014 Cừu Lười. All rights reserved.
//

#import "UtilManager.h"
#import "SerialOperationQueue.h"

@interface UtilManager()

@property (nonatomic, strong) SerialOperationQueue *logicQueue;
@property (nonatomic, strong) SerialOperationQueue *writeQueue;

@end

@implementation UtilManager

+ (instancetype)manager{
	static dispatch_once_t predicate;
	static UtilManager *instance = nil;
	dispatch_once(&predicate, ^{instance = [[self alloc] init];});
	return instance;
}

- (id)init
{
    self = [super init];
    if (self) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *dbPath = [documentsDirectory stringByAppendingPathComponent:@"database.sqlite"];
        _databaseQueue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
        
        _sessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        
        _serverFormater = [[NSDateFormatter alloc] init];
        [_serverFormater setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
        [_serverFormater setDateFormat:UTC_TIME_FORMAT];
        
        _localFormater = [[NSDateFormatter alloc] init];
        [_localFormater setTimeZone:[NSTimeZone localTimeZone]];
    }
    return self;
}

- (SerialOperationQueue *)logicQueue {
    if (!_logicQueue) {
        _logicQueue = [[SerialOperationQueue alloc] init];
    }
    return _logicQueue;
}

- (SerialOperationQueue *)writeQueue {
    if (!_writeQueue) {
        _writeQueue = [[SerialOperationQueue alloc] init];
    }
    return _writeQueue;
}

- (void)addExecuteLogicBlock:(void (^)())block {
    NSBlockOperation *operation = [[NSBlockOperation alloc] init];
    [operation addExecutionBlock:block];
    [self.logicQueue addOperation:operation];
}

- (void)addExecuteWriteDataBlock:(void (^)())block {
    NSBlockOperation *operation = [[NSBlockOperation alloc] init];
    [operation addExecutionBlock:block];
    [self.writeQueue addOperation:operation];
}

- (void)fakeServerChanged {
    [self addExecuteLogicBlock:^{
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *resorcesPath = [documentsDirectory stringByAppendingPathComponent:@"equipment.json"];
        NSData *data = [NSData dataWithContentsOfFile:resorcesPath];
        NSDictionary *dict = [JsonLiteObjC objectFromData:data];
        NSInteger currentYear = [(NSString *)[[[dict objectForKey:@"equipment"] firstObject] objectForKey:@"modelYear"] integerValue];
        NSInteger newYear = currentYear + 1;
        NSString *jsonString = [NSString stringWithContentsOfFile:resorcesPath encoding:NSUTF8StringEncoding error:NULL];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"\"modelYear\": \"%i\"", currentYear] withString:[NSString stringWithFormat:@"\"modelYear\": \"%i\"", newYear]];
        NSData *data1 = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        [data1 writeToFile:resorcesPath atomically:YES];
    }];
}

@end