//
//  ChangeFoodController.h
//  G2TestDemo
//
//  Created by lcc on 15/9/7.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CaiPG.h"
#import "JiKou.h"

@protocol ShiJiaDleGate <NSObject>

-(void)sendMesage :(NSString *)number andWithPrice:(NSString *)price andWithIndex:(NSIndexPath *)index andWithJiKou:(JiKou *)jikoM;

@end
@interface ChangeFoodController : UIViewController

@property (nonatomic, copy) NSString *taocanID;

@property (nonatomic, copy) NSString *dedishID;

@property (nonatomic, copy) NSString *caiName;
//WHC 判断来源 如果为已经下的单 什么都不能改变
@property (nonatomic,copy) NSString *panDuanStr;
@property (nonatomic,copy) NSString *atOnceMoney;
@property (nonatomic,strong) NSIndexPath *indexPath;
@property (nonatomic,copy) NSString *number;
@property (copy,nonatomic )NSString *zengsong;

@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UIButton *jianBtn;
@property (weak, nonatomic) IBOutlet UIView *zengsongView1;
@property (assign,nonatomic) id<ShiJiaDleGate>delegate;
@property (strong,nonatomic) NSMutableArray *jiKouArr;
@end
