//
//  JYOrderManager.h
//  G2TestDemo
//
//  Created by NDlan on 7/12/15.
//  Copyright © 2015年 ws. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NDLTransferHeader.h"
#import "JYOrderDetailModel.h"


@interface JYOrderManager : NSObject

//打烊接口
//http://localhost:8080/jewelry-main/productInfo/iosProInfo?returnJson=true&barCode=1
-(void)closingWithBarCode:(NSString *)barCode block:(NDlHttpResponse)block;

//URL：http://localhost:8080/jewelry-main/iosSalesItem/orderDetails?returnJson=true&salesId=40288122512e0b0e01512e11e8870004
//订单详细
-(void)obtainOrderItemDetailWithSalesId:(NSString *)salesId block:(NDlHttpResponse)block;

//http://localhost:8080/jewelry-main/iosSales/orderList?returnJson=true
//订单头信息
-(void)obtainOrderHeaderWith:(NSDictionary *)queryDic block:(NDlHttpResponse)block;

//商品账单结算保存订单
//http://localhost:8080/jewelry-main/iosSales/iosSaveOrder?returnJson=true&paySum=1000&seller=1&barCode=123,40288122512e0b0e01512e11e8870004
-(void)checkOutWithSavedOrder:(NSString *)paySum seller:(NSString *)seller barCode:(NSString *)barCode block:(NDlHttpResponse)block;

@end
