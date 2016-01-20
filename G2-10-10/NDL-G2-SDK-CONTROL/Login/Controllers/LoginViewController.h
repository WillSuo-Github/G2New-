//
//  LoginViewController.h
//  G2TestDemo
//
//  Created by lcc on 15/7/29.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "MainViewController.h"
#import "NDLFrameWindowDelegate.h"
#import "NDLLoginManager.h"
@interface LoginViewController : BaseViewController<NDLFrameWindowDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *headerImage;

@property (weak, nonatomic) MainViewController *mainViewController;
@property (strong, nonatomic) NDLLoginManager *loginManager;

-(void)didLoginManager:(NSString *)account password:(NSString *)password;

@property (strong, nonatomic) id<NDLFrameWindowDelegate> frameWindowDelegate;





@end
