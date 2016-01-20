//
//  OrderViewController.h
//  G2TestDemo
//
//  Created by lcc on 15/7/23.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Singleton.h"
#import "DeskState.h"
#import "replacePG.h"
#import "BaseViewController.h"
#import "NDLCoreBusincessHeader.h"

@interface OrderViewController : NDLBaseOrderViewController

SingletonH(OrderView)

@property (nonatomic, strong) DeskState *ST;

@property (nonatomic, assign) BOOL canReplace;

@property (nonatomic, copy) replacePG *replaceInfo;
@property (nonatomic, copy) NSString *replaceTaoCanID;


@property (nonatomic, copy)NSString *whereFromStr;

-(void)deleteOrderWithClosedNoItems;
-(void)saveOrderItems;
-(void)printOrderInfo:(NSMutableArray*)foodMenuArr;
-(void)showOrderInfo:(NSMutableArray* )foodMenuArr;
-(void)clearBillChangeRecordList;
-(void)payCash;

@end
