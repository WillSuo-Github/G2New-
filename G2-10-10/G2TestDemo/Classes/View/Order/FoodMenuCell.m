//
//  FoodMenuCell.m
//  G2TestDemo
//
//  Created by lcc on 15/7/27.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import "FoodMenuCell.h"

@interface FoodMenuCell ()

@property (weak, nonatomic) IBOutlet UILabel *xuhao;

@property (weak, nonatomic) IBOutlet UILabel *dishName;
@property (weak, nonatomic) IBOutlet UILabel *dishPrice;

@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *zengsong;

@property (weak, nonatomic) IBOutlet UILabel *caiming;
@property (weak, nonatomic) IBOutlet UILabel *danjia;
@property (weak, nonatomic) IBOutlet UILabel *shuliang;
@property (weak, nonatomic) IBOutlet UILabel *jine;

@end


@implementation FoodMenuCell

- (void)awakeFromNib {
    // Initialization code

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setCaipg:(CaiPG *)caipg{
    
    _caipg = caipg;
    
    self.danjia.text = caipg.oriCostStr;
    self.shuliang.text = @"1";
    self.price.text = caipg.oriCostStr;
    if ([caipg.oriCostStr isEqualToString:@"0"]) {
        self.zengsong.hidden = NO;
    }
    else{
        self.zengsong.hidden = YES;
    }
    self.dishName.text = caipg.dishesName;
    //DLog(@" my price :%@",caipg.oriCostStr);
    
    /**
     *  现在讲显示为总价  单价X3 = 总价  显示总价
     */
    NSString *priceStr = [NSString stringWithFormat:@"%.2f",caipg.oriCostStr.floatValue * caipg.unitNumStr.integerValue];
    self.dishPrice.text = priceStr;//caipg.oriCostStr;

    if ([caipg.isRed isEqualToString:@"1"]) {
        [self setTextRedColor];
    }
    if (![caipg.unitNumStr isEqualToString:@"1"]) {
        self.caiming.text = [NSString stringWithFormat:@"%@     X %@",caipg.dishesName,caipg.unitNumStr];
    }else{
        
       self.caiming.text = caipg.dishesName;
    }
}

- (void)setTextRedColor{
    
    self.caiming.textColor = [UIColor redColor];
    self.danjia.textColor = [UIColor redColor];
    self.shuliang.textColor = [UIColor redColor];
    self.jine.textColor = [UIColor redColor];
}

- (void)setNub:(NSInteger)nub{
    
    _nub = nub;
    self.xuhao.text = [NSString stringWithFormat:@"%02ld",nub+1];
}

@end
