//
//  OrderTool.m
//  G2TestDemo
//
//  Created by lcc on 15/7/29.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import "OrderTool.h"
#import "HttpTool.h"
#import "CaiPG.h"
#import "MJExtension.h"


@implementation OrderTool

+ (void)GETNormal:(NSString *)String
 parameters:(id)parameters
    success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure{
    
    NSString *ss = [NSString stringWithFormat:@"%@/canyin-frontdesk/bill/ajax/diancaiContent?billType=1&billId=&returnJson=json",ceshiIP];
    NSString *urlString = [NSString stringWithFormat:@"%@&categoryId=%@",ss,String];

    NSLog(@"++++%@",urlString);

    [HttpTool GET:urlString parameters:nil success:^(id responseObject) {

        
        if (success) {
            NSDictionary *dishes = [responseObject objectForKey:@"dishes"];

            NSArray *arr = [dishes objectForKey:@"content"];
//            NSLog(@"%@",arr);
            arr = [CaiPG objectArrayWithKeyValuesArray:arr];
            
            for (CaiPG *cai in arr) {

                cai.unitNumStr = @"1";
            }
            success(arr);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
    
}


+ (void)GETTaoCan:(NSString *)String
       parameters:(id)parameters
          success:(void (^)(id responseObject))success
          failure:(void (^)(NSError *error))failure{
    
    NSString *ss = [NSString stringWithFormat:@"%@/canyin-frontdesk/bill/ajax/diancaiContent?billType=1&billId=&returnJson=json",ceshiIP];
    NSString *urlString = [NSString stringWithFormat:@"%@&dsCategoryId=%@",ss,String];
    [HttpTool GET:urlString parameters:nil success:^(id responseObject) {
        
        if (success) {
            NSDictionary *dishes = [responseObject objectForKey:@"dishes"];
            NSArray *arr = [dishes objectForKey:@"content"];
            arr = [CaiPG objectArrayWithKeyValuesArray:arr];
            success(arr);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
