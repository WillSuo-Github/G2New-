//
//  ErrorMessage.m

//  Copyright (c) 2015年 NDL. All rights reserved.
//

#import "ErrorMessage.h"
#import "BSNetworkNotify.h"
#import <UIKit/UIKit.h>

#define CONFIRM_TITLE @"错误提示"
#define CONFIRM_BUTTON_NAME @"确定"

@implementation ErrorMessage

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
+ (instancetype)initWith:(NSDictionary *)dic
{
    return [[self alloc] initWithDic:dic];
}


-(NSString *)description

{
    return [NSString stringWithFormat:@"错误信息，编码: %@ 错误信息: %@",
            self.statusCode,self.message];
    
}

/**
 *显示确定和取消两种按钮
 */
+(void)confirmUIAlertView:(NSString *)title
                  message:(NSString *)message
                     name:(NSString *)name{
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title                                                  message:message
        delegate:nil
        cancelButtonTitle:name
        otherButtonTitles:nil];
    
    [alert show];
}

+(void)confirmUIAlertView:(NSString *)message
{
    [self confirmUIAlertView:CONFIRM_TITLE
                     message:message
                        name:CONFIRM_BUTTON_NAME];
    
}

NSString *bsNetstatus=@"缺省状态";

+(void)handleNetworkError:(NSError *)error{
    if (error==nil) {
        bsNetstatus=@"系统连接正常";
    }
    if (error.code<0) {
        bsNetstatus=@"系统连接超时";
    }else{
        bsNetstatus=@"系统连接正常";
    }
}


+(NSInteger )checkNetWork{
    NSString *netStatus =[[BSNetworkNotify sharedBSNetworkNotify] currentNetworkReachability];
    if (![netStatus isEqualToString:@"AppNetOK"]) {
        return networkError;
    }
    if ([bsNetstatus isEqualToString:@"系统连接超时"]) {
        return networkError;
        
    }else if([bsNetstatus isEqualToString:@"缺省状态"]){
        return NSIntegerMax;
    }else {
        return networkRight;
    }
}


@end
