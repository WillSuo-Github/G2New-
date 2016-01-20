//
//  TransactionParameter.h
//  G2TestDemo
//
//  Created by ws on 15/12/18.
//  Copyright © 2015年 ws. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TransactionParameter : NSObject
/**
 *  out_trade_no  商户唯一订单号
 auth_code 扫码枪扫描到的用户的付款条码
 total_amount 订单总金额（微信支付为分，支付宝支付为元）
 subject 商品或支付单简要描述
 pay_type支付方式（ali_pay：支付宝支付,qq_pay：qq钱包,weixin_pay：微信支付,baidu_pay：百度钱包）
 merchant_no 商户号（腾势管理的商户的id）
 appl_id 应用标识;
 */

/**
*  商户唯一订单号
*/
@property (strong,nonatomic)NSString *out_trade_no;
/**
 *  扫码枪扫描到的用户的付款条码
 */
@property (strong,nonatomic)NSString *auth_code;

/**
 *  订单总金额（微信支付为分，支付宝支付为元）
 */
@property (strong,nonatomic)NSString *total_amount;
/**
 *  商品或支付单简要描述
 */
@property (strong,nonatomic)NSString *subject;
/**
 *  支付方式（ali_pay：支付宝支付,qq_pay：qq钱包,weixin_pay：微信支付,baidu_pay：百度钱包）
 */
@property (strong,nonatomic)NSString *pay_type;
/**
 *  （腾势管理的商户的id）
 */
@property (strong,nonatomic)NSString *merchant_no;
/**
 *  应用标识
 */
@property (strong,nonatomic)NSString *appl_id;

/**
 *  登录账号手机
 */
@property (strong,nonatomic)NSString *payee_phone;


@end
