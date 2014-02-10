//
//  Lib.h
//  Customer
//
//  Created by Quach Ngoc Tam on 12/23/13.
//  Copyright (c) 2013 El Nino. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Lib : NSObject

// Date time
+(NSString *)convertToLocalTimezone:(NSString *)UTCTime
                      withUTCFormat:(NSString *)timeFormat
                     andLocalFormat:(NSString *)localTimeFormat;

+(NSString *)convertToUTCTimezone:(NSString *)localTime
                  withLocalFormat:(NSString *)localTimeFormat
                     andUTCFormat:(NSString *)UTCTimeFormat;

@end
