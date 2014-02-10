//
//  EquipmentListCellInfo.h
//  architecture-demo
//
//  Created by Cừu Lười on 2/10/14.
//  Copyright (c) 2014 Cừu Lười. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EquipmentModel;

@interface EquipmentListCellInfo : NSObject

@property (nonatomic, strong) NSMutableAttributedString *titleString;
@property (nonatomic, strong) NSMutableAttributedString *detailString;

@property (nonatomic, strong) EquipmentModel *model;

@end
