//
//  UIColor+PrismSales.m
//  DISPrism_Sales
//
//  Created by Cừu Lười on 12/11/13.
//  Copyright (c) 2013 Phi Dung. All rights reserved.
//

#import "UIColor+PrismSales.h"

@implementation UIColor (PrismSales)

// takes @"#123456"
+ (UIColor *)colorWithHexString:(NSString *)str {
    const char *cStr = [str cStringUsingEncoding:NSASCIIStringEncoding];
    long x = strtol(cStr+1, NULL, 16);
    return [UIColor colorWithHex:x];
}

// takes 0x123456
+ (UIColor *)colorWithHex:(UInt32)col {
    unsigned char r, g, b;
    b = col & 0xFF;
    g = (col >> 8) & 0xFF;
    r = (col >> 16) & 0xFF;
    return [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:1];
}

@end
