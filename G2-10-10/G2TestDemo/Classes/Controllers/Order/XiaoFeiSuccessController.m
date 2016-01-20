//
//  XiaoFeiSuccessController.m
//  G2TestDemo
//
//  Created by lcc on 15/9/11.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import "XiaoFeiSuccessController.h"
#import "HttpTool.h"
#import "OrderViewController.h"
#import "ZhiFuChuanDiPG.h"
#import "DXKeyboard.h"
#import "UIUtils.h"

#import "DengDaiViewController.h"

@interface XiaoFeiSuccessController ()<UITextFieldDelegate,DXKeyboardDelegate>

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property(strong,nonatomic) NSString *xiaofeiSuc;
@property (weak, nonatomic) IBOutlet UIButton *querenfasong;
@property (weak, nonatomic) IBOutlet UITextField *kaung1;
@property (weak, nonatomic) IBOutlet UITextField *kuang2;
@property (weak, nonatomic) IBOutlet UILabel *labelBiaoti;
@property(strong,nonatomic)ZhiFuChuanDiPG *zhifuCD;

@property (weak, nonatomic) IBOutlet UITextField *dianzizhangdanText;

@property (strong, nonatomic)UITextField *isBeingEditingTextField;


@end

@implementation XiaoFeiSuccessController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //数字键盘代理
    
    DXKeyboard *jianpanView = [[DXKeyboard alloc] init];
    jianpanView.delegate = self;
    self.dianzizhangdanText.delegate=self;
    [self.dianzizhangdanText setInputView:jianpanView];

    
    //监控textfield的字数
//    [self.dianzizhangdanText addTarget:self action:@selector(anniubianse) forControlEvents:UIControlEventEditingChanged];
    
    self.dianzizhangdanText.delegate=self;
    
    self.labelBiaoti.textColor=[UIColor colorWithRed:60/255.0 green:141/255.0 blue:222/255.0 alpha:1];
    self.querenfasong.backgroundColor=[UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1];
