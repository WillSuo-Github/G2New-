//
//  ShouQuJinEController.m
//  G2TestDemo
//
//  Created by lcc on 15/9/8.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import "ShouQuJinEController.h"
#import "ErweimaController.h"
#import "DXKeyboard.h"
#import "SwipingCardViewController.h"
#import "CustomAlertView.h"
#import "PromptSwipingCardViewController.h"
#import "UIUtils.h"

#import "HttpTool.h"
@interface ShouQuJinEController ()<DXKeyboardDelegate>
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (nonatomic, strong) ErweimaController *erweimaVc;
@property (weak, nonatomic) IBOutlet UITextField *xiaofeijine;

@property (weak, nonatomic) IBOutlet UIImageView *datubiaoImage;
@property (weak, nonatomic) IBOutlet UILabel *zhifuleixingLabel;
@property (weak, nonatomic) IBOutlet UIImageView *xiaotubiaoImage;

@property (weak, nonatomic) IBOutlet UILabel *RMB;

@property (nonatomic, strong) DXKeyboard *keyBoard;

@end

@implementation ShouQuJinEController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.contentView.layer.borderWidth = 1;
    self.contentView.layer.cornerRadius = 10;
    //self.contentView.layer.borderColor = [[UIColor redColor]CGColor];
    self.contentView.layer.borderColor = [[UIColor colorWithRed:105/255.0 green:109/255.0 blue:113/255.0 alpha:1]CGColor];
    self.contentView.layer.masksToBounds = YES;
    self.xiaofeijine.layer.borderWidth = 2;
    self.xiaofeijine.layer.borderColor = [[UIColor whiteColor]CGColor];
    self.xiaofeijine.layer.masksToBounds = YES;
    //207 210 212   
    self.xiaofeijine.textColor = [UIColor colorWithRed:207/255.0 green:210/255.0 blue:212/255.0 alpha:1];
    
    
    
    self.RMB.textColor = [UIColor colorWithRed:106/255.0 green:109/255.0 blue:113/255.0 alpha:1];
    self.xiaofeijine.textColor = [UIColor colorWithRed:106/255.0 green:109/255.0 blue:113/255.0 alpha:1];
    self.xiaofeijine.font = [UIFont fontWithName:@"Arial" size:19.0f];
    

    
    
////    
////    UIButton * rightButton = [[UIButton alloc]
////                                     initWithTitle:@"回到首页"
////                                     style:UIBarButtonItemStyleBordered
////                                     target:self
////                                     action:@selector(callModalList)];
//    
//    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 66, 60)];
//    //    [leftBtn setTitle:@"取消" forState:UIControlStateNormal];
//    //[rightBtn setImage:[UIImage imageNamed:@"hlk_qx"] forState:UIControlStateNormal];
//    
//    [rightBtn setImage:[UIImage imageNamed:@"right_button.png"] forState:UIControlStateNormal];
//    //.image=[UIImage imageNamed:@"right_button.png"];
//    rightBtn.tintColor=[UIColor colorWithRed:74/255.0 green:74/255.0 blue:74/255.0 alpha:1.0];
//     [rightBtn addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
//    
//    [rightBtn setImageEdgeInsets:UIEdgeInsetsMake(-30, -30, 0, -30)];
//    [rightBtn sizeToFit];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
//    
////    UIBarButtonItem *returnButtonItem = [[UIBarButtonItem alloc] init];
////    returnButtonItem.title = @"返回";
////    self.navigationItem.leftBarButtonItem = returnButtonItem;
    
    
//    
//    UIButton *rightBtn = [[UIButton alloc] init];
//    //    [leftBtn setTitle:@"取消" forState:UIControlStateNormal];
//    [rightBtn setImage:[UIImage imageNamed:@"hlk_duihao"] forState:UIControlStateNormal];
//    [rightBtn setImageEdgeInsets:UIEdgeInsetsMake(-30, -55, 0, -30)];
//    [rightBtn sizeToFit];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
//    
    
    
    
    
    
    
    DXKeyboard  *jianpanView = [[DXKeyboard alloc]initWithFrame:CGRectMake(0, 300, 1024, 412)];
    jianpanView.delegate = self;
    [_xiaofeijine setInputView:jianpanView];

    self.keyBoard = jianpanView;
    [_xiaofeijine setBorderStyle:UITextBorderStyleRoundedRect];
    
    
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 32, 32);
    [btn setImage:[UIImage imageNamed:@"hlk_fh"] forState:UIControlStateNormal];
    
    [btn setImageEdgeInsets:UIEdgeInsetsMake(-30, -30, 0, -30)];
    [btn sizeToFit];
    [btn addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];

    
    if (self.zhifuchuandi.count.length) {
        self.xiaofeijine.text = self.zhifuchuandi.count;
        
    }
