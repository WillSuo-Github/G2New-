//
//  SettingManager.m
//  G2TestDemo
//
//  Created by ws on 15/12/8.
//  Copyright © 2015年 ws. All rights reserved.
//

#import "NDLSettingManager.h"

#import "NDLBusinessConfigure.h"
#import "NDLModelConfigure.h"
#import "Common.h"
@implementation NDLSettingManager



// 获得单例 管理
+(NDLSettingManager *) settingManager
{
    static NDLSettingManager *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;

}

-(void)requestSetingInfo:(NSString *)param block:(NDlHttpResponse)block{
    NSString *urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/system/setting?returnJson=json",ceshiIP];
    [HttpTool GET:urlStr parameters:nil success:^(id responseObject) {
        
        NSDictionary *dict = [responseObject objectForKey:@"cashierDeskSetting"];
        //开台后
        NSString *isStartEnterOrder = [dict objectForKey:@"isStartEnterOrder"];
        //预定后
        NSString *isOrderEnterDesk = [dict objectForKey:@"isOrderEnterDesk"];
        //下单确认后
        NSString *isShowPlaceBillConfirmWindow = [dict objectForKey:@"isShowPlaceBillConfirmWindow"];
        //下单后
        NSString *billPlaceEnterDeskOrPay = [dict objectForKey:@"billPlaceEnterDeskOrPay"];
        
        //锁屏时间
        NSString *leaveTime = [dict objectForKey:@"leaveTime"];
        
        
        //操作设置
        if ((NSNull *)isStartEnterOrder != [NSNull null]) {
            [[NSUserDefaults standardUserDefaults] setObject:isStartEnterOrder forKey:KKAITAIHOUINDEX];
        }
        if ((NSNull *)isOrderEnterDesk != [NSNull null]) {
            [[NSUserDefaults standardUserDefaults] setObject:isOrderEnterDesk forKey:KYUDINGHOUINDEX];
        }
        if ((NSNull *)isShowPlaceBillConfirmWindow != [NSNull null]) {
            [[NSUserDefaults standardUserDefaults] setObject:isShowPlaceBillConfirmWindow forKey:KXIANDANQUERENINDEX];
        }
        if ((NSNull *)billPlaceEnterDeskOrPay != [NSNull null]) {
            [[NSUserDefaults standardUserDefaults] setObject:billPlaceEnterDeskOrPay forKey:KXIADANHOUINDEX];
        }
        if ((NSNull *)leaveTime != [NSNull null]) {
            [[NSUserDefaults standardUserDefaults] setObject:leaveTime forKey:KSUOPINGINDEX];
        }
        
        
        //预定设置
        dict = [responseObject objectForKey:@"commonSettingCashierDeskSetting"];
        NSString *yujingshijian = [dict objectForKey:@"orderWarnTime"];
        NSString *suodingshijian = [dict objectForKey:@"orderLockTime"];
        NSString *daoqibaoliushijian = [dict objectForKey:@"orderLockTime"];
        
        [[NSUserDefaults standardUserDefaults] setObject:yujingshijian forKey:KYuJingShiJian];
        [[NSUserDefaults standardUserDefaults] setObject:suodingshijian forKey:KSuoDingShiJian];
        [[NSUserDefaults standardUserDefaults] setObject:daoqibaoliushijian forKey:KDaoQiBaoLiu];
        
        
        if (block) {
            block(nil,nil);
        }
       
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];

}
////打印设置接口
////http://localhost:8080/jewelry-main/productInfo/iosProInfo?returnJson=true&barCode=1
//-(void)closingWithBarCode:(NSString *)barCode block:(NDlHttpResponse)block
//{
//    NSString *urlStr = [NSString stringWithFormat:@"/productInfo/iosProInfo?returnJson=true&barCode=%@",
//                      barCode];
//    HttpTool * http=[HttpTool httpWithURL:NDL_JY_URL isErrorTemplate:YES];
//    
//    [http postWithForm:urlStr parameters:nil modelClass:[JYPayToolType class]
//               keyPath:@"objectzJson" block:^(id responseObject, ErrorMessage *bsErrorMessage) {
//                   NSLog(@"responseObject:%@",responseObject);
//                   //服务器返回结构
//                   if (responseObject) {
//                       if (block) {
//                           block(@"0",nil);
//                       }
//                   }
//               }];
//    
//    
//    
//    
//}
//
////URL：http://localhost:8080/jewelry-main/productInfo/iosProInfo?returnJson=true&barCode=1
////修改密码 接口
//-(void)obtainProduceInfoWith:(NSString *)barCode block:(NDlHttpResponse)block
//{
//    
//}

@end
