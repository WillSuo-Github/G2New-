//
//  PayTypeModel.h
//  G2TestDemo
//
//  Created by ws on 15/9/14.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PayTypeModel : NSObject

@property (nonatomic, strong) NSArray *allObjects;
@property (nonatomic, assign) NSInteger allTotalmoney;
@property (nonatomic, copy) NSString *allCptIdCount;

//圆形图上的总金额
@property (nonatomic, assign) NSInteger *allMoney;

@end
