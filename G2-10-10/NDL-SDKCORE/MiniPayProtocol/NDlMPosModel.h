//
//  NdlMPosModel.m
//  GITestDemo
//
//  Created by NDlan on 16/11/15.
//  Copyright © 2015年 Kyson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MiniPosSDK.h"

typedef NS_ENUM(NSInteger, VerifyParamsSuccessCode)
{
    NDMPOSK_MANAGER_VERIFYPARAM_CODE3_WRITING =0,//code=3,正在写入参数
    NDMPOSK_MANAGER_VERIFYPARAM_CODE3_SIGN,///code=3 正在签到
    NDMPOSK_MANAGER_VERIFYPARAM_CODE0_SIGN,///code=0 正在签到
    NDMPOSK_MANAGER_VERIFYPARAM_CODE3IN4_WRITING,//正在写入参数
    NDMPOSK_MANAGER_VERIFYPARAM_CODE3IN4_SIGN,//正在签到
    NDMPOSK_MANAGER_VERIFYPARAM_CODE3IN4_SIGNED,//已经签到
    NDMPOSK_MANAGER_VERIFYPARAM_CODE_SIGNED,
    NDMPOSK_MANAGER_NETWOKR_ERROR,///网络连接超时
    
};

typedef NS_ENUM(NSInteger, VerisonUpdatedFromWebAndTransmitToPos)
{
    NDMPOSK_MANAGER_VERSIONUPDATED_DOWN_OK=0,//从服务的获取成功
    NDMPOSK_MANAGER_VERSIONUPDATED_DOWN_ERROR,//从服务的获取异常
    NDMPOSK_MANAGER_VERSIONUPDATED_DOWN_ISNew,//已经是新版本
    NDMPOSK_MANAGER_VERSIONUPDATED_TO_POS_OK,
    NDMPOSK_MANAGER_VERSIONUPDATED_TO_POS_ERROR
    
};


typedef NS_ENUM(NSInteger, PayWithCreditCardType)
{
    NDMPOSK_PAY_CARD_CASH_RANGE_ERROR=0,//常规消费区间是1~50000
    NDMPOSK_PAY_CARD_CASH_DEVICE_ERROR,//无设备连接
    NDMPOSK_PAY_CARD_CASH_OK,//常规消费
    NDMPOSK_PAY_CARD_CASH_ACK,//请确定交易金额！
    NDMPOSK_PAY_CARD_CASH_DEVICE_BUSING//设备繁忙，稍后再试
    
};

//T0消费结果类型
typedef NS_ENUM(NSInteger,PayWithCardT0){
    NDLMPOSK_PAY_CARD_T0_CASH_RANGE_ERROR =0, //
    //NDLMPOSK_PAY_CARD_T0_
};

//T1普通消费结果类型
typedef NS_ENUM(NSInteger,PayWithCardT1){
    NDLMPOSK_PAY_CARD_T1_CASH_RANGE_ERROR =0,
};

typedef NS_ENUM(NSInteger, LoginAndSignResultType)
{
    NDMPOSK_PAY_LOGIN_SIGN_LOGIN_OK=0,//登陆成功
    NDMPOSK_PAY_LOGIN_SIGN_LOGIN_MOBLEORPASS_ERROR,//登录失败，手机号或密码错误！
    NDMPOSK_PAY_LOGIN_SIGN_LOGIN_MOBLEORPASS_OTHERERROR,//常规消费
    NDMPOSK_PAY_LOGIN_SIGN_LOGIN_NETERROR,
    NDMPOSK_PAY_LOGIN_SIGN_OK,//签到成功
    NDMPOSK_PAY_LOGIN_SIGN_ERROR,
    NDMPOSK_PAY_LOGIN_SIGN_DIVICE_CONNECTED,//设备已经连接
    NDMPOSK_PAY_LOGIN_SIGN_DIVICE_NOCONNECTED,//设备没有连接
    NDMPOSK_PAY_LOGIN_SIGN_TIMEOUT,//设备已经连接
    
};


//登录结果类型
typedef NS_ENUM(NSInteger, LoginResultType)
{
    NDLMPOSK_PAY_LOGIN_OK=0,//登陆成功
    NDLMPOSK_PAY_LOGIN_USER_OR_PASSWORD_ERROR, //手机号或密码错误
    NDLMPOSK_PAY_LOGIN_USER_OR_PASSWORD_EMPTY, //手机号或密码空
    NDLMPOSK_PAY_LOGIN_OTHER_ERROR,  //其他错误
    NDLMPOSK_PAY_LOGIN_NETWORK_ERROR,
};
