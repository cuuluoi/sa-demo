//
//  EquipmentListService.h
//  architecture-demo
//
//  Created by Cừu Lười on 2/10/14.
//  Copyright (c) 2014 Cừu Lười. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EquipmentListService : NSObject

- (void)loadData;

@property (nonatomic, strong) NSMutableArray *equipments;
@property (nonatomic, copy, readwrite) void(^equipmentListDidLoad)(EquipmentListService *sender);
@property (nonatomic, strong) NSString *equipmentListTitle;

- (void)loadMoreEquipment;

@end
