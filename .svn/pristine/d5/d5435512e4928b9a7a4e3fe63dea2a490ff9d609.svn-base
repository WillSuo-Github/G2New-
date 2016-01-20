//
//  DetailVipViewController.m
//  G2TestDemo
//
//  Created by lcc on 15/8/4.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import "DetailVipViewController.h"
#import "CardRechargeController.h"
#import "CardRecordController.h"
#import "RechargeRecordViewController.h"
#import "ChangeStatusController.h"
#import "ZhiFuViewController.h"
#import "MiniPosSDK.h"
#import "UIUtils.h"

//#import "huiyuanchongzhiViewController.h"

@interface DetailVipViewController ()<ChangeStatusControllerDelegate,CardRechargeControllerDelegate,sendChuandiDleegate>
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (nonatomic, strong) UIViewController *tmpVC;
@property (weak, nonatomic) IBOutlet UIButton *huiyuanchongzhi;
@property (weak, nonatomic) IBOutlet UIButton *xiaofeijilu;
@property (weak, nonatomic) IBOutlet UIButton *chognzhijilu;
@property (weak, nonatomic) IBOutlet UIButton *biangeng;
@property (weak, nonatomic) IBOutlet UILabel *huiyuanguanli;

@property (strong,nonatomic) ZhiFuChuanDiPG * chuandiW;

@end

@implementation DetailVipViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //添加nva上面字体
//    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
//    self.navigationController.navigationBar.frame=CGRectMake(0, 44, 770, 77);


    
//
//    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
//    titleLable.backgroundColor=[UIColor clearColor];
//    titleLable.font=[UIFont boldSystemFontOfSize:22];
//    titleLable.textColor=[UIColor colorWithRed:105/255.0 green:105/255.0  blue:105/255.0  alpha:1];
//   
//    titleLable.textAlignment=NSTextAlignmentCenter;
//    titleLable.text=@"会员管理";
//    [titleLable sizeToFit];
//    self.navigationItem.titleView = titleLable;

    
    //去nav下面黑线
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        NSArray *list=self.navigationController.navigationBar.subviews;
        for (id obj in list) {
            if ([obj isKindOfClass:[UIImageView class]]) {
                UIImageView *imageView=(UIImageView *)obj;
                NSArray *list2=imageView.subviews;
                for (id obj2 in list2) {
                    if ([obj2 isKindOfClass:[UIImageView class]]) {
                        UIImageView *imageView2=(UIImageView *)obj2;
                        imageView2.hidden=YES;
                    }
                }
            }
        }
    }


    
    
    
    self.huiyuanguanli.textColor=[UIColor colorWithRed:105/255.0 green:109/255.0 blue:113/255.0 alpha:1];
    

// Do any additional setup after loading the view from its nib.
    
}
//蓝牙客户端展示 
-(void)vipShowLanya{
    NSMutableString *strVip = [NSMutableString stringWithFormat:@"0:%@,%@,%@,%@,%@",self.vip.name,self.vip.cardNo,self.vip.membershipCardClassName,self.vip.mobile,self.vip.balance];
    
    MiniPosSDKCreateWindow([UIUtils UTF8_To_GB2312:strVip]);

}


- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    self.navigationController.navigationBar.height = 79;
    self.navigationController.navigationBar.backgroundColor=[UIColor whiteColor];
    //修改空指针问题 LiuJQ
    [self vipShowLanya];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
//    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
//    self.navigationController.navigationBar.frame=CGRectMake(0, 0, 770, 77);
    
    //[self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.height = 79;
    self.navigationController.navigationBar.backgroundColor=[UIColor whiteColor];
    

   
   // UILabel *titleLable = [[UILabel alloc]init];
    
    UIButton *titleButton = [[UIButton alloc]init];
    [titleButton setTitle:@"会员管理" forState:UIControlStateNormal];
    [titleButton setTitleEdgeInsets:UIEdgeInsetsMake(-30, 0, 0, 0)];
    [titleButton setTitleColor:[UIColor colorWithRed:105/255.0 green:105/255.0  blue:105/255.0  alpha:1] forState:UIControlStateNormal];
    titleButton.backgroundColor=[UIColor clearColor];
    titleButton.titleLabel.font=[UIFont systemFontOfSize: 22];
   
    [titleButton sizeToFit];
    self.navigationItem.titleView = titleButton;

