//
//  BSHTTPNetworking.m
//  KTAPP
//
//  Created by admin on 15/6/15.
//  Copyright (c) 2015年 NDL. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "BSHTTPNetworking.h"
#import "BSCMFrameworkHeader.h"
#import "BSDigestAuthorization.h"
#import "BSModelSerializer.h"
#import "NDLModelConfigure.h"
#import "ErrorMessage.h"
#import "LoginUser.h"
#import "UserSession.h"
@interface BSHTTPNetworking (){
    //modelSerializer = [[BSModelSerializer alloc] init];
    //BSModelSerializer *modelSerializer;
}

@property (nonatomic, strong) AFHTTPRequestOperationManager *bsmanager;

@property (nonatomic, strong) BSModelRouter *router;

@property (nonatomic, strong) BSModelSerializer *modelSerializer;

@end

@implementation BSHTTPNetworking

//@synthesize bsmanager;

@synthesize router;
@synthesize uri;
@synthesize httpMethod;

static LoginUser *loginUser;

static BSDigestAuthorization *digestAuthorization;

static int loginRetryNumber;

static NSString *baseURL;
static BOOL isErrorTemplate;

+(void)setBaseURL:(NSString *)url isErrorTemplate:(BOOL)isHandle{
    baseURL=url;
    isErrorTemplate=isHandle;
}

+(void)currentUser:(LoginUser *)user{
    loginUser=user;
}
/*
+(instancetype)httpManager
{
    return [[super alloc] initWithURL:NDL_URL];
}
*/

+(instancetype)httpManagerWithURL:(NSString *)url isErrorTemplate:(BOOL)isHandle{
    return [[super alloc] initWithURL:url isErrorTemplate:isHandle];

}

- (instancetype)initWithURL:(NSString *)url isErrorTemplate:(BOOL)isHandle{
    self = [super init];
    if (!self) {
        return nil;
    }
    if (!self.modelSerializer) {
        self.modelSerializer=[[BSModelSerializer alloc] init];
    }
    if(!self.router) {
        
        self.router=  [[BSModelRouter alloc]
                       initWithBaseURL:[NSURL URLWithString:url]];
        self.router.isErrorTemplate=isHandle;
        digestAuthorization=[BSDigestAuthorization instaceDigestAuthorization];
    }
    return self;
}

+(instancetype)httpManager:(NSURLSessionConfiguration *)configuration
{
    return [[super alloc] initWithBaseURL:configuration];
}

- (instancetype)initWithBaseURL:(NSURLSessionConfiguration *)configuration{
    self = [super init];
    if (!self) {
        return nil;
    }
    if(!self.router) {
        self.router=  [[BSModelRouter alloc]
                       initWithBaseURL:[NSURL URLWithString:NDL_URL] sessionConfiguration:configuration];
        
    }
    return self;
}

+(void)httpGET:(NSString *)restPath
   pathPattern:(NSString * )pathPattern
    modelClass:(Class)modelClass
       keyPath:(NSString *)keyPath
         block:(BSHTTPResponse)block
{
 
    [self httpGET:restPath
            pathPattern:pathPattern
            modelClass:modelClass
            keyPath:keyPath
            block:block
            errorUILabel:nil
     ];
    
}

+(void)httpGET:(NSString *)restPath
    pathPattern:(NSString * )pathPattern
    modelClass:(Class)modelClass
    keyPath:(NSString *)keyPath
    block:(BSHTTPResponse)block
    errorUILabel:( UILabel *)errorUILabel
{
    BSHTTPNetworking * bshttp=[self httpManagerWithURL:baseURL isErrorTemplate:isErrorTemplate];
     [bshttp get:restPath
        pathPattern:pathPattern
        modelClass:modelClass
        keyPath:keyPath
        block:block
        errorUILabel:errorUILabel
      ];
}


-(void)get:(NSString *)restPath
    pathPattern:(NSString * )pathPattern
    modelClass:(Class)modelClass
    keyPath:(NSString *)keyPath
    block:(BSHTTPResponse)block{
    
    [self get:restPath pathPattern:pathPattern modelClass:modelClass keyPath:keyPath block:(BSHTTPResponse)block
        errorUILabel:nil
     ];
}

/**
 *
 */
#pragma mark -get
-(void)get:(NSString *)restPath
    pathPattern:(NSString * )pathPattern
    modelClass:(Class)modelClass
    keyPath:(NSString *)keyPath
    block:(BSHTTPResponse)block
    errorUILabel:( UILabel *)errorUILabel
{
    //增加网络连接可用性判断
    NSString *netStatus =[[BSNetworkNotify sharedBSNetworkNotify] currentNetworkReachability];
    if (netStatus!=nil&&[netStatus isEqualToString:@"noNet"]) {
        return ;
    }
    NSLog(@"本次请求URL\t%@",baseURL);
    NSLog(@"本次请求路径为%@",restPath);
    NSLog(@"本次请求方法GET");
    
    uri=pathPattern;
    httpMethod=@"GET";
    uri=[[NSString alloc]initWithFormat:@"%@%@",baseURL,pathPattern];
    //[BSHTTPNetworking httpManager];
    [digestAuthorization ncDisgest:uri];
    [router routeGET:pathPattern modelClass:[modelClass class] keyPath:keyPath];
    
    [router GET:restPath parameters:nil
        success:[self block:block errorUILabel:errorUILabel]
        failure:[self block:block failure:nil errorUILabel:errorUILabel]
     ];
    
}

