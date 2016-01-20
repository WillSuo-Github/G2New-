//
//  JiaoYiJiLuCell.m
//  G2TestDemo
//
//  Created by lcc on 15/8/17.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import "JiaoYiJiLuCell.h"
#import "TimeTool.h"

@interface JiaoYiJiLuCell ()

@property (weak, nonatomic) IBOutlet UILabel *danhao;
@property (weak, nonatomic) IBOutlet UILabel *cantai;
@property (weak, nonatomic) IBOutlet UILabel *kaidanren;
@property (weak, nonatomic) IBOutlet UILabel *shouyinyuan;
@property (weak, nonatomic) IBOutlet UILabel *kaidanshijian;
@property (weak, nonatomic) IBOutlet UILabel *jiezhangshijian;
@property (weak, nonatomic) IBOutlet UILabel *yingshoujine;
@property (weak, nonatomic) IBOutlet UILabel *shihoujine;
@property (weak, nonatomic) IBOutlet UILabel *zhuangtai;


@end

@implementation JiaoYiJiLuCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setPg:(JiaoYiPG *)pg{
    
    _pg = pg;
    self.danhao.text = pg.billNo;
    self.cantai.text = pg.tabNo;
    self.kaidanren.text = pg.createEmployeeName;
    self.shouyinyuan.text = pg.cashierEmployeeName;

    self.jiezhangshijian.text = [TimeTool JiaoYizhuanhuanshijian:pg.payTime];

    self.kaidanshijian.text = [TimeTool JiaoYizhuanhuanshijian:pg.billTime];
    self.yingshoujine.text = [NSString stringWithFormat:@"%.2f",pg.oriCost.floatValue];
    self.shihoujine.text = [NSString stringWithFormat:@"%.2f",pg.realCost.floatValue];
    self.zhuangtai.text = pg.billStatusDesc;
}



@end
