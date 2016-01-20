//
//  NDLLoginManager.m
//  G2TestDemo
//
//  Created by NDlan on 5/12/15.
//  Copyright © 2015年 ws. All rights reserved.
//

#import "NDLLoginManager.h"
#import "NDLBusinessConfigure.h"

@interface NDLLoginManager(){
    dispatch_queue_t _queue;
}

@end
@implementation NDLLoginManager


static NDLLoginManager *instance;

+(NDLLoginManager *) loginManager{
    if (!instance) {
        instance=[[super allocWithZone:nil]init];
    }
    return instance;
}

- (instancetype)init {
    if ((self = [super init]) != nil) {
        //
    }
    return self;
}

-(void)login:(NSString *)accountNumber password:(NSString *)password block:(NDlHttpResponse)block{
    NSString *urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/login?username=%@,72e12515-f54f-11e4-af9a-02004c4f4f50&password=%@&from=mobile",ceshiIP,accountNumber,
                        password];
    [HttpTool POST:urlStr parameters:nil success:^(id responseObject) {
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
        
    } failure:^(NSError *error) {
        NSLog(@"异常为:%@",error.description);
        if (block) {
            block(@"2",nil);
        }
    }];
        
}


@end
