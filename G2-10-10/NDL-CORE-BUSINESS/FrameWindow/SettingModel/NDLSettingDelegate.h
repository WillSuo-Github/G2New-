//
//  NDLSettingDelegate.h
//  G2TestDemo
//
//  Created by ws on 15/12/10.
//  Copyright © 2015年 ws. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

@protocol NDLSettingDelegate <NSObject>

@optional

/**
 *  设置菜单 数据源
 *
 *  @param menuArray
 */

-(NSArray *)setSettingMenu:(UIViewController *)setingViewController;


/**
 *  设置菜单中的选项
 *
 *  @param index
 */


-(void)didSelectMenuIndex:(UIViewController *)setingViewController target:(UIViewController *)controller;


@end
