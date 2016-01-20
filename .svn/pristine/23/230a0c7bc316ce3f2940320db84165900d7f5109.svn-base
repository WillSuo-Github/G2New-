//
//  HttpTool.h
//  G2TestDemo
//
//  Created by lcc on 15/7/27.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BSCMFrameworkHeader.h"
@interface HttpTool : NSObject

+(HttpTool *)httpWithURL:(NSString *)url isErrorTemplate:(BOOL)isHandle;

-(void)postWithForm:(NSString *)restPath
    parameters:(id)parameters
    modelClass:(Class)modelClass
    keyPath:(NSString *)keyPath
    block:(NDlHttpResponse)block;

-(void)getWithForm:(NSString *)restPath
       pathPattern:(NSString  *)paramModel
        modelClass:(Class)modelClass
           keyPath:(NSString *)keyPath
             block:(NDlHttpResponse)block;


+ (void)POST:(NSString *)URLString
    parameters:(id)parameters
    success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure;

+ (void)GET:(NSString *)URLString
     parameters:(id)parameters
     success:(void (^)(id responseObject))success
      failure:(void (^)(NSError *error))failure;

@end
