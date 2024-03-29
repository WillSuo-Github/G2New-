//
//  BSUITableMultCellOperation.h
//  KTAPP
//
//  Created by admin on 15/6/30.
//  Copyright (c) 2015年 KT. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
@protocol BSUITableMultCellOperation <NSObject>

/**
 *NIB或者故事板方式调用方法
 */
-(UITableViewCell *)viewCellWithBSContentObject:(NSArray *)bscArray;

/**
 *手工编码的调用方法
 */
-(UITableViewCell *)viewCellWithHandBSContentObject:(NSArray *)bscArray;

@end
