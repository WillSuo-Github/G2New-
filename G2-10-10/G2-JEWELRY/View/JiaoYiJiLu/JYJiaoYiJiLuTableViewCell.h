//
//  JYJiaoYiJiLuTableViewCell.h
//  G2TestDemo
//
//  Created by wjy on 15/12/11.
//  Copyright © 2015年 ws. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYOderListModel.h"
@interface JYJiaoYiJiLuTableViewCell : UITableViewCell

//订单号
@property (weak, nonatomic) IBOutlet UILabel *dingdanhao;
//消费时间
@property (weak, nonatomic) IBOutlet UILabel *xiaofeishijian;
//会员姓名
@property (weak, nonatomic) IBOutlet UILabel *huiyuanxingming;
//消费金额
@property (weak, nonatomic) IBOutlet UILabel *xiaofeijine;
//折扣
@property (weak, nonatomic) IBOutlet UILabel *zhekou;
//实收金额
@property (weak, nonatomic) IBOutlet UILabel *shishoujine;
//支付方式
@property (weak, nonatomic) IBOutlet UILabel *zhifufangshi;
//收银员
@property (weak, nonatomic) IBOutlet UILabel *shouyinyuan;
@property(strong,nonatomic)JYOderListModel *model;
@end
