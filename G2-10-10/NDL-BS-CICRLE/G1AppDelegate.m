//
//  AppDelegate.m
//  GITestDemo
//
//  Created by Femto03 on 14/11/25.
//  Copyright (c) 2014年 Kyson. All rights reserved.
//

#import "G1AppDelegate.h"
//#import <PgySDK/PgyManager.h>
//#import <PgySDK>
//#include "MiniPosSDK.h"
//#include "BLEDriver.h"
#import "Common.h"
#import "PromptInfo.h"
#import "BSNetworkNotify.h"

extern int _quanjuQianDaoType;
@interface G1AppDelegate ()

@end

BSNetworkNotify *networkNotify;

@implementation G1AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //sleep(1);
    //[[UINavigationBar appearance] setBarTintColor:[UIColor yellowColor]];
    _quanjuQianDaoType = 0;
    
    //searchDevices = [NSMutableArray array];
    //[[PgyManager sharedPgyManager] startManagerWithAppId:@"71efd1ebf0e6c3c99ef5893dd95cee97"];
    //[[PgyManager sharedPgyManager] setThemeColor:rgb(55, 126, 180, 1)];
    
    //默认颜色
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.tintColor = [UIColor redColor];
    networkNotify=[BSNetworkNotify sharedBSNetworkNotify];
    
    [networkNotify startNetworkReachability];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     [networkNotify stopNetworkReachability];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [networkNotify startNetworkReachability];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/*
 禁止横屏
 */
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskPortrait;
}
@end