//    NSLog(@"___%@",self.count);
    //self.xiaofeijine.placeholder = self.count;
    
    [self setZhiFuTuBiao];
    [self setUpNavItem];
    
    //设置是否开始比较服务器与本地的版本信息
    self.isFirstGetVersionInfo = NO;
    //设置是否签过到
    //[[NSUserDefaults standardUserDefaults]setBool:false forKey:kHasSignedIn];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    if (self.isFirstGetVersionInfo) {
        
        if (MiniPosSDKDeviceState() >=0) {
            MiniPosSDKGetDeviceInfoCMD();
        }
        

    }
}
- (IBAction)back:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)fanhui{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btn:(id)sender {
    
    //MiniPosSDKGetDeviceInfoCMD();
    
    CustomAlertView *cav = [[CustomAlertView alloc]init];
    [cav show];
    
     MiniPosSDKDownPro();
    return;
    [ [ UIApplication sharedApplication] setIdleTimerDisabled:YES ] ;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        DownThread1((__bridge void*)cav,[NSArray arrayWithObjects:@"kernel", nil]);
        
        [ [ UIApplication sharedApplication] setIdleTimerDisabled:NO ] ;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [cav dismiss];
        });
        
    });
}

//设置导航栏
- (void)setUpNavItem{
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    [btn setImage:[UIImage imageNamed:@"hlk_duihao"] forState:UIControlStateNormal];
    if ([self.zhifuchuandi.PayType isEqualToString:@"银行卡支付"]) {
        
        
        [btn addTarget:self action:@selector(swipeCard) forControlEvents:UIControlEventTouchUpInside];
        
    }else{
        
        [btn addTarget:self action:@selector(jumpToErweimaS) forControlEvents:UIControlEventTouchUpInside];
    }
    [btn setImageEdgeInsets:UIEdgeInsetsMake(-30, -55, 0, -30)];
    [btn sizeToFit];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}


- (void)swipeCard{
    
    [[NSUserDefaults standardUserDefaults] setObject:@"13202264038" forKey:kLoginPhoneNo];
    
    [[NSUserDefaults standardUserDefaults]synchronize];
    

    if (MiniPosSDKDeviceState()==0) {
        
       // [self verifyParamsSuccess:^{
            
            if (MiniPosSDKGetCurrentSessionType()== SESSION_POS_UNKNOWN) {
                
                int amount  = [self.xiaofeijine.text doubleValue]*100;
                
                if (amount > 0) {
                    
                    char buf[20];
                    
                    sprintf(buf,"%012d",amount);
                    
                    NSLog(@"amount: %s",buf);
                    //解决珠宝项目编译链接问题
                    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"operatedType"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                   // _type = 1;
                    MiniPosSDKSaleTradeCMD(buf, NULL,"1");
                
                    
                    UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"SwipingCard" bundle:nil];
                    PromptSwipingCardViewController *scvc = [mainStory instantiateViewControllerWithIdentifier:@"eeeee"];
                    scvc.amount  = self.xiaofeijine.text;
                    self.zhifuchuandi.count = self.xiaofeijine.text;
                    scvc.zhifuchuandi = self.zhifuchuandi;
                    [self.navigationController pushViewController:scvc animated:YES];
                    return ;
                    
//                    
//                    NewSwipingCardViewController *vc = [[NewSwipingCardViewController alloc]init];
//                    vc.amount = self.xiaofeijine.text;
//                    vc.delegate = self.navigationController.viewControllers[0];
//                    [self.navigationController pushViewController:vc animated:YES];
//                        return;
                    
                } else {
                    
                    [self showTipView:@"请确定交易金额！"];
                    
                    
                }
                
            }else{
                [self showTipView:@"设备繁忙，稍后再试"];
            }

            
       // }];
        
    
        
    }else{
        //[self showConnectionAlert];
        [self presentBluetoothConnectionVC];
    }
}

