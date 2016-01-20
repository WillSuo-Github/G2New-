//
//  HttpTool.h
//  G2TestDemo
//
//  Created by lcc on 15/7/27.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpTool : NSObject


+ (void)POST:(NSString *)URLString
                      parameters:(id)parameters
                         success:(void (^)(id responseObject))success
                         failure:(void (^)(NSError *error))failure;

+ (void)GET:(NSString *)URLString
                     parameters:(id)parameters
                        success:(void (^)(id responseObject))success
                        failure:(void (^)(NSError *error))failure;

@end
