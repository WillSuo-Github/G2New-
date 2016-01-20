//
//  SaveOrderListCell.m
//  G2TestDemo
//
//  Created by lcc on 15/8/31.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import "SaveOrderListCell.h"
#import "DeskState.h"
#import "TimeTool.h"

@interface SaveOrderListCell ()

@property (weak, nonatomic) IBOutlet UILabel *cantai;
@property (weak, nonatomic) IBOutlet UILabel *renshu;

@property (weak, nonatomic) IBOutlet UILabel *xiaofeijine;
@property (weak, nonatomic) IBOutlet UILabel *jiucanshijian;

@end

@implementation SaveOrderListCell

- (void)awakeFromNib {
    // Initialization code
    UIView *view = [[UIView alloc] initWithFrame:self.bounds];
    view.backgroundColor = [UIColor colorWithRed:231/255.0 green:232/255.0 blue:238/255.0 alpha:1];
    self.selectedBackgroundView = view;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setSaveList:(SaveListPG *)saveList{
    
    _saveList = saveList;
//    @property (nonatomic, copy) NSString *tabNo;
//    @property (nonatomic, copy) NSString *peopleNum;
//    @property (nonatomic, copy) NSString *realCost;
//    @property (nonatomic, copy) NSString *billTime;
    self.cantai.text = saveList.tabNo;
    self.renshu.text = saveList.peopleNum;
    self.xiaofeijine.text = saveList.consumeCost;
    
    //NSLog(@"saveTime:%@",saveList.billTime);
   NSString *time = [TimeTool JiaoYizhuanhuanshijian:saveList.billTime];
    //NSLog(@"time:%@",time);
    self.jiucanshijian.text = time;//saveList.billTime;

}
@end
