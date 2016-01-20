//
//  SuperSuccessViewController.m
//  G2TestDemo
//
//  Created by ws on 15/11/27.
//  Copyright © 2015年 ws. All rights reserved.
//

#import "SuperSuccessViewController.h"
#import "XiaoFeiSuccessController.h"


@interface SuperSuccessViewController ()

@end

@implementation SuperSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUIAutolayout];
    [self setUINavigationAutolyout];
    
    
}



-(void)setUINavigationAutolyout
{
    
    
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 66, 60)];
    //    [leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    //[rightBtn setImage:[UIImage imageNamed:@"hlk_qx"] forState:UIControlStateNormal];
    
    [leftBtn setImage:[UIImage imageNamed:@"hlk_fh"] forState:UIControlStateNormal];
    //.image=[UIImage imageNamed:@"right_button.png"];
    leftBtn.tintColor=[UIColor colorWithRed:74/255.0 green:74/255.0 blue:74/255.0 alpha:1.0];
    [leftBtn addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(-30, -30, 0, -30)];
    [leftBtn sizeToFit];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    UIButton *rightBtn = [[UIButton alloc] init];
    [rightBtn setImage:[UIImage imageNamed:@"hlk_duihao"] forState:UIControlStateNormal];
    [rightBtn setImageEdgeInsets:UIEdgeInsetsMake(-30, -55, 0, -30)];
    [rightBtn addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [rightBtn sizeToFit];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    UIButton *titleButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    NSString *titleStr = [NSString stringWithFormat:@"￥%@",self.zhiFuChuanDiPG.count];
    [titleButton setTitle:titleStr forState:UIControlStateNormal];
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    titleButton.titleLabel.font = [UIFont systemFontOfSize:21];
    titleButton.userInteractionEnabled = NO;
    //[titleButton setImageEdgeInsets:UIEdgeInsetsMake(-10, -55, 20, -30)];
     [titleButton setTitleEdgeInsets:UIEdgeInsetsMake(-30, -55, 0, -30)];
    
    self.navigationItem.titleView = titleButton;

    
}


