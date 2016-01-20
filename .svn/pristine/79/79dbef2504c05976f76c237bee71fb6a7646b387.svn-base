//
//  CardRecordCell.m
//  G2TestDemo
//
//  Created by lcc on 15/8/6.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import "CardRecordCell.h"
#import "TimeTool.h"

@interface CardRecordCell ()

@property (weak, nonatomic) IBOutlet UILabel *xiaofeiriqi;

@property (weak, nonatomic) IBOutlet UILabel *shouyinyuan;

@property (weak, nonatomic) IBOutlet UILabel *xiaofeijine;

@property (weak, nonatomic) IBOutlet UILabel *shihoujine;

@property (weak, nonatomic) IBOutlet UILabel *zengjiajifen;

@property (weak, nonatomic) IBOutlet UILabel *fukuanxiangqing;


@end

@implementation CardRecordCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

 /*
 "createTime":1431068232000,  日期
 "cashierName":"霍元乙2223", 收银员
 "membercardCost":90,  消费金额
 "addIntegral":94, 增加积分
 "payableCost":94, 实收金额
 "billStatusDesc":"已结账", 付款详情
 */
- (void)setRecordPG:(RecordPG *)recordPG{
    
    
    self.xiaofeiriqi.textColor=[UIColor colorWithRed:78/255.0 green:152/255.0 blue:226/255.0 alpha:1];
    self.shouyinyuan.textColor=[UIColor colorWithRed:86/255.0 green:93/255.0 blue:103/255.0 alpha:1];
    self.xiaofeijine.textColor=[UIColor colorWithRed:86/255.0 green:93/255.0 blue:103/255.0 alpha:1];
    self.shihoujine.textColor=[UIColor colorWithRed:86/255.0 green:93/255.0 blue:103/255.0 alpha:1];
    self.zengjiajifen.textColor=[UIColor colorWithRed:86/255.0 green:93/255.0 blue:103/255.0 alpha:1];
    self.fukuanxiangqing.textColor=[UIColor colorWithRed:86/255.0 green:93/255.0 blue:103/255.0 alpha:1];
    
    

    
    _recordPG = recordPG;

    self.xiaofeiriqi.text = [TimeTool Vipzhuanhuanshijian:recordPG.payTime];
    self.shouyinyuan.text = recordPG.cashierName;
    self.xiaofeijine.text = recordPG.membercardCost;
    self.zengjiajifen.text = recordPG.addIntegral;
    self.shihoujine.text = recordPG.payableCost;
    self.fukuanxiangqing.text = recordPG.billStatusDesc;
    
}

@end
