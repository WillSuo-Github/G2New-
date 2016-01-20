//
//  LoginViewController.m
//  G2TestDemo
//
//  Created by lcc on 15/7/29.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import "LoginViewController.h"
#import "MainViewController.h"

#import "NDLLoginManager.h"
#import "NDLBusinessConfigure.h"
#import "CustomAlertView.h"
#import "Common.h"
#define kAlphaNum @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
NSString *restarantIdStr;
NSString *restarantLogoImagePathStr;
NSString *restarantNameStr;
NSString *restarantAddressStr;
NSString *restarantTenWinIdStr;
@interface LoginViewController ()<UITextFieldDelegate>
//@property(strong,nonatomic)UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UITextField *zhanghao;   //账号的输入框
@property (weak, nonatomic) IBOutlet UITextField *mima;  //密码的输入框

@property (weak, nonatomic) IBOutlet UIButton *denglu;  //登陆按钮
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *juhua;

@property (weak, nonatomic) IBOutlet UIView *LoginView;
@property (weak, nonatomic) IBOutlet UIView *zhanghaoView;
@property (weak, nonatomic) IBOutlet UIView *mimaView;



@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!self.frameWindowDelegate) {
         self.frameWindowDelegate=self;
    }
    if (!self.loginManager) {
        self.loginManager= [NDLLoginManager loginManager];
    }
    UIImageView *backgroundeImage = [[UIImageView alloc]initWithFrame:self.view.frame];
    
    backgroundeImage.image = [UIImage imageNamed:@"BG"];
    
    [self.view insertSubview:backgroundeImage atIndex:0];
    
    //设置登陆按钮的背景颜色
    self.denglu.backgroundColor = [UIColor colorWithRed:78/225.0 green:152/255.0 blue:226/255.0 alpha:1];
    
    //就是可以按照你给它定义的那些操作实现效果
    self.denglu.userInteractionEnabled = YES;
    
    self.denglu.userInteractionEnabled = YES;
    // 设置账号的显示
    self.zhanghaoView.layer.borderWidth = 1;
    self.zhanghaoView.layer.borderColor = [[UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1]CGColor];
    
    self.zhanghao.tintColor = [UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1];
    
    
    self.mimaView.layer.borderWidth = 1;
      self.mimaView.layer.borderColor = [[UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1]CGColor];
   // self.mimaView.layer.cornerRadius = 5;
    self.mimaView.layer.masksToBounds = YES;
    
    self.mima.tintColor = [UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1];
    self.mima.delegate = self;
    
    self.denglu.layer.cornerRadius = 7;
    self.denglu.layer.masksToBounds = YES;
    
    //键盘类型
    self.zhanghao.keyboardType = UIKeyboardTypeASCIICapable;
    

    NSString *G2User = [[NSUserDefaults standardUserDefaults] stringForKey:kG2User];
    NSString *G2Password =  [[NSUserDefaults standardUserDefaults] stringForKey:KG2Password];
    self.zhanghao.text = G2User;
    self.mima.text = G2Password;
    
    [self initBLESDK];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    NSLog(@"LoginViewController viewDidAppear");
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //[[NSNotificationCenter defaultCenter] postNotificationName:kBluetoothIsPoweredOn object:nil];
}

//textfield输入完成时
- (BOOL)textFieldShouldReturn:(UITextField *)aTextfield {
    
    [_zhanghao resignFirstResponder];//键盘隐藏
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dengluChick:nil];
    });
    
    return YES;
}

//设置账号输入键盘限制
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSCharacterSet *cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:kAlphaNum] invertedSet];
    
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""]; //按cs分离出数组,数组按@""分离出字符串
    
    BOOL canChange = [string isEqualToString:filtered];
    
    return canChange;
}



