//
//  AppDelegate.m
//  G2-JEWELRY
//
//  Created by NDlan on 1/12/15.
//  Copyright © 2015年 ws. All rights reserved.
//

#import "G2JYAppDelegate.h"
#import "MainViewController.h"
#import "LoginViewController.h"
#import "IQKeyboardManager.h"
#import "FDMainViewController.h"
#import "JYLoginDalegate.h"
#import "JYLoginManager.h"
#import "NDLLoginManager.h"
#import "JYMainViewController.h"
#import "BSNetworkNotify.h"
#import "JYLoginManager.h"
@interface G2JYAppDelegate (){
     BSNetworkNotify *networkNotify;
}

@end

@implementation G2JYAppDelegate


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
    JYMainViewController *mainViewController=[[JYMainViewController alloc]init];
    loginVc.mainViewController=mainViewController;
    //视图协议设置
    JYLoginDalegate *loginDalegate=[[JYLoginDalegate alloc] init];
//    loginVc.frameWindowDelegate=loginDalegate;
    //登陆模型设置
    NDLLoginManager *loginManager=[[JYLoginManager alloc]init];
    loginVc.loginManager=loginManager;
    self.window.rootViewController = loginVc;
    [self.window makeKeyAndVisible];
    
    JYLoginManager *lm=[[JYLoginManager alloc]init];
       [lm testLoginSession];
   
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

@end
