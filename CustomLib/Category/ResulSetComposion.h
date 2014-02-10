//
//  ResulSetComposion.h
//  Customer
//
//  Created by Cừu Lười on 12/26/13.
//  Copyright (c) 2013 El Nino. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FMResultSet;

@interface ResulSetComposion : NSObject

@property (nonatomic, readonly, weak) FMResultSet *resulSet;

- (instancetype)initWithResulSet:(FMResultSet *)set;

- (BOOL)next;

- (id)objectForColumnName:(NSString *)string;

- (id)objectForColumnIndex:(NSInteger)index;

- (void)close;

@end