//    self.querenfasong.backgroundColor=[UIColor colorWithRed:60/255.0 green:141/255.0 blue:222/255.0 alpha:1];
    // Do any additional setup after loading the view from its nib.
    self.querenfasong.layer.cornerRadius=5;
    
    self.kaung1.layer.borderWidth=1;
    self.kuang2.layer.borderWidth=1;
    self.kaung1.layer.cornerRadius=5;
    self.kuang2.layer.cornerRadius=5;
    self.kuang2.layer.borderColor=[UIColor colorWithRed:198/255.0 green:198/255.0  blue:198/255.0  alpha:1].CGColor;
    self.kaung1.layer.borderColor=[UIColor colorWithRed:198/255.0 green:198/255.0  blue:198/255.0  alpha:1].CGColor;
    
    self.kaung1.backgroundColor=[UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1];
    
    
    
    
    self.contentView.layer.borderWidth = 1;
    self.contentView.layer.cornerRadius = 5;
    self.contentView.layer.borderColor=[UIColor grayColor].CGColor;
    self.contentView.layer.masksToBounds = YES;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"hlk_fh"] forState:UIControlStateNormal];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(-30, -55, 0, -30)];
    [btn sizeToFit];
    [btn addTarget:self action:@selector(popView) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
//    NSLog(@"--------------%@,%@",self.RealCount,self.count);
    if (self.zhifuchuandi.count.length) {
        if ((self.zhifuchuandi.count.floatValue - self.zhifuchuandi.RealCount.floatValue) != 0.0)
        {
            //zhifuchuandi.count.floatValue - self.zhifuchuandi.RealCount.floatValue
            UIButton *titleButton = [[UIButton alloc]init];
            [btn sizeToFit];
            
            
            //start of line
            // 现在将找零  修改为  显示实际收取金额
            [titleButton setTitle:[NSString stringWithFormat:@"找零%.2f元",(self.zhifuchuandi.count.floatValue - self.zhifuchuandi.RealCount.floatValue)] forState:UIControlStateNormal];
            
         //   [titleButton setTitle:self.zhifuchuandi.count forState:UIControlStateNormal];
            
            
            
            // end of line
            [titleButton setTitleEdgeInsets:UIEdgeInsetsMake(-30, -55, 0, -30)];
            titleButton.titleLabel.font = [UIFont fontWithName : @"Helvetica-Bold"  size : 30 ];
            //titleButton.titleLabel.textColor = [UIColor colorWithRed:103/255.0 green:108/255.0 blue:112/255.0 alpha:1];
            [titleButton setTitleColor:[UIColor colorWithRed:103/255.0 green:108/255.0 blue:112/255.0 alpha:1] forState:UIControlStateNormal];
            
            
            titleButton.userInteractionEnabled = NO;
            
            
            //self.navigationItem.title = [NSString stringWithFormat:@"找零：%.1f元",(self.zhifuchuandi.count.floatValue - self.zhifuchuandi.RealCount.floatValue)];
            self.navigationItem.titleView = titleButton;

//            [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName : @"Helvetica-Bold"  size : 30 ],NSForegroundColorAttributeName:[UIColor colorWithRed:103/255.0 green:108/255.0 blue:112/255.0 alpha:1]}];
        }
        /*
       // }// add 15-11-13  现金支付 显示  支付金额
        else
        {
            UIButton *titleButton = [[UIButton alloc]init];
            [btn sizeToFit];
            [titleButton setTitle:[NSString stringWithFormat:@"￥：%.1f元支付成功",(self.zhifuchuandi.RealCount.floatValue)] forState:UIControlStateNormal];
            [titleButton setTitleEdgeInsets:UIEdgeInsetsMake(-30, -55, 0, -30)];
            titleButton.titleLabel.font = [UIFont fontWithName : @"Helvetica-Bold"  size : 30 ];
            //titleButton.titleLabel.textColor = [UIColor colorWithRed:103/255.0 green:108/255.0 blue:112/255.0 alpha:1];
            [titleButton setTitleColor:[UIColor colorWithRed:103/255.0 green:108/255.0 blue:112/255.0 alpha:1] forState:UIControlStateNormal];
            
            
            titleButton.userInteractionEnabled = NO;
            
            
            self.navigationItem.title = [NSString stringWithFormat:@"找零：%.1f元",(self.zhifuchuandi.count.floatValue - self.zhifuchuandi.RealCount.floatValue)];
          //  self.navigationItem.titleView = titleButton;
            
            
            
            
            
        }
        */
    
}
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    
    NSLog(@"paymentType:%@",self.zhifuchuandi.paymentType);
    
    if (![self.zhifuchuandi.paymentType isEqualToString:@"1"]) {
        //微信支付 支付宝支付 QQ钱包 百度钱包支付,  发送成功指令。
        
        if (MiniPosSDKDeviceState() == 0) {
            
            MiniPosSDKCreateWindow("s");
            
        }
        
    }else{
        //现金支付 ，发送找零页面显示指令
        
        double count =  self.zhifuchuandi.count.floatValue - self.zhifuchuandi.RealCount.floatValue;
        if (MiniPosSDKDeviceState() == 0) {
            
        
            MiniPosSDKCreateWindow([UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"7:%.2lf",count]]);
            
        }
        
    }
    

    
    
}

