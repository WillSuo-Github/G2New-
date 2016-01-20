//
//  ErweimaController.m
//  G2TestDemo
//
//  Created by lcc on 15/9/10.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import "ErweimaController.h"
#import "SaoMiaoController.h"

@interface ErweimaController ()
@property (nonatomic, strong) SaoMiaoController *saomiaoVc;

@property (weak, nonatomic) IBOutlet UIImageView *datubiaoImage;
@property (weak, nonatomic) IBOutlet UILabel *zhifuleixingLabel;

@end

@implementation ErweimaController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setZhiFuTuBiao];
    [self setUpNavItem];
    
    

    // Do any additional setup after loading the view from its nib.
}
- (IBAction)erweimaBtn:(id)sender {
    
    [self jumpToErweima];

    
}

//- (void)viewDidAppear:(BOOL)animated{
//    
//    [super viewDidAppear:animated];
//    [self setUpNavItem];
//}


- (void)jumpToErweima{
    
    SaoMiaoController *saoMiaoVc = [[SaoMiaoController alloc] init];
    
    ZhiFuChuanDiPG *zhifuchuanDi = [[ZhiFuChuanDiPG alloc]init];
    
    self.saomiaoVc = saoMiaoVc;
    zhifuchuanDi.PayType = self.zhifuchuandi.PayType;
    zhifuchuanDi.billID = self.zhifuchuandi.billID;
    
    zhifuchuanDi.idIdentifyStr = self.zhifuchuandi.idIdentifyStr;
    
    zhifuchuanDi.count = self.zhifuchuandi.count;
    zhifuchuanDi.whereFrom = self.zhifuchuandi.whereFrom;
   zhifuchuanDi.orderNo = self.zhifuchuandi.orderNo;
   zhifuchuanDi.cptID = self.zhifuchuandi.cptID;
    zhifuchuanDi.tabID = self.zhifuchuandi.tabID;
    zhifuchuanDi.paymentType = self.zhifuchuandi.paymentType;
    saoMiaoVc.zhifuchuandi = zhifuchuanDi;
     //[self. setTitleEdgeInsets:UIEdgeInsetsMake(-30, -55, 0, -30)];
    
    
    [self.navigationController pushViewController:saoMiaoVc animated:YES];

}



- (void)setUpNavItem{
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [btn setImage:[UIImage imageNamed:@"hlk_fh"] forState:UIControlStateNormal];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(-30, -30, 0, -30)];
    [btn sizeToFit];
    [btn addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [btn2 setImage:[UIImage imageNamed:@"hlk_duihao"] forState:UIControlStateNormal];
   
           [btn2 setImageEdgeInsets:UIEdgeInsetsMake(-30, -55, 0, -30)];
       [btn2 sizeToFit];
    [btn2 addTarget:self action:@selector(jumpToErweima) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn2];
}

- (void)fanhui{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setZhiFuTuBiao{
    
    UIView *zhongjianView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    if ([self.zhifuchuandi.PayType isEqualToString:@"支付宝支付"]) {
        UIImageView *datubiaoImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, -10, 42, 42)];
        datubiaoImage.image = [UIImage imageNamed:@"hlk_zfb1"];
        
        UILabel *zhifuleixingLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 0, 80, 50)];
        zhifuleixingLabel.text = @"支付宝支付";
        [zhifuleixingLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:21]];
        [zhifuleixingLabel sizeToFit];
        [zhongjianView addSubview:datubiaoImage];
        [zhongjianView addSubview:zhifuleixingLabel];
//        [self.navigationItem.rightBarButtonItem setImageEdgeInsets:UIEdgeInsetsMake(-30, -55, 0, -30)];
//        [btn2 sizeToFit];
        self.navigationItem.titleView = zhongjianView;
        
    }else if([self.zhifuchuandi.PayType isEqualToString:@"微信支付"]){
        
        UIImageView *datubiaoImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, -10, 42, 42)];
        datubiaoImage.image = [UIImage imageNamed:@"hkl_wxzf1"];
 
        UILabel *zhifuleixingLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 0, 80, 50)];
        zhifuleixingLabel.text = @"微信支付";
        [zhifuleixingLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:21]];
        [zhifuleixingLabel sizeToFit];
        [zhongjianView addSubview:datubiaoImage];
        [zhongjianView addSubview:zhifuleixingLabel];
        self.navigationItem.titleView = zhongjianView;
        
    }
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
