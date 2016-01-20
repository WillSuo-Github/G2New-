//
//  LoginViewController.m
//  GITestDemo
//
//  Created by Femto03 on 14/11/25.
//  Copyright (c) 2014年 Kyson. All rights reserved.
//

#import "LoginViewController.h"
#import "UIUtils.h"
#import "QCheckBox.h"
#import "SIAlertView.h"
#import "AFNetworking.h"
#include "des.h"
#import "LeftSlideViewController.h"
#import "LeftSortsViewController.h"
#import "G1AppDelegate.h"
#import "KVNProgress.h"
#import "LoginWaitViewController.h"
#import "NDlMPosPay.h"
#import "ConnectDeviceViewController.h"
#import "PromptInfo.h"
#import "Common.h"
#import "UserManager.h"
#import <Foundation/Foundation.h>

//BOOL _quanjuisTuiChu;

@interface LoginViewController ()<UIAlertViewDelegate,QCheckBoxDelegate,UITextFieldDelegate>
{
    UITapGestureRecognizer *disMissTap;
    NSTimer *timer;
    KVNProgressConfiguration *basicConfiguration;
    UIView *_showView;
    UIImageView *_imageView;
    int count;
}

@property (weak, nonatomic) IBOutlet UILabel *mimacuowuLabel;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    UserSession *session = [UserSession new];
    session.sessionId =@"1";
    session.username =@"wudi";
    session.status = @"0";
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/test"]];
    [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/1"]];
    [NSKeyedArchiver archiveRootObject:session toFile:filePath];
    
    
    UserSession *session1 = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    NSLog(@"session:%@",[session1 description]);
    
    self.navigationController.navigationBarHidden = NO;


    //_isNeedAutoConnect = YES;
    
    //NSLog(@"沙盒路径：%@",NSHomeDirectory());
    //NSString *Path = [[NSBundle mainBundle] pathForResource:@"kernel" ofType:@""];
    
    //NSLog(@"kernel:%@",Path);
    
    [self _initSubViews];
    
    [self initBLESDK];
    
    self.mimacuowuLabel.hidden = YES;
    
    
    // Do any additional setup after loading the view.
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillshow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillhide:) name:UIKeyboardWillHideNotification object:nil];
//    if (MiniPosSDKDeviceState() == 0) {
//        [self.connectDeviceButton setTitle:@"设备已连接" forState:UIControlStateNormal];
//    } else {
//        [self.connectDeviceButton setTitle:@"请先选择连接移动终端" forState:UIControlStateNormal];
//        self.connectDeviceButton.enabled = YES;
//    }
    //调整结构添加 LiuJQ
    [NDlMPosPay shardNDlMPosPay].miniPosManagerDelegate=self;
    [[NDlMPosPay shardNDlMPosPay] initMiniPosSDKAddDelegate];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];

} 

- (void)keyboardWillshow:(NSNotification *)notification
{
    NSLog(@"keyboardWillshow");
    //获取键盘的高度
    //    NSValue *sizeValue = [notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    //    CGRect frame = [sizeValue CGRectValue];
    //    float height = CGRectGetHeight(frame);
    [self.view addGestureRecognizer:disMissTap];
    //    [UIView animateWithDuration:0.35 animations:^{
    //        self.bgScrollView.height = self.view.height - height;
    //    }];
    
}
- (void)keyboardWillhide:(NSNotification *)notification
{
    [self.view removeGestureRecognizer:disMissTap];
    //    [UIView animateWithDuration:0.35 animations:^{
    //        self.bgScrollView.height = self.view.height;
    //    }];
}