- (void)popView{
    
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)buxuyao:(id)sender {
    
    [self xianjingjiezhang];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:Kqingchuwaimai object:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    [[NSNotificationCenter defaultCenter]postNotificationName:KshuaxinVIP object:nil];
    if ([self.zhifuchuandi.whereFrom isEqualToString:@"预定"]) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"YudingMessage" object:nil];
        
    }
    
}
- (IBAction)fasongTap:(id)sender {
    

//    [self.querenfasong setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    
//    self.querenfasong.backgroundColor=[UIColor colorWithRed:60/255.0 green:141/255.0 blue:222/255.0 alpha:1];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)qingtai{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/index/qingtai/%@",ceshiIP,self.zhifuchuandi.tabID];
    [HttpTool GET:urlStr parameters:nil success:^(id responseObject) {
        //        NSLog(@"%@",responseObject);
//        [self showAlertViewWithMessage:@"交易成功"];
        
        DLog(@"jiaoyichenggong");
        
        //发送消费成功的通知
        [[NSNotificationCenter defaultCenter]postNotificationName:KxianjinxiaofeiSuccess object:nil];
        
        
        
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}



- (void)xianjingjiezhang{
    
    //发送成功消费的通知
    
   [[NSNotificationCenter defaultCenter] postNotificationName:KzhifuSuccess object:nil userInfo:self.zhifuchuandi.PayType];

    if ([self.zhifuchuandi.paymentType isEqualToString:@"1"]) {
        
        DLog(@"%@",self.zhifuchuandi.billID);
        
        
        if (self.zhifuchuandi.billID.length) {
            NSString *urlStr=[NSString stringWithFormat:@"%@/canyin-frontdesk/bill/pop/paymentType/update?billId=%@&cptId=73fca052-f54f-11e4-af9a-02004c4f4f50&paymentType=%@&money=%@&dbpId=",ceshiIP,self.zhifuchuandi.billID,self.zhifuchuandi.paymentType,self.zhifuchuandi.count];
            DLog(@"=========%@",urlStr);
            
            [HttpTool GET:urlStr parameters:nil success:^(id responseObject) {
                
            
                
            
              NSLog(@"%@",responseObject);
                
                NSString *str=[responseObject objectForKey:@"message" ];
                
                           if ([str isEqualToString:@"支付成功"]) {
                   
                               
                               if ([self.zhifuchuandi.paymentType isEqualToString:@"1"]) {
                                   
                                   if (MiniPosSDKDeviceState() == 0) {
                                       
                                       MiniPosSDKCreateWindow("s");
                                       
                                   }
                                   
                               }
                               
                               //调用现金结账
                               [self cashRMBPayOff];
                               

                              
                               
                
                        }else{
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"支付失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                               [alert show];
                            
                
                            }
                
            } failure:^(NSError *error) {
                NSLog(@"------%@",error);
            }];
        }
    }
    

    
}









//电子账单输入11位手机号按钮变蓝色   别动我代码 
//-(void)anniubianse{
//    
//    if (self.dianzizhangdanText.text.length==11) {
//        
//        [self.querenfasong setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        self.querenfasong.backgroundColor=[UIColor colorWithRed:60/255.0 green:141/255.0 blue:222/255.0 alpha:1];
//    }
//}

//结账借口
- (void)cashRMBPayOff{
    
    
    if (self.zhifuchuandi.billID.length)
    {
        NSString *urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/bill/pay/%@?isPrint=false&isForce=true&rid=0.23375838149835548",ceshiIP,self.zhifuchuandi.billID];
        [HttpTool GET:urlStr parameters:nil success:^(id responseObject)
         {
             //            NSLog(@"%@",responseObject);
             XiaoFeiSuccessController *xiaofeiSucc = [[XiaoFeiSuccessController alloc] init];
             self.xiaofeiSuc = xiaofeiSucc;
             
             if ([self.zhifuchuandi.whereFrom isEqualToString:kWaiMaiJieZhangFromStr]) {
                 
                 //外卖结账成功
                 DLog(@"waimaijiezhangchenggong");
             }else{
                 
                 [self qingtai];
                 
             }
             [self.navigationController pushViewController:xiaofeiSucc animated:YES];
             
             
         } failure:^(NSError *error) {
             NSLog(@"%@",error);
         }];
    }
    
    
}

//数字键盘
#pragma mark -- 数字键盘
- (void)numberKeyBoardInput:(NSInteger) number
{
    if (self.dianzizhangdanText.text.length >10) {
        return;
        
    }
    //    DebugLog(@"string number : %d",number);
    if (number <= 9 && number >= 1) {
        NSMutableString *textString = [[NSMutableString alloc] initWithFormat:@"%@%ld",self.dianzizhangdanText.text,(long)number];
        self.dianzizhangdanText.text = textString;
    }if (number == 11) {
        NSMutableString *textString = [[NSMutableString alloc] initWithFormat:@"%@00",self.dianzizhangdanText.text];
        
        self.dianzizhangdanText.text = textString;
        
    }if (number == 10) {
        NSMutableString *textString = [[NSMutableString alloc] initWithFormat:@"%@.",self.dianzizhangdanText.text];
self.dianzizhangdanText.text = textString;
    }if (number == 12) {
        NSMutableString *textString = [[NSMutableString alloc] initWithFormat:@"%@0",self.dianzizhangdanText.text];
        
        self.dianzizhangdanText.text = textString;
        
        
        
    }
}

- (void)xiaqufangfa{
    
    [self.view endEditing:YES];
}

- (void)numberKeyBoardBackspace {
    NSMutableString* mutableString = [[NSMutableString alloc] initWithFormat:@"%@",self.dianzizhangdanText.text];
    
    if ([mutableString length] >= 1) {
        NSRange tmpRange;
        tmpRange.location = [mutableString length] - 1;
        tmpRange.length = 1;
        [mutableString deleteCharactersInRange:tmpRange];
    }
    self.dianzizhangdanText.text = mutableString;
    
}

- (void)numberKeyBoardFinish
{
    //    DebugLog(@"finished.......");
    [self.dianzizhangdanText resignFirstResponder];
}

- (void)bgButtonClick27703784131
{
    
    [self.dianzizhangdanText resignFirstResponder];
    
    
}

- (void) numberKeyBoardShou{
    
    [self xiaqufangfa];
}




//
//- (void)showAlertViewWithMessage:(NSString *)message{
//    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//    [alert show];
//}
//

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
