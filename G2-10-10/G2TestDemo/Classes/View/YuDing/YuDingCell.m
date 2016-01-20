//
//  YuDingCell.m
//  G2TestDemo
//
//  Created by lcc on 15/8/23.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import "YuDingCell.h"
#import "TimeTool.h"

@interface YuDingCell ()

@property (weak, nonatomic) IBOutlet UILabel *yudingdanhao;
@property (weak, nonatomic) IBOutlet UILabel *cantai;
@property (weak, nonatomic) IBOutlet UILabel *yudingren;
@property (weak, nonatomic) IBOutlet UILabel *shoujihao;
@property (weak, nonatomic) IBOutlet UILabel *jiucanrenshu;
@property (weak, nonatomic) IBOutlet UILabel *yudingshijian;
@property (weak, nonatomic) IBOutlet UILabel *yudingyajin;
@property (weak, nonatomic) IBOutlet UILabel *yudinglaiyuan;
@property (weak, nonatomic) IBOutlet UILabel *shifoudiancan;

@property (weak, nonatomic) IBOutlet UILabel *zhuangtai;

@end

@implementation YuDingCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

/*
 
 orderNo 订单id
 tabNo  餐台id
 orderPeopleName  预订人
 telphone  手机号
 peopleNum  就餐人数
 orderTime  预定时间
 prepay   预定押金
 orderWayDesc   预定来源
 orderStatusDesc  订单状态
 isStatus  是否已经点餐
 
 */

- (void)setList:(YuDingList *)list{
    //字体颜色
    
    self.yudingdanhao.textColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1];
    self.cantai.textColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1];
    self.yudingren.textColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1];
    self.shoujihao.textColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1];
    self.jiucanrenshu.textColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1];
    self.yudingshijian.textColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1];
    self.yudingyajin.textColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1];
    self.yudinglaiyuan.textColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1];
    self.shifoudiancan.textColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1];
    self.zhuangtai.textColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1];
    
    
    _list = list;
    self.yudingdanhao.text = list.orderNo;
   
    
    self.cantai.text = list.tabNo;
    self.yudingren.text = list.orderPeopleName;
    self.shoujihao.text = list.telphone;
    self.jiucanrenshu.text = list.peopleNum;
    
    self.yudingshijian.text = [TimeTool JiaoYizhuanhuanshijian:list.orderTime];
    self.yudingyajin.text = list.prepay;
    self.yudinglaiyuan.text = list.orderWayDesc;
    self.zhuangtai.text = list.orderStatusDesc;
   // NSLog(@"list.isStatus :%@",list.isStatus);
    if (list.isStatus == nil) {
        self.shifoudiancan.text = @"否" ;
    }else{
        
        self.shifoudiancan.text = @"是" ;
    }
}

@end
