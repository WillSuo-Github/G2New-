//
//  G1WeiXinPayViewController.m
//  G2TestDemo
//
//  Created by NDlan on 17/12/15.
//  Copyright © 2015年 ws. All rights reserved.
//

#import "G1WeiXinPayViewController.h"
#import "ScanQRCodeViewController.h"
#import "Common.h"

@interface G1WeiXinPayViewController ()
@property (weak, nonatomic) IBOutlet UITextField *inputAmountTextField;
@property (weak, nonatomic) IBOutlet UIButton *OKButton;
@property (weak, nonatomic) IBOutlet UITextField *inputAmountTextFieldCustom;
@property (weak, nonatomic) IBOutlet UIButton *OKButtonCustom;
@property (weak, nonatomic) IBOutlet UIButton *backButton;

@end

@implementation G1WeiXinPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(-30, 0, 80, 50)];
    [button setTitle:@"取消" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    self.navigationItem.leftBarButtonItem = leftButton;
    
    
    [self.OKButtonCustom addTarget:self action:@selector(OKButtonClick:) forControlEvents:UIControlEventTouchUpInside];

    
    
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    
    self.OKButtonCustom.userInteractionEnabled = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backButtonClick:(UIButton *)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
}



-(void)OKButtonClick:(UIButton *)sender
{
    NSLog(@"buttonClick");
    self.OKButtonCustom.userInteractionEnabled = NO;
    
    /**
     out_trade_no  商户唯一订单号
     auth_code 扫码枪扫描到的用户的付款条码
     total_amount 订单总金额（微信支付为分，支付宝支付为元）
     subject 商品或支付单简要描述
     pay_type支付方式（ali_pay：支付宝支付,qq_pay：qq钱包,weixin_pay：微信支付,baidu_pay：百度钱包）
     merchant_no 商户号（腾势管理的商户的id）
     appl_id 应用标识
     payee_phone 登录账号手机
     */
    NSString *phoneNumStr = [[NSUserDefaults standardUserDefaults]stringForKey:kLoginPhoneNo];
    TransactionParameter *transactionParameter = [[TransactionParameter alloc]init];
    transactionParameter.total_amount = [NSString stringWithFormat:@"%@",self.inputAmountTextFieldCustom.text];
    transactionParameter.out_trade_no = [UtilityGlobal gen_uuid];
    transactionParameter.merchant_no = @"weichuangbao";
    transactionParameter.subject = @"weichuangbao";
    transactionParameter.payee_phone = phoneNumStr;
    transactionParameter.pay_type = [NSString stringWithFormat:@"weixin_pay"];
    transactionParameter.appl_id = @"weichuangbao";
    
    
    ScanQRCodeViewController *scanQRCodeViewController = [[ScanQRCodeViewController alloc]init];
    scanQRCodeViewController.transactionParameter = transactionParameter;
   
    
    
    [self.navigationController pushViewController:scanQRCodeViewController animated:YES];
    
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