- (void)dismissAction
{
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
//    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)_initSubViews
{
    disMissTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissAction)];
    
    //self.configButton.layer.cornerRadius = 3.0;
    //self.configButton.layer.masksToBounds = YES;
    self.siginButton.layer.cornerRadius = 3.0;
    self.siginButton.layer.masksToBounds = YES;
    
    self.password.delegate = self;
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    imageView1.backgroundColor = [UIColor clearColor];
    imageView1.image = [UIImage imageNamed:@"人物标志.png"];
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    imageView2.backgroundColor = [UIColor clearColor];
    imageView2.image = [UIImage imageNamed:@"密码标志.png"];
    
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    label1.backgroundColor = [UIColor clearColor];
    label1.text = @"账号";
    label1.textAlignment = UITextAlignmentCenter;
    
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    label2.backgroundColor = [UIColor clearColor];
    label2.text = @"密码";
    label2.textAlignment = UITextAlignmentCenter;
    
    
    self.phoneNo.leftView = label1;
    self.password.leftView = label2;
    self.phoneNo.leftViewMode = UITextFieldViewModeAlways;
    self.password.leftViewMode = UITextFieldViewModeAlways;
    
    self.phoneNo.layer.cornerRadius = 3.0;
    self.password.layer.cornerRadius = 3.0;
    self.phoneNo.layer.masksToBounds = YES;
    self.password.layer.masksToBounds = YES;

  /*
    _checkBox = [[QCheckBox alloc]initWithDelegate:self];
    _checkBox.frame = CGRectMake(220, 6, 120, 30);
    [_checkBox setTitle:@"记住密码" forState:UIControlStateNormal];
    _checkBox.titleLabel.font =[UIFont systemFontOfSize: 12];
    [_checkBox setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    [_checkBox setTitleColor:[UIColor greenColor] forState:UIControlStateHighlighted];
//    [_checkBox setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    [_checkBox setImage:[UIImage imageNamed:@"小方框.png"] forState:UIControlStateNormal];
    [_checkBox setImage:[UIImage imageNamed:@"小方框2.png"] forState:UIControlStateSelected];
    [self.protocolView addSubview:_checkBox];
    
    BOOL b = [[NSUserDefaults standardUserDefaults]boolForKey:kRememberPassword];
    [_checkBox setChecked:b];
    
    self.phoneNo.text = [[NSUserDefaults standardUserDefaults]stringForKey:kLoginPhoneNo];
    
    if (b) {
        self.password.text  = [[NSUserDefaults standardUserDefaults]stringForKey:KPassword];
    }
   */
}







- (IBAction)configAction:(id)sender {
    
    
    //MiniPosSDKSetParam("000000000", [UIUtils UTF8_To_GB2312:@"商户号"], "898100012340003");
   //MiniPosSDKSetParam("000000000", [UIUtils UTF8_To_GB2312:@"主密钥1"], "3E61C7071A836483628567ADB6F8F2EC");
   //return;
    
//    if (![self.phoneNo.text isEqualToString:@"99"] || ![self.password.text isEqualToString:@"937927"]) {
//        
//        [self showTipView:@"操作员号或密码错误！请检查后重试。"];
//        
//        return;
//    }
    
    [self performSegueWithIdentifier:@"loginModalToConfig" sender:self];
}

//登录
- (IBAction)siginAction:(UIButton *)sender {
    [self dismissAction];

    
    if(![UIUtils isCorrectPhoneNo:self.phoneNo.text]){
        [self showTipView:@"请输入正确的手机号"];
        return;
    }
    
    if ([self.password.text isEqualToString:@""]) {
        [self showTipView:@"密码不能为空"];
        return;
    }
    
    //由于不是同一个实现所以需要重新设置代理
    
    [[NDlMPosPay shardNDlMPosPay] siginAction:self.phoneNo.text password:self.password.text];

    
}


-(IBAction)loginAction:(UIButton *)sender{
    
    
    
    [[NDlMPosPay shardNDlMPosPay] loginActionWithPhoneNo:self.phoneNo.text andPassword:self.password.text];

}

#pragma mark -- 登录回调
-(void)needLoginAction:(NSString *)result errorType:(LoginResultType)code{

    
    switch (code) {
        case NDLMPOSK_PAY_LOGIN_OK:  //登录成功
        {
            [self showWaiting];
            [self hideProgressAfterDelaysInSeconds:3 withCompletion:^{
                G1AppDelegate *tempAppDelegate = (G1AppDelegate *)[[UIApplication sharedApplication] delegate];
                
                LeftSortsViewController *leftVC = [[LeftSortsViewController alloc]init];
                
                UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                UIViewController *mainVC =   [story instantiateViewControllerWithIdentifier:@"MainVC"];
                
                
                LeftSlideViewController *leftSlideVC = [[LeftSlideViewController alloc]initWithLeftView:leftVC andMainView:mainVC];
                tempAppDelegate.LeftSlideVC = leftSlideVC;
                
                [self presentViewController:leftSlideVC animated:YES completion:nil];
                
            }];
            
            
            NSLog(@"NDLMPOSK_PAY_LOGIN_OK");
        }
            break;
        case NDLMPOSK_PAY_LOGIN_USER_OR_PASSWORD_ERROR: //用户密码错误
            NSLog(@"NDLMPOSK_PAY_LOGIN_USER_OR_PASSWORD_ERROR");
            break;
        case NDLMPOSK_PAY_LOGIN_OTHER_ERROR: //登录其它错误
            NSLog(@"NDLMPOSK_PAY_LOGIN_OTHER_ERROR");
            break;
            
        default:
            break;
    }
    
}


-(void)needSiginAction:(NSString *)result errorType:(LoginAndSignResultType)code sessionCodeResult:(SessionCodeResult *)sessionCodeResult{
    self.statusStr=sessionCodeResult.msg;
    self.sessionType=sessionCodeResult.sessionType;
    self.responceCode=sessionCodeResult.responceCode;
    
    [self siginResult:result errorType:code];
}

