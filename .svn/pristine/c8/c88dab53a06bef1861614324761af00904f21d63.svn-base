//
//  NDLOrderDelegate.h
//  G2TestDemo
//
//  Created by NDlan on 6/12/15.
//  Copyright © 2015年 ws. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZhiFuChuanDiPG.h"
@protocol NDLOrderDelegate <NSObject>

@optional
//删除订单
-(void)deleteOrderWithClosedNoItems;

-(void)saveOrderItems;

-(void)showOrderInfo:(NSMutableArray* )foodMenuArr;

-(void)clearBillChangeRecordList;

//点击Table进入餐饮的选菜视图，珠宝不需要,对应Table的选中事件
-(void)wellPickProduct:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

//结账,订单界面跳转到结账界面
-(void)willPayCash:(ZhiFuChuanDiPG *)chuandiPg;

//打印订单，打印订单
-(void)printOrderInfo:(NSMutableArray*)foodMenuArr;
//初始化时获取主页商品数据
- (void)obtainProductListAndCategorys;
//根据种类显示商品
-(void) obtainProductListWithCategoryId:(NSString *)categoryId;
//根据查询条件显示商品
-(void)obtainProductListWithQueryDic:(NSDictionary *)dic;

@end
