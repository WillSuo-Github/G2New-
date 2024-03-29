//
//  SwipingCardViewController.m
//  GITestDemo
//
//  Created by wudi on 15/07/15.
//  Copyright (c) 2015年 Yogia. All rights reserved.
//

#import "SwipingCardViewController.h"
#import "PrintNoteViewController.h"
#import "Common.h"

@interface SwipingCardViewController ()<UIAlertViewDelegate>
{
    NSString *sendValue;
}

@property (strong,nonatomic) PrintNoteViewController *printNoteViewController;
@end

@implementation SwipingCardViewController


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jishixiaofeiField) name:jishixiaofeiShibai object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(chongxinshuaka) name:jishixiaofeiChongxin object:nil];
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:jishixiaofeiShibai object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:jishixiaofeiChongxin object:nil];
}


- (void)chongxinshuaka{
    
    [self.navigationController popViewControllerAnimated:YES];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"错误" message:@"请重新刷卡！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)jishixiaofeiField{
    
    [self.navigationController popViewControllerAnimated:YES];

    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"错误" message:@"身份验证失败，请核对您的信息！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.type;
    
    if ([self.type isEqualToString:@"即时收款"]) {
        self.label.hidden = NO;
    }
    
//    sendValue = @"消费交易";
//    [self performSelector:@selector(pushToPrint) withObject:nil afterDelay:1.0];
    
    NSData *gif = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"文件刷卡动画" ofType:@"gif"]];
    
    self.webView.userInteractionEnabled = NO;//用户不可交互
    [self.webView loadData:gif MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
    
    self.webView.scalesPageToFit = true;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)recvMiniPosSDKStatus
{
    if (!self.isViewLoaded) {
        return;
    }
    
    [super recvMiniPosSDKStatus];
    
    if ([self.statusStr isEqualToString:[NSString stringWithFormat:@"消费成功"]]) {
        [self showTipView:self.statusStr];
        sendValue = @"消费交易";
        [self performSelector:@selector(popAction) withObject:nil afterDelay:2.0];
    }
    
    if ([self.statusStr isEqualToString:[NSString stringWithFormat:@"查询余额成功"]]) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"查询余额成功！" message:@"余额信息请在设备终端查阅。" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        
        [alertView show];
        
       // [self pushToCheck];
    }
    
    
    if ([self.statusStr isEqualToString:[NSString stringWithFormat:@"查询余额失败"]]) {
        [self showTipView:self.statusStr];
        [self performSelector:@selector(popAction) withObject:nil afterDelay:2.0];
    }                                                                                                                                                                                                                                                                                                                                                     
    
    if ([self.statusStr isEqualToString:[NSString stringWithFormat:@"消费失败"]]) {
        [self showTipView:self.statusStr];
        [self performSelector:@selector(popAction) withObject:nil afterDelay:2.0];
    }
    
    
    if ([self.statusStr isEqualToString:@"设备响应超时"]) {
        [self showTipView:self.statusStr];
        [self performSelector:@selector(popAction) withObject:nil afterDelay:2.0];
    }
    
    if ([self.statusStr isEqualToString:@"查询余额响应超时"]) {
        [self showTipView:self.statusStr];
        [self performSelector:@selector(popAction) withObject:nil afterDelay:2.0];
    }
    
    if ([self.statusStr isEqualToString:@"收取图片成功"] ) {
        
        
        [self showTipView:self.statusStr];
        
       // [self.webView setBackgroundImage:[UIImage imageWithData:[NSData dataWithBytes:imageData length:imageLen]] forState:UIControlStateNormal];
        
        
      
        [self.webView loadData:[NSData dataWithBytes:imageData length:imageLen] MIMEType:@"image/jpg" textEncodingName:nil baseURL:nil];
        
        
        return;
        //获取签名图片
        UIImage *image = [UIImage imageWithData:[NSData dataWithBytes:imageData length:imageLen]];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
        //将这个图片嵌入到银联小票中
        // 现在两个图片的合成 测试已经完成
        
        
        
        
        //将这个图片上传到 服务器
        /**
         *  上传服务器的信息 如何获取到？
            
         */
        
        self.printNoteViewController = [[PrintNoteViewController alloc]init];
        self.printNoteViewController.view.backgroundColor = [UIColor whiteColor];
        self.printNoteViewController.signImage = [UIImage imageWithData:[NSData dataWithBytes:imageData length:imageLen]];
        self.printNoteViewController.modalPresentationStyle = UIModalPresentationFormSheet;
        [self presentViewController:self.printNoteViewController animated:YES completion:nil];
        
        
        //商户号
        NSData *mcCodeData = [NSData dataWithBytes:(const void *)gMerchantCode length:sizeof( char)*15];
        NSString *mcCodeString = [[NSString alloc] initWithData:mcCodeData encoding:NSUTF8StringEncoding];
        NSLog(@"商户号mcCodeString:%@",mcCodeString);
        
        
    }
    
    self.statusStr = @"";
}


- (void)pushToPrint
{
    [self performSegueWithIdentifier:@"swipPushToPrint" sender:self];
}

- (void)pushToCheck
{
    [self performSegueWithIdentifier:@"swipPushToCheck" sender:self];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   
    UIViewController *send = segue.destinationViewController;
    if ([send respondsToSelector:@selector(setType:)]) {
        if (sendValue) {
            [send setValue:sendValue forKey:@"type"];
            
        }
    }
    
    if ([send respondsToSelector:@selector(setCount:)]) {
        [send setValue:[NSNumber numberWithFloat:self.count] forKey:@"count"];
    }
    
}

- (void)popAction
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - 
#pragma mark - UIAlertView delegate 
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self popAction];
}

@end
