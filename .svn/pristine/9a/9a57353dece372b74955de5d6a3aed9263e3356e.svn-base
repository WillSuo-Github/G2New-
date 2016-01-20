//
//  JYProductManager.h
//  G2TestDemo
//
//  Created by NDlan on 7/12/15.
//  Copyright © 2015年 ws. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NDLTransferHeader.h"

@interface JYProductManager : NSObject

+(JYProductManager *) productManager;

//打烊接口
//http://localhost:8080/jewelry-main/productInfo/iosProInfo?returnJson=true&barCode=1
-(void)closingWithBarCode:(NSString *)barCode block:(NDlHttpResponse)block;


//URL：http://localhost:8080/jewelry-main/productInfo/iosProInfo?returnJson=true&barCode=1
//根据条码查询商品信息
-(void)obtainProduceInfoWith:(NSString *)barCode block:(NDlHttpResponse)block;

///http://localhost:8080/jewelry-main/productInfo/iosList?returnJson=true
//商品页面信息
-(void)obtainProduceInfoWithDic:(NSDictionary*)queryDic block:(NDlHttpResponse)block;
// 商品类别信息
-(void)obtainProduceInfoCateWithDic:(NSDictionary*)queryDic block:(NDlHttpResponse)block;
@end