- (IBAction)dengluChick:(id)sender {
    
 //   self.denglu.userInteractionEnabled = NO;
    if (debug) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        MainViewController *mainV = [[MainViewController alloc] init];
        window.rootViewController = mainV;
        return;
    }
    if ([_zhanghao.text isEqualToString:@""]) {
        [self showErrorWithMessage:@"账号不可为空"];
        return;
    }

    if ([_mima.text isEqualToString:@""]) {
        [self showErrorWithMessage:@"密码不可为空"];
        return;
    }

    [self.zhanghao resignFirstResponder];
    [self.mima resignFirstResponder];
  
    self.juhua.hidden = NO;
 
    if ([self.frameWindowDelegate respondsToSelector:@selector(didLoginManager:password:)]){
        [self.frameWindowDelegate didLoginManager:self.zhanghao.text password:self.mima.text];
    }
    
}


//从服务器下载图片
- (void)downloadImage{
    

    
    
}

-(void)didLoginManager:(NSString *)account password:(NSString *)password{
    
    [self.loginManager login:account password:password
                  block:^(NSObject *response,ErrorMessage *errorMessage)  {
                      NSLog(@"responseObject:%@",response);
                      
                      
                      NSString *value=(NSString *)response;
                      if ([value isEqualToString:@"0"])
                      {
  
                          
                          [[NSUserDefaults standardUserDefaults] setObject:self.zhanghao.text forKey:kG2User];
                          [[NSUserDefaults standardUserDefaults] setObject:self.mima.text forKey:KG2Password];
                          [[NSUserDefaults standardUserDefaults] synchronize];
                          
                          
                          
                          NSString *G2RestarantLogoImagePathStr  =  [[NSUserDefaults standardUserDefaults] stringForKey:kG2RestarantLogoImagePathStr];

                          
                          NSURL *url = [NSURL URLWithString:G2RestarantLogoImagePathStr];
                          NSURLRequest *request = [NSURLRequest requestWithURL:url];
                          
                          // 2
                          AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
                          
                          NSString *str = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/5555"];
                          
                          operation.inputStream = [NSInputStream inputStreamWithURL:url];
                          operation.outputStream = [NSOutputStream outputStreamToFileAtPath:str append:NO];
                          
                          [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                              
                              return ;
                             
                              
                              CustomAlertView *cav = [[CustomAlertView alloc]init];
                              [cav show];
                              
                              
                              dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
                                  TransferFilesToPos((__bridge void*)cav,@[@"44"]);
                                  
                                  [ [ UIApplication sharedApplication] setIdleTimerDisabled:NO ] ;
                                  
                                  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                      [cav dismiss];
                                      
                                      
                                      
                                      UIWindow *window = [UIApplication sharedApplication].keyWindow;
                                      //MainViewController *mainV = //[[MainViewController alloc] init];
                                      //添加动画
                                      CATransition *transition = [CATransition animation];
                                      transition.duration = 1.5;
                                      transition.type = @"rippleEffect";
                                      [window.layer addAnimation:transition forKey:nil];
                                      window.rootViewController = self.mainViewController;
                                      
                                      
                                  });
                                  
                              });
 
                              
                              
                              
                          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                              NSLog(@"failure");
                              [self hideHUD];
                              [self showTipView:@"获取失败,请检查网络"];
                              
                              
                          }];
                          
                          // 5
                          [operation start];
                          
                          
                          
                          
                          UIWindow *window = [UIApplication sharedApplication].keyWindow;
                          //MainViewController *mainV = //[[MainViewController alloc] init];
                          //添加动画
                          CATransition *transition = [CATransition animation];
                          transition.duration = 1.5;
                          transition.type = @"rippleEffect";
                          [window.layer addAnimation:transition forKey:nil];
                          window.rootViewController = self.mainViewController;
                          return ;

             
                      }else if([value isEqualToString:@"1"]){
                          [self showErrorWithMessage:@"用户名或密码有误"];
                          self.juhua.hidden = YES;
                      }else{
                          self.denglu.userInteractionEnabled = YES;
                          self.juhua.hidden = YES;
                          [self showErrorWithMessage:@"登陆超时"];
                      }
     }];

}

- (void)showErrorWithMessage:(NSString *)message{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"登录失败" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
    
    // 2.添加动画
    CAKeyframeAnimation *shakeAnim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    shakeAnim.values = @[@-10, @0, @10, @0];
    shakeAnim.repeatCount = 3;
    shakeAnim.duration = 0.1;
    [self.LoginView.layer addAnimation:shakeAnim forKey:nil];
    self.juhua.hidden = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
