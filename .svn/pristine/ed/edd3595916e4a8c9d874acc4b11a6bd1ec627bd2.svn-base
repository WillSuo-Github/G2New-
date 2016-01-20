//
//  JiLuCaiViewCell.m
//  G2TestDemo
//
//  Created by lcc on 15/8/20.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import "JiLuCaiViewCell.h"

@interface JiLuCaiViewCell ()


@property (weak, nonatomic) IBOutlet UILabel *caiming;
@property (weak, nonatomic) IBOutlet UILabel *danjia;
@property (weak, nonatomic) IBOutlet UILabel *shuliang;
@property (weak, nonatomic) IBOutlet UILabel *jine;


@end


@implementation JiLuCaiViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCaipg:(CaiPG *)caipg{
    
    _caipg = caipg;
    self.caiming.text = caipg.dishesName;
    self.danjia.text = caipg.unitPrice;
//    NSLog(@"%@",self.danjia.text);
    self.shuliang.text = caipg.unitNum;
    CGFloat jine = caipg.unitNum.floatValue * caipg.unitPrice.floatValue;
//    NSLog(@"%f-----%f-----%f",caipg.unitPrice.floatValue,caipg.unitNum.floatValue,jine);
    self.jine.text = [NSString stringWithFormat:@"%.2f",jine];
}

@end
