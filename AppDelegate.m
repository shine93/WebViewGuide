//
//  AppDelegate.m
//  01-在屏幕中显示指定的网页
//
//  Created by shine on 2017/6/6.
//  Copyright © 2017年 shine. All rights reserved.
//

#import "AppDelegate.h"

#import "XXTableViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    XXTableViewController *tabVC = [[XXTableViewController alloc] initWithStyle:UITableViewStylePlain];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:tabVC];
    
    self.window.rootViewController = nav;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}



@end
