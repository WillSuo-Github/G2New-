//
//  HttpTool.m
 //  G2TestDemo
//
//  Created by lcc on 15/7/27.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import "HttpTool.h"
#import "AFNetworking.h"
#import "BSCMFrameworkHeader.h"
#import "BSHTTPNetworking.h"

@interface HttpTool(){
    NSString *baseURL;
    BOOL isErrorTemplate;
}

@end
@implementation HttpTool


+(HttpTool *)httpWithURL:(NSString *)url isErrorTemplate:(BOOL)isHandle{
    static HttpTool *httpTool;
    //if (!httpTool) {
        httpTool=[[super alloc] initWithURL:url isErrorTemplate:isHandle];
    //}
    //baseURL=url;
    return httpTool;
    
}

- (instancetype)initWithURL:(NSString *)url isErrorTemplate:(BOOL)isHandle{
    self = [super init];
    if (!self) {
        return nil;
    }
    baseURL=url;
    isErrorTemplate=isHandle;
    return self;
}

-(void)postWithForm:(NSString *)restPath
         parameters:(id)parameters
         modelClass:(Class)modelClass
            keyPath:(NSString *)keyPath
              block:(NDlHttpResponse)block{

    [BSHTTPNetworking setBaseURL:baseURL isErrorTemplate:isErrorTemplate];
    [BSHTTPNetworking httpPOST:restPath
        pathPattern:nil
        parameters:parameters
        modelClass:modelClass
        keyPath:keyPath
        block:^(id response, NSError *error, ErrorMessage *errorMessage) {
            if (block) {
                block(response,errorMessage);
            }
        }
     ];
}

-(void)getWithForm:(NSString *)restPath
       pathPattern:(NSString  *)paramModel
        modelClass:(Class)modelClass
           keyPath:(NSString *)keyPath
             block:(NDlHttpResponse)block{
    [BSHTTPNetworking setBaseURL:baseURL isErrorTemplate:isErrorTemplate];
    [BSHTTPNetworking httpGET:restPath
                   pathPattern:paramModel
     
                    modelClass:modelClass
                       keyPath:keyPath
                         block:^(id response, NSError *error, ErrorMessage *errorMessage) {
                             if (block) {
                                 block(response,errorMessage);
                             }
                         }
     ];

}


+ (void)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    [mgr POST:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)GET:(NSString *)URLString
 parameters:(id)parameters
    success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure{
    
    
  
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    
    [mgr GET:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {

        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


@end
