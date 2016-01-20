//
//  LineChartModel.h
//  G2TestDemo
//
//  Created by ws on 15/9/15.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LineChartModel : NSObject

@property (nonatomic, assign) double attendance;
@property (assign,nonatomic) double max_index;
@property (nonatomic,copy)NSString *date_day;
@property (nonatomic,copy)NSString *time_hour;
@property (nonatomic,copy)NSString *max_attendance;
@property (nonatomic,copy)NSString *max_date_day;
@property (nonatomic,copy)NSString *max_time_hour;
@property (copy,nonatomic)NSString *TableTurnoverRate;
@property (assign,nonatomic)double max_TableTurnoverRate;



@end
