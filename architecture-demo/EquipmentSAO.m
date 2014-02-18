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
#import "EquipmentListJSON.h"
#import "EquipmentJSON.h"

@implementation EquipmentSAO

- (void)getObjectFromServer {
    NSString *fileJsonPath = [[NSBundle mainBundle] pathForResource:@"equipment" ofType:@"json"];
    NSURL *fileURL = [NSURL fileURLWithPath:fileJsonPath];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:fileURL];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *productsDict = [JsonLiteObjC objectFromData:responseObject];
        [productsDict setTransformClass:[EquipmentListJSON class]];
        EquipmentListJSON *eqListJSON =  [productsDict transFormObject];
        NSMutableArray *array = [NSMutableArray array];
        for (EquipmentJSON *equipmentJSON in eqListJSON.equipment) {
            [array addObject:[equipmentJSON entityMaping]];
        }
        _equipments = array;
        if (_didDownloadObjects) {
            _didDownloadObjects(self);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    [[UtilManager manager].sessionManager.operationQueue addOperation:operation];
}

@end