/**
 *  这个方法 中有一个二维码界面 现在跳过这个界面
    但是保留方法 待用
    现在使用的是jumpToErweimaS方法
 */
- (void)jumpToErweima{
    
    if (self.xiaofeijine.text.length) {
        ErweimaController *erweimaVc = [[ErweimaController alloc] init];
        
        ZhiFuChuanDiPG *zhifuchuanDi = [[ZhiFuChuanDiPG alloc]init];
        
        
       zhifuchuanDi.PayType = self.zhifuchuandi.PayType;
        zhifuchuanDi.idIdentifyStr = self.zhifuchuandi.idIdentifyStr;
        zhifuchuanDi.count = self.xiaofeijine.text;
       zhifuchuanDi.billID = self.zhifuchuandi.billID;
       zhifuchuanDi.whereFrom = self.zhifuchuandi.whereFrom;
        zhifuchuanDi.orderNo = self.zhifuchuandi.orderNo;
        zhifuchuanDi.cptID = self.zhifuchuandi.cptID;
        zhifuchuanDi.tabID = self.zhifuchuandi.tabID;
        zhifuchuanDi.paymentType = self.zhifuchuandi.paymentType;
        erweimaVc.zhifuchuandi = zhifuchuanDi;
        self.erweimaVc = erweimaVc;
        NSLog(@"frame:%@",NSStringFromCGRect(erweimaVc.view.frame));
        
        [self.navigationController pushViewController:erweimaVc animated:YES];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"金额不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}


//设置支付图标 和 导航栏
- (void)setZhiFuTuBiao{

    UIView *zhongjianView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    if ([self.zhifuchuandi.PayType isEqualToString:@"支付宝支付"]) {
        UIImageView *datubiaoImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, -10, 42, 42)];
        datubiaoImage.image = [UIImage imageNamed:@"hlk_zfb1"];
        [self.xiaotubiaoImage setImage:[UIImage imageNamed:@"hlk_zfb"]];
        UILabel *zhifuleixingLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 0, 80, 50)];
        zhifuleixingLabel.text = @"支付宝支付";
        [zhifuleixingLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:21]];
        [zhifuleixingLabel sizeToFit];
        [zhongjianView addSubview:datubiaoImage];
        [zhongjianView addSubview:zhifuleixingLabel];
        self.navigationItem.titleView = zhongjianView;
        
    }else if([self.zhifuchuandi.PayType isEqualToString:@"微信支付"]){
        UIImageView *datubiaoImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, -10, 42, 42)];
        datubiaoImage.image = [UIImage imageNamed:@"hkl_wxzf1"];
        [self.xiaotubiaoImage setImage:[UIImage imageNamed:@"hkl_wxzf1"]];
        UILabel *zhifuleixingLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 0, 80, 50)];
        zhifuleixingLabel.text = @"微信支付";
        [zhifuleixingLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:21]];
        [zhifuleixingLabel sizeToFit];
        [zhongjianView addSubview:datubiaoImage];
        [zhongjianView addSubview:zhifuleixingLabel];
        self.navigationItem.titleView = zhongjianView ;

    }else if([self.zhifuchuandi.PayType isEqualToString:@"银行卡支付"]){
        UIImageView *datubiaoImage = [[UIImageView alloc]initWithFrame:CGRectMake(-20, -10, 60, 43)];
        datubiaoImage.image = [UIImage imageNamed:@"yinlian"];
        [self.xiaotubiaoImage setImage:[UIImage imageNamed:@"hlk_sk"]];
        UILabel *zhifuleixingLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 0, 80, 50)];
        
        zhifuleixingLabel.text = @"银行卡支付";
        

        [zhifuleixingLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:21]];
        [zhifuleixingLabel sizeToFit];
        [zhongjianView addSubview:datubiaoImage];
        [zhongjianView addSubview:zhifuleixingLabel];
         self.navigationItem.titleView = zhongjianView;
    }//add QQ钱包  15-11-12
    else if([self.zhifuchuandi.PayType isEqualToString:@"QQ钱包"]){
        UIImageView *datubiaoImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, -10, 42, 42)];
        datubiaoImage.image = [UIImage imageNamed:@"hlk_qqqb"];
        [self.xiaotubiaoImage setImage:[UIImage imageNamed:@"hlk_qqqb"]];
        UILabel *zhifuleixingLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 0, 80, 50)];
        zhifuleixingLabel.text = @"QQ钱包";
        [zhifuleixingLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:21]];
        [zhifuleixingLabel sizeToFit];
        [zhongjianView addSubview:datubiaoImage];
        [zhongjianView addSubview:zhifuleixingLabel];
        self.navigationItem.titleView = zhongjianView;
    }// 百度钱包支付  15-11-19
    else if([self.zhifuchuandi.PayType isEqualToString:@"百度钱包支付"]){
        UIImageView *datubiaoImage = [[UIImageView alloc]initWithFrame:CGRectMake(-50, -10, 42, 42)];
        datubiaoImage.image = [UIImage imageNamed:@"hlk_bdqb"];
        [self.xiaotubiaoImage setImage:[UIImage imageNamed:@"hlk_bdqb"]];
        UILabel *zhifuleixingLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 80, 50)];
        zhifuleixingLabel.text = @"百度钱包支付";
        [zhifuleixingLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:21]];
        [zhifuleixingLabel sizeToFit];
        [zhongjianView addSubview:datubiaoImage];
        [zhongjianView addSubview:zhifuleixingLabel];
        self.navigationItem.titleView = zhongjianView;
    }
    
}

