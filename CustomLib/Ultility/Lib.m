//
//  Lib.m
//  Customer
//
//  Created by Quach Ngoc Tam on 12/23/13.
//  Copyright (c) 2013 El Nino. All rights reserved.
//

#import "Lib.h"
#import "UtilManager.h"
@implementation Lib


#pragma mark - date time converter
+ (NSString *)convertToUTCTimezone:(NSString *)localTime withLocalFormat:(NSString *)localTimeFormat andUTCFormat:(NSString *)UTCTimeFormat
{
    // local time format
    NSString * UTCTime = nil;
    
    NSDateFormatter* df_utc = [[UtilManager manager] serverFormater];
    [df_utc setDateFormat:UTCTimeFormat];
    
    NSDateFormatter* df_local = [[UtilManager manager] localFormater];;
    
    [df_local setDateFormat:localTimeFormat];
    
    NSDate * localDate = [df_local dateFromString:localTime];
    
    UTCTime = [df_utc stringFromDate:localDate];
    
    return UTCTime;
}

+ (NSString *)convertToLocalTimezone:(NSString *)UTCTime
                       withUTCFormat:(NSString *)timeFormat
                      andLocalFormat:(NSString *)localTimeFormat
{
	// local time format
	NSString * localTime = nil;
	
	NSDateFormatter* df_utc = [[UtilManager manager] serverFormater];
    //	[df_utc setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:-3600*7]];
	[df_utc setDateFormat:timeFormat];
	
	NSDateFormatter* df_local = [[UtilManager manager] localFormater];;
	[df_local setDateFormat:localTimeFormat];
	
	NSDate * utcDate = [df_utc dateFromString:UTCTime];
	
	localTime = [df_local stringFromDate:utcDate];
	
	return localTime;
}

+ (BOOL)isAllWhiteSpaces:(NSString *)rawString {
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmed = [rawString stringByTrimmingCharactersInSet:whitespace];
    if ([trimmed length] == 0) {
        return YES;
    }
    
    return NO;
}

@end
