//
//  YuDingFirstViewController.h
//  G2TestDemo
//
//  Created by lcc on 15/8/23.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface YuDingFirstViewController : BaseViewController


/**
 *  对外的数据保存信息
 */
@property (nonatomic, strong) NSArray *dataArr;
@property (weak, nonatomic) IBOutlet UITextField *searbar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


/**
 *  这个URL接口 是从 预定控制器界面 得到
 */
@property (copy,nonatomic) NSString *getUrl;
@end
