//
//  BSDigestAuthorization.h
//
//  Created by admin on 15/8/25.
//  Copyright (c) 2015年 NDL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@interface BSDigestAuthorization : NSObject

+(BSDigestAuthorization *) instaceDigestAuthorization;

-(void)basicAuthorization:(NSString *)user password:(NSString *)password;

-(void)digestAuthorization:(NSString *)user password:(NSString *)password  digestURI:(NSString *) uri
                httpMethod:(NSString *)httpMethod headerAuthenticate:(NSString *)authenticate;

-(NSURLSessionConfiguration *)currentConfiguration;

-(NSString *)currentDigestAuthorization;

-(void)setRequestSerializer:(AFHTTPRequestSerializer <AFURLRequestSerialization> *)requestSerializer;

-(void) ncDisgest:(NSString *)uri;

@end
