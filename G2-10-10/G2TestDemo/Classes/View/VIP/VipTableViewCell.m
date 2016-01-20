//
//  VipTableViewCell.m
//  G2TestDemo
//
//  Created by lcc on 15/8/4.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import "VipTableViewCell.h"
#import "MJExtension.h"
#import "TimeTool.h"
#import "MJRefresh.h"


@interface VipTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *kahao;
@property (weak, nonatomic) IBOutlet UILabel *leixing;

@property (weak, nonatomic) IBOutlet UILabel *xingming;
@property (weak, nonatomic) IBOutlet UILabel *shoujihao;

@property (weak, nonatomic) IBOutlet UILabel *chuangjianshijian;
@property (weak, nonatomic) IBOutlet UILabel *jifen;
@property (weak, nonatomic) IBOutlet UILabel *zhuangtai;
@property (weak, nonatomic) IBOutlet UILabel *jine;

@end


@implementation VipTableViewCell





- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setVips:(VipStates *)vips{
    self.kahao.textColor=[UIColor colorWithRed:86/255.0 green:93/255.0 blue:103/255.0 alpha:1];
    self.leixing.textColor=[UIColor colorWithRed:86/255.0 green:93/255.0 blue:103/255.0 alpha:1];
    self.xingming.textColor=[UIColor colorWithRed:86/255.0 green:93/255.0 blue:103/255.0 alpha:1];
    self.shoujihao.textColor=[UIColor colorWithRed:86/255.0 green:93/255.0 blue:103/255.0 alpha:1];
    self.chuangjianshijian.textColor=[UIColor colorWithRed:86/255.0 green:93/255.0 blue:103/255.0 alpha:1];
    self.zhuangtai.textColor=[UIColor colorWithRed:86/255.0 green:93/255.0 blue:103/255.0 alpha:1];
    self.jifen.textColor=[UIColor colorWithRed:86/255.0 green:93/255.0 blue:103/255.0 alpha:1];
    self.jine.textColor=[UIColor colorWithRed:86/255.0 green:93/255.0 blue:103/255.0 alpha:1];
    
    
    _vips = vips;
    self.xingming.text = vips.name;
    self.shoujihao.text = vips.mobile;

    if (vips.shipCards.count) {
        CardStatus *cards = [CardStatus mj_objectWithKeyValues:vips.shipCards[0]];
        self.jine.text = [NSString stringWithFormat:@"%.2f",cards.balance.floatValue];
        if ([cards.cardStatus isEqualToString:@"1"]) {
            self.zhuangtai.text = @"正常";
        }else if ([cards.cardStatus isEqualToString:@"2"]){
            
            self.zhuangtai.text = @"停用";
        }else if ([cards.cardStatus isEqualToString:@"3"]){
            
            self.zhuangtai.text = @"挂失";
        }
        self.jifen.text = cards.memberIntegral;
        self.kahao.text = cards.cardNo;
        
        
        self.chuangjianshijian.text = [TimeTool Vipzhuanhuanshijian:cards.cardIssueTime];
        
        self.leixing.text = cards.membershipCardClassName;

    }
    
    
}


@end
