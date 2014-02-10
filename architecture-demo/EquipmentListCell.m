//
//  EquipmentListCell.m
//  architecture-demo
//
//  Created by Cừu Lười on 2/10/14.
//  Copyright (c) 2014 Cừu Lười. All rights reserved.
//

#import "EquipmentListCell.h"
#import "EquipmentListCellInfo.h"

@interface EquipmentListCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end

@implementation EquipmentListCell

- (void)setInfoObject:(EquipmentListCellInfo *)infoObject {
    _infoObject = infoObject;
    [_titleLabel setAttributedText:_infoObject.titleString];
    [_detailLabel setAttributedText:_infoObject.detailString];
}

@end
