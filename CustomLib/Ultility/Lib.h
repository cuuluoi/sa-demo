//
//  Lib.h
//  Customer
//
//  Created by Quach Ngoc Tam on 12/23/13.
//  Copyright (c) 2013 El Nino. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Lib : NSObject
+(NSString*)convertString:(NSString*)stringNumber;

+ (void)resizeHeightForLabel:(UILabel *)label;

+ (CGFloat)caculateHeightForLabel:(UILabel *)label;

+ (CGFloat)caculateHeightForText:(NSString *)text
                  withWidthBound:(CGFloat)widthBound
                         andFont:(UIFont *)font
                    andBreakmode:(NSLineBreakMode)breakMode;

+ (void)setView:(UIView *)view
      afterView:(UIView *)headView
  andBehindView:(UIView *)tailView
   withDistance:(CGFloat)distance;

+ (void)setView:(UIView *)view
      afterView:(UIView *)headView
   withDistance:(CGFloat)distance;

+ (void)setLableAccessibility:(UILabel*)lable
                       string:(NSString*)text;

+ (void)setBoldForTextInLabel:(UILabel *)label withRange:(NSRange)range andBoldFont:(UIFont *)boldFont;

+ (NSString *)currencyStringFromNumber:(NSNumber *)number;

+ (UILabel *)navigationTitleViewFromString:(NSString *)str;

+ (CGFloat)getCurrentBoundWidth;

+ (BOOL)isDownloadWithWebId:(NSString*)webId avatarKey:(NSString*)avatarKey;

+ (void)removeImage:(NSString*)fileName;

+ (NSString*)documentPath:(NSString*)name;
+ (UIBarButtonItem *)barButtonItemFromImage:(NSString *)imageName;
+ (UIImage*)getImageWithAvatarkey:(NSString*)avatarKey webId:(NSString*)webId;
+ (void)removeImageInFolderWithWebId:(NSString*)webId  success:(void(^)(void))success;
+ (void)saveImageInFolderWithWebId:(NSString*)WebId avatarKey:(NSString*)avatar image:(UIImage*)image;

// Date time
+(NSString *)convertToLocalTimezone:(NSString *)UTCTime
                      withUTCFormat:(NSString *)timeFormat
                     andLocalFormat:(NSString *)localTimeFormat;

+(NSString *)convertToUTCTimezone:(NSString *)localTime
                  withLocalFormat:(NSString *)localTimeFormat
                     andUTCFormat:(NSString *)UTCTimeFormat;

+ (BOOL)isAllWhiteSpaces:(NSString *)str;

@end
