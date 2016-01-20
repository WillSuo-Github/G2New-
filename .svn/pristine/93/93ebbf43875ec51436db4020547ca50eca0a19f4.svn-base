//
//  ErrorMessage.h
//  Copyright (c) 2015年 NDL. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ErrorMessage : NSObject

@property (nonatomic, copy) NSString *statusCode;

@property (nonatomic, copy) NSString *message;

- (instancetype)initWithDic:(NSDictionary *)dic;


+ (instancetype)initWith:(NSDictionary *)dic;


+(void)confirmUIAlertView:(NSString *)message;

/*
 *网络连接系统正常
 */
#define networkRight 10000000
#define networkError -1001
extern NSString *bsNetstatus;

+(void)handleNetworkError:(NSError *)error;

@end
