//
//  JYPayManager.m
//  G2TestDemo
//
//  Created by NDlan on 7/12/15.
//  Copyright © 2015年 ws. All rights reserved.
//

#import "JYPayManager.h"
#import "NDLCoreBusincessHeader.h"
#import "JYModelConfigureHeader.h"
#import "JYProductInfoModel.h"

#import "JYPayToolType.h"
#import "JYOrderItem.h"
@implementation JYPayManager

//http://localhost:8080/jewelry-main/iosPro/iosPaytype?returnJson=true&payStatus=1
//支付方式接口
-(void)obatinWithPayStatus:(NSString *)payStatus block:(NDlHttpResponse)block{
    NSString *urlStr = [NSString stringWithFormat:@"/jewelry-main/iosPro/iosPaytype?returnJson=true&payStatus=1"];
    HttpTool * http=[HttpTool httpWithURL:NDL_JY_URL isErrorTemplate:YES];
    
    [http postWithForm:urlStr parameters:nil modelClass:[NSString class]
               keyPath:@"iosReturnJson" block:^(id responseObject, ErrorMessage *bsErrorMessage) {
                   NSLog(@"responseObject:%@",responseObject);
                   // //服务器返回结构
                   if (responseObject) {
                       if (block) {
                           block(responseObject,nil);
                       }
                   }
                   
     }];
}
// 退货
//URL：http:localhost:8080/jewelry-main/iosSales/iosSalesReturn?returnJson=true&salesId=123&itemId=1&barCode=1&reason=不好&amount=155&payType=40288115507e6e7001507e6f71a30002
-(void)returnOrderItem:(JYOrderItem  *)orderItem block:(NDlHttpResponse)block{
    NSString *urlStr = [NSString stringWithFormat:@"/jewelry-main/iosSales/iosSalesReturn?returnJson=true&salesId=%@&itemId=%@&barCode=%@&reason=%@&amount=%@&payType=%@",
                        orderItem.salesId,orderItem.itemId,orderItem.barCode,orderItem.reason,
                        orderItem.amount,orderItem.payType];
    HttpTool * http=[HttpTool httpWithURL:NDL_JY_URL isErrorTemplate:NO];
    
    [http postWithForm:urlStr parameters:nil modelClass:[NSString class]
               keyPath:@"statusCode" block:^(id responseObject, ErrorMessage *bsErrorMessage) {
                   NSLog(@"responseObject:%@",responseObject);
                   // //服务器返回结构
                   if (responseObject) {
                       if (block) {
                           block(responseObject,nil);
                       }  
                   }
                   
               }];
}
/*
 out_trade_no  商户唯一订单号
 auth_code 扫码枪扫描到的用户的付款条码
 total_amount 订单总金额（微信支付为分，支付宝支付为元）
 subject 商品或支付单简要描述
 pay_type支付方式（ali_pay：支付宝支付,qq_pay：qq钱包,weixin_pay：微信支付,baidu_pay：百度钱包）
 merchant_no 商户号（腾势管理的商户的id）
 appl_id 应用标识
 */

//第三方支付
-(void)ThirdPartyPayment:(JYPayModel *)pay block:(NDlHttpResponse)block{

    NSString *urlStr=[NSString stringWithFormat:@"%@/third-party-payment/barPay.do?out_trade_no=%@&auth_code=%@&total_amount=%@&subject=%@&pay_type=%@&merchant_no=tencrwin&appl_id=web_test",NDL_JY_URL,pay.out_trade_no,pay.auth_code,pay.total_amount,pay.subject,pay.pay_type];
    [HttpTool POST:urlStr parameters:nil success:^(id responseObject) {
        
        NSLog(@"%@",responseObject);
        
    } failure:^(NSError *error) {
       
        NSLog(@"%@",error);
        
}];
    
    
//    HttpTool * http=[HttpTool httpWithURL:NDL_JY_URL isErrorTemplate:NO];
//    NSLog(@"----%@",urlStr);
//
//    [http postWithForm:urlStr parameters:nil modelClass:[NSDictionary class]
//               keyPath:@"" block:^(id responseObject, ErrorMessage *bsErrorMessage) {
//                   NSLog(@"responseObject:%@",responseObject);
//                   // //服务器返回结构
//                   if (responseObject) {
//                       if (block) {
//                           block(responseObject,nil);
//                       }
//                   }
//                   
//               }];
//    

}

@end
