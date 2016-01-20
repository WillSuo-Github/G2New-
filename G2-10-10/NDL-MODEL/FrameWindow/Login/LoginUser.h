//
//  LoginUser.h
//  G2TestDemo
//
//  Created by NDlan on 6/12/15.
//  Copyright © 2015年 ws. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginUser : NSObject

//用户名
@property (nonatomic, retain)NSString *username;

//登陆者UseBaseId
@property (nonatomic, assign)NSNumber * userId;

//密码
@property (nonatomic ,retain)NSString *password;

@end
