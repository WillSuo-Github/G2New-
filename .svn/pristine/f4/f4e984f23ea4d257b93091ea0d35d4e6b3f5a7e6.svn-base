//
//  RechargeRecordCell.m
//  G2TestDemo
//
//  Created by lcc on 15/8/6.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import "RechargeRecordCell.h"
#import "TimeTool.h"

@interface RechargeRecordCell ()

@property (weak, nonatomic) IBOutlet UILabel *chongzhijine;
@property (weak, nonatomic) IBOutlet UILabel *shifujine;

@property (weak, nonatomic) IBOutlet UILabel *youhuijine;
@property (weak, nonatomic) IBOutlet UILabel *zengjiajifen;

@property (weak, nonatomic) IBOutlet UILabel *chongzhihoujifen;

@property (weak, nonatomic) IBOutlet UILabel *chongzhileixing;
@property (weak, nonatomic) IBOutlet UILabel *caozuoriqi;

@property (weak, nonatomic) IBOutlet UILabel *caozuoren;

@end


@implementation RechargeRecordCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

/*
 "createTime":1435629675000,  创建时间
 preferentialCash 优惠金额
 rechargeCash 充值金额
 paidinCash 实付金额
 addIntegral 增加积分
 totalIntegral 充值后积分
 cardOperationTypeDesc 充值类型
 "iosName":"王经理", 操作人
 */

- (void)setRechargePG:(rechargePg *)rechargePG{

    self.chongzhijine.textColor=[UIColor colorWithRed:86/255.0 green:93/255.0 blue:103/255.0 alpha:1];
    self.shifujine.textColor=[UIColor colorWithRed:86/255.0 green:93/255.0 blue:103/255.0 alpha:1];
    self.youhuijine.textColor=[UIColor colorWithRed:86/255.0 green:93/255.0 blue:103/255.0 alpha:1];
    self.zengjiajifen.textColor=[UIColor colorWithRed:86/255.0 green:93/255.0 blue:103/255.0 alpha:1];
    self.chongzhihoujifen.textColor=[UIColor colorWithRed:86/255.0 green:93/255.0 blue:103/255.0 alpha:1];
    self.chongzhileixing.textColor=[UIColor colorWithRed:86/255.0 green:93/255.0 blue:103/255.0 alpha:1];
    self.caozuoriqi.textColor=[UIColor colorWithRed:86/255.0 green:93/255.0 blue:103/255.0 alpha:1];
    self.caozuoren.textColor=[UIColor colorWithRed:86/255.0 green:93/255.0 blue:103/255.0 alpha:1];
    
    _rechargePG = rechargePG;
    self.caozuoriqi.text = [TimeTool Vipzhuanhuanshijian:rechargePG.createTime];
    self.youhuijine.text = rechargePG.preferentialCash;
    self.chongzhijine.text = rechargePG.rechargeCash;
    self.shifujine.text = rechargePG.paidinCash;
    self.zengjiajifen.text = rechargePG.addIntegral;
    self.chongzhihoujifen.text = rechargePG.totalIntegral;
    self.chongzhileixing.text = rechargePG.cardOperationTypeDesc;
    self.caozuoren.text = rechargePG.iosName;
}

@end
