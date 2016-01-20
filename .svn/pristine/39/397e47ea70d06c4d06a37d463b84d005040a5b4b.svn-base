//
//  UserManager.m
//  KTAPP
//
//  Created by admin on 15/8/6.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "UserManager.h"

#import "UserSession.h"
#import "NSData+CommonCrypto.h"
#import "BSDigestAuthorization.h"

static const char *const kDataLocalOperationQueueName = "kDataLocalOperationQueue";

@interface UserManager(){
    
     dispatch_queue_t _queue;
}
@end

@implementation UserManager

static UserManager *instance;

static UserSession *session;

+(UserManager *)userManager{
    
   return [self localUserManager];
   
    
}

+(UserManager *) localUserManager{
    if (!instance) {
        instance=[[super allocWithZone:nil]init];
        
    }
    return instance;
}
- (instancetype)init {
    if ((self = [super init]) != nil) {
        _queue =
        dispatch_queue_create(kDataLocalOperationQueueName, NULL);
    }
    return self;
}

+(void) registSession:(UserSession *)userSession{
    if (!session) {
        session=[UserSession new];
        
    }
    session.username=userSession.username;
    session.sessionId=userSession.sessionId;
    session.status=userSession.status;
}

+(NSString *)currentSessionId{
    return session.sessionId;
}

+(BOOL)checkSession{
    //BSDigestAuthorization *digest=[BSDigestAuthorization instaceDigestAuthorization];
    
    //return YES;
    if (!session) {
        return NO;
    }
    if (!session.sessionId) {
        return NO;
    }
    if (![session.status isEqualToString:@"0"]) {
        return NO;
    }
    return YES;
}
#pragma mark -商家经营类型

@end
