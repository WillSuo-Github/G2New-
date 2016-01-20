//
//  MenuViewController.h
//  G2TestDemo
//
//  Created by lcc on 15/7/21.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreStateViewController.h"
@class MenuViewController;
@protocol  MenuViewControllerDelegate<NSObject>

@optional
- (void)MenuViewController:(MenuViewController *)menuVC DidChickMenuCell:(NSInteger)index;

@end

@interface MenuViewController : UITableViewController<StoreStateViewControllerDelegare>
@property (nonatomic, weak) id<MenuViewControllerDelegate> delegate;

@end
