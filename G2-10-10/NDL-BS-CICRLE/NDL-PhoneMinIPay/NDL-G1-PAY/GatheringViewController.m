//
//  GatheringViewController.m
//  GITestDemo
//
//  Created by 吴狄 on 15/6/27.
//  Copyright (c) 2015年 Kyson. All rights reserved.
//

#import "GatheringViewController.h"
#import "WDCalculator.h"
#import "SwipingCardViewController.h"
#import "AFNetworking.h"
#import "CustomAlertView.h"
#import "ConnectDeviceViewController.h"
#import "JishiChooseController.h"
#import "G1AppDelegate.h"
#import "NDlMPosPay.h"
#import "PromptInfo.h"
#import "common.h"
@interface GatheringViewController ()<WDCalculatorDelegate>
{
    NSString *web_kernel;
    NSString *web_task;
    NSString *pos_kernel;
    NSString *pos_task;
    NSMutableArray *updateFiles;
    CustomAlertView *cav;
    

    BOOL isGetDeviceMsgAction;
    
    
    NSString *payType;

}
@property (nonatomic, strong) JishiChooseController *jishiVC;
@end

@implementation GatheringViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.totalNum.text = @"0.00";
    self.showStr.text =@"0";
//    isFirstGetVersionInfo = true;
    //结构调整注销 LiuJQ
    //self.isFirstGetVersionInfo = true;
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(connectSuccess) name:KconnectDeivesSuccess object:nil];
    
     [NDlMPosManager shardNDlMPosManager].miniPosManagerDelegate=self;
}

- (void)connectSuccess{

    [self normalConsume:nil];
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:KconnectDeivesSuccess object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    //[ //[[NDlMPosManager shardNDlMPosManager] initMiniPosSDKAddDelegate];];
    
    [[NDlMPosManager shardNDlMPosManager] initMiniPosSDKAddDelegate];
    WDCalculator *calculator = [[WDCalculator alloc]initWithFrame:self.calculatorView.frame];
    calculator.delegate = self;
    [self.view addSubview:calculator];
    
   
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.navigationItem.title = @"支付页面";
    UIButton *btn = [[UIButton alloc] init];
//    [btn setTitle:@"222" forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"ht"] forState:UIControlStateNormal];
    [btn sizeToFit];
    [btn addTarget:self action:@selector(openOrCloseLeftView) forControlEvents:UIControlEventTouchUpInside];
    self.tabBarController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    UIButton *btn1 = [[UIButton alloc] init];
    [btn1 setImage:[UIImage imageNamed:@"sjjb"] forState:UIControlStateNormal];
    [btn1 sizeToFit];
    self.tabBarController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn1];

    //结构调整注销 LiuJQ
    /*
    MiniPosSDKInit();
    
    if (self.isFirstGetVersionInfo) {
            //获取设备信息的
        MiniPosSDKGetDeviceInfoCMD();
        //isFirstGetVersionInfo = false;
    }
    */
    
}