+(void)httpPOST:(NSString *)restPath
    pathPattern:(Class  )paramModel
     parameters:(id)parameters
     modelClass:(Class)modelClass
     keyPath:(NSString *)keyPath
     block:(BSHTTPResponse)block
{
    [self httpPOST:restPath
       pathPattern:paramModel
        parameters:parameters
        modelClass:modelClass
        keyPath:keyPath
        block:block
        errorUILabel:nil
     ];
}

+(void)httpPOST:(NSString *)restPath
    pathPattern:(Class  )paramModel
    parameters:(id)parameters
    modelClass:(Class)modelClass
    keyPath:(NSString *)keyPath
    block:(BSHTTPResponse)block
    errorUILabel:( UILabel *)errorUILabel
{
    BSHTTPNetworking * bshttp=[self httpManagerWithURL:baseURL isErrorTemplate:isErrorTemplate];
    
    [bshttp  post:restPath pathPattern:paramModel
            parameters:parameters
            modelClass:modelClass
            keyPath:keyPath
            block:block
            errorUILabel:errorUILabel
     ];
}

-(void)post:(NSString *)restPath
    pathPattern:(Class  )paramModel
    parameters:(id)parameters
    modelClass:(Class)modelClass
    keyPath:(NSString *)keyPath
      block:(BSHTTPResponse)block{
    [self  post:restPath pathPattern:paramModel
            parameters:parameters
            modelClass:modelClass
            keyPath:keyPath
            block:block
            errorUILabel:nil
     ];
}


#pragma mark - BSHTTP HandlesHttp Restful Post ,Data Model Descrited JMExtension
-(void)post:(NSString *)restPath
    pathPattern:(Class  )paramModel
    parameters:(id)parameters
    modelClass:(Class)modelClass
    keyPath:(NSString *)keyPath
    block:(BSHTTPResponse)block
    errorUILabel:( UILabel *)errorUILabel
{
    NSLog(@"本次请求URL\t%@",baseURL);
    NSLog(@"本次请求路径为\t%@",restPath);
    NSLog(@"本次请求参数\t%@",parameters);
    NSLog(@"本次请求方法POST");
    //增加网络连接可用性判断
    NSString *netStatus =[[BSNetworkNotify sharedBSNetworkNotify] currentNetworkReachability];
    if (netStatus!=nil&&[netStatus isEqualToString:@"noNet"]) {
        return ;
    }
    
    uri=[[NSString alloc]initWithFormat:@"%@%@",baseURL,restPath];
    httpMethod=@"POST";
    //[BSHTTPNetworking httpManager];
    //如果是post方法，当传入的参数不是字典时，需要做转换
    NSDictionary * params=[self.modelSerializer jsonDictionaryForModel:parameters modelClass:paramModel error:nil ];
    //参数转换完成
    [digestAuthorization ncDisgest:uri];
    [router routePOST:restPath modelClass:[modelClass class] keyPath:keyPath];
    
    [router POST:restPath parameters:params
         success:[self block:block errorUILabel:errorUILabel]
         failure:[self block:block failure:nil errorUILabel:errorUILabel]
    ];
   
}



#pragma mark - BSHTTP Handles
- (BSHTTPRequestSuccess)
    block:(BSHTTPResponse)block
    errorUILabel:( UILabel *)errorUILabel{
    return ^(NSURLSessionDataTask *task, id responseObject, id model) {
        [[BSNetworkNotify sharedBSNetworkNotify] networkRunning];
        //Modified LiuJQ
        //[Conf handleNetworkError:nil];
        if (!isErrorTemplate) {
            block(responseObject,nil,nil);
            return ;
        }
        if (block&&![model isKindOfClass:[ErrorMessage class]]) {
            block(model,nil,nil);
        }else if(block&& [model isKindOfClass:[ErrorMessage class]]){
            ErrorMessage *bserror=model;
            NSLog(@"本次请求返回信息为%@",
                  bserror.description);
            if (errorUILabel) {
                errorUILabel.text=[(ErrorMessage *)model message ];
            }else{
                NSString *message=[[[NSString alloc] initWithString:
                                    [(ErrorMessage *)model statusCode ]]
                                   stringByAppendingString:
                                   [(ErrorMessage *)model message ]];
                //[BSUIComponentView confirmUIAlertView:message];
            }
        }
    };
}

