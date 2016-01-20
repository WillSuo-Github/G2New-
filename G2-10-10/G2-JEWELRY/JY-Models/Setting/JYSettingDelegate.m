//
//  JYSettingDelegate.m
//  G2TestDemo
//
//  Created by ws on 15/12/11.
//  Copyright © 2015年 ws. All rights reserved.
//

#import "JYSettingDelegate.h"
#import "SetingViewController.h"
#import "YuDingViewController.h"
#import "XiuGaiMiMaViewController.h"
#import "SettingAboutViewController.h"
#import "PrintViewController.h"

@implementation JYSettingDelegate


/**
 *  设置菜单 数据源
 *
 *  @param menuArray
 */
-(NSArray *)SetSettingMenu
{
    NSLog(@"设置 菜单 数据源");
    return [NSArray arrayWithObjects:@"操作设置",@"打印设置",@"修改密码", @"参数更新",nil];
    
}

/**
 *  设置菜单中的选项
 *
 *  @param index
 */

-(void)DidSelectMenuIndex:(NSInteger)index
{
    
    
    
    
}




@end
