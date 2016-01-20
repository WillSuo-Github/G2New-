   //
//  ZhuZhuangViewController.m
//  G2TestDemo
//
//  Created by ws on 15/9/9.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import "ZhuZhuangViewController.h"
#import "CaiPinFenXiController.h"

#import "HttpTool.h"
#import "topRG.h"
#import "MJExtension.h"
#import "BarChartModel.h"
#import "PayTypeModel.h"

#import "XYPieChart.h"
#import "Example2PieView.h"
#import "MyPieElement.h"
#import "PieLayer.h"
#import "NSDate+FSExtension.h"
#import "FSCalendar.h"
#import "MJExtension.h"


@interface ZhuZhuangViewController ()<XYPieChartDelegate,XYPieChartDataSource,FSCalendarDataSource,FSCalendarDelegate>
{
    BOOL showPercent;
}
//日历
@property (weak, nonatomic) FSCalendar *calendar;
@property (weak, nonatomic) IBOutlet UIButton *riliNoTwo;
@property (weak, nonatomic) IBOutlet UIButton *riliNoOne;
@property (strong,nonatomic) UIView *riliView;
@property (assign,nonatomic) BOOL riqiXuanze;
//判断是否日期搜索
@property (weak, nonatomic) IBOutlet UITextField *riliOne;
@property (weak, nonatomic) IBOutlet UITextField *riliTwo;
@property (assign,nonatomic) BOOL riqiSousuoYesOrNo;
@property (weak, nonatomic) IBOutlet UIView *CaiPinFenXiView;

@property (weak, nonatomic) IBOutlet UIButton *today;
@property (weak, nonatomic) IBOutlet UIButton *jinqitian;
//扇形
@property (weak, nonatomic) IBOutlet Example2PieView *pieView;


@property (nonatomic, strong) PayTypeModel *payTypemodel;
@property (nonatomic, strong) BarChart *barChart;

@property (strong, nonatomic) CaiPinFenXiController *caiVc;
@property (nonatomic, strong) NSMutableArray *shujuArr;
@property (copy,nonatomic) NSString *todayOnlyfist;
@property (nonatomic, strong) NSMutableArray *slices;
@property (nonatomic, strong) NSArray *sliceColors;
//扇形
@property (weak, nonatomic) IBOutlet UILabel *MoneyLable;
//设置加宽字体
@property (weak, nonatomic) IBOutlet UILabel *OneTongJi;
@property (weak, nonatomic) IBOutlet UILabel *shangZuoFenXi;
@property (weak, nonatomic) IBOutlet UILabel *zhiFuFangShi;
@property (weak, nonatomic) IBOutlet UILabel *zhongJianLabel;
//日期选择点击事件
- (IBAction)riqiyixuanze:(id)sender;
//日期查询点击事件
- (IBAction)findUseDate:(id)sender;



@property (nonatomic, strong) NSMutableArray *zhexian1;
@property (nonatomic, strong) NSMutableArray *zhexian2;
@property (nonatomic,strong) NSString *todayOrNot;
@property (weak, nonatomic) IBOutlet UIView *bigView;

@property (strong,nonatomic) NSMutableArray *zheXianW1;
@property (strong,nonatomic) NSMutableArray *zheXianW2;
@end

@implementation ZhuZhuangViewController
@synthesize pieView;
- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化封装图数组
    self.zheXianW1 = [NSMutableArray array];
    self.zheXianW2 = [NSMutableArray array];
    self.riliOne.backgroundColor = [UIColor clearColor];
    self.riliTwo.backgroundColor = [UIColor clearColor];
    [self.riliOne resignFirstResponder];
    [self.riliTwo resignFirstResponder];
    [self.bigView bringSubviewToFront:self.riliNoOne];
    [self.bigView bringSubviewToFront:self.riliNoTwo];
    //
    self.riliOne.userInteractionEnabled = NO;
    self.riliTwo.userInteractionEnabled = NO;
    
    
    
    _barChart = [[BarChart alloc]initWithFrame:CGRectMake(384, 120, 300, 210)];
    
//    PCChartViewController *pccChartView = [[PCChartViewController alloc]init];
//    pccChartView.view.frame = CGRectMake(0, 70, self.view.width - 345, self.view.height);
    
    [self setUpCaipinfenxi];