+(void)httpAuthorizationPOST:(NSString *)restPath
                 pathPattern:(Class )pathPattern
                  parameters:(id)parameters
                  modelClass:(Class)modelClass
                     keyPath:(NSString *)keyPath
                       block:(BSHTTPResponse)block
{
    
    BSHTTPNetworking * bshttp=[self httpManager:digestAuthorization.currentConfiguration];
    [bshttp  post:restPath pathPattern:pathPattern
       parameters:parameters
       modelClass:modelClass
          keyPath:keyPath
            block:block
     errorUILabel:nil
     ];
}

- (void (^)(NSError *error))
    block:(BSHTTPResponse)block
    failure:(BSHTTPRequestFailure)failure
    errorUILabel:( UILabel *)errorUILabel
{
    return ^(NSError *error) {
        NSDictionary *dict=error.userInfo;
        //错误码
        NSString *localizedDescription=[dict objectForKey:@"NSLocalizedDescription"];
        
        NSHTTPURLResponse *httpResponse=(NSHTTPURLResponse *)[dict objectForKey:@"com.alamofire.serialization.response.error.response"];
 
        NSString *errorDescription=(NSString *)[dict objectForKey:@"NSLocalizedDescription"];
  
        //不是系统异常，是由于没有配置统一处理模型，而使用了它，不是系统异常
        if (block&&isErrorTemplate&&errorDescription==nil){
            //[ErrorMessage handleNetworkError:error];
            if (errorUILabel) {
                errorUILabel.text=@"系统异常";
                errorUILabel.text=@"模型转换出现异常";
            }else {
                [ErrorMessage
                 confirmUIAlertView:@"模型转换出现异常"];
                
            }
        }
        int underlyingError=(int)[dict objectForKey:@"_kCFStreamErrorCodeKey"];
       // [4]	(null)	 @"_kCFStreamErrorCodeKey" : (int)61/798
        NSLog(@"系统出现异常，详细信息:\n%@",error);
        BOOL bCode= error.code==-1004||error.code==-1001;
        BOOL bResponse= httpResponse==nil;
        //[5]	(null)	@"NSLocalizedDescription" : @"未能连接到服务器。"
        BOOL bDesc=([errorDescription isEqualToString:@"未能连接到服务器。"]||
            [errorDescription isEqualToString:@"请求超时。"]);
        //underlyingError	int	0	0
        BOOL bUnderError= (underlyingError==978||underlyingError==0);
        if((bCode || bResponse) && (bDesc|| bUnderError) ){
            [[BSNetworkNotify sharedBSNetworkNotify] networkTimeOut];
            return ;
        }
        //key	__NSCFConstantString *	@"Www-Authenticate"	0x00000001107bc478
        //value	__NSCFString *	@"Digest realm=\"REST-Realm\", qop=\"auth\", nonce=\"MTQ0MDUyNDE4OTUxOTplYjAyY2UyYzhhOGQ1MTU4YjRmMWVhNjQ0NzRiMDZjOQ==\""	0x00007f83a870e290
        NSDictionary *headerFields = [httpResponse allHeaderFields];
        NSString *authenticate=(NSString *)[headerFields objectForKey:@"Www-Authenticate"];
        NSLog(@"系统出现异常，权限信息:\n%@",authenticate);
        
        //NSString *uriResponse=(NSString *)[dict objectForKey:@"NSErrorFailingURLKey"];
        //
        //uriResponse=[[NSString alloc]initWithFormat:@"%@%@",KBS_URL,uri];
        NSString *realmResponse=[[authenticate substringToIndex:6] lowercaseString];
        if ([realmResponse containsString:@"digest"]) {//
            [digestAuthorization digestAuthorization:@"marcin" password:@"michalski"
                                           digestURI:uri httpMethod:httpMethod
                                  headerAuthenticate:authenticate];
            //[digestAuthorization digestAuthorization:@"anonymous" password:@""
            //                               digestURI:uri httpMethod:httpMethod
            //                      headerAuthenticate:authenticate];

        }
        

        //如果是权限问题继续提交
        if ([localizedDescription containsString:@"401"]&&loginRetryNumber<AUTHORIZATION_RETRY) {
            //权限认证出现异常,则再次请求
            loginRetryNumber++;
             NSDictionary *dicLogin = [NSDictionary dictionaryWithObjectsAndKeys:loginUser.username,@"username",
                loginUser.password,@"password", nil];
            [BSHTTPNetworking httpAuthorizationPOST:USER_LOGIN_SCHEMA
                           pathPattern:[LoginUser class]
                            parameters:dicLogin
                            modelClass:[UserSession class]
                               keyPath:@""
                                 block:(BSHTTPResponse)block
             ];
             return ;
        }
        //if (block&&loginRetryNumber>=AUTHORIZATION_RETRY) {
        if (block){
            [ErrorMessage handleNetworkError:error];
            if (errorUILabel) {
                errorUILabel.text=error.description;
                errorUILabel.text=localizedDescription;
            }else {
                [ErrorMessage
                 confirmUIAlertView:localizedDescription];

            }
        }
    };
}


@end
