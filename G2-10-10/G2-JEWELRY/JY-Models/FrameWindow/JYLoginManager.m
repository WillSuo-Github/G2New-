//
//  JYLoginManager.m
//  G2TestDemo
//
//  Created by NDlan on 6/12/15.
//  Copyright © 2015年 ws. All rights reserved.
//

#import "JYLoginManager.h"
#import "JYModelConfigureHeader.h"
#import "JYProductManager.h"
#import "JYPayManager.h"
#import "JYProductManager.h"
@implementation JYLoginManager

-(void)testLoginSession{
  /*
    NSString *urlStr = [NSString stringWithFormat:@"/jewelry-main/login/urlLogin?u=admin&p=admin&returnJson=true"];
    HttpTool * http=[HttpTool httpWithURL:NDL_JY_URL isErrorTemplate:NO];
    [http getWithForm:urlStr pathPattern:@"/jewelry-main/login/" modelClass:[NSString class] keyPath:@"statusCode" block:^(id responseObject, ErrorMessage *bsErrorMessage) {
        NSLog(@"responseObject:%@",responseObject);
    }];
    */
    NSString *urlStr = [NSString stringWithFormat:@"/jewelry-main/login"];
    HttpTool * http=[HttpTool httpWithURL:NDL_JY_URL isErrorTemplate:YES];
    
    NSLog(@"%@",urlStr);
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"admin",@"username",@"admin",@"password",@"1",@"indexType", nil];
    NSLog(@"%@",dic);

    NSLog(@"%@",urlStr);

[http postWithForm:urlStr parameters:dic modelClass:[NSString class] keyPath:@"statusCode" block:^(id response, ErrorMessage *bsErrorMessage) {
    NSLog(@"login response :%@",response);
}];
    
    
}
-(void)login:(NSString *)accountNumber password:(NSString *)password block:(NDlHttpResponse)block{

    NSString *value = @"0";
    //服务器返回0 表示成功
    if ([value isEqualToString:@"0"]) {
        if (block) {
            block(@"0",nil);
        }
    }else{
        if (block) {
            block(@"1",nil);
        }
    }
    /*
    NSString *urlStr = [NSString stringWithFormat:@"/canyin-frontdesk/login?username=%@,72e12515-f54f-11e4-af9a-02004c4f4f50&password=%@&from=mobile",accountNumber,
                        password];
    HttpTool * http=[HttpTool httpWithURL:ceshiIP isErrorTemplate:NO];
    
    [http postWithForm:urlStr parameters:nil modelClass:[NSDictionary class] keyPath:@"login" block:^(id responseObject, ErrorMessage *bsErrorMessage) {
        NSLog(@"responseObject:%@",responseObject);
        NSLog(@"%@",responseObject);
        
        NSDictionary *dict = [responseObject objectForKey:@"login"];
        NSString *value = [dict objectForKey:@"value"];
        //服务器返回0 表示成功
        //if ([value isEqualToString:@"0"]) {
            if (block) {
                block(@"0",nil);
            }
        else{
            if (block) {
                block(@"1",nil);
            }
        }
        
    //}];

    JYPayManager *pay=[[JYPayManager alloc]init];
    [pay obatinWithPayStatus:@"1"  block:^(NSObject *response,ErrorMessage *errorMessage)  {
        NSLog(@"responseObject:%@",response);
        
        NSString *value=(NSString *)response;
    }];
     */
  
//    JYProductManager *pm=[[JYProductManager alloc]init];
//    [pm obtainProduceInfoWith:@"1"  block:^(NSObject *response,ErrorMessage *errorMessage)  {
//        NSLog(@"responseObject:%@",response);
//        NSString *value=(NSString *)response;i
   // }];
   // -(void)obtainProduceInfoWith:(NSString *)barCode block:(NDlHttpResponse)block
    /*
    NSString *urlStr = [NSString stringWithFormat:@"/canyin-frontdesk/login?username=%@,72e12515-f54f-11e4-af9a-02004c4f4f50&password=%@&from=mobile",accountNumber,
                        password];
    HttpTool * http=[HttpTool httpWithURL:NDL_JY_URL isErrorTemplate:NO];
    
    [http postWithForm:urlStr parameters:nil modelClass:[NSDictionary class] keyPath:@"login" block:^(id responseObject, ErrorMessage *bsErrorMessage) {
        NSLog(@"responseObject:%@",responseObject);
        NSLog(@"%@",responseObject);
        
        NSDictionary *dict = [responseObject objectForKey:@"login"];
        NSString *value = [dict objectForKey:@"value"];
        //服务器返回0 表示成功
        if ([value isEqualToString:@"0"]) {
            if (block) {
                block(@"0",nil);
            }
        }else{
            if (block) {
                block(@"1",nil);
            }
        }

    }];
*/
   
}

@end
