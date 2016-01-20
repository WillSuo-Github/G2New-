//
//  WaiMaiDingdanCell.m
//  G2TestDemo
//
//  Created by lcc on 15/9/9.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import "WaiMaiDingdanCell.h"
#import "TimeTool.h"


@interface WaiMaiDingdanCell ()





@end

@implementation WaiMaiDingdanCell

- (void)awakeFromNib{
    [_bianhao sizeToFit];
    [_peisongshijian sizeToFit];
    [_jine sizeToFit];
    [_xingming sizeToFit];
    [_lianxifangshi sizeToFit];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setModel:(WaiMaiPG *)model{
    
    _model = model;
    _bianhao.text = model.takesNumber;
    _xingming.text = model.contactName;
    _lianxifangshi.text =  model.mobile;
    _jine.text = model.totalCost;
    // NSString *time = [TimeTool JiaoYizhuanhuanshijian:model.sendTime];
    //_peisongshijian.text = time;
    _peisongshijian.text = model.minuteDiff;
    
}



@end
