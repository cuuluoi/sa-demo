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

+(NSString*)convertString:(NSString*)stringNumber{
    BOOL isNumberNegative = NO;
    double number = [stringNumber doubleValue];
    if (number<0) {
        number =-number;
        isNumberNegative = YES;
    }
    NSString *str = [NSString stringWithFormat:@"%.2f", number];
    NSArray *array = [str componentsSeparatedByString:@"."];
    NSString *stringReslut = @"";
    if ([array count]>1) {
        NSString *string_1 = [array objectAtIndex:0];
        NSMutableArray *arrayResutl = [[NSMutableArray alloc] init];
        if (string_1.length>3) {
            for (int i = 0; i<string_1.length; i++) {
                NSString *string = [string_1 substringWithRange:NSMakeRange(i, 1)];
                [arrayResutl addObject:string];
            }
        }else{
            stringReslut = string_1;
        }
        int count = 0;
        for (int i =[arrayResutl count]-1; i>=0; i--) {
            if (count==3) {
                stringReslut = [NSString stringWithFormat:@"%@,%@", [arrayResutl objectAtIndex:i], stringReslut];
                count = 0;
            }else{
                stringReslut = [NSString stringWithFormat:@"%@%@", [arrayResutl objectAtIndex:i], stringReslut];
            }
            count +=1;
        }
    }
    if ([array count]>1) {
        stringReslut = [NSString stringWithFormat:@"%@.%@", stringReslut, [array objectAtIndex:1]];
    }
    if (isNumberNegative) {
        stringReslut = [NSString stringWithFormat:@"-%@", stringReslut];
    }
    return stringReslut;
}

+ (CGFloat)caculateHeightForLabel:(UILabel *)label {
    CGRect labelFrame = label.frame;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        CGRect expectedFrame = [label.text boundingRectWithSize:CGSizeMake(label.frame.size.width, 9999)
                                                        options:NSStringDrawingUsesLineFragmentOrigin
                                                     attributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                 label.font, NSFontAttributeName,
                                                                 nil]
                                                        context:nil];
        labelFrame.size = expectedFrame.size;
        labelFrame.size.height = ceil(labelFrame.size.height); //iOS7 is not rounding up to the nearest whole number
    } else {
        #pragma GCC diagnostic ignored "-Wdeprecated-declarations"
        labelFrame.size = [label.text sizeWithFont:label.font
                                 constrainedToSize:CGSizeMake(label.frame.size.width, 9999)
                                     lineBreakMode:label.lineBreakMode];
        #pragma GCC diagnostic warning "-Wdeprecated-declarations"
    }
    
    return labelFrame.size.height;
}

+ (BOOL)isDownloadWithWebId:(NSString*)webId avatarKey:(NSString*)avatarKey{
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *folderPath = [NSString stringWithFormat:@"%@/%@", documentsDirectory, webId];
    NSString *path = [folderPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", avatarKey]];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        return NO;
    }
    return YES;
}

+ (NSString*)documentPath:(NSString*)name{
    NSArray* documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    NSString* documentDirectory = [documentDirectories objectAtIndex:0];
    NSString* documentDirectoryFilename = [documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", name]];
    return documentDirectoryFilename;
}

+ (void)saveImageInFolderWithWebId:(NSString*)WebId avatarKey:(NSString*)avatar image:(UIImage*)image{
    // save image in folder
    NSData *pngData = UIImageJPEGRepresentation(image, 1);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
    NSString *dataPath = [NSString stringWithFormat:@"%@/%@", documentsDirectory, WebId];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
        [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:nil];
    [pngData writeToFile:[NSString stringWithFormat:@"%@/%@.png", dataPath, avatar] atomically:YES];
    // end save image in folder
    
    NSUserDefaults *defaultAvatar = [NSUserDefaults standardUserDefaults];
    [defaultAvatar setObject:avatar forKey:@"avatarKey"];
    [defaultAvatar synchronize];
}

+ (void)removeImageInFolderWithWebId:(NSString*)webId  success:(void(^)(void))success{
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
    NSString *path = [NSString stringWithFormat:@"%@/%@", documentsDirectory, webId];
    NSArray *fileArray = [fileMgr contentsOfDirectoryAtPath:path error:nil];
    for (NSString *filename in fileArray)  {
        [fileMgr removeItemAtPath:[path stringByAppendingPathComponent:filename] error:NULL];
    }
    success();
}

+ (UIImage*)getImageWithAvatarkey:(NSString*)avatarKey webId:(NSString*)webId{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [NSString stringWithFormat:@"%@/%@", documentsDirectory, webId];
    NSString *getImagePath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", avatarKey]];
    UIImage *img = [UIImage imageWithContentsOfFile:getImagePath];
    return img;
}



+ (CGFloat)caculateHeightForText:(NSString *)text withWidthBound:(CGFloat)widthBound andFont:(UIFont *)font andBreakmode:(NSLineBreakMode)breakMode {
    CGSize expectedSize;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        CGRect expectedFrame = [text boundingRectWithSize:CGSizeMake(widthBound, 9999)
                                                        options:NSStringDrawingUsesLineFragmentOrigin
                                                     attributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                 font, NSFontAttributeName,
                                                                 nil]
                                                        context:nil];
        expectedSize = expectedFrame.size;
    } else {
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
        expectedSize = [text sizeWithFont:font
                                 constrainedToSize:CGSizeMake(widthBound, 9999)
                                     lineBreakMode:breakMode];
#pragma GCC diagnostic warning "-Wdeprecated-declarations"
    }
    
    return expectedSize.height;
}

