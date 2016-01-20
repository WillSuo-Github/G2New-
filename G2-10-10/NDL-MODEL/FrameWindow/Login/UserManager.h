//
//  UserManager.h
//  KTAPP
//
//  Created by admin on 15/8/6.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginUser.h"
#import "ErrorMessage.h"
#import "UserSession.h"


@interface UserManager : NSObject

+(UserManager *)userManager;

+(UserManager *) localUserManager;


+(void) registSession:(UserSession *)userSession;

+(BOOL)checkSession;

+(NSString *)currentSessionId;


#pragma mark -商家经营类型
-(NSMutableArray *) loadLoginUser:(LoginUser *)user;

@end
