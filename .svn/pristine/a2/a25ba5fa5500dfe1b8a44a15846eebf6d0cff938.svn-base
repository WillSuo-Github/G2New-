//
//  JYShangPinXiangQingViewController.m
//  G2TestDemo
//
//  Created by wjy on 15/12/7.
//  Copyright © 2015年 ws. All rights reserved.
//

#import "JYShangPinXiangQingViewController.h"
#import "JYSaoMaXiaDanViewController.h"
#import "JYMainViewController.h"

@interface JYShangPinXiangQingViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *ShangPinImage;
@property (weak, nonatomic) IBOutlet UILabel *JiaGe;
//商品名称
@property (weak, nonatomic) IBOutlet UILabel *ShangPinMingCheng;
//类别
@property (weak, nonatomic) IBOutlet UILabel *LeiBie;
//成色
@property (weak, nonatomic) IBOutlet UILabel *ChengSe;
//商品编号
@property (weak, nonatomic) IBOutlet UILabel *ShangPinNumber;
//主石重
@property (weak, nonatomic) IBOutlet UILabel *ZhuShiZhong;
//副石重
@property (weak, nonatomic) IBOutlet UILabel *FuShiZhong;
//尺寸
@property (weak, nonatomic) IBOutlet UILabel *ChiCun;
//总件数
@property (weak, nonatomic) IBOutlet UILabel *ZongJianShu;
//主石重数量
@property (weak, nonatomic) IBOutlet UILabel *ZhuShiZhongNumber;
//副石重数量
@property (weak, nonatomic) IBOutlet UILabel *FuShiZhongNumber;
//顶部显示名称
@property (weak, nonatomic) IBOutlet UILabel *TapJYName;
//加入购物车
@property (weak, nonatomic) IBOutlet UIButton *BuyButton;


@end

@implementation JYShangPinXiangQingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //加入购物车button
    self.BuyButton.layer.cornerRadius=5;
    self.BuyButton.backgroundColor=[UIColor colorWithRed:27/255.0 green:156/255.0 blue:253/255.0 alpha:1];
    
    //设置UI显示 WHC
    [self seTView];
}
-(void)seTView{
    //右边按钮隐藏
    
    //WHC 设置数据信息
    //价格
    self.JiaGe.text = self.proDuctModel.price;
    //名称
    self.ShangPinMingCheng.text = self.proDuctModel.name;
    //成色
    self.LeiBie.text = self.proDuctModel.metalId;
    //商品编号
    self.ShangPinNumber.text = self.proDuctModel.number;
    //主石重
    self.ZhuShiZhong.text = self.proDuctModel.mainStoneWeight;
   //辅石重
    self.FuShiZhong.text = self.proDuctModel.auxiliaryStoneWeight;
    //尺寸
    self.ChiCun.text = self.proDuctModel.shoucun;
    //总件数 无
//    self.ZongJianShu.text = self.proDuctModel.
    //主石重数量
    self.ZhuShiZhongNumber.text = self.proDuctModel.mainStoneNum;
    //辅石重数量
    self.FuShiZhongNumber.text = self.proDuctModel.auxiliaryStoneNum;
    //顶部显示名称
    self.TapJYName.text = self.proDuctModel.name;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//加入购物车
- (IBAction)BuyButton:(id)sender {
    
}
//返回按钮
- (IBAction)back:(id)sender {
    
    
    // 设置控制面板的底层面板
    
    JYSaoMaXiaDanViewController *saoma = [[JYSaoMaXiaDanViewController alloc]init];
  
    [[MainViewController sharedMainView] MainViewInsertSubviewWith:saoma];
    
    
}

@end
