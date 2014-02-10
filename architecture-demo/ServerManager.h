//
//  ServerManager.h
//  architecture-demo
//
//  Created by Cừu Lười on 2/10/14.
//  Copyright (c) 2014 Cừu Lười. All rights reserved.
//

@interface ServerManager : NSObject

+ (instancetype)manager;

- (void)syncObjectsFromServer;

@end