#pragma mark -- 自定义键盘

- (void)numberKeyBoardInput:(NSInteger) number
{
//    DebugLog(@"string number : %d",number);
    if (number <= 9 && number >= 1) {
        NSMutableString *textString = [[NSMutableString alloc] initWithFormat:@"%@%ld",_xiaofeijine.text,(long)number];
            _xiaofeijine.text = textString;
    }if (number == 11) {
        NSMutableString *textString = [[NSMutableString alloc] initWithFormat:@"%@00",_xiaofeijine.text];
        _xiaofeijine.text = textString;
    }if (number == 10) {
        NSMutableString *textString = [[NSMutableString alloc] initWithFormat:@"%@.",_xiaofeijine.text];
        _xiaofeijine.text = textString;
    }if (number == 12) {
        NSMutableString *textString = [[NSMutableString alloc] initWithFormat:@"%@0",_xiaofeijine.text];
        _xiaofeijine.text = textString;
    

    }
}

- (void)xiaqufangfa{
    [self.view endEditing:YES];
}

- (void)numberKeyBoardBackspace {
    NSMutableString* mutableString = [[NSMutableString alloc] initWithFormat:@"%@", _xiaofeijine.text];
    if ([mutableString length] >= 1) {
        NSRange tmpRange;
        tmpRange.location = [mutableString length] - 1;
        tmpRange.length = 1;
        [mutableString deleteCharactersInRange:tmpRange];
    }
    _xiaofeijine.text = mutableString;
}

- (void)numberKeyBoardFinish
{
//    DebugLog(@"finished.......");
    [_xiaofeijine resignFirstResponder];
}

- (void)bgButtonClick27703784131
{
    [_xiaofeijine resignFirstResponder];
}

- (void) numberKeyBoardShou{
    [self xiaqufangfa];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}




