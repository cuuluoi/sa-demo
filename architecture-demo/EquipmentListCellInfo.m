//
//  EquipmentListCellInfo.m
//  architecture-demo
//
//  Created by Cừu Lười on 2/10/14.
//  Copyright (c) 2014 Cừu Lười. All rights reserved.
//

#import "EquipmentListCellInfo.h"
#import "EquipmentModel.h"

@implementation EquipmentListCellInfo

- (NSMutableAttributedString *)titleString {
    if (!_titleString) {
        NSMutableArray *array = [NSMutableArray array];
        [array addObject:_model.makeString];
        [array addObject:_model.productCodeString];
        NSString *productString = [array componentsJoinedByString:@","];
        array = [NSMutableArray array];
        [array addObject:productString];
        [array addObject:_model.serialString];
        [array addObject:_model.equipmentDescriptionString];
        NSString *equipmentString = [array componentsJoinedByString:@"\n"];
        _titleString = [[NSMutableAttributedString alloc] initWithString:equipmentString];
        NSRange row1Range = [equipmentString rangeOfString:productString];
        NSRange row2Range = NSMakeRange(row1Range.length + row1Range.location + 1, _model.serialString.length);
        NSRange row3Range = NSMakeRange(row2Range.length + row2Range.location + 1, _model.equipmentDescriptionString.length);
        [_titleString addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16.0]} range:row1Range];
        [_titleString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0],NSForegroundColorAttributeName:[UIColor colorWithRed:0 green:0 blue:1 alpha:0.5]} range:row2Range];
        [_titleString addAttributes:@{NSFontAttributeName:[UIFont italicSystemFontOfSize:12.0],NSForegroundColorAttributeName:[UIColor grayColor]} range:row3Range];
    }
    return _titleString;
}

- (NSMutableAttributedString *)detailString {
    if (!_detailString) {
        NSMutableArray *array = [NSMutableArray array];
        [array addObject:@"Year: "];
        [array addObject:_model.modelYearString];
        NSString *yearString = [array componentsJoinedByString:@""];
        array = [NSMutableArray array];
        [array addObject:@"Last PM Date: "];
        [array addObject:_model.lastPMDateString];
        NSString *dateString = [array componentsJoinedByString:@""];
        array = [NSMutableArray array];
        [array addObject:@""];
        [array addObject:yearString];
        [array addObject:dateString];
        NSString *infoString = [array componentsJoinedByString:@"\n"];
        _detailString = [[NSMutableAttributedString alloc] initWithString:infoString];
        NSRange row1Range = [infoString rangeOfString:yearString];
        NSRange row2Range = [infoString rangeOfString:dateString];
        [_detailString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0],NSForegroundColorAttributeName:[UIColor greenColor]} range:row1Range];
        [_detailString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0],NSForegroundColorAttributeName:[UIColor redColor]} range:row2Range];
    }
    return _detailString;
}

@end
