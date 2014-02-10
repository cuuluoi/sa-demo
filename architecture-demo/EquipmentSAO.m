//
//  EquipmentSAO.m
//  architecture-demo
//
//  Created by Cừu Lười on 2/10/14.
//  Copyright (c) 2014 Cừu Lười. All rights reserved.
//

#import "EquipmentSAO.h"
#import "UtilManager.h"
#import "Equipment.h"
#import "DictionaryContainer.h"

@implementation EquipmentSAO

- (void)getObjectFromServer {
    NSString *fileJsonPath = [[NSBundle mainBundle] pathForResource:@"equipment" ofType:@"json"];
    NSURL *fileURL = [NSURL fileURLWithPath:fileJsonPath];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:fileURL];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *productsDict = [JsonLiteObjC objectFromData:responseObject];
        if (productsDict && productsDict.count) {
            NSArray *equipments = [productsDict objectForKey:@"equipment"];
            NSMutableArray *equipmentParserArray = [NSMutableArray array];
            for (NSDictionary *dict in equipments) {
                if (dict && ![dict isKindOfClass:[NSNull class]] && dict.count) {
                    DictionaryContainer *dictContain = [[DictionaryContainer alloc] initWithDictionary:dict];
                    Equipment *eq = [[Equipment alloc] init];
                    eq.equipmentWebId = [dictContain objectForKey:@"webId"];
                    eq.serial = [dictContain objectForKey:@"serialNumber"];
                    eq.equipmentDescription = [dictContain objectForKey:@"description"];
                    eq.lastPMDate = [dictContain objectForKey:@"lastPMDate"];
                    eq.modelYear = [dictContain objectForKey:@"modelYear"];
                    NSDictionary *productDict = [dictContain objectForKey:@"product"];
                    static SBJson4Writer *writer;
                    if (!writer) {
                        writer = [[SBJson4Writer alloc] init];
                    }
                    NSString *productString = [writer stringWithObject:productDict];
                    eq.product = productString;
                    [equipmentParserArray addObject:eq];
                }
            }
            _equipments = equipmentParserArray;
            if (_didDownloadObjects) {
                _didDownloadObjects(self);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    [[UtilManager manager].sessionManager.operationQueue addOperation:operation];
}

@end
