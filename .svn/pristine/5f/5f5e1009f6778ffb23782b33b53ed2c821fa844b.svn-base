//
//  JYOrderManager.m
//  G2TestDemo
//
//  Created by NDlan on 7/12/15.
//  Copyright © 2015年 ws. All rights reserved.
//

#import "JYOrderManager.h"
#import "NDLCoreBusincessHeader.h"
#import "JYModelConfigureHeader.h"

#import "JYProductInfoModel.h"
//订单头信息
#import "JYOderHeadertModel.h"


@implementation JYOrderManager

//打烊接口
//http://localhost:8080/jewelry-main/productInfo/iosProInfo?returnJson=true&barCode=1
-(void)closingWithBarCode:(NSString *)barCode block:(NDlHttpResponse)block{
    NSString *urlStr = [NSString stringWithFormat:@"/jewelry-main/productInfo/iosProInfo?returnJson=true&barCode=%@",
                        barCode];
    HttpTool * http=[HttpTool httpWithURL:NDL_JY_URL isErrorTemplate:NO];
    
    [http postWithForm:urlStr parameters:nil modelClass:[JYProductInfoModel class]
               keyPath:@"objectzJson" block:^(id responseObject, ErrorMessage *bsErrorMessage) {
        NSLog(@"responseObject:%@",responseObject);
        //服务器返回0 表示成功
        if (responseObject) {
            if (block) {
                block(responseObject,nil);
            }
        }
        
    }];
    
}

//URL：http://localhost:8080/jewelry-main/iosSalesItem/orderDetails?returnJson=true&salesId=40288122512e0b0e01512e11e8870004
//订单详细
-(void)obtainOrderItemDetailWithSalesId:(NSString *)salesId block:(NDlHttpResponse)block{
    NSString *urlStr = [NSString stringWithFormat:@"/jewelry-main/iosSalesItem/orderDetails?returnJson=true&salesId=%@",
                        salesId];
    HttpTool * http=[HttpTool httpWithURL:NDL_JY_URL isErrorTemplate:NO];
    
    [http postWithForm:urlStr parameters:nil modelClass:[JYProductInfoModel class]
               keyPath:@"objectzJson" block:^(id responseObject, ErrorMessage *bsErrorMessage) {
                   NSLog(@"responseObject:%@",responseObject);
                   //服务器返回0 表示成功
                   if (responseObject) {
                       if (block) {
                           block(responseObject,nil);
                       }
                   }
                   
               }];

}

//http://localhost:8080/jewelry-main/iosSales/orderList?returnJson=true
//订单头信息
-(void)obtainOrderHeaderWith:(NSDictionary *)queryDic block:(NDlHttpResponse)block{
    NSString *urlStr = [NSString stringWithFormat:@"/jewelry-main/iosSales/orderList?returnJson=true&startTime=2015-12-07&endTime=2015-12-09"];
    HttpTool * http=[HttpTool httpWithURL:NDL_JY_URL isErrorTemplate:YES];
    //http://192.168.1.164:8080/jewelry-main/iosSales/orderList?returnJson=true&startTime=2015-11-19&endTime=2015-11-19
    //http://192.168.1.227:8080/jewelry-main/iosSales/orderList?returnJson=true&startTime=2015-12-07&endTime=2015-12-09
    
    [http postWithForm:urlStr parameters:nil modelClass:[JYOderHeadertModel class]
               keyPath:@"objectzJson" block:^(id responseObject, ErrorMessage *bsErrorMessage) {
                   NSLog(@"responseObject:%@",responseObject);
                   //服务器返回0 表示成功
                   if (responseObject) {
                       if (block) {
                           block(responseObject,nil);
                       }
                   }
                   
               }];
    
}

//商品账单结算保存订单
//http://localhost:8080/jewelry-main/iosSales/iosSaveOrder?returnJson=true&paySum=1000&seller=1&barCode=123,40288122512e0b0e01512e11e8870004
-(void)checkOutWithSavedOrder:(NSString *)paySum seller:(NSString *)seller barCode:(NSString *)barCode block:(NDlHttpResponse)block{
    NSString *urlStr = [NSString stringWithFormat:@"/jewelry-main/iosSales/iosSaveOrder?returnJson=true&paySum=%@&seller=%@&barCode=%@",paySum,seller,barCode];
    HttpTool * http=[HttpTool httpWithURL:NDL_JY_URL isErrorTemplate:NO];
    
    [http postWithForm:urlStr parameters:paySum modelClass:[JYOderHeadertModel class]
               keyPath:@"objectzJson" block:^(id responseObject, ErrorMessage *bsErrorMessage) {
                   NSLog(@"responseObject:%@",responseObject);
                   //服务器返回0 表示成功
                   if (responseObject) {
                       if (block) {
                           block(responseObject,nil);
                       }
                   }
                   
               }];
}


@end
