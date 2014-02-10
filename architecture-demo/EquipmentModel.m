//
//  EquipmentModel.m
//  architecture-demo
//
//  Created by Cừu Lười on 2/10/14.
//  Copyright (c) 2014 Cừu Lười. All rights reserved.
//

#import "EquipmentModel.h"
#import "Equipment.h"
#import "DictionaryContainer.h"
#import "Lib.h"
#import "UtilManager.h"

@implementation EquipmentModel

- (NSDictionary *)productDict {
    if (!_productDict) {
        if (_entity.product) {
            NSData *data = [_entity.product dataUsingEncoding:NSUTF8StringEncoding];
            _productDict = [JsonLiteObjC objectFromData:data];
        }
    }
    return _productDict;
}

- (NSString *)serialString {
    if (!_serialString) {
        if (_entity.serial) {
            _serialString = _entity.serial;
        } else {
            _serialString = @"";
        }
    }
    return _serialString;
}

- (NSString *)productCodeString {
    if (!_productCodeString) {
        NSDictionary *dict = self.productDict;
        if (dict && dict.count) {
            DictionaryContainer *contain = [[DictionaryContainer alloc] initWithDictionary:dict];
            _productCodeString = [contain objectForKey:@"productCode"];
        } else {
            _productCodeString = @"";
        }
    }
    return _productCodeString;
}

- (NSString *)makeString {
    if (!_makeString) {
        NSDictionary *dict = self.productDict;
        if (dict && dict.count) {
            DictionaryContainer *contain = [[DictionaryContainer alloc] initWithDictionary:dict];
            _makeString = [contain objectForKey:@"manufacturer"];
        } else {
            _makeString = @"";
        }
    }
    return _makeString;
}

- (NSString *)equipmentDescriptionString {
    if (!_equipmentDescriptionString) {
        if (_entity.equipmentDescription) {
            _equipmentDescriptionString = _entity.equipmentDescription;
        } else {
            _equipmentDescriptionString = @"";
        }
    }
    return _equipmentDescriptionString;
}

- (NSString *)modelYearString {
    if (!_modelYearString) {
        if (_entity.modelYear) {
            _modelYearString = _entity.modelYear;
        } else {
            _modelYearString = @"";
        }
    }
    return _modelYearString;
}

- (NSString *)lastPMDateString {
    if (!_lastPMDateString) {
        if (_entity.lastPMDate) {
            _lastPMDateString = [Lib convertToLocalTimezone:_entity.lastPMDate withUTCFormat:UTC_TIME_FORMAT andLocalFormat:LOCAL_DATE_FORMAT];
        } else {
            _lastPMDateString = @"";
        }
    }
    return _lastPMDateString;
}

@end
