//
//  SettingManager.h
//  G2TestDemo
//
//  Created by ws on 15/12/8.
//  Copyright © 2015年 ws. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NDLSettingDelegate.h"
#import "NDLTransferHeader.h"

@interface NDLSettingManager : NSObject 



+(NDLSettingManager *) settingManager;

-(void)requestSetingInfo:(NSString *)param block:(NDlHttpResponse)block;

////打印设置接口
////http://localhost:8080/jewelry-main/productInfo/iosProInfo?returnJson=true&barCode=1
/*
 
 
 */

//-(void)closingWithBarCode:(NSString *)barCode block:(NDlHttpResponse)block;
//
//
////URL：http://localhost:8080/jewelry-main/productInfo/iosProInfo?returnJson=true&barCode=1
////修改密码 接口
//-(void)obtainProduceInfoWith:(NSString *)barCode block:(NDlHttpResponse)block;
@end