//    
//    UIButton *rightButton = [[UIButton alloc]init];
//    [rightButton setImage:image1 forState:UIControlStateNormal];
//    [rightButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 30, 30)]

    
    UIButton *btn =[[UIButton alloc] init];
    btn.tag = 0;
    
    
    [self topBtnChick:btn];
    
    
    
    
    //去nav下面黑线
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        NSArray *list=self.navigationController.navigationBar.subviews;
        for (id obj in list) {
            if ([obj isKindOfClass:[UIImageView class]]) {
                UIImageView *imageView=(UIImageView *)obj;
                NSArray *list2=imageView.subviews;
                for (id obj2 in list2) {
                    if ([obj2 isKindOfClass:[UIImageView class]]) {
                        UIImageView *imageView2=(UIImageView *)obj2;
                        imageView2.hidden=YES;
                    }
                }
            }
        }
    }
    
    //添加nva左边箭头
    UIImage *image=[[UIImage imageNamed:@"hlk_fh"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIButton *leftButton = [[UIButton alloc]init];
    [leftButton setImage:image forState:UIControlStateNormal];
    [leftButton setImageEdgeInsets:UIEdgeInsetsMake(0,30, 30, 0)];
    [leftButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem=leftBarButton;
    //添加nva右边
    UIImage *image1=[[UIImage imageNamed:@"hlk_duihao"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIButton *rightButton = [[UIButton alloc]init];
    [rightButton setImage:image1 forState:UIControlStateNormal];
    [rightButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 30, 30)];//(0,0,0,50)];
    
    [rightButton addTarget:self action:@selector(quxiao) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem=rightBarButton;
    
}




- (IBAction)topBtnChick:(UIButton *)sender {
    
    
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    if (sender.tag == 0) {
        
       
        CardRechargeController *cardRecharge = [[CardRechargeController alloc] init];
        NSString *strYue = self.yue;
        NSString *strJfen = self.jifen;
        cardRecharge.yue = strYue;
        cardRecharge.jifen = strJfen;
        cardRecharge.view.frame = self.contentView.bounds;
        
        _tmpVC = cardRecharge;
        cardRecharge.delegate = self;
////
//        ZhiFuViewController *zhifu=[[ZhiFuViewController alloc]init];
//        zhifu.view.frame=self.contentView.bounds;
//        self.tmpVC=zhifu;
//        
//        huiyuanchongzhiViewController *huiyuanzhongzhi=[[huiyuanchongzhiViewController alloc]init];
//        huiyuanzhongzhi.view.frame=self.contentView.bounds;
//        self.tmpVC=huiyuanzhongzhi;
        
        //点击会员卡按钮事显示灰色
        self.huiyuanchongzhi.backgroundColor=[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
        [self.huiyuanchongzhi setTitleColor:[UIColor colorWithRed:78/255.0 green:152/255.0 blue:226/255.0 alpha:1] forState:UIControlStateNormal];
        //点击会员卡充值时其他按钮事蓝色
        self.xiaofeijilu.backgroundColor=[UIColor colorWithRed:78/255.0 green:152/255.0 blue:226/255.0 alpha:1];
        self.chognzhijilu.backgroundColor=[UIColor colorWithRed:78/255.0 green:152/255.0 blue:226/255.0 alpha:1];
        self.biangeng.backgroundColor=[UIColor colorWithRed:78/255.0 green:152/255.0 blue:226/255.0 alpha:1];
        
        //字体颜色
        [self.xiaofeijilu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.chognzhijilu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.biangeng setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
       // ZhiFuViewController
      [self.contentView addSubview:cardRecharge.view];
    }else if (sender.tag == 1){
        
        CardRecordController *recordVC = [[CardRecordController alloc] init];
        recordVC.mcid = self.mcid;
        recordVC.view.frame = self.contentView.bounds;
        _tmpVC = recordVC;
        
        //点击背景颜色
        sender.backgroundColor=[UIColor  colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
        //字体颜色
        [self.xiaofeijilu setTitleColor:[UIColor colorWithRed:78/255.0 green:152/255.0 blue:226/255.0 alpha:1] forState:UIControlStateNormal];
        
        self.huiyuanchongzhi.backgroundColor=[UIColor colorWithRed:78/255.0 green:152/255.0 blue:226/255.0 alpha:1];
        self.chognzhijilu.backgroundColor=[UIColor colorWithRed:78/255.0 green:152/255.0 blue:226/255.0 alpha:1];
        self.biangeng.backgroundColor=[UIColor colorWithRed:78/255.0 green:152/255.0 blue:226/255.0 alpha:1];
        
        [self.huiyuanchongzhi setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.chognzhijilu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.biangeng setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        
        [self.contentView addSubview:recordVC.view];
    }else if (sender.tag == 2){
        
        RechargeRecordViewController *rechargeRecord = [[RechargeRecordViewController alloc] init];
        _tmpVC = rechargeRecord;
        rechargeRecord.mcid = self.mcid;
        rechargeRecord.view.frame = self.contentView.bounds;
        sender.backgroundColor=[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
         [self.chognzhijilu setTitleColor:[UIColor colorWithRed:78/255.0 green:152/255.0 blue:226/255.0 alpha:1]forState:UIControlStateNormal];
        
        
        self.huiyuanchongzhi.backgroundColor=[UIColor colorWithRed:78/255.0 green:152/255.0 blue:226/255.0 alpha:1];
        self.xiaofeijilu.backgroundColor=[UIColor colorWithRed:78/255.0 green:152/255.0 blue:226/255.0 alpha:1];
        self.biangeng.backgroundColor=[UIColor colorWithRed:78/255.0 green:152/255.0 blue:226/255.0 alpha:1];
        
        [self.huiyuanchongzhi setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.xiaofeijilu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.biangeng setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

        
        [self.contentView addSubview:rechargeRecord.view];
    }else if (sender.tag == 3){
       
//        sender.selected = YES;
        ChangeStatusController *changeSt = [[ChangeStatusController alloc] init];
        _tmpVC = changeSt;
        changeSt.delegate = self;
        changeSt.view.frame = self.contentView.bounds;
        
        sender.backgroundColor=[UIColor  colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
    [self.biangeng setTitleColor:[UIColor colorWithRed:78/255.0 green:152/255.0 blue:226/255.0 alpha:1] forState:UIControlStateNormal];
        
        self.huiyuanchongzhi.backgroundColor=[UIColor colorWithRed:78/255.0 green:152/255.0 blue:226/255.0 alpha:1];
        self.xiaofeijilu.backgroundColor=[UIColor colorWithRed:78/255.0 green:152/255.0 blue:226/255.0 alpha:1];
        self.chognzhijilu.backgroundColor=[UIColor colorWithRed:78/255.0 green:152/255.0 blue:226/255.0 alpha:1];
        
        [self.huiyuanchongzhi setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.xiaofeijilu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.chognzhijilu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [self.contentView addSubview:changeSt.view];
        
    }
    
    
    
}

-(void)back{
    
    [self dismissViewControllerAnimated:YES completion:nil];
//    [self.view removeFromSuperview];
}

-(void)quxiao{
    
    if ([_delegate  respondsToSelector:@selector(huiYunaGuanLiQuXiao:)]) {
        [self.delegate huiYunaGuanLiQuXiao:self];
    }
}



//-(void)huiYunaGuanLiQuXiao:(DetailVipViewController *)quxiao;
//{
//    [self.view removeFromSuperview];
//    
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - ChangeStatusControllerDelegate
- (void)ChangeStatusQuxiaoBtnChick{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - cardRechargeController的代理方法
- (void)CardRechargeControllerDidChickQuXiao:(CardRechargeController *)cardRechargeVc{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)CardRechargeControllerDidChickQueDing:(CardRechargeController *)cardRechargeVc WithCount:(CGFloat)count WithPayType:(NSString *)payType{
//    ZhiFuChuanDiPG *zhifuchuandi = [[ZhiFuChuanDiPG alloc]init];
//
//    zhifuchuandi.count = [NSString stringWithFormat:@"%.2f",count];
//    zhifuVc.chuandiPG = zhifuchuandi;
//    NSLog(@"wwwww%@",zhifuVc.chuandiPG.count);
//    zhifuVc.chuandiPG.whereFrom = @"会员卡充值";
//    
//    
//    //
//    zhifuVc = [[ZhiFuViewController alloc]init];
    //交换数据
    ZhiFuViewController *zhifuVc = [[ZhiFuViewController alloc]init];
    zhifuVc.delegate = self;
    ZhiFuChuanDiPG *chuandiPg = [[ZhiFuChuanDiPG alloc] init];
    //    //手机号是唯一标示
    //    NSLog(@"%@",self.mcid);
    chuandiPg.count = [NSString stringWithFormat:@"%.2f",count];
    chuandiPg.whereFrom = KVipCreatChongzhi;


    chuandiPg.idIdentifyStr = self.shoujiNO;
    chuandiPg.VIPforwardUrl = self.mcid;
    if (self.chuandiW) {
        zhifuVc.chuandiPG = self.chuandiW;
    }
    else{
        zhifuVc.chuandiPG = chuandiPg;
        self.chuandiW = chuandiPg;
    }
    
    
    
    zhifuVc.panDuanHiden = @"wang";
    [self.navigationController pushViewController:zhifuVc animated:YES];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark 支付页面的代理方法
-(void)sendChuanDi:(ZhiFuChuanDiPG *)zhifuW
{
    self.chuandiW = zhifuW;
}
@end