-(void)setUIAutolayout
{
  
   
    
    //
    //    UIView *zhongjianView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 100)];
    //
    //    if ([self.zhifuchuandi.PayType isEqualToString:@"支付宝支付"]) {
    //        UIImageView *datubiaoImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, -10, 42, 42)];
    //        datubiaoImage.image = [UIImage imageNamed:@"hlk_zfb1"];
    //
    //        UILabel *zhifuleixingLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 0, 80, 50)];
    //        zhifuleixingLabel.text = @"支付宝支付";
    //        [zhifuleixingLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:21]];
    //        [zhifuleixingLabel sizeToFit];
    //        [zhongjianView addSubview:datubiaoImage];
    //        [zhongjianView addSubview:zhifuleixingLabel];
    //
    //
    //        //添加导航条中间图标
    //
    //        UIButton *titleButton = [[UIButton alloc]init];
    //        [titleButton setImage:[UIImage imageNamed:@"hlk_zfb1"] forState:UIControlStateNormal];
    //        [titleButton setTitle:@"支付宝支付" forState:UIControlStateNormal];
    //
    //
    //
    //
    //        self.navigationItem.titleView = titleButton; //zhongjianView;
    //
    //    }else if([self.zhifuchuandi.PayType isEqualToString:@"微信支付"]){
    //
    //        UIImageView *datubiaoImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, -10, 42, 42)];
    //        datubiaoImage.image = [UIImage imageNamed:@"hkl_wxzf1"];
    //
    //        UILabel *zhifuleixingLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 0, 80, 50)];
    //        zhifuleixingLabel.text = @"微信支付";
    //        [zhifuleixingLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:21]];
    //        [zhifuleixingLabel sizeToFit];
    //        [zhongjianView addSubview:datubiaoImage];
    //        [zhongjianView addSubview:zhifuleixingLabel];
    //        self.navigationItem.titleView = zhongjianView;
    //
    //    }// add 15-11-12
    //    else if([self.zhifuchuandi.PayType isEqualToString:@"QQ钱包"]){
    //
    //        UIImageView *datubiaoImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, -10, 42, 42)];
    //        datubiaoImage.image = [UIImage imageNamed:@"hkl_wxzf1"];
    //
    //        UILabel *zhifuleixingLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 0, 80, 50)];
    //        zhifuleixingLabel.text = @"QQ钱包";
    //        [zhifuleixingLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:21]];
    //        [zhifuleixingLabel sizeToFit];
    //        [zhongjianView addSubview:datubiaoImage];
    //        [zhongjianView addSubview:zhifuleixingLabel];
    //        self.navigationItem.titleView = zhongjianView;
    //
    //    }
    //    // add 15-11-19
    //    else if([self.zhifuchuandi.PayType isEqualToString:@"百度钱包支付"]){
    //
    ////        UIImageView *datubiaoImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, -10, 42, 42)];
    ////        datubiaoImage.image = [UIImage imageNamed:@"hkl_wxzf1"];
    //
    //        UILabel *zhifuleixingLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 0, 80, 50)];
    //        zhifuleixingLabel.text = @"百度钱包支付";
    //        [zhifuleixingLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:21]];
    //        [zhifuleixingLabel sizeToFit];
    //       // [zhongjianView addSubview:datubiaoImage];
    //        [zhongjianView addSubview:zhifuleixingLabel];
    //        self.navigationItem.titleView = zhongjianView;
    //
    //    }
    //
    
    // 设置  支付成功 标志 动态图片
//        UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(200, 100, 300, 50)];
//        label.text=[NSString stringWithFormat:@"正在连接%@",self.zhiFuChuanDiPG.PayType];
//        label.font=[UIFont boldSystemFontOfSize:30];
//        [self.view addSubview:label];
    
//    //现在更改为一个静态图片 将这个注销
//    //此设置是一个动态图片
//        UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(270,80,250,250)];
//            // 读取gif图片数据
//        webView.backgroundColor = [UIColor whiteColor];
//        webView.size = CGSizeMake(200,300);
//        //webView.intrinsicContentSize = CGSizeMake(200, 200);
//        NSData *gif = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"animationCircleSmall" ofType:@"gif"]];
//        webView.scalesPageToFit = YES;
//        [webView loadData:gif MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
//        [self.view addSubview:webView];
//
    
    //设置一个静态图片
    
    UIImageView *successimageView = [[UIImageView alloc]initWithFrame:CGRectMake(280,125,200 ,200 )];
    successimageView.image = [UIImage imageNamed:@"CashOtherButtonSuccess"];
    [self.view addSubview:successimageView];
    
    
    // 设置支付成功 文字标示
    
    UILabel *successLabel =[[UILabel alloc]initWithFrame:CGRectMake(350, 350, 300, 50)];
    successLabel.text=[NSString stringWithFormat:@"支付成功"];
    successLabel.textColor = [UIColor blueColor];
    //successLabel.font=[UIFont boldSystemFontOfSize:30];
    [self.view addSubview:successLabel];

    //设置交易金额 标示
    
    UILabel *transcationAmountLabel =[[UILabel alloc]initWithFrame:CGRectMake(280, 400, 300, 50)];
    transcationAmountLabel.text=[NSString stringWithFormat:@"交易金额:"];
    //transcationAmountLabel.font=[UIFont boldSystemFontOfSize:30];
    [self.view addSubview:transcationAmountLabel];
    
    UILabel *transcationAmountLabelText =[[UILabel alloc]initWithFrame:CGRectMake(350,400, 300, 50)];
    transcationAmountLabelText.text=[NSString stringWithFormat:@"￥%@",self.zhiFuChuanDiPG.count];
    //transcationAmountLabelText.font=[UIFont boldSystemFontOfSize:30];
    [self.view addSubview:transcationAmountLabelText];
    
    
      //设置交易时间标示
    NSString *transcationDateStr = [self getCurrentDateStr:@"%04ld-%02ld-%02ld %02ld:%02ld:%02ld"];
    UILabel *transcationDateLabelText =[[UILabel alloc]initWithFrame:CGRectMake(280,450, 300, 50)];
    transcationDateLabelText.text=[NSString stringWithFormat:@"交易时间:%@",transcationDateStr];
    //transcationDateLabelText.font=[UIFont boldSystemFontOfSize:30];
    [self.view addSubview:transcationDateLabelText];
    
    
}



-(NSString *)getCurrentDateStr:(NSString *)format
{
    
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit|NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    NSString *currentDateStr = nil;
    if (format.length == 0) {
       currentDateStr = [NSString stringWithFormat:@"%ld%ld%ld%ld%ld%ld",[dateComponent year],[dateComponent month],[dateComponent day],[dateComponent hour],[dateComponent minute],[dateComponent second]];
    }
    else
    {
         currentDateStr = [NSString stringWithFormat:format,[dateComponent year],[dateComponent month],[dateComponent day],[dateComponent hour],[dateComponent minute],[dateComponent second]];
    }
   
    return currentDateStr;

}


-(void)rightButtonClick:(UIButton *)sender
{
    XiaoFeiSuccessController *xiaoFeiSuccessController = [[XiaoFeiSuccessController alloc]init];
    
    ZhiFuChuanDiPG *zhifuchuanDi = [[ZhiFuChuanDiPG alloc]init];
    zhifuchuanDi.PayType = self.zhiFuChuanDiPG.PayType;
    zhifuchuanDi.billID = self.zhiFuChuanDiPG.billID;
    // 这个金额 传递到 最后的界面  （最后的界面显示的金额 为找零 金额  ）
    zhifuchuanDi.count = @"0";
    zhifuchuanDi.RealCount = self.zhiFuChuanDiPG.RealCount;
    zhifuchuanDi.whereFrom = self.zhiFuChuanDiPG.whereFrom;
    zhifuchuanDi.orderNo = self.zhiFuChuanDiPG.orderNo;
    zhifuchuanDi.cptID = self.zhiFuChuanDiPG.cptID;
    zhifuchuanDi.tabID = self.zhiFuChuanDiPG.tabID;
    zhifuchuanDi.paymentType = self.zhiFuChuanDiPG.paymentType;
    xiaoFeiSuccessController.zhifuchuandi= zhifuchuanDi;
    
    
    [self.navigationController pushViewController:xiaoFeiSuccessController animated:YES];
    
    
}

-(void)leftButtonClick:(UIButton *)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
