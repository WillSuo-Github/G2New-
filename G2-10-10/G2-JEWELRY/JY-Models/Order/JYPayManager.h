//
//  JYPayManager.h
//  G2TestDemo
//
//  Created by NDlan on 7/12/15.
//  Copyright © 2015年 ws. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NDLTransferHeader.h"

#import "JYOrderItem.h"
#import "JYPayToolType.h"
#import "JYPayModel.h"
@interface JYPayManager : NSObject

//http://localhost:8080/jewelry-main/iosPro/iosPaytype?returnJson=true&payStatus=1
//支付方式接口
-(void)obatinWithPayStatus:(NSString *)payStatus block:(NDlHttpResponse)block;


//URL：http:localhost:8080/jewelry-main/iosSales/iosSalesReturn?returnJson=true&salesId=123&itemId=1&barCode=1&reason=不好&amount=155&payType=40288115507e6e7001507e6f71a30002
//退货
-(void)returnOrderItem:(JYOrderItem  *)orderItem block:(NDlHttpResponse)block;
//第三方支付
-(void)ThirdPartyPayment:(JYPayModel *)pay block:(NDlHttpResponse)block;
@end
