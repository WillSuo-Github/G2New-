//
//  MenuViewController.h
//  G2TestDemo
//
//  Created by lcc on 15/7/21.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreStateViewController.h"
#import "NDLFrameWindowDelegate.h"

@class MenuViewController;
@protocol  MenuViewControllerDelegate<NSObject>
@optional
- (void)MenuViewController:(MenuViewController *)menuVC DidChickMenuCell:(NSInteger)index;

@end

@interface MenuViewController : UITableViewController<StoreStateViewControllerDelegare,NDLFrameWindowDelegate>
@property (nonatomic, weak) id<MenuViewControllerDelegate> delegate;
@property(strong,nonatomic)NSArray *arr;

@end
