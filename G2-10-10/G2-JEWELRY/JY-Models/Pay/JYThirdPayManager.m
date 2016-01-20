//
//  JYPayManager.m
//  G2TestDemo
//
//  Created by ws on 15/12/24.
//  Copyright © 2015年 ws. All rights reserved.
//

#import "JYThirdPayManager.h"
#import "HttpTool.h"
#import "PayType.h"
#import "MJExtension.h"
#import "NDLBusinessConfigure.h"

@implementation JYThirdPayManager



-(void)requestPaymentMethodBlock:(httpResponseSuccess )block
{
    NSString *urlStr  = [NSString stringWithFormat:@"%@/canyin-frontdesk/order/ajax/getpaymentTypes?returnJson=json",ceshiIP];
    //http://localhost:8080/jewelry-main/iosPro/iosPaytype?returnJson=true&payStatus=1
    NSString *urlStrJY = [NSString stringWithFormat:@"%@/jewelry-main/iosPro/iosPaytype?returnJson=true&payStatus=1",ceshiIP];
    NSLog(@"%@",urlStrJY);
    [HttpTool GET:urlStrJY parameters:nil success:^(id responseObject) {
        
        NSLog(@"  payment request %@",responseObject);
        NSDictionary *dic = [responseObject objectForKey:@"iosReturnJson"];
        //NSDictionary *dic = [arr firstObject];
        NSArray *paymentObjectArr = [dic objectForKey:@"objectzJson"];
        
        
        //NSLog(@"%@",arr);
        NSArray *paymentArr = [NSArray arrayWithArray:[PayType mj_objectArrayWithKeyValuesArray:paymentObjectArr]];
        if (paymentArr.count >0) {
            block(paymentArr,nil);
        }
        else
        {
            block(nil,nil);
        }
        
        
    } failure:^(NSError *error){
        NSLog(@"%@",error);
        block(nil,error.localizedDescription);
    }];
    
}




@end
