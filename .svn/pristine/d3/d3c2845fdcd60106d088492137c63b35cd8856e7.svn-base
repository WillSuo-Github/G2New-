//
//  PCChartViewController.m
//  PNChartDemo
//
//  Created by kevin on 11/7/13.
//  Copyright (c) 2013年 kevinzhow. All rights reserved.
//

#import "PCChartViewController.h"
#define ARC4RANDOM_MAX 0x100000000

@implementation PCChartViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(130, 100, 320, 280)];
    
    self.lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(13, 400, 653, 210)];
    self.lineChart.yLabelFormat = @"%1.1f";
    self.lineChart.backgroundColor = [UIColor clearColor];
    [self.lineChart setXLabels:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24"]];
    self.lineChart.showCoordinateAxis = YES;
    
//Use yFixedValueMax and yFixedValueMin to Fix the Max and Min Y Value
    //Only if you needed
    self.lineChart.yFixedValueMax = 300.0;
    self.lineChart.yFixedValueMin = 0.0;

    [self.lineChart setYLabels:@[
        @"0",
        @"50",
        @"100",
        @"150",
        @"200",
        @"250",
        @"300",
        ]
     ];
    
    // Line Chart #1
    NSArray * data01Array = @[@60.1, @160.1, @126.4, @0.0, @186.2, @127.2, @176.2];
    PNLineChartData *data01 = [PNLineChartData new];
    data01.dataTitle = @"上座率";
    //data01.color = PNFreshGreen;
    data01.alpha = 0.3f;
    data01.itemCount = data01Array.count;
    data01.inflexionPointStyle = PNLineChartPointStyleTriangle;
    data01.getData = ^(NSUInteger index) {
        CGFloat yValue = [data01Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    // Line Chart #2
    NSArray * data02Array = @[@0.0, @180.1, @26.4, @202.2, @126.2, @167.2, @276.2];
    PNLineChartData *data02 = [PNLineChartData new];
    data02.dataTitle = @"翻台率";
    //data02.color = PNTwitterColor;
    data02.alpha = 0.5f;
    data02.itemCount = data02Array.count;
    data02.inflexionPointStyle = PNLineChartPointStyleCircle;
    data02.getData = ^(NSUInteger index) {
        CGFloat yValue = [data02Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    self.lineChart.chartData = @[data01, data02];
    [self.lineChart strokeChart];
    self.lineChart.delegate = self;
    

    [self.view addSubview:self.lineChart];

    self.lineChart.legendStyle = PNLegendItemStyleStacked;
    self.lineChart.legendFont = [UIFont boldSystemFontOfSize:12.0f];
    self.lineChart.legendFontColor = [UIColor blackColor];
    
    UIView *legend = [self.lineChart getLegendWithMaxWidth:320];
    [legend setFrame:CGRectMake(100, 380, legend.frame.size.width, legend.frame.size.width)];
    [self.view addSubview:legend];
}
    
    
//    NSArray *items = @[[PNPieChartDataItem dataItemWithValue:10 color:PNLightGreen],
//                       [PNPieChartDataItem dataItemWithValue:20 color:PNFreshGreen description:@"WWDC"],
//                       [PNPieChartDataItem dataItemWithValue:40 color:PNDeepGreen description:@"GOOG I/O"],
//                       ];
//    
//    self.pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(SCREEN_WIDTH /2.0 - 100, 135, 200.0, 200.0) items:items];
//    self.pieChart.descriptionTextColor = [UIColor whiteColor];
//    self.pieChart.descriptionTextFont  = [UIFont fontWithName:@"Avenir-Medium" size:11.0];
//    self.pieChart.descriptionTextShadowColor = [UIColor clearColor];
//    self.pieChart.showAbsoluteValues = NO;
//    self.pieChart.showOnlyValues = NO;
//    [self.pieChart strokeChart];

    
//    self.pieChart.legendStyle = PNLegendItemStyleStacked;
//    self.pieChart.legendFont = [UIFont boldSystemFontOfSize:12.0f];
//    
//    UIView *legend = [self.pieChart getLegendWithMaxWidth:200];
//    [legend setFrame:CGRectMake(130, 350, legend.frame.size.width, legend.frame.size.height)];
//    [self.view addSubview:legend];

//    [self.view addSubview:self.pieChart];
//};


- (void)userClickedOnLineKeyPoint:(CGPoint)point lineIndex:(NSInteger)lineIndex pointIndex:(NSInteger)pointIndex{
    NSLog(@"Click Key on line %f, %f line index is %d and point index is %d",point.x, point.y,(int)lineIndex, (int)pointIndex);
}

- (void)userClickedOnLinePoint:(CGPoint)point lineIndex:(NSInteger)lineIndex{
    NSLog(@"Click on line %f, %f, line index is %d",point.x, point.y, (int)lineIndex);
}


@end