//    [self setUpPie];
  
    //获取当前时间
    //获取当前时间
    //设置上方时间按钮的默认时间
    NSDate *now = [NSDate date];
    NSCalendar *calendar1 = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar1 components:unitFlags fromDate:now];
    int year = [dateComponent year];
    int month = [dateComponent month];
   
    int day = [dateComponent day];
    NSString *day1 = nil;
    if (day <10) {
        day1 = [NSString stringWithFormat:@"0%d",day];
    }else{
        day1  = [NSString stringWithFormat:@"%d",day];
    }
    NSString *date01111 = [NSString stringWithFormat:@"%d-%d-%@",year,month,day1];
    [self.riliNoOne setTitle:date01111 forState:UIControlStateNormal];
    [self.riliNoTwo setTitle:date01111 forState:UIControlStateNormal];
    [self.riliNoOne setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.riliNoTwo setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    //mutch easier do this with array outside

    
    self.jinqitian.layer.cornerRadius = 15;
    self.jinqitian.layer.masksToBounds = YES;
    
    self.today.layer.cornerRadius = 15;
    self.today.layer.masksToBounds = YES;
    
    _MoneyLable.font = [UIFont fontWithName:@"Arial" size:25];
    _MoneyLable.textColor = [UIColor blueColor];
    //    [_MoneyLable sizeToFit];

    //界面优化 字体调整x
    _OneTongJi.text = @"单项统计";
    [_OneTongJi setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [_OneTongJi sizeToFit];
    
    _shangZuoFenXi.text = @"上座分析";
    [_shangZuoFenXi setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [_shangZuoFenXi sizeToFit];
    
    _zhiFuFangShi.text = @"支付方式";
    [_zhiFuFangShi setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [_zhiFuFangShi sizeToFit];
    
    _zhongJianLabel.text = @"数据报告";
    [_zhongJianLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:23]];
    [_zhongJianLabel sizeToFit];


    

    
    //
    self.todayOrNot = @"today";
    
    [self today:nil];
    
    
//    [self.view addSubview:pccChartView.view];
    [self.view addSubview:_barChart];

    
    [self setpieChart];
    [self riqijianli];
}
- (UIColor*)randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

- (void)setLineChart{
    
    
    self.zhexian1 = [NSMutableArray array];
    self.zhexian2 = [NSMutableArray array];
    NSString *urlStringShangZuo = nil;
    NSString *urlStringFanTai = nil;
    if (self.riqiSousuoYesOrNo) {
        urlStringShangZuo =  [NSString stringWithFormat:@"%@/canyin-frontdesk/report/yyfx/timeDivSeatOccupancyRateStatList?returnJson=json&viewFlag=today&startDate=%@&endDate=%@",ceshiIP,self.riliNoOne.titleLabel.text,self.riliNoTwo.titleLabel.text];
        urlStringFanTai = [NSString stringWithFormat:@"%@/canyin-frontdesk/report/yyfx/fastfoodDinnerfanftailulist?returnJson=json&viewFlag=&startDate=%@&endDate=%@",ceshiIP,self.riliNoOne.titleLabel.text,self.riliNoTwo.titleLabel.text];
        
//        self.riqiSousuoYesOrNo = NO;
    } else {
        urlStringShangZuo =  [NSString stringWithFormat:@"%@/canyin-frontdesk/report/yyfx/timeDivSeatOccupancyRateStatList?returnJson=json&viewFlag=%@&startDate=&endDate=",ceshiIP,self.todayOrNot];
        urlStringFanTai = [NSString stringWithFormat:@"%@/canyin-frontdesk/report/yyfx/fastfoodDinnerfanftailulist?returnJson=json&viewFlag=%@&startDate=&endDate=",ceshiIP,self.todayOrNot];
    }

    
    [HttpTool GET:urlStringShangZuo parameters:nil success:^(id responseObject) {
        NSMutableArray *arr = responseObject[@"hashMapList"];
        self.zheXianW1 = [LineChartModel objectArrayWithKeyValuesArray:arr];
        [HttpTool GET:urlStringFanTai parameters:nil success:^(id responseObject) {
            NSMutableArray *arr1 = responseObject[@"hashMapList"];
            self.zheXianW2 = [LineChartModel objectArrayWithKeyValuesArray:arr1];
            [self CustomLineChartUIAutolayout:self.zheXianW1 And:self.zheXianW2];
        } failure:^(NSError *error) {
            
        }];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
  

    
}

-(void)CustomLineChartUIAutolayout:(NSMutableArray *)firstData And:(NSMutableArray *)scondData
{
    [self.lineChart removeFromSuperview];
    NSLog(@"888%@",scondData);
    self.lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(13, 480.0, 653, 210.0)];
    self.lineChart.yLabelFormat = @"%1.1f";
    self.lineChart.backgroundColor = [UIColor clearColor];
  
    NSMutableArray *arr = [NSMutableArray array];
    LineChartModel *oneLast = [firstData lastObject];
    LineChartModel *twoLast = [scondData lastObject];
    NSMutableArray *zhexian1 = [NSMutableArray array];
    NSMutableArray *zhexian2 = [NSMutableArray array];
    if (self.riqiSousuoYesOrNo) {
        
        for (int i = 0; i < self.zheXianW1.count - 1;  i ++) {
            LineChartModel *model1 = self.zheXianW1[i];
            [arr addObject:model1.date_day];
            NSString *str = [NSString stringWithFormat:@"%f",model1.attendance];
            [zhexian1 addObject:str];
            
            LineChartModel *mode2 = self.zheXianW2[i];
            [zhexian2 addObject:mode2.TableTurnoverRate];
        }
    }else{
    if ([self.todayOrNot isEqualToString: @"today"]) {
//        int k = (int) oneLast.max_TableTurnoverRate;
        //time
        //     NSDictionary *dic =  [self.zheXianW2 keyValues];
        //    NSLog(@"%@",dic);
        for (int i = 0; i < self.zheXianW1.count - 1; i ++) {
            LineChartModel *model1 = self.zheXianW1[i];
            //        NSLog(@"%@",model1.attendance);
            [arr addObject:model1.time_hour];
            //NSString
            NSString *str = [NSString stringWithFormat:@"%f",model1.attendance];
            [zhexian1 addObject:str];
            
            LineChartModel *mode2 = self.zheXianW2[i];
            [zhexian2 addObject:mode2.TableTurnoverRate];
        }
    
        

    }
    else{
        
        for (int i = 0; i < self.zheXianW1.count - 1;  i ++) {
            LineChartModel *model1 = self.zheXianW1[i];
            [arr addObject:model1.date_day];
            NSString *str = [NSString stringWithFormat:@"%f",model1.attendance];
            [zhexian1 addObject:str];
            
            LineChartModel *mode2 = self.zheXianW2[i];
            [zhexian2 addObject:mode2.TableTurnoverRate];
            
        }
    
    }
    }
    [self.lineChart setXLabels:arr];
    self.lineChart.showCoordinateAxis = YES;
    
    //Use yFixedValueMax and yFixedValueMin to Fix the Max and Min Y Value
    //Only if you needed
    self.lineChart.yFixedValueMax = 300.0;
    self.lineChart.yFixedValueMin = 0.0;
    
    // 设置Y轴坐标
    [self.lineChart setYLabels:@[
                                 @"  0 %",
                                 @" 50 %",
                                 @"100 %",
                                 @"150 %",
                                 @"200 %",
                                 @"250 %",
                                 @"300 %",
                                 ]
     ];
    
    // Line Chart  first line
    PNLineChartData *fistLineChartData = [PNLineChartData new];
    fistLineChartData.dataTitle = @"上座率";
    fistLineChartData.color = [UIColor colorWithRed:87/255.0 green:159/255.0 blue:243/255.0 alpha:1];
    fistLineChartData.alpha = 0.3f;
    fistLineChartData.itemCount = zhexian1.count;
    fistLineChartData.inflexionPointStyle = PNLineChartPointStyleTriangle;
    fistLineChartData.getData = ^(NSUInteger index) {
        CGFloat yValue = [zhexian1[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
        
    };
    //LiuJQ
    int j =(int)oneLast.max_index;
  
    if ([self.todayOrNot isEqualToString: @"today"]) {
            fistLineChartData.maxValue=oneLast.max_time_hour;
    }else{
        fistLineChartData.maxValue = oneLast.max_date_day;

    }
        fistLineChartData.maxValuePostion=j;
    
    
    ///
    PNLineChartData *secondLineChartData = [PNLineChartData new];
    secondLineChartData.dataTitle = @"翻台率";
    secondLineChartData.color = [UIColor orangeColor];
    secondLineChartData.alpha = 0.3f;
    secondLineChartData.itemCount = zhexian2.count;
    secondLineChartData.inflexionPointStyle = PNLineChartPointStyleTriangle;
    secondLineChartData.getData = ^(NSUInteger index) {
        CGFloat yValue = [zhexian2[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
        
    };
    //LiuJQ
    int w = (int)twoLast.max_index;

    if ([self.todayOrNot isEqualToString: @"today"]) {
        secondLineChartData.maxValue = twoLast.max_time_hour;
    }else{
        secondLineChartData.maxValue = twoLast.max_date_day;
        
    }
        secondLineChartData.maxValuePostion = w;
    
    
    
    
    self.lineChart.chartData = @[fistLineChartData,secondLineChartData];
    [self.lineChart strokeChart];
    self.lineChart.delegate = self;
    
    
    [self.view addSubview:self.lineChart];
    
    self.lineChart.legendStyle = PNLegendItemStyleStacked;
    self.lineChart.legendFont = [UIFont boldSystemFontOfSize:12.0f];
    self.lineChart.legendFontColor = [UIColor redColor];
    
    UIView *legend = [self.lineChart getLegendWithMaxWidth:320];
    [legend setFrame:CGRectMake(100,450, legend.frame.size.width, legend.frame.size.width)];
    [self.view addSubview:legend];
    
  
}







- (void)setUpPie{
    
    self.slices = [NSMutableArray arrayWithCapacity:10];
    
    for(int i = 0; i < 5; i ++)
    {
        NSNumber *one = [NSNumber numberWithInt:rand()%20];
        [self.slices addObject:one];
    }

    
    
    self.sliceColors =[NSArray arrayWithObjects:
                       [UIColor colorWithRed:246/255.0 green:155/255.0 blue:0/255.0 alpha:1],
                       [UIColor colorWithRed:129/255.0 green:195/255.0 blue:29/255.0 alpha:1],
                       [UIColor colorWithRed:62/255.0 green:173/255.0 blue:219/255.0 alpha:1],
                       [UIColor colorWithRed:229/255.0 green:66/255.0 blue:115/255.0 alpha:1],
                       [UIColor colorWithRed:148/255.0 green:141/255.0 blue:139/255.0 alpha:1],nil];
//    
//    [self.pieView setDataSource:self];
//    [self.pieView setStartPieAngle:M_PI_2];
//    [self.pieView setAnimationSpeed:2.0];
//    [self.pieView setLabelFont:[UIFont fontWithName:@"DBLCDTempBlack" size:16]];
//    [self.pieView setLabelRadius:55];
//    [self.pieView setShowPercentage:YES];
//    [self.pieView setPieBackgroundColor:[UIColor colorWithWhite:0.95 alpha:1]];
//    [self.pieView setPieCenter:CGPointMake(155, 135)];
//    [self.pieView setUserInteractionEnabled:NO];
//    [self.pieView setLabelShadowColor:[UIColor blackColor]];
//    [self.pieView setPieRadius:75];
    
    //设置中心圆
    UILabel *label = [[UILabel alloc] init];
    label.width = 60;
    label.height = 60;
    label.center = CGPointMake(155, 135);
    label.backgroundColor = [UIColor whiteColor];
    label.layer.cornerRadius = label.width / 2;
    label.layer.masksToBounds = YES;
    [self.pieView addSubview:label];
}



- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
}


- (void)viewDidUnload{
    [self setPieView:nil];
    [super viewDidUnload];
}

- (void)setUpCaipinfenxi{
    _caiVc = [[CaiPinFenXiController alloc]init];
    _caiVc.date = @"today";
//    _caiVc.todayOrSevenDay = @"tao";
    _caiVc.todayOrSevenDay = @"today";
    ;
    
    [self.CaiPinFenXiView addSubview:_caiVc.view];
}

- (IBAction)today:(id)sender{
    //请求完毕把日期删除
    self.caiVc.startDate = nil;
    self.caiVc.endDate = nil;
    //菜肴查询界面
    self.riqiSousuoYesOrNo = NO;

    self.jinqitian.backgroundColor = [UIColor clearColor];
    [self.jinqitian setTitleColor:[UIColor colorWithRed:35/255.0 green:122/255.0 blue:234/255.0 alpha:1] forState:UIControlStateNormal];
    [self.today setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.today.backgroundColor = [UIColor colorWithRed:35/255.0 green:122/255.0 blue:234/255.0 alpha:1];
    self.today.selected = YES;
    self.jinqitian.selected = NO;
    [self.shujuArr removeAllObjects];
    self.caiVc.date = @"today";
    self.todayOrNot = @"today";
    //删除扇形
    
  
    while (self.pieView.layer.values.count) {
         [self.pieView.layer deleteValues:@[self.pieView.layer.values[0]] animated:YES];
    }
    if (self.todayOnlyfist) {
          [self setpieChart];
        _caiVc.todayOrSevenDay = @"today";
      

        [_caiVc setMenuContentWithDate:@"today"];
    }
    else {
    self.todayOnlyfist = @"1";
    }
    // 折线
   [self setLineChart];
    //柱状图
   [self requestZhuZhuangTuXinXi];
}

- (IBAction)jinqitian:(id)sender {
    //请求完毕把日期删除
    self.caiVc.startDate = nil;
    self.caiVc.endDate = nil;
    self.riqiSousuoYesOrNo = NO;

    self.jinqitian.backgroundColor = [UIColor colorWithRed:35/255.0 green:122/255.0 blue:234/255.0 alpha:1];
    [self.jinqitian setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.today.backgroundColor = [UIColor clearColor];
    [self.today setTitleColor:[UIColor colorWithRed:35/255.0 green:122/255.0 blue:234/255.0 alpha:1] forState:UIControlStateNormal];
    self.jinqitian.selected = YES;
    self.today.selected = NO;
    [self.shujuArr removeAllObjects];
    self.caiVc.date = @"7day";
    self.todayOrNot = @"7day";
//    self
    while (self.pieView.layer.values.count) {
        [self.pieView.layer deleteValues:@[self.pieView.layer.values[0]] animated:YES];
    }
    ////菜肴查询 按日期查询
    self.caiVc.todayOrSevenDay = @"7day";
    self.caiVc.date = @"e";
    [self.caiVc setMenuContentWithDate:@"7day"];
    [self setLineChart];
    [self setpieChart];
    [self requestZhuZhuangTuXinXi];
}

#pragma mark - pieView的代理和数据源方法

- (NSUInteger)numberOfSlicesInPieChart:(XYPieChart *)pieChart
{
    NSInteger number = self.slices.count;
    return number;
}
//-(void)drawShanxing
- (void)setpieChart{
    NSString *urlString = nil;
    if (self.riqiSousuoYesOrNo) {
        urlString =  [NSString stringWithFormat:@"%@/canyin-frontdesk/report/yyfx/fastfoodDinnerYingShouzonghe?returnJson=json?pageType=&startDate=%@&endDate=%@",ceshiIP,self.riliNoOne.titleLabel.text,self.riliNoTwo.titleLabel.text];
//        self.riqiSousuoYesOrNo = NO;
        NSLog(@"2222222222%@",urlString);
    } else {
        urlString =  [NSString stringWithFormat:@"%@/canyin-frontdesk/report/yyfx/fastfoodDinnerYingShouzonghe?returnJson=json&pageType=%@",ceshiIP,self.todayOrNot];
        NSLog(@"222222222%@",urlString);
    }
    
    [HttpTool POST:urlString parameters:nil success:^(id responseObject) {
     NSLog(@"123456789%@",responseObject);
        while (self.pieView.layer.values.count) {
            [self.pieView.layer deleteValues:@[self.pieView.layer.values[0]] animated:YES];
        }
        self.slices = [NSMutableArray array];
        NSMutableArray *tempArr = [responseObject objectForKey:@"list"];

        NSDictionary *dict = tempArr[0];
        //判断返回是否为空
        if ([dict isKindOfClass:[NSNull class]]) {
            return ;
        }
        NSString *totalMoney = [dict objectForKey:@"totalmoney"];
        
        NSString *aMoney = [NSString stringWithFormat:@"%ld",(long)totalMoney.integerValue];
        //加载扇形
        //扇形值
        //扇形的颜色
        NSMutableArray *arrColor = [NSMutableArray array];
        UIColor * waimaiColor= [UIColor colorWithRed:253/255.0 green:132/255.0 blue:10/255.0 alpha:1];
        UIColor * tangshiColor = [UIColor colorWithRed:87/255.0 green:159/255.0 blue:243/255.0 alpha:1];
        UIColor *yudingColor = [UIColor colorWithRed:47/255.0 green:57/255.0 blue:164/255.0 alpha:1];
        [arrColor addObject:tangshiColor];
        [arrColor addObject:waimaiColor];
        [arrColor addObject:yudingColor];
        //扇形的值
        NSMutableArray *valueArr = [NSMutableArray array];
        NSString *tangshi = dict[@"shitang"];
        NSString *waimai = dict[@"waimai"];
        NSString *yuding = dict[@"yuding"];
        [valueArr addObject:tangshi];
        [valueArr addObject:waimai];
        [valueArr addObject:yuding];
        NSArray *titleArr1 = @[@"堂食",@"外卖",@"预定"];
        NSMutableArray *titleArr = [NSMutableArray arrayWithArray:titleArr1];
        //扇形的标题
        //判断空值 删除 0 数据
        for (int i = 0; i < valueArr.count; i ++) {
            NSString *str = valueArr[i];
            if (![str floatValue]) {
                [valueArr removeObjectAtIndex:i];
                [titleArr removeObjectAtIndex:i];
                [arrColor removeObjectAtIndex:i];
            }
        }
        
        
        
        [self addShanxing:arrColor andWith:titleArr andWith:valueArr];
    //////////////////////////////////////////////
       
        
        
        for (NSString *key in [dict allKeys]) {
            if (![key isEqualToString:@"TIME"]) {
                NSString *bili = [dict objectForKey:key];
                NSString *biliStr = [NSString stringWithFormat:@"%.1f",bili.floatValue];
                
                [self.slices addObject:biliStr];
            }
        }
        
        int count = 0;
        long long int a = aMoney.longLongValue;
        while (a !=0) {
            count ++;
            a /= 10;
        }
        NSMutableString *string = [NSMutableString stringWithString:aMoney];
        NSMutableString *newstring = [NSMutableString string];
        while (count > 3) {
            count -= 3;
            NSRange rang = NSMakeRange(string.length - 3, 3);
            NSString *str = [string substringWithRange:rang];
            [newstring insertString:str atIndex:0];
            [newstring insertString:@"," atIndex:0];
            [string deleteCharactersInRange:rang];
        }
        [newstring insertString:string atIndex:0];
        
        _MoneyLable.text = newstring;
        
    } failure:^(NSError *error) {
        NSLog(@"++%@",error);
    }];
}
//扇形添加 标题等等
-(void)addShanxing :(NSArray *)colarAr andWith:(NSArray *)titleArr andWith:(NSArray *) valueAr
{
    
    for(int i = 0; i < colarAr.count ; i++){
        MyPieElement* elem = [MyPieElement pieElementWithValue:[valueAr[i] intValue] color:colarAr[i]];
//        double k = [valueAr[i]  doubleValue] ;
        elem.title = [NSString stringWithFormat:@"%@ %@%@",titleArr[i],valueAr[i],@"%"];
        [pieView.layer addValues:@[elem] animated:NO];
    }
    showPercent = YES;
    pieView.layer.transformTitleBlock = ^(PieElement* elem, float percent){
        return [(MyPieElement*)elem title];
    };
    pieView.layer.showTitles = 2;

}
//数字分离加逗号方法
+(NSString *)countNumAndChangeformat:(NSString *)num{
    int count = 0;
    long long int a = num.longLongValue;
    while (a != 0) {
        count++;
        a /= 10;
    }
    NSMutableString *string = [NSMutableString stringWithString:num];
    NSMutableString *newstring = [NSMutableString string];
    while (count > 3) {
        count -= 3;
        NSRange rang = NSMakeRange(string.length - 3, 3);
        NSString *str = [string substringWithRange:rang];
        [newstring insertString:str atIndex:0];
        [newstring insertString:@"," atIndex:0];
        [string deleteCharactersInRange:rang];
    }
    [newstring insertString:string atIndex:0];
    return newstring;
}

- (CGFloat)pieChart:(XYPieChart *)pieChart valueForSliceAtIndex:(NSUInteger)index
{
    return [[self.slices objectAtIndex:index] floatValue];
}

- (UIColor *)pieChart:(XYPieChart *)pieChart colorForSliceAtIndex:(NSUInteger)index
{
    
    return [self.sliceColors objectAtIndex:(index % self.sliceColors.count)];
}

- (NSMutableArray *)shujuArr{
    
    if (_shujuArr == nil) {
        _shujuArr = [NSMutableArray array];
    }
    return _shujuArr;
}

#pragma mark - barChart数据源处理方法
-(void)requestZhuZhuangTuXinXi{
    NSString *urlString = nil;
    if (self.riqiSousuoYesOrNo) {
        urlString =  [NSString stringWithFormat:@"%@/canyin-frontdesk/report/yyfx/paymentTypeStatLists?returnJson=json&pageType=&startDate=%@&endDate=%@",ceshiIP,self.riliNoOne.titleLabel.text,self.riliNoTwo.titleLabel.text];
//        self.riqiSousuoYesOrNo = NO;
        NSLog(@"555555555%@",urlString);
    } else {
        urlString =  [NSString stringWithFormat:@"%@/canyin-frontdesk/report/yyfx/paymentTypeStatLists?returnJson=json&pageType=%@",ceshiIP,self.todayOrNot];
        NSLog(@"5555555%@",urlString);
    }

    
//    NSString *urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/report/yyfx/paymentTypeStatLists?returnJson=json&&startDate=2015-09-20&endDate=2015-10-20",ceshiIP];
    //&startDate=2015-11-3&endDate=2015-11-18
    [HttpTool POST:urlString parameters:nil success:^(id responseObject) {
        NSLog(@"4444%@",responseObject);
        NSMutableArray *data = [NSMutableArray arrayWithArray:responseObject[@"pay_type"]];
        NSMutableArray *tempArray = [NSMutableArray array];
        NSMutableArray *xLabelArr = [NSMutableArray array];
        NSDictionary *payTypeDic = [data lastObject];
        _payTypemodel = [[PayTypeModel alloc]init];
        _payTypemodel.allTotalmoney = [payTypeDic[@"allTotalmoney"] integerValue];
        _payTypemodel.allCptIdCount = payTypeDic[@"allCptIdCount"];
//        NSMutableArray *arr = [NSMutableArray arrayWithArray:@[@""]]
        [data removeObject:payTypeDic];
        //界面显示不友好
        NSString *str = [NSString string];
        for (NSDictionary *dic in data) {
            str = [NSString stringWithFormat:@"%@%@",dic[@"paymentName"],str];
        }
        int k = data.count;
        if ([str rangeOfString:@"微信支付"].location == NSNotFound) {
             NSDictionary *dic = @{@"totalmoney":@"1",@"cptIdCount":@"0",@"paymentName":@"微信支付"};
            [data addObject:dic];
        }
        if ([str rangeOfString:@"支付宝支付"].location == NSNotFound) {
             NSDictionary *dic = @{@"totalmoney":@"1",@"cptIdCount":@"0",@"paymentName":@"支付宝支付"};
            [data addObject:dic];
        }
        if ([str rangeOfString:@"现金"].location == NSNotFound) {
             NSDictionary *dic = @{@"totalmoney":@"1",@"cptIdCount":@"0",@"paymentName":@"现金"};
            [data addObject:dic];
        }
        if ([str rangeOfString:@"银行卡支付"].location == NSNotFound) {
             NSDictionary *dic = @{@"totalmoney":@"1",@"cptIdCount":@"0",@"paymentName":@"银行卡支付"};
            [data addObject:dic];
        }
        if ([str rangeOfString:@"会员卡支付"].location == NSNotFound) {
             NSDictionary *dic = @{@"totalmoney":@"1",@"cptIdCount":@"0",@"paymentName":@"会员卡支付"};
            [data addObject:dic];
        }
        if ([str rangeOfString:@"其他支付"].location == NSNotFound) {
             NSDictionary *dic = @{@"totalmoney":@"1",@"cptIdCount":@"0",@"paymentName":@"其他支付"};
            [data addObject:dic];
        }
        if ([str rangeOfString:@"QQ钱包"].location == NSNotFound) {
             NSDictionary *dic = @{@"totalmoney":@"1",@"cptIdCount":@"0",@"paymentName":@"QQ钱包"};
            [data addObject:dic];
        }
        
       

        for (NSDictionary *dic in data) {
            
            BarChartModel *model = [[BarChartModel alloc]initWithDictionary:dic];
            
            CGFloat proportion = (CGFloat)(model.totalmoney*1.0  / _payTypemodel.allTotalmoney);

            [tempArray addObject:@(proportion)];
            @try {
                [xLabelArr addObject:model.paymentName];
            }
            @catch (NSException *exception) {
                NSLog(@"Error is paymentName is null");
            }
            
        }

        _payTypemodel.allObjects = [tempArray copy];
        _barChart.data = _payTypemodel.allObjects;
//        _barChart.data = tempArray;
        _barChart.xLabels = [xLabelArr copy];
//        UIColor *co = [UIColor blueColor];
//        UIColor *co1 = [UIColor grayColor];
//        UIColor *co2 = [UIColor blueColor];
//        UIColor *co3 = [UIColor grayColor];
//        UIColor *co4 = [UIColor grayColor];
//        UIColor *co5 = [UIColor blueColor];
//        UIColor *co6 = [UIColor orangeColor];
//        _barChart.barColors = @[co,co1,co2,co3,co4,co5,co6];
        
    } failure:^(NSError *error) {
        
    }];
    
}


- (IBAction)riqiyixuanze:(id)sender {
    self.riliNoOne.userInteractionEnabled = NO;
    self.riliNoTwo.userInteractionEnabled = NO;
    //日历View
    [self.view bringSubviewToFront:self.riliView];
    self.riliView.hidden = NO;
    UIButton *btn = (UIButton *)sender;
//    btn.userInteractionEnabled = NO;
    if (btn.tag == 520) {
        self.riqiXuanze = YES;
    }
    else
    {
        self.riqiXuanze = NO;
    }
  
}
-(void)riqijianli{
    self.riliView = [[UIView alloc]initWithFrame:CGRectMake(600, 80, 400, 320)];
    self.riliView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.riliView];
    FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, 0, 400, 320)];
    calendar.dataSource = self;
    calendar.delegate = self;
    //获取当前时间
    NSDate *now = [NSDate date];
    NSCalendar *calendar1 = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar1 components:unitFlags fromDate:now];
    int year = [dateComponent year];
    int month = [dateComponent month];
    int day = [dateComponent day];
    //////////
    [calendar selectDate:[NSDate fs_dateWithYear:year month:month day:day]];
    [self.riliView addSubview:calendar];
    self.calendar = calendar;
    self.riliView.hidden = YES;
}
#pragma mark FSCalender的代理
- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date
{
    self.riliNoOne.userInteractionEnabled = YES;
    self.riliNoTwo.userInteractionEnabled = YES;
    self.riliView.hidden = YES;
    if (self.riqiXuanze ) {
        [self.riliNoOne setTintColor:[UIColor grayColor]];

        [self.riliNoOne setTitle:[date fs_stringWithFormat:@"yyyy-MM-dd"] forState:UIControlStateNormal];
    } else {
        [self.riliNoTwo setTintColor:[UIColor grayColor]];
       [self.riliNoTwo setTitle:[date fs_stringWithFormat:@"yyyy-MM-dd"] forState:UIControlStateNormal];
    }
    
//    NSLog(@"did select date %@",[date fs_stringWithFormat:@"yyyy-MM-dd"]);
}

- (void)calendarCurrentPageDidChange:(FSCalendar *)calendar
{
    NSLog(@"did change to page %@",[calendar.currentPage fs_stringWithFormat:@"MMMM yyyy"]);
}

- (BOOL)calendar:(FSCalendar *)calendar hasEventForDate:(NSDate *)date
{
    return date.fs_day == 5;
}
- (IBAction)findUseDate:(id)sender {
     self.riqiSousuoYesOrNo = YES;
//    NSMutableString *str = self.riliNoOne.titleLabel.text;
//    NSMutableString * str =
    //判断选择日期 //设置上方时间按钮的默认时间
    NSDate *now = [NSDate date];
    NSCalendar *calendar1 = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar1 components:unitFlags fromDate:now];
    int year = [dateComponent year];
    int month = [dateComponent month];
    
    int day = [dateComponent day];
    NSString *day1 = nil;
    if (day <10) {
        day1 = [NSString stringWithFormat:@"0%d",day];
    }else{
        day1  = [NSString stringWithFormat:@"%d",day];
    }
    NSString *date01111 = [NSString stringWithFormat:@"%d%d%@",year,month,day1];
    int k =[[[self.riliNoOne.titleLabel.text componentsSeparatedByString:@"-"] componentsJoinedByString:@""] intValue];
    int w = [[[self.riliNoTwo.titleLabel.text componentsSeparatedByString:@"-"] componentsJoinedByString:@""] intValue];
    int h = [date01111 intValue];
    if ([[[self.riliNoOne.titleLabel.text componentsSeparatedByString:@"-"] componentsJoinedByString:@""] intValue] > [[[self.riliNoTwo.titleLabel.text componentsSeparatedByString:@"-"] componentsJoinedByString:@""] intValue]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"时间选择不对" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [alert show];
    }else if(w > h){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"时间选择不对" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];

        
    } else {
        while (self.pieView.layer.values.count) {
            [self.pieView.layer deleteValues:@[self.pieView.layer.values[0]] animated:YES];
        }
        //菜肴按类别查询 日历
        _caiVc.startDate = self.riliNoOne.titleLabel.text;
        _caiVc.endDate = self.riliNoTwo.titleLabel.text;
       
        //折线
        [self setLineChart];
        [_caiVc setMenuContentWithDate:@"7day"];
        //扇形按照日期查询
        [self setpieChart];
        //柱状按日期查询
        [self requestZhuZhuangTuXinXi];

    }
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //王洪昌日历搜索
    self.riliNoOne.userInteractionEnabled = YES;
    self.riliNoTwo.userInteractionEnabled = YES;
    self.riliView.hidden = YES;
}

@end
