//
//  DaYangAlertViewController.h
//  G2TestDemo
//
//  Created by lcc on 15/8/17.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DaYangAlertViewController;
@protocol DaYangAlertViewControllerDelegate <NSObject>

@optional
-(void)DaYangAlertViewControllerDidChickQuDing:(DaYangAlertViewController *)dayangVc;
-(void)dayangquxiao:(DaYangAlertViewController *)dayang;
@end

@interface DaYangAlertViewController : UIViewController

@property (nonatomic, strong) NSArray *arr;
@property (nonatomic, weak)id <DaYangAlertViewControllerDelegate> delegate;

@end