// start

/**
 *  现在使用的是这个方法
 */
- (void)jumpToErweimaS{
    
    if (!self.xiaofeijine.text.length) return;
    SaoMiaoController *saoMiaoVc = [[SaoMiaoController alloc] init];
    self.saoMiaoVC = saoMiaoVc;
    ZhiFuChuanDiPG *zhifuchuanDi = [[ZhiFuChuanDiPG alloc]init];
    zhifuchuanDi.VIPforwardUrl = self.zhifuchuandi.VIPforwardUrl;
    zhifuchuanDi.PayType = self.zhifuchuandi.PayType;
    zhifuchuanDi.billID = self.zhifuchuandi.billID;
    zhifuchuanDi.count = self.xiaofeijine.text;
    zhifuchuanDi.whereFrom = self.zhifuchuandi.whereFrom;
    zhifuchuanDi.orderNo = self.zhifuchuandi.orderNo;
    zhifuchuanDi.cptID = self.zhifuchuandi.cptID;
    zhifuchuanDi.tabID = self.zhifuchuandi.tabID;
    zhifuchuanDi.paymentType = self.zhifuchuandi.paymentType;
    self.saoMiaoVC.zhifuchuandi = zhifuchuanDi;
    
    

    NSString *str2 = @"2:支付宝支付引导"; //支付宝引导
    NSString *str3 = @"3:微信支付引导"; //微信支付引导
    
    if (MiniPosSDKDeviceState()==0) {

        
        if([zhifuchuanDi.PayType isEqualToString:@"支付宝支付"]){
            
             MiniPosSDKCreateWindow([UIUtils UTF8_To_GB2312:str2]);
            
        }else if ([zhifuchuanDi.PayType isEqualToString:@"微信支付"]){
            
             MiniPosSDKCreateWindow([UIUtils UTF8_To_GB2312:str3]);
        }
        
       
    }
    
    
    
    [self.navigationController pushViewController:saoMiaoVc animated:YES];
}




- (void)fanhuiS{
    
    [self.navigationController popViewControllerAnimated:YES];
}


//
//- (void)setUpNavItemS{
//    
//    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
//    [btn setImage:[UIImage imageNamed:@"hlk_fh"] forState:UIControlStateNormal];
//    [btn setImageEdgeInsets:UIEdgeInsetsMake(-30, -30, 0, -30)];
//    [btn sizeToFit];
//    [btn addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
//    
//    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
//    [btn2 setImage:[UIImage imageNamed:@"hlk_duihao"] forState:UIControlStateNormal];
//    
//    [btn2 setImageEdgeInsets:UIEdgeInsetsMake(-30, -55, 0, -30)];
//    [btn2 sizeToFit];
//    [btn2 addTarget:self action:@selector(jumpToErweima) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn2];
//}
//
//
//- (void)setZhiFuTuBiao{
//    
//    UIView *zhongjianView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
//    if ([_PayType isEqualToString:@"支付宝支付"]) {
//        UIImageView *datubiaoImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, -10, 42, 42)];
//        datubiaoImage.image = [UIImage imageNamed:@"hlk_zfb1"];
//        
//        UILabel *zhifuleixingLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 0, 80, 50)];
//        zhifuleixingLabel.text = @"支付宝支付";
//        [zhifuleixingLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:21]];
//        [zhifuleixingLabel sizeToFit];
//        [zhongjianView addSubview:datubiaoImage];
//        [zhongjianView addSubview:zhifuleixingLabel];
//        //        [self.navigationItem.rightBarButtonItem setImageEdgeInsets:UIEdgeInsetsMake(-30, -55, 0, -30)];
//        //        [btn2 sizeToFit];
//        self.navigationItem.titleView = zhongjianView;
//        
//    }else if([_payType isEqualToString:@"微信支付"]){
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
//    }
//}
//
//




// end of line
- (void)recvMiniPosSDKStatus
{

    [super recvMiniPosSDKStatus];
    
    self.statusStr = @"";
    
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
