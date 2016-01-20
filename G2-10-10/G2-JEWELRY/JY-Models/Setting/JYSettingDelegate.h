//
//  JYSettingDelegate.h
//  G2TestDemo
//
//  Created by ws on 15/12/11.
//  Copyright © 2015年 ws. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NDLCoreBusincessHeader.h"
@interface JYSettingDelegate : NSObject <NDLSettingDelegate>

/**
 *  设置菜单 数据源
 *
 *  @param menuArray
 */
-(void)SetSettingMenu;

/**
 *  设置菜单中的选项
 *
 *  @param index
 */

-(void)DidSelectMenuIndex:(NSInteger)index;




@end
