//
//  PromptConsumerSuccessViewController.m
//  G2TestDemo
//
//  Created by ws on 15/11/10.
//  Copyright © 2015年 ws. All rights reserved.
//

#import "PromptConsumerSuccessViewController.h"
#import "XiaoFeiSuccessController.h"

@interface PromptConsumerSuccessViewController ()
@property(strong,nonatomic)NSTimer *timePersoner;

@property(strong,nonatomic)XiaoFeiSuccessController *xiaoFeiSuccessController;

@end

@implementation PromptConsumerSuccessViewController






- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


-(void)setNavigationBarUIAutoLayout
{
    /**
     导航工具条的设置
     */
    
    //左侧 按钮
//    UIButton *leftButton = [[UIButton alloc]init];
//    
//    [leftButton setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
//    
//    [leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
//    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    
    //中间图标
    
     UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 100)];
    if ([self.zhiFuChuanDiPG.PayType isEqualToString:@"支付宝支付"]) {
        UIImageView *titleImageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"hlk_zfb1"]];
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 0, 80, 50)];
        titleLabel.text = [NSString stringWithFormat:@"￥%@",self.zhiFuChuanDiPG.count];
        [titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:21]];
        [titleLabel sizeToFit];
        [titleView addSubview:titleImageview];
        [titleView addSubview:titleLabel];
    }
    else if ([self.zhiFuChuanDiPG.PayType isEqualToString:@"微信支付"])
    {
        UIImageView *titleImageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"hkl_wxzf1"]];
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 0, 80, 50)];
        titleLabel.text = [NSString stringWithFormat:@"￥%@",self.zhiFuChuanDiPG.count];
        [titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:21]];
        [titleLabel sizeToFit];
        [titleView addSubview:titleImageview];
        [titleView addSubview:titleLabel];
    }
    else if ([self.zhiFuChuanDiPG.PayType isEqualToString:@"其他"])
    {
//        UIImageView *titleImageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"hlk_zfb1"]];
//        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 0, 80, 50)];
//        titleLabel.text = @"支付宝支付";
//        [titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:21]];
//        [titleLabel sizeToFit];
//        [titleView addSubview:titleImageview];
//        [titleView addSubview:titleLabel];
    }
    
  
    
    self.navigationItem.titleView = titleView;

 
    NSData *gif = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"animationCircleSmall" ofType:@"gif"]];
    
    //NSData *gif = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"WaitingForMe" ofType:@"gif"]];
    [self.gifImageView loadData:gif MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
    self.gifImageView.scalesPageToFit = YES;
    self.gifImageView.backgroundColor = [UIColor redColor];
    
    self.timePersoner = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(jumpToTheXiaofeiSuccessController) userInfo:nil repeats:NO];
    [self.timePersoner fire];
    
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)jumpToTheXiaofeiSuccessController
{
    [self.timePersoner invalidate];
    self.timePersoner  = nil;
    NSLog(@" jump to xiaofei success");
    XiaoFeiSuccessController *xiaofeiSucc = [[XiaoFeiSuccessController alloc] init];
    self.xiaoFeiSuccessController = xiaofeiSucc;
    
    
     [self.navigationController pushViewController:xiaofeiSucc animated:YES];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
