//
//  ThirdPayDataManager.m
//  G2TestDemo
//
//  Created by ws on 15/12/23.
//  Copyright © 2015年 ws. All rights reserved.
//

#import "NDLThirdPayDataManager.h"
#import "HttpTool.h"
#import "PayType.h"
#import "MJExtension.h"
#import "NDLBusinessConfigure.h"

@implementation NDLThirdPayDataManager

-(void)requestPaymentMethodBlock:(httpResponseSuccess )block
{
    NSString *urlStr  = [NSString stringWithFormat:@"%@/canyin-frontdesk/order/ajax/getpaymentTypes?returnJson=json",ceshiIP];
     NSLog(@"%@",urlStr);
    [HttpTool GET:urlStr parameters:nil success:^(id responseObject) {
        
        NSLog(@"  payment request %@",responseObject);
        NSArray *arr = [responseObject objectForKey:@"paymentTypes"];
        //NSLog(@"%@",arr);
         NSMutableArray *paymentArr = [NSMutableArray arrayWithArray:[PayType mj_objectArrayWithKeyValuesArray:arr]];
        for (PayType *tmp in paymentArr) {
            if ([tmp.paymentType isEqualToString:@"1"]) {
                [paymentArr removeObject:tmp];
            }
        }
        if (paymentArr.count >0) {
            block(paymentArr,nil);
        }else
        {
            block(nil,nil);
        }
        
        
    } failure:^(NSError *error){
        NSLog(@"%@",error);
        block(nil,error.localizedDescription);
    }];
    
}



@end
