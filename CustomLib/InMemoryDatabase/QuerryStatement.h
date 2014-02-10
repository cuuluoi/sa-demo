//
//  QuerryStatement.h
//  LocalStorage
//
//  Created by El Nino on 6/22/13.
//  Copyright (c) 2013 El Nino. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    QuerryStatementTypeUpdate = 1,
    QuerryStatementTypeQuery = 2
}QuerryStatementType;

@interface QuerryStatement : NSObject

@property (assign) QuerryStatementType type;
@property (nonatomic, strong) NSString *stm;

@end
