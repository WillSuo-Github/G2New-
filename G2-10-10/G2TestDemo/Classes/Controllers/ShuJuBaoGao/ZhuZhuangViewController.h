//
//  ZhuZhuangViewController.h
//  G2TestDemo
//
//  Created by ws on 15/9/9.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BarChart.h"
#import "ContributionGraph.h"

#import "PNChartDelegate.h"
#import "PNChart.h"
#import "LineChartModel.h"

@interface ZhuZhuangViewController : UIViewController<ContributionGraphDataSource,PNChartDelegate>

+(NSString *)countNumAndChangeformat:(NSString *)num;

//LineChart
@property (nonatomic) PNLineChart * lineChart;

//@property (nonatomic ,strong) LineChartModel *lineChartModel;

@end
