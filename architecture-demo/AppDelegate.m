//
//  AppDelegate.m
//  architecture-demo
//
//  Created by Cừu Lười on 2/5/14.
//  Copyright (c) 2014 Cừu Lười. All rights reserved.
//

#import "AppDelegate.h"
#import "ServerManager.h"
#import "EquipmentListViewController.h"

#define COPY_DB_FILE @"COPIED_DB_FILE"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self copyDB];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    EquipmentListViewController *rootViewController = [[EquipmentListViewController alloc] initWithNibName:NSStringFromClass([EquipmentListViewController class]) bundle:Nil];
    [self.window setRootViewController:rootViewController];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [[ServerManager manager] syncObjectsFromServer];
    return YES;
}

-(void)copyDB {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    if (![user boolForKey:COPY_DB_FILE]) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSError *error;
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        
        NSString *dbPath = [documentsDirectory stringByAppendingPathComponent:@"database.sqlite"];
        if ([fileManager fileExistsAtPath:dbPath]) {
            return;
        }
        NSString *resourcePath = [[NSBundle mainBundle] pathForResource:@"database"
                                                                 ofType:@"sqlite"];
        [fileManager copyItemAtPath:resourcePath
                             toPath:dbPath
                              error:&error];
        assert(error == nil);
        [user setBool:YES forKey:COPY_DB_FILE];
        [user synchronize];
    }
}

@end
