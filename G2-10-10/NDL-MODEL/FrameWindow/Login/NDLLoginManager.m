//
//  NDLLoginManager.m
//  G2TestDemo
//
//  Created by NDlan on 5/12/15.
//  Copyright © 2015年 ws. All rights reserved.
//

#import "NDLLoginManager.h"
#import "NDLBusinessConfigure.h"
#import "NDLModelConfigure.h"
#import "Common.h"
@interface NDLLoginManager(){
    //dispatch_queue_t _queue;
}

@end
@implementation NDLLoginManager

+(NDLLoginManager *) loginManager{
    static NDLLoginManager *instance;
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
    NSString *urlStr = [NSString stringWithFormat:@"/canyin-frontdesk/login?username=%@&password=%@&from=mobile",accountNumber,
                        password];
    HttpTool * http=[HttpTool httpWithURL:ceshiIP isErrorTemplate:NO];
    
    [http postWithForm:urlStr parameters:nil modelClass:[NSDictionary class] keyPath:@"login" block:^(id responseObject, ErrorMessage *bsErrorMessage) {
        
        NSLog(@"responseObject:%@",responseObject);
        //NSLog(@"%@",responseObject);
        
//#define kG2NDLId     @"kG2NDLId" //诺德兰id
//#define kG2TencrwinId @"kG2TencrwinId"  //滕氏id
//#define KG2RestarantName @"KG2RestarantName" //商户名称
//#define kG2RestarantAddress @"kG2RestarantAddress"//商户地址
//#define kG2RestarantLogoImagePathStr @"kG2RestarantLogoImagePathStr"//商户LOGO图片
        

        
        
        NSDictionary *dict = [responseObject objectForKey:@"login"];
        //add by manman start of line
        // 获得商店信息
        
        //诺德兰ID
        restarantIdStr = [dict objectForKeyedSubscript:@"restId"];
        // 腾势ID
        restarantTenWinIdStr = [dict objectForKeyedSubscript:@"mId"];
        
        //商户名称
        restarantNameStr = [dict objectForKeyedSubscript:@"restName"];
        // 商户地址
        restarantAddressStr = [dict objectForKeyedSubscript:@"adrDetail"];

        //商户LOGO图片
         restarantLogoImagePathStr = [NSString stringWithFormat:@"%@/canyin-main%@",ceshiIP,[dict objectForKeyedSubscript:@"restpic"]];
        
        //商户手机号
        NSString *phoneNo = [dict objectForKeyedSubscript:@"juridicalPhone"];
        
        [[NSUserDefaults standardUserDefaults] setObject:restarantIdStr forKey:kG2NDLId];
        [[NSUserDefaults standardUserDefaults] setObject:restarantTenWinIdStr forKey:kG2TencrwinId];
        [[NSUserDefaults standardUserDefaults] setObject:restarantNameStr forKey:KG2RestarantName];
        [[NSUserDefaults standardUserDefaults] setObject:restarantAddressStr forKey:kG2RestarantAddress];
        [[NSUserDefaults standardUserDefaults] setObject:restarantLogoImagePathStr forKey:kG2RestarantLogoImagePathStr];
        [[NSUserDefaults standardUserDefaults] setObject:phoneNo forKey:kG2PhoneNo];
    
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        NSLog(@"诺德兰ID:%@,滕氏ID:%@",restarantIdStr,restarantTenWinIdStr);
        
        
        
       // NSLog(@"")
        // end of line
        //restarantLogoImagePathStr//
        //http://122.112.12.25:18081/MposApp/activateG2.action?mid=898126020130001&ndlMid=00000000518a3cc901518a5962a80018&sn=G1020150811&flagCode=0800362
        
        //MposApp/activateG2.action?mid=898126020130001&ndlMid=00000000518a3cc901518a5962a80018&sn=G1020150811&flagCode=0800362
        
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
    
    
}


@end