+ (void)resizeHeightForLabel:(UILabel *)label {
    CGFloat newHeight = [Lib caculateHeightForLabel:label];
    
    [label setFrame:CGRectMake(label.frame.origin.x, label.frame.origin.y, label.frame.size.width, newHeight)];
}

+ (void)setLableAccessibility:(UILabel*)lable string:(NSString*)text {
    [lable setText:text];
    [lable setAccessibilityLabel:text];
    [Lib resizeHeightForLabel:lable];
}

+ (void)setView:(UIView *)view afterView:(UIView *)headView andBehindView:(UIView *)tailView withDistance:(CGFloat)distance {
    view.frame = CGRectMake(view.frame.origin.x,
                            CGRectGetMaxY(headView.frame) + distance,
                            view.frame.size.width,
                            view.frame.size.height);
    if (tailView) {
        tailView.frame = CGRectMake(tailView.frame.origin.x,
                                    CGRectGetMaxY(view.frame) + distance,
                                    tailView.frame.size.width,
                                    tailView.frame.size.height);
    }
}

+ (void)setView:(UIView *)view afterView:(UIView *)headView withDistance:(CGFloat)distance {
    [Lib setView:view afterView:headView andBehindView:nil withDistance:distance];
}

+ (void)setBoldForTextInLabel:(UILabel *)label withRange:(NSRange)range andBoldFont:(UIFont *)boldFont {
    if ([label respondsToSelector:@selector(setAttributedText:)])
    {
        // iOS6 and above : Use NSAttributedStrings
        // Create the attributes
        NSDictionary *attrs = @{NSFontAttributeName: label.font};
        NSDictionary *subAttrs = @{NSFontAttributeName: boldFont};
        
        // Create the attributed string (text + attributes)
        NSMutableAttributedString *attributedText =[[NSMutableAttributedString alloc] initWithString:label.text
                                                                                          attributes:attrs];
        [attributedText setAttributes:subAttrs range:range];
        
        // Set it in our UILabel and we are done!
        [label setAttributedText:attributedText];
    } else {
        // iOS5 and below
        // Here we have some options too. The first one is to do something
        // less fancy and show it just as plain text without attributes.
        // The second is to use CoreText and get similar results with a bit
        // more of code. Interested people please look down the old answer.
        
        // Now I am just being lazy so :p
    }
}

//+ (NSString*)convertToString:(NSDictionary*)dict{
//    NSString *string_result = @"";
//    NSArray *arrayAllKeys = [dict allKeys];
//    for (NSString *str in arrayAllKeys) {
//        string_result = [NSString]
//    }
//    return nil;
//}

+ (NSString *)currencyStringFromNumber:(NSNumber *)number {
    static NSNumberFormatter * numberFormatter;
    if (!numberFormatter) {
        numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
        [numberFormatter setCurrencyCode:@"USD"];
        [numberFormatter setNegativeFormat:@"(-)¤#,##0.00"];
        [numberFormatter setMinimumFractionDigits:2];
        [numberFormatter setMaximumFractionDigits:2];
    }
    NSString *string = [numberFormatter stringForObjectValue:number];
    return string;
}

+ (UILabel *)navigationTitleViewFromString:(NSString *)str {
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:17.0];
    label.text = str;
    label.frame = CGRectZero;
    [label sizeToFit];
    return label;
}


#pragma mark - bar button item
+ (UIBarButtonItem *)barButtonItemFromImage:(NSString *)imageName {
    UIImage *backButtonImage = [UIImage imageNamed:imageName];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:backButtonImage forState:UIControlStateNormal];
    backButton.frame = CGRectMake(0, 0, backButtonImage.size.width, backButtonImage.size.height);
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    return item;
}

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
