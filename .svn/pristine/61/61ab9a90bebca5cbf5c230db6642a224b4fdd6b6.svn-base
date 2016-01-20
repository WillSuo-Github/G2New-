//
//  G1BaiduPayViewController.m
//  G2TestDemo
//
//  Created by NDlan on 17/12/15.
//  Copyright © 2015年 ws. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "G1BaiduPayViewController.h"
#import "WDCalculator.h"
#import "ScanQRCodeViewController.h"

@interface G1BaiduPayViewController ()<WDCalculatorDelegate>

@end

@implementation G1BaiduPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     交易所需参数 对象
     */
    self.transactionParameter = [[TransactionParameter alloc]init];
    
    
    WDCalculator *calculator = [[WDCalculator alloc]initWithFrame:self.calculatorView.frame];
    calculator.delegate = self;
    [calculator sizeToFit];
    [self.view addSubview:calculator];
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

-(void)WDCalculatorDidClick:(WDCalculator *)WDCalculator{
    //self.num.text  = [NSString stringWithFormat:@"￥ %.2f",WDCalculator.num];
    self.totalNum.text = [NSString stringWithFormat:@"%.2f",WDCalculator.totalNum];
    self.showStr.text = WDCalculator.str;
}

//常规消费
- (IBAction)normalConsume:(UIButton *)sender {
    
 
    NSLog(@"百度钱包");
    
    
    /**
     out_trade_no  商户唯一订单号
     auth_code 扫码枪扫描到的用户的付款条码
     total_amount 订单总金额（微信支付为分，支付宝支付为元）
     subject 商品或支付单简要描述
     pay_type支付方式（ali_pay：支付宝支付,qq_pay：qq钱包,weixin_pay：微信支付,baidu_pay：百度钱包）
     merchant_no 商户号（腾势管理的商户的id）
     appl_id 应用标识

     */
    NSString *businessId = [[NSUserDefaults standardUserDefaults]stringForKey:kMposG1MerchantNo];
    TransactionParameter *transactionParameter = [[TransactionParameter alloc]init];
    transactionParameter.total_amount = [NSString stringWithFormat:@"%@",self.totalNum];
    transactionParameter.merchant_no = [NSString stringWithFormat:@"%@",businessId];
    transactionParameter.pay_type = [NSString stringWithFormat:@"百度钱包"];
    
    
    ScanQRCodeViewController * scanQRCodeViewController = [[ScanQRCodeViewController alloc]init];
    

    
    
    
    
    
    
}
@end