-(void)didWaiting:(NSString *)result errorType:(LoginAndSignResultType)code{
    if(code == NDMPOSK_PAY_LOGIN_SIGN_LOGIN_OK){ //登录成功
        [self showWaiting];
        [self hideProgressAfterDelaysInSeconds:3 withCompletion:^{
            
            
            [[NDlMPosManager shardNDlMPosManager] login:self.phoneNo.text
                                               password:self.password.text bSignedIn:false];
            
            
            G1AppDelegate *tempAppDelegate = (G1AppDelegate *)[[UIApplication sharedApplication] delegate];
            
            LeftSortsViewController *leftVC = [[LeftSortsViewController alloc]init];
            
//            UINavigationController *mainVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MainVC"];
            
            
            //[UserManager userManager]
            UserSession *userSession=[UserSession new];
            userSession.status=@"0";
            [UserManager registSession:userSession];
            
            UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *mainVC =   [story instantiateViewControllerWithIdentifier:@"MainVC"];

            
            LeftSlideViewController *leftSlideVC = [[LeftSlideViewController alloc]initWithLeftView:leftVC andMainView:mainVC];
            tempAppDelegate.LeftSlideVC = leftSlideVC;
            
            [self presentViewController:leftSlideVC animated:YES completion:nil];
            //[self siginResult:result errorType:code];
        }];
    }
    if(code==NDMPOSK_PAY_LOGIN_SIGN_LOGIN_MOBLEORPASS_ERROR){
        self.mimacuowuLabel.hidden = NO;
        self.password.text = @"";
        [self.navigationController popViewControllerAnimated:YES];
    }

}
-(void)showWaiting{
    
    //LiuJQ
    //_quanjuisTuiChu = NO;
    LoginWaitViewController *loginWaitVc = [[LoginWaitViewController alloc] init];
    [self.navigationController pushViewController:loginWaitVc animated:YES];
    
}




//应当把此逻辑转移到登陆的实现中NDlMPosPay的siginAction
- (void)siginResult:(NSString *)result errorType:(LoginAndSignResultType)code
{
    //NSLog(@"%@",self.statusStr);
    
    if(code==NDMPOSK_PAY_LOGIN_SIGN_DIVICE_CONNECTED)
    {
        [self.connectDeviceButton setTitle:@"设备已连接" forState:UIControlStateNormal];
        NSLog(@"recvMiniPosSDKStatus:设备已连接");
        
        
    }
    if(code==NDMPOSK_PAY_LOGIN_SIGN_DIVICE_NOCONNECTED) //设备不连接
    {
        UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ConnectDeviceViewController *cdvc = [mainStory instantiateViewControllerWithIdentifier:@"CD"];
        [self.navigationController pushViewController:cdvc animated:YES];
        
    }

    if (code==NDMPOSK_PAY_LOGIN_SIGN_OK) {
        [self hideHUD];
        NSLog(@"LoginViewController ----签到成功");
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"签到成功！" message:@"点击进入操作页面！" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        alertView.tag=99;
        //[alertView show];
        
        
        SIAlertView *salertView = [[SIAlertView alloc] initWithTitle:@"签到成功！" andMessage:@"点击进入操作页面！"];
        [salertView addButtonWithTitle:@"OK"
                                 type:SIAlertViewButtonTypeDefault
                              handler:^(SIAlertView *alertView) {
                                  [self performSegueWithIdentifier:@"loginToHome" sender:self];
                              }];

        
        salertView.titleColor = [UIColor blueColor];
        salertView.cornerRadius = 10;
        salertView.buttonFont = [UIFont boldSystemFontOfSize:15];
        salertView.transitionStyle = SIAlertViewTransitionStyleSlideFromTop;
        [salertView show];
    }else if (code==NDMPOSK_PAY_LOGIN_SIGN_ERROR) {
        [self hideHUD];
         NSLog(@"LoginViewController ----签到失败");
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"签到失败！" message:self.displayString delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
         [alertView show];
    }

    
    if (code==NDMPOSK_PAY_LOGIN_SIGN_TIMEOUT) {
        
        [self hideHUD];
        //[self showTipView:result];
    }
    if (code==NDMPOSK_PAY_LOGIN_SIGN_OK){
        //[PromptInfo showText:result];
    }
    [self didWaiting:result errorType:code];   
}




#pragma mark - UIAlertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==99)
    [self performSegueWithIdentifier:@"loginToHome" sender:self];
}

#pragma mark - QCheckBoxDelegate

- (void)didSelectedCheckBox:(QCheckBox *)checkbox checked:(BOOL)checked{

    [[NSUserDefaults standardUserDefaults] setBool:checked forKey:kRememberPassword];
}

#pragma mark - textField的代理方法
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    self.mimacuowuLabel.hidden = YES;
    return YES;
}



@end
