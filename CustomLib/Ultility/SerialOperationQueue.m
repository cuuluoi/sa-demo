//
//  SerialOperationQueue.m
//  DSL462_iOS
//
//  Created by El Nino on 8/6/13.
//  Copyright (c) 2013 El Nino. All rights reserved.
//

#import "SerialOperationQueue.h"

@implementation SerialOperationQueue

-(void)addOperation:(NSOperation *)op {
    NSOperation *lastOperation = [self.operations lastObject];
    if (lastOperation) {
        [op addDependency:lastOperation];
    }
    [super addOperation:op];
}

@end
