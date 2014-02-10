//
//  EquipmentDAO.h
//  architecture-demo
//
//  Created by Cừu Lười on 2/10/14.
//  Copyright (c) 2014 Cừu Lười. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EquipmentDAO : NSObject

- (BOOL)importObjectList:(NSArray *)array;

- (NSArray *)equipmentsList;

- (NSArray *)equipmentsListOffset:(NSInteger)offset limit:(NSInteger)limit;

@end
