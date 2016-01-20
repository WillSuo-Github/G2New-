//
//  BSCMFrameworkHeader.h
//  Copyright (c) 2015年 NDL. All rights reserved.
//

#ifndef KTAPP_BSCMFrameworkHeader_h
#define KTAPP_BSCMFrameworkHeader_h

#import "ErrorMessage.h"

@class ErrorMessage;
//业务处理的请求方法对象Resonpse的block
typedef void (^NDlHttpResponse)(id response,
                                ErrorMessage *bsErrorMessage);


//多少次之后，系统把用户锁定
#define USER_LONGIN_NUMBER 5
//认证（摘要认证）之后，需要系统重新提供登陆
#define AUTHORIZATION_RETRY 2

//摘要认证
#define DIGEST_NONCE_KEY @"testNonce"
#define DIGEST_NONCE_VALIDITY_SEC 10000

#pragma mark--第三方网络组件

#import "AFNetworking.h"

#import "BSModelRouter.h"



#import "AFNetworkActivityIndicatorManager.h"
//网络可用性检查
#import "BSNetworkNotify.h"
/**
 *HTTP处理接口方法
 */
//#import "BSHTTPNetworking.h"

#import "Base64.h"

#import "BSSecurity.h"

#import "BSSecurityFactory.h"

//md5,sha1
#import "NSData+CommonCrypto.h"

#import <SystemConfiguration/SystemConfiguration.h>


#endif
