//
//  JYVIPManager.m
//  G2TestDemo
//
//  Created by NDlan on 7/12/15.
//  Copyright © 2015年 ws. All rights reserved.
//

#import "JYVIPManager.h"
#import "NDLCoreBusincessHeader.h"
#import "JYModelConfigureHeader.h"
#import "MJExtension.h"

#import "JYProductInfoModel.h"
#import "JYMemberInfo.h"
#import "JYMemberTypeModel.h"
#import "JYMemberBase.h"
#import "JYMember.h"
@implementation JYVIPManager

+(JYVIPManager *) loginManager{
    static JYVIPManager *instance;
    if (!instance) {
        instance=[[super allocWithZone:nil]init];
    }
    return instance;
}

- (instancetype)init {
    if ((self = [super init]) != nil) {
        //
    }
    return self;
}

///http://localhost:8080/jewelry-main/productInfo/iosProInfo?returnJson=true&barCode=1
///修改密码
-(void)modifiedPassword:(NSString *)password block:(NDlHttpResponse)block{
    NSString *urlStr = [NSString stringWithFormat:@"/jewelry-main/productInfo/iosProInfo?returnJson=true&barCode=%@",
                        password];
    HttpTool * http=[HttpTool httpWithURL:NDL_JY_URL isErrorTemplate:NO];
    
    [http postWithForm:urlStr parameters:nil modelClass:[NSDictionary class] keyPath:@"objectzJson" block:^(id responseObject, ErrorMessage *bsErrorMessage) {
        NSLog(@"responseObject:%@",responseObject);

        if (responseObject) {
            if (block) {
                block(responseObject,nil);
            }
        }
        
    }];

}


//http://localhost:8080/jewelry-main/iosMemInfoDetail/iosMemInfoStatus?returnJson=true
//获取会员详细信息(接口通)
-(void)gainMemberInfoWith:(NSDictionary *)memeberId block:(NDlHttpResponse)block{
    NSString *urlStr = [NSString stringWithFormat:@"/jewelry-main/iosMemInfoDetail/iosMemInfoStatus?returnJson=true"];
    HttpTool * http=[HttpTool httpWithURL:NDL_JY_URL isErrorTemplate:NO];
    
    [http postWithForm:urlStr parameters:memeberId modelClass:[JYMemberInfo class] keyPath:@"objectzJson" block:^(id responseObject, ErrorMessage *bsErrorMessage) {
        NSLog(@"responseObject:%@",responseObject);
        
        if (responseObject) {
            if (block) {
                block(responseObject,nil);
            }
        }
        
    }];
}

//http://http:localhost:8080/jewelry-main/iosMember/iosMemberCardType?returnJson=true
//会员类型(接口通)
-(void)gainMemberTypeWith:(NSString *)password block:(NDlHttpResponse)block{
    NSString *urlStr = [NSString stringWithFormat:@"/jewelry-main/iosMember/iosMemberCardType?returnJson=true"];
    HttpTool * http=[HttpTool httpWithURL:NDL_JY_URL isErrorTemplate:NO];
    
    [http postWithForm:urlStr parameters:nil modelClass:[JYMemberTypeModel class] keyPath:@"objectzJson" block:^(id responseObject, ErrorMessage *bsErrorMessage) {
        NSLog(@"responseObject:%@",responseObject);
        
        if (responseObject) {
            if (block) {
                block(responseObject,nil);
            }
        }
        
    }];

}

//http://localhost:8080/jewelry-main/iosMember/iosMemberCard?returnJson=true
//获取会员信息(接口通)
-(void)gainMemberBaseWith:(NSDictionary *)queryDic block:(NDlHttpResponse)block{
    NSString *urlStr = [NSString stringWithFormat:@"/jewelry-main/iosMember/iosMemberCard?returnJson=true"];
    HttpTool * http=[HttpTool httpWithURL:NDL_JY_URL isErrorTemplate:NO];
    
    [http postWithForm:urlStr parameters:queryDic modelClass:[JYMemberBase class] keyPath:@"objectzJson" block:^(id responseObject, ErrorMessage *bsErrorMessage) {
        NSLog(@"responseObject:%@",responseObject);
        
        if (responseObject) {
            if (block) {
                block(responseObject,nil);
            }
        }
        
    }];
}

//URL：	 http:localhost:8080/jewelry-main/iosMember/iosCreateMember?returnJson=true&name=李斯&sex=男&phone=13122334455&cardType=4028810951325f4d015132a6dc590016&feteDay=1992-11-11&profession=医生&education=研究生&mailBox=123@qq.com&remark=11&empId=212
//创建会员
-(void)createMemberBaseWith:(JYMember *)member block:(NDlHttpResponse)block{
    NSString *urlStr = [NSString stringWithFormat:@"/jewelry-main/iosMember/iosCreateMember?returnJson=true&name=李斯&sex=男&phone=13122334455&cardType=4028810951325f4d015132a6dc590016&feteDay=1992-11-11&profession=医生&education=研究生&mailBox=123@qq.com&remark=11&empId=212"];
    //&name=%@&sex=%@&phone=%@&cardType=%@&feteDay=%@&profession=%@&education=%@&mailBox=%@&remark=%@&empId=%@
    //member.name,member.sex,member.phone,member.cardType,member.feteDay,member.profession,member.education,member.mailBox,member.remark,member.empId
    //NSDictionary *dic = member.keyValues;
    HttpTool * http=[HttpTool httpWithURL:NDL_JY_URL isErrorTemplate:NO];
    
    [http postWithForm:urlStr parameters:nil modelClass:[NSString class] keyPath:@"statusCode" block:^(id responseObject, ErrorMessage *bsErrorMessage) {
        NSLog(@"responseObject:%@",responseObject);
        
    }];
}
@end
