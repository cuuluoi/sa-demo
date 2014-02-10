//
//  SmallButton.m
//  Customer
//
//  Created by Cừu Lười on 12/24/13.
//  Copyright (c) 2013 El Nino. All rights reserved.
//

#import "SmallButton.h"

@implementation SmallButton

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect bounds = self.bounds;
    CGFloat widthDelta = 44.0 - self.bounds.size.width;
    CGFloat heightDelta = 44.0 - self.bounds.size.height;
    bounds = CGRectInset(self.bounds, -0.5 * widthDelta, -0.5 * heightDelta);
    BOOL val = CGRectContainsPoint(bounds, point);
    return val;
}

@end