- (void)openOrCloseLeftView{
    
    G1AppDelegate *tempAppDelegate = (G1AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (tempAppDelegate.LeftSlideVC.closed)
    {
        [tempAppDelegate.LeftSlideVC openLeftView];
    }
    else
    {
        [tempAppDelegate.LeftSlideVC closeLeftView];
    }
}


//常规消费
- (IBAction)normalConsume:(UIButton *)sender {
  
    if(MiniPosSDKDeviceState()<0){
        //[self showTipView:@"设备未连接"];
        [self showConnectionAlert];
        return;
    }
    [NDlMPosPay shardNDlMPosPay].miniPosManagerDelegate=self;
    
    [[NDlMPosCoreSDK shardNDlMPosCoreSDK] signInMPosSuceess:^{
        NSLog(@"签到成功");
    } Fail:^(SessionCodeResult *result) {
        NSLog(@"签到失败");
    }];
    
    return;
    //刷卡
    [NDlMPosPay shardNDlMPosPay].miniPosManagerDelegate=self;
    [[NDlMPosPay shardNDlMPosPay] payWithCreditCard:self.totalNum.text];

    
}






//即时收款
- (IBAction)immediatelyConsume:(UIButton *)sender {
    
    //return;
    
    if (self.totalNum.text.floatValue < 100) {
        [self showTipView:@"即时消费不能小于100"];
        return;
    }
    
    JishiChooseController *jishiVC = [[JishiChooseController alloc] init];
    self.jishiVC = jishiVC;
    jishiVC.count = self.totalNum.text;

    [self.navigationController pushViewController:jishiVC animated:YES];
    
    
    self.totalNum.text = @"0.00";
    self.showStr.text = @"0";
}



    //sdk 回调方法
- (void)recvMiniPosSDKStatus
{
    [super recvMiniPosSDKStatus];
    
    if ([self.statusStr isEqualToString:[NSString stringWithFormat:@"签到成功"]]) {
        [self hideHUD];
        NSLog(@"LoginViewController ----签到成功");
        
        [self showTipView:self.statusStr];
    }
    
    
    if ([self.statusStr isEqualToString:[NSString stringWithFormat:@"签到失败"]]) {
        [self hideHUD];
        NSLog(@"LoginViewController ----签到失败");
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"签到失败！" message:self.displayString delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
        
    } else if([self.statusStr isEqualToString:@"签到成功" ]){
        //签到成功时隐藏
        [self hideHUD];
        
    }else if([self.statusStr isEqualToString:[NSString stringWithFormat:@"消费失败"]]){
        [PromptInfo showText:self.statusStr];
    }
    if ([self.statusStr isEqualToString:[NSString stringWithFormat:@"设备已拔出"]]) {
       //
       [self showConnectionAlert];
    }

    
    
    self.statusStr = @"";
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - WDCalculatorDelegate
-(void)WDCalculatorDidClick:(WDCalculator *)WDCalculator{
    //self.num.text  = [NSString stringWithFormat:@"￥ %.2f",WDCalculator.num];
    self.totalNum.text = [NSString stringWithFormat:@"%.2f",WDCalculator.totalNum];
    self.showStr.text = WDCalculator.str;
}

#pragma mark -- NDlMPosManagerDelegate
-(void)needPayWithCreditCard:(NSString *)result errorType:(PayWithCreditCardType)code{
    //-(void)needPayWithCreditCard:(NSString *)result errorType:(int)code;
    if (code==NDMPOSK_PAY_CARD_CASH_RANGE_ERROR) {
        [self showTipView:@"常规消费区间是1~50000"];
        return;
    }else if(code==NDMPOSK_PAY_CARD_CASH_DEVICE_ERROR){
        [self showConnectionAlert];
        return;
    }else if(code==NDMPOSK_PAY_CARD_CASH_OK){
        self.totalNum.text = @"0.00";
        self.showStr.text = @"0";
        SwipingCardViewController *scvc = [self.storyboard instantiateViewControllerWithIdentifier:@"SC"];
        
        [self.navigationController pushViewController:scvc animated:YES];
        [scvc setValue:@"常规消费" forKey:@"type"];
        
    }else if(code==NDMPOSK_PAY_CARD_CASH_ACK){
        [self showTipView:@"请确定交易金额！"];
    }else if(code==NDMPOSK_PAY_CARD_CASH_DEVICE_BUSING){
        [self showTipView:@"设备繁忙，稍后再试"];
        
    }
    
}

-(void)needMiniPosSDKResponse:(SessionCodeResult *)result{
    //
    NSLog(@"GatheringViewController,mPos状态码是\n%@",result.description);
    self.statusStr=result.msg;
    self.sessionType=result.sessionType;
    self.responceCode=result.responceCode;
    
    //LiuJQ Bug info
    [self recvMiniPosSDKStatus];
    
}

@end
