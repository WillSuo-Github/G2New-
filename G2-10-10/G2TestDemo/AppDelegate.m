//
//  AppDelegate.m
//  G2TestDemo
//
//  Created by lcc on 15/7/20.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "LoginViewController.h"
#import "IQKeyboardManager.h"
#import "FDMainViewController.h"
#import "BSNetworkNotify.h"

@interface AppDelegate (){
    BSNetworkNotify *networkNotify;
    //LoginViewController *loginVc ;
    //MainViewController *mainViewController;
}
@end
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    /**
     自动管理系统键盘
     */
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldRestoreScrollViewContentOffset = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //登陆设置具体的主视图
    LoginViewController *loginVc = [[LoginViewController alloc] init];
    MainViewController *mainViewController=[[FDMainViewController alloc]init];
    loginVc.mainViewController=mainViewController;
    self.window.rootViewController = loginVc;
    [self.window makeKeyAndVisible];
    
        //初始化一次点菜界面保存订单的Array
    NSMutableArray *arr = [NSMutableArray array];
    [[NSUserDefaults standardUserDefaults] setObject:arr forKey:KSaveOrder];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    networkNotify=[BSNetworkNotify sharedBSNetworkNotify];
    
    [networkNotify startNetworkReachability];
    return YES;
}

- (BOOL)prefersStatusBarHidden
{
    return YES; // 返回NO表示要显示，返回YES将hiden
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
  //  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //登陆设置具体的主视图
//    LoginViewController *loginVc = [[LoginViewController alloc] init];
//    MainViewController *mainViewController=[[FDMainViewController alloc]init];
//    loginVc.mainViewController=mainViewController;
//    self.window.rootViewController = loginVc;
//    
//    [self.window makeKeyAndVisible];
    [networkNotify startNetworkReachability];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



@end
