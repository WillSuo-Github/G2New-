//
//  JYVIPManager.h
//  G2TestDemo
//
//  Created by NDlan on 7/12/15.
//  Copyright © 2015年 ws. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NDLTransferHeader.h"
#import "JYMember.h"


@interface JYVIPManager : NSObject

///http://localhost:8080/jewelry-main/productInfo/iosProInfo?returnJson=true&barCode=1
//修改密码
-(void)modifiedPassword:(NSString *)password block:(NDlHttpResponse)block;


//http://localhost:8080/jewelry-main/iosMemInfoDetail/iosMemInfoStatus?returnJson=true
//获取会员详细信息
-(void)gainMemberInfoWith:(NSDictionary *)memeberId block:(NDlHttpResponse)block;


//http://http:localhost:8080/jewelry-main/iosMember/iosMemberCardType?returnJson=true
//会员类型
-(void)gainMemberTypeWith:(NSString *)password block:(NDlHttpResponse)block;

//http://localhost:8080/jewelry-main/iosMember/iosMemberCard?returnJson=true
//获取会员信息
-(void)gainMemberBaseWith:(NSDictionary *)queryDic block:(NDlHttpResponse)block;

//URL：	 http:localhost:8080/jewelry-main/iosMember/iosCreateMember?returnJson=true&name=李斯&sex=男&phone=13122334455&cardType=4028810951325f4d015132a6dc590016&feteDay=1992-11-11&profession=医生&education=研究生&mailBox=123@qq.com&remark=11&empId=212
//创建会员
-(void)createMemberBaseWith:(JYMember  *)password block:(NDlHttpResponse)block;

//打印设置接口
//http://localhost:8080/jewelry-main/productInfo/iosProInfo?returnJson=true&barCode=1
-(void)settingPrintInfo:(JYMember *)member block:(NDlHttpResponse)block;


@end
