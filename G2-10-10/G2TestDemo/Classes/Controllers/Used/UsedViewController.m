
//  UsedViewController.m
//  G2TestDemo
//
//  Created by lcc on 15/7/22.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import "UsedViewController.h"
#import "MainViewController.h"

#import "AFNetworking.h"
#import "MJExtension.h"
#import "DeskState.h"
#import "DeskViewCell.h"
#import "HttpTool.h"
#import "MJRefresh.h"
#import "AreaStates.h"
#import "CaiPG.h"
#import "WaiMaiDingdanController.h"
#import "MBProgressHUD.h"
#import "JiKou.h"


#define cellHeight 40
#define TopViewHeight 100
#define waimaiWidth 690


@interface UsedViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,WaiMaiDingdanControllerDelegate>{
    
    BOOL waimaiDetilHidden;
    BOOL waimaiHidden;
    BOOL _isRefreshiang;

}

@property (nonatomic, strong) UIScrollView *scrollV;
@property (nonatomic, strong) NSMutableArray *AllTable;

@property (nonatomic, strong) UICollectionView *collect;

@property (nonatomic, strong) UIRefreshControl *refresh;

@property (nonatomic, strong) NSMutableArray *AreasArr;

@property (nonatomic, strong) NSMutableArray *tmpArr;

@property (nonatomic, strong) UIView *suoyin;

@property (nonatomic, strong) NSMutableArray *orderDetilArr;

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIScrollView *topScorllView;

@property (nonatomic, strong) UIButton *selectBtn;

@property (nonatomic, strong) WaiMaiDingdanController *waimaiVc;

/**
 *  颜色排序的数组
 */
@property (nonatomic, strong) NSMutableArray *darkArr;

@property (nonatomic, strong) NSMutableArray *greenArr;

@property (nonatomic, strong) NSMutableArray *yellowArr;

@property (nonatomic, strong) NSMutableArray *redArr;

@property (nonatomic, strong) NSMutableArray *blueArr;

@property (nonatomic, strong) MBProgressHUD *hub;


@property(nonatomic,strong)UIView *fugaiView;

@property(nonatomic,strong)NSString *tableNum;
@property (strong,nonatomic) NSMutableArray *jiKouArr;



@end

@implementation UsedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _isRefreshiang = NO;
    //初始化数组
    self.jiKouArr = [NSMutableArray array];
    // Do any additional setup after loading the view.[[
    self.view.backgroundColor = [UIColor whiteColor];

    [self requestDeskInfo];
    [self setUpCollectionView];
    
    [self setUpTopView];
    
    [self setUpRightView];
    
    waimaiDetilHidden = YES;
    waimaiHidden = YES;

    CGFloat waimaiH = 668;

    
    self.fugaiView = [[UIView alloc]initWithFrame:CGRectMake(0, 0 ,self.view.width, self.view.height)];
    self.fugaiView.backgroundColor = [UIColor blackColor];
    self.fugaiView.alpha = 0.5;
    self.fugaiView.hidden = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
    [self.fugaiView addGestureRecognizer:tap];
    
//    UIWindow *windows = [UIApplication sharedApplication].keyWindow;
//    [windows.rootViewController.view addSubview:self.fugaiView];
    
    [self.view addSubview:self.fugaiView];
    WaiMaiDingdanController *waimaiVc = [[WaiMaiDingdanController alloc] init];
    waimaiVc.delegate = self;
    self.waimaiVc = waimaiVc;
    self.waimaiVc.moreButton.hidden = YES;
    
    
    //[self.waimaiVc.view addSubview:self.fugaiView];
    
    //waimaiVc.view.frame = CGRectMake(kScreenWidth, 80, waimaiW, waimaiH);
    waimaiVc.view.frame = CGRectMake(kScreenWidth, TopViewHeight,waimaiWidth, waimaiH);
    [self.view addSubview:waimaiVc.view];
    
    self.dishInfoArr = [NSMutableArray array];
    

    

}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.dishInfoArr == nil) {
        [self.dishInfoArr removeAllObjects];
    }
    
    
    
    
}

- (void)requestDeskInfo{
    
    
    //start
    // start
    
    
    for (UIView *view in self.topScorllView.subviews) {
        //        if ([view isKindOfClass:[UIButton class]]) {
//        NSLog(@"%@",view);
        view.layer.borderWidth = 0;
        //view.layer.borderColor = [[UIColor redColor] CGColor];
        //        }
    }
    UIButton *btn = (UIButton *)[self.view viewWithTag:0];
    
    btn.layer.masksToBounds = YES;
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = [[UIColor colorWithRed:78/255.0 green:152/255.0 blue:226/255.0 alpha:1] CGColor];
    
    
    
    // end of line

    
    
    //end of line
    
    
    
    [self showLoding];

    _isRefreshiang = YES;
    NSString *urlS = [NSString stringWithFormat:@"%@/canyin-frontdesk/IOS_index/ajax/table/list?returnJson=json&search_EQ_dinnerStatus=",ceshiIP];
//    DLog(@"%@",urlS);
    [self removeAllArr];
    [self.collect reloadData];

//    NSLog(@"——————————%@",urlS);
    [HttpTool POST:urlS parameters:nil success:^(id responseObject) {
        

        [self hideLoding];
        NSDictionary *dict = [responseObject objectForKey:@"tables"];
        NSMutableArray *arr = [dict objectForKey:@"content"];
//                    NSLog(@"----%@",arr);
        arr = [DeskState mj_objectArrayWithKeyValuesArray:arr];

        [self yansePaiXuWith:arr];
        
        NSArray *areas = [responseObject objectForKey:@"roleTableAreas"];
        
        _AreasArr = [AreaStates mj_objectArrayWithKeyValuesArray:areas];

//        [self.collect reloadData];
        [self.collect.header endRefreshing];
        _isRefreshiang = NO;
        [self setUpTopView];
//        [self setUpSuoyin];
    } failure:^(NSError *error) {
        
        [self hideLoding];
        NSLog(@"&&&&&&%@",error);
        
    }];
    
}

- (void)setUpRightView{
    UIView * btnView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth - 30, 220, 30, 350)];
    for (NSInteger i=0; i < 5; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.frame = CGRectMake(5, 70 *i, 15, 15);
        btn.tag = i + 10;
        [btn addTarget:self action:@selector(yansepaixu:) forControlEvents:UIControlEventTouchUpInside];
        switch (i) {
            case 0:
                btn.backgroundColor = [UIColor colorWithRed:166 / 255.0 green:212 / 255.0 blue:167 / 255.0 alpha:1];
                break;
            case 1:
                btn.backgroundColor = [UIColor colorWithRed:248 / 255.0 green:225 / 255.0 blue:139 / 255.0 alpha:1];
                break;
            case 2:
                btn.backgroundColor = [UIColor colorWithRed:244 / 255.0 green:169 / 255.0 blue:178 / 255.0 alpha:1];
                break;
            case 3:
                btn.backgroundColor = [UIColor colorWithRed:175 / 255.0 green:204 / 255.0 blue:241 / 255.0 alpha:1];
                break;
            case 4:
                btn.backgroundColor = [UIColor colorWithRed:168 / 255.0 green:173 / 255.0 blue:179 / 255.0 alpha:1];
                
            default:
                break;
        }
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = btn.bounds.size.width/2;
        
        [btnView addSubview:btn];
    }
    [self.view addSubview:btnView];
}

- (void)yansepaixu:(UIButton *)btn{

    
    switch (btn.tag) {
        case 10:
            if (self.greenArr.count) {
                NSInteger section = [self.AllTable indexOfObject:self.greenArr[0]];
                NSLog(@"green%ld",section);
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:section inSection:0];
                //[self.collect scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
                DeskViewCell *cell  = (DeskViewCell *)[self.collect cellForItemAtIndexPath:indexPath];
                CGPoint cellPoint = cell.frame.origin;
                cellPoint.x = 0;
                cellPoint.y -= 30;
                [self.collect setContentOffset:cellPoint ];
                
            }
            break;
        case 11:
            if (self.yellowArr.count) {
                NSInteger section = [self.AllTable indexOfObject:self.yellowArr[0]];
                NSLog(@"yellow%ld",section);
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:section inSection:0];
                //[self.collect scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
                DeskViewCell *cell  = (DeskViewCell *)[self.collect cellForItemAtIndexPath:indexPath];
                CGPoint cellPoint = cell.frame.origin;
                cellPoint.x = 0;
               cellPoint.y -= 30;
                [self.collect setContentOffset:cellPoint ];

            }
            break;
        case 12:
            if (self.redArr.count) {
                NSInteger section = [self.AllTable indexOfObject:self.redArr[0]];
                NSLog(@"red%ld",section);
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:section inSection:0];
               // [self.collect scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
                DeskViewCell *cell  = (DeskViewCell *)[self.collect cellForItemAtIndexPath:indexPath];
                CGPoint cellPoint = cell.frame.origin;
                cellPoint.x = 0;
              cellPoint.y -= 30;
                [self.collect setContentOffset:cellPoint ];

            }
            break;
        case 13:
            if (self.blueArr.count) {
                NSInteger section = [self.AllTable indexOfObject:self.blueArr[0]];
                NSLog(@"blue%ld",section);
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:section inSection:0];
               // [self.collect scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
                DeskViewCell *cell  = (DeskViewCell *)[self.collect cellForItemAtIndexPath:indexPath];
                CGPoint cellPoint = cell.frame.origin;
                cellPoint.x = 0;
              cellPoint.y -= 30;
                [self.collect setContentOffset:cellPoint ];

            }
            break;
        case 14:
            if (self.darkArr.count) {
                NSInteger section = [self.AllTable indexOfObject:self.darkArr[0]];//灰色位置
                NSLog(@"dark%ld",section);
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:section inSection:0];
                //[self.collect scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
                DeskViewCell *cell  = (DeskViewCell *)[self.collect cellForItemAtIndexPath:indexPath];
                CGPoint cellPoint = cell.frame.origin;
                cellPoint.x = 0;
                cellPoint.y -= 30;
                [self.collect setContentOffset:cellPoint ];
                
               
            }
            
        default:
            break;
    }
}

- (void)setUpTopView{
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, TopViewHeight)];
    _topView = topView;
    topView.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    [self.view addSubview:topView];
    
    
    UIScrollView *topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(31, 0, kScreenWidth - 200, TopViewHeight)];
    self.topScorllView = topScrollView;
    self.topScorllView.showsHorizontalScrollIndicator = NO;
    
    UILabel *fengexian = [[UILabel alloc]initWithFrame:CGRectMake(0, TopViewHeight, kScreenWidth,1)];
    fengexian.backgroundColor = [UIColor grayColor];
    [self.topView addSubview:fengexian];
    [self.topView addSubview:topScrollView];
    
    UIButton *waimaiBtn = [[UIButton alloc] initWithFrame:CGRectMake(900, TopViewHeight - 40, 80, 30)];
    [waimaiBtn setTitle:@"外卖" forState:UIControlStateNormal];
    [waimaiBtn setBackgroundColor:[UIColor colorWithRed:64/255.0 green:132/255.0 blue:221/255.0 alpha:1]];
    waimaiBtn.layer.cornerRadius = 15;
    waimaiBtn.layer.masksToBounds = YES;
    
    [waimaiBtn addTarget:self action:@selector(waimaiBtnChick) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:waimaiBtn];
    
    
    
    CGFloat btnx;
    CGFloat btnY = 50;
    CGFloat btnW = 80;
    CGFloat btnH = 44;
    NSInteger count = self.AreasArr.count;
    self.topScorllView.contentSize = CGSizeMake(btnW * count + 70, 0);
//    for (int i = 0; i <= count; ++i)
//    {
//        UIButton *btn = [[UIButton alloc] init];
////        btnW = self.topView.width / count;
////        btnH = self.topView.height;
//        
//        if (i == 0)
//        {
//            btnx = i * btnW + 70;
//            btn.frame = CGRectMake(btnx, btnY, btnW + 55, btnH);
//            [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
//            [btn setFont:[UIFont systemFontOfSize:18]];
//            [btn setTitleColor:[UIColor colorWithRed:75/255.0 green:138/255.0 blue:221/255.0 alpha:1] forState:UIControlStateSelected];
//            [btn setBackgroundImage:[UIImage imageNamed:@"dck"] forState:UIControlStateSelected];
//            [btn setTitle:@"全部" forState:UIControlStateNormal];
//            [btn addTarget:self action:@selector(requestDeskInfo) forControlEvents:UIControlEventTouchUpInside];
//        }else
//        {
//            
//            
//            btnx = i * btnW + 70;
//            btn.frame = CGRectMake(btnx, btnY, btnW + 55, btnH);
//            AreaStates *topPg = self.AreasArr[i - 1];
//            btn.tag = i;
//            
//            [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
//            [btn setFont:[UIFont systemFontOfSize:18]];
//            [btn setTitleColor:[UIColor colorWithRed:75/255.0 green:138/255.0 blue:221/255.0 alpha:1] forState:UIControlStateSelected];
//            [btn setBackgroundImage:[UIImage imageNamed:@"dck"] forState:UIControlStateSelected];
//            
//                //        [btn.layer setBorderWidth:1];
//                //        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//                //        CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 1, 0, 0, 1 });
//                //        [btn.layer setBorderColor:colorref];//边框颜色
//            
//            [btn setTitle:topPg.name forState:UIControlStateNormal];
//            [btn addTarget:self action:@selector(topButtonChick:) forControlEvents:UIControlEventTouchUpInside];
//        }
//        
//        
//        
//        
//        
//        
//        
//        
//        
//        if (i == 0) {
//            btn.selected = YES;
//            self.selectBtn = btn;
//        }
//        
//        [self.topScorllView addSubview:btn];
//    }
//    
    
    
    //start
    
    
    CGRect btnFrame = CGRectMake(0, 60, 50, 40);
    for (int i = 0; i <= count; ++i)
    {
        
        if (i == 0) {
            // first button  全部
            UIButton *TmpButton = [self createUIButtonAutoLayoutSizeWithTitle:@"全部" AndOriginalFramePosition:btnFrame];
            //[TmpButton setTitle:@"全部" forState:UIControlStateNormal];
            [TmpButton addTarget:self action:@selector(requestDeskInfo) forControlEvents:UIControlEventTouchUpInside];
            [self.topScorllView addSubview:TmpButton];
            btnFrame.origin.x += TmpButton.size.width +20;
            TmpButton.tag = i+100;
            TmpButton.selected = YES;
            
            TmpButton.layer.masksToBounds = YES;
            TmpButton.layer.borderWidth = 1;
            TmpButton.layer.borderColor = [[UIColor colorWithRed:78/255.0 green:152/255.0 blue:226/255.0 alpha:1] CGColor];
            [TmpButton setTitleColor:[UIColor colorWithRed:78/255.0 green:152/255.0 blue:226/255.0 alpha:1] forState:UIControlStateSelected];
            
           //TmpButton.titleLabel.textColor = [UIColor colorWithRed:78/255.0 green:152/255.0 blue:226/255.0 alpha:1];
            
        }
        else
        {
            
            AreaStates *topPg = self.AreasArr[i - 1];
            
            UIButton *TmpButton = [self createUIButtonAutoLayoutSizeWithTitle:topPg.name AndOriginalFramePosition:btnFrame];
            [TmpButton addTarget:self action:@selector(topButtonChick:) forControlEvents:UIControlEventTouchUpInside];
            [self.topScorllView addSubview:TmpButton];
            btnFrame =  TmpButton.frame;
            btnFrame.origin.x += TmpButton.size.width +20;
            TmpButton.tag = i;
            
            
            
            
        }
        
        
        
    }
    
    
    // end of line
    
    
    
    
    
    
    

}

//start


// button 按钮标题的自适应大小  设置button按钮的大小
-(UIButton *)createUIButtonAutoLayoutSizeWithTitle:(NSString *)titleStr AndOriginalFramePosition:(CGRect) btnFrame
{
    //    NSLog(@"frame:x:%f y:%f w:%f h:%f",btnFrame.origin.x,btnFrame.origin.y,btnFrame.size.width,btnFrame.size.height);
    //NSString *str = @"这是按钮的标题";
    //NSString *str = @"标题";
    //创建一个指定的类型的button
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    //设置button标题的字体
    //btn.titleLabel.font = [UIFont systemFontOfSize:13.0];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
    [btn setTitleColor:[UIColor colorWithRed:78/255.0 green:152/255.0 blue:226/255.0 alpha:1] forState:UIControlStateSelected];
    //[btn setTitleColor:[UIColor redColor]   forState:UIControlStateSelected];
    
    
    //对按钮的外形做了设定，不喜可删~
    //btn.layer.masksToBounds = YES;
    //btn.layer.borderWidth = 1;
    //btn.layer.borderColor = [[UIColor blackColor] CGColor];
    // btn.layer.cornerRadius = 3;
    
    //******
    //[UIColor colorWithRed:85.0 / 255.0 green:90.0 / 255.0 blue:96.0 / 255.0 alpha:1.0f]
    [btn setTitleColor:[UIColor colorWithRed:85.0 / 255.0 green:90.0 / 255.0 blue:96.0 / 255.0 alpha:1.0f] forState:UIControlStateNormal];
    //[btn setFont:[UIFont systemFontOfSize:18]];
    //[btn setTitleColor:[UIColor colorWithRed:75/255.0 green:138/255.0 blue:221/255.0 alpha:1] forState:UIControlStateSelected];
    // [btn setBackgroundImage:[UIImage imageNamed:@"dck"] forState:UIControlStateSelected];
    btn.clipsToBounds = YES;
    //btn.contentMode = UIViewContentModeScaleAspectFill;
    
    
    //*****
    
    //设置标题的颜色 状态
    //    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitle:titleStr forState:UIControlStateNormal];
    
    //重要的是下面这部分哦！
    //获得标题的字体样式和大小 即标题的大小的属性
    CGSize titleSize = [titleStr sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:btn.titleLabel.font.fontName size:btn.titleLabel.font.pointSize]}];
    
    //    NSLog(@"titleSize:w:%f,h:%f",titleSize.width,titleSize.height);
    //
    //    NSLog(@"titleStr:%@",titleStr);
    //标题的高度不变 宽度变化
    titleSize.height = 30;
    //titleSize.width += 20;
    
    btn.frame = CGRectMake(btnFrame.origin.x +10 ,btnFrame.origin.y, titleSize.width +20,titleSize.height);
    
    
    
    //[self.topScrollView  addSubview:btn];
    return btn;
    
}



//end of line





-(void)tapClick:(UITapGestureRecognizer *)tap
{
    CGFloat waimaiH = 668;
//    CGFloat waimaiW = 460;
    
    if (!waimaiHidden ) {
        [UIView animateWithDuration:1.0 animations:^{
            self.waimaiVc.view.frame = CGRectMake(kScreenWidth,100, waimaiWidth, waimaiH);
            waimaiHidden = YES;
            [self.waimaiVc.searchBarTextField resignFirstResponder];
            
        }];
    }
    self.fugaiView.hidden = YES;
    
    
}



- (void)waimaiBtnChick{
    
//    NSLog(@"waimai");
    CGFloat waimaiH = 668;
//    CGFloat waimaiW = 460;

    self.fugaiView.hidden = NO;
    if (waimaiHidden) {
        [UIView animateWithDuration:1.0 animations:^{
            //self.waimaiVc.view.frame = CGRectMake(kScreenWidth - 343, 80, waimaiW, waimaiH);
            self.waimaiVc.view.frame = CGRectMake(kScreenWidth - 420, 100, waimaiWidth, waimaiH);
            self.waimaiVc.moreButton.hidden = YES;
           
            
            NSLog(@"11");
            
            waimaiHidden = NO;
        }];
    }else{
        
        [UIView animateWithDuration:1.0 animations:^{
            self.waimaiVc.view.frame = CGRectMake(kScreenWidth, 100, waimaiWidth, waimaiH);
            waimaiHidden = YES;
            self.waimaiVc.moreButton.hidden = NO;
             self.fugaiView.hidden = YES;
              NSLog(@"22");
        }];
    }
}

- (void)topButtonChick:(UIButton *)btn{
    
    //UIButton *first = (UIButton *)
//    if ([[self.topScorllView viewWithTag:0] isKindOfClass:[UIButton class]]) {
//        UIButton *first = (UIButton *)[self.topScorllView viewWithTag:0];
//        
//        if (first.selected == YES) {
//            first.selected =NO;
//        }
//    };
    
    UIButton *first = (UIButton *)[self.topScorllView viewWithTag:100];
    first.selected = NO;
    
    
    [self showLoding];
    self.selectBtn.selected = NO;
    self.selectBtn = btn;
    self.selectBtn.selected = YES;
    [self removeAllArr];
//    [self.collect reloadData];
    
    
    // start
    
    
    for (UIView *view in self.topScorllView.subviews) {
        //        if ([view isKindOfClass:[UIButton class]]) {
//        NSLog(@"%@",view);
        view.layer.borderWidth = 0;
        //view.layer.borderColor = [[UIColor redColor] CGColor];
        //        }
    }
    
    btn.layer.masksToBounds = YES;
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = [[UIColor colorWithRed:78/255.0 green:152/255.0 blue:226/255.0 alpha:1] CGColor];
    
    
    
    // end of line
    
    
    
    AreaStates *topPg = self.AreasArr[btn.tag - 1];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/IOS_index/ajax/table/list?search_EQ_tableArea.areaId=%@&returnJson=json",ceshiIP,topPg.areaId];
    [HttpTool GET:urlStr parameters:nil success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        [self hideLoding];

        NSDictionary *dict = [responseObject objectForKey:@"tables"];
        NSMutableArray *arr = [dict objectForKey:@"content"];
            //        NSLog(@"%@",arr);
        arr = [DeskState objectArrayWithKeyValuesArray:arr];
        [self yansePaiXuWith:arr];
        
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [self hideLoding];
    }];
    
}

- (void)removeAllArr{
    
    [self.AllTable removeAllObjects];
    [self.greenArr removeAllObjects];
    [self.darkArr removeAllObjects];
    [self.yellowArr removeAllObjects];
    [self.blueArr removeAllObjects];
    [self.redArr removeAllObjects];
}

- (void)yansePaiXuWith:(NSMutableArray *)arr{
    
//    NSLog(@"-------%@",arr);
    
    for (DeskState *state in arr) {
        
        NSString *oneTimeStr = @"";
        NSString *twoTimeStr = @"";
        NSString *threeTimeStr = @"";
        NSString *chaEtimeStr = @"";
        
        if (state.openTableTime)
        {
            NSDateFormatter *date=[[NSDateFormatter alloc] init];
            [date setDateFormat:@"HH:mm"];
            
            NSString *nowDateStr = [date stringFromDate:[NSDate date]];
            
            NSCalendar *cal=[NSCalendar currentCalendar];
            unsigned int unitFlags=NSYearCalendarUnit| NSMonthCalendarUnit| NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit;
            NSDateComponents *d = [cal components:unitFlags fromDate:[date dateFromString:state.openTableTime] toDate:[date dateFromString:nowDateStr] options:0];
//                        NSLog(@"++++%ld+++%ld",[d hour],[d minute]);
            chaEtimeStr = [NSString stringWithFormat:@"%ld",([d hour]*60 + [d minute])];

            threeTimeStr = [NSString stringWithFormat:@"%ld",chaEtimeStr.integerValue / 100];
            twoTimeStr = [NSString stringWithFormat:@"%ld",(chaEtimeStr.integerValue % 100) / 10];
            oneTimeStr = [NSString stringWithFormat:@"%ld",(chaEtimeStr.integerValue % 10)];
        }
        
        

        if (state.dinnerStatus.length)
        {
            
            if ([state.dinnerStatus isEqualToString:@"1"])
            {
                
                    //                [self changeColorWith:@"dark" one:@"" two:@"" three:@""];
                [self.darkArr addObject:state];
                
            }else if ([state.dinnerStatus isEqualToString:@"2"])
            {
                

                
                if (chaEtimeStr.integerValue < 30 )
                {
                    
                        //                    [self changeColorWith:@"green" one:oneTimeStr two:twoTimeStr three:threeTimeStr];
                    [self.greenArr addObject:state];
                    
                }else if (chaEtimeStr.integerValue >= 30 && chaEtimeStr.integerValue <= 100)
                {
                    
                    
                        //                    [self changeColorWith:@"yellow" one:oneTimeStr two:twoTimeStr three:threeTimeStr];
                    [self.yellowArr addObject:state];
                    
                }else if (chaEtimeStr.integerValue > 100)
                {
                    
                        //                    [self changeColorWith:@"red" one:oneTimeStr two:twoTimeStr three:threeTimeStr];
                    [self.redArr addObject:state];
                }else{
                    
                    DLog(@"###########%@",state.tabNo);
                }
                
            }
        }
    }
    if (self.greenArr.count) {
        [self.AllTable addObjectsFromArray:self.greenArr];
//        [self.AllTable addObject:self.greenArr];
    }
    
    if (self.yellowArr.count) {
        [self.AllTable addObjectsFromArray:self.yellowArr];
//        [self.AllTable addObject:self.yellowArr];

    }
    if (self.redArr.count) {
        [self.AllTable addObjectsFromArray:self.redArr];
//        [self.AllTable addObject:self.redArr];
    }
    if (self.blueArr.count) {
        [self.AllTable addObjectsFromArray:self.blueArr];
//        [self.AllTable addObject:self.blueArr];
    }
    if (self.darkArr.count) {
        [self.AllTable addObjectsFromArray:self.darkArr];
//        [self.AllTable addObject:self.darkArr];
    }
    
    
//    NSLog(@"~~~~~%@",self.AllTable);
    [self.collect reloadData];
}


- (void)setUpCollectionView{
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.minimumInteritemSpacing = 5;
    flowLayout.minimumLineSpacing = 36;
    flowLayout.sectionInset = UIEdgeInsetsMake(30, 30, 30, 30);
    flowLayout.itemSize = CGSizeMake(kdeskWidth, kdeskHeight);
    
    UICollectionView *collect = [[UICollectionView alloc] initWithFrame:CGRectMake(0, TopViewHeight, kScreenWidth - 30, kScreenHeight - kBottomHeight - TopViewHeight) collectionViewLayout:flowLayout];
    collect.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(RefreshBegin:)];
    _collect = collect;
    collect.alwaysBounceVertical = YES;
    collect.backgroundColor = [UIColor whiteColor];
    [self.collect registerClass:[DeskViewCell class] forCellWithReuseIdentifier:@"cell"];
    collect.dataSource = self;
    collect.delegate = self;

    [self.view addSubview:collect];
    
    
}

- (void)setUpSuoyin{


    CGFloat w = 25;
    CGFloat h = self.tmpArr.count * 30;
    CGFloat y = (kScreenHeight - h) / 2;
    CGFloat x = kScreenWidth - w;
    
    
    UIView *suoyin = [[UIView alloc] initWithFrame:CGRectMake(x, y, w, h)];
//    suoyin.backgroundColor = [UIColor orangeColor];
    _suoyin = suoyin;
//    [self setUpSuoyinSubView];
    [self.view addSubview:suoyin];
    
}

- (void)setUpSuoyinSubView{
    CGFloat w = 25;
    CGFloat h = 30;
    CGFloat y;
    CGFloat x;
    for (int i = 0; i < self.tmpArr.count; ++i) {
        UIButton *btn = [[UIButton alloc] init];
        x = 0;
        y = i * h;
        btn.frame = CGRectMake(x, y, w, h);
        btn.tag = i;
        [btn addTarget:self action:@selector(suoyinBtnChick:) forControlEvents:UIControlEventTouchDown];
        [self.suoyin addSubview:btn];
        [btn setTitle:[NSString stringWithFormat:@"%c",i + 65] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
}

- (void)suoyinBtnChick:(UIButton *)btn{
    
    NSIndexPath *path = [NSIndexPath indexPathForRow:1 inSection:btn.tag];
    [self.collect scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
}

- (void)RefreshBegin:(NSString *)str{
    
    if (!_isRefreshiang) {
        [self requestDeskInfo];
    }
    
    
//    UIButton *btn = [[UIButton alloc] init];
//    btn.tag = 3;
//    [[MainViewController sharedMainView] BottomViewDidChick:nil withButton:btn];
//    [self.collect.header endRefreshing];
}
#pragma mark - WaiMaiDingdanController的代理方法
- (void)WaiMaiDingdanControllerDidChickMore:(WaiMaiDingdanController *)waimaiVc{
    CGFloat waimaiH = 668;
//    CGFloat waimaiW = 460;
    
   // if (waimaiDetilHidden) {
//        [UIView animateWithDuration:1.0 animations:^{
//            self.waimaiVc.view.frame = CGRectMake(kScreenWidth -690,100, waimaiWidth, waimaiH);
//            waimaiDetilHidden = NO;
//        }];

//    }else{
//        
        [UIView animateWithDuration:1.0 animations:^{
            self.waimaiVc.view.frame = CGRectMake(kScreenWidth -420, 100, waimaiWidth, waimaiH);
            waimaiDetilHidden = NO;
        }completion:^(BOOL finished) {
            self.waimaiVc.moreButton.hidden = NO;
        }];
    
//    }
}


#pragma mark - UICollectionView的数据源和代理方法

//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
//    
//    return self.AllTable.count;
//}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

//    NSArray *arr = self.tmpArr[section];
//    return arr.count;
//    return [self.AllTable[section] count];
    return self.AllTable.count;
}


// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"cell";
    [collectionView registerNib:[UINib nibWithNibName:@"DeskViewCell" bundle:nil] forCellWithReuseIdentifier:ID];
    DeskViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
//    DeskState *states = self.tmpArr[indexPath.section][indexPath.row];
 
//    DeskState *states = self.AllTable[indexPath.section][indexPath.row];
    DeskState *states = self.AllTable[indexPath.row];
    
//    NSLog(@"state :%@",states.description);
    
    cell.state = states;
    
    if([cell.state.dinnerStatus isEqualToString:@"1"])
        cell.rightFenGeXian.backgroundColor = [UIColor grayColor];
    
    
//    cell.tableName = [NSString stringWithFormat:@"%c%ld",indexPath.section + 65,indexPath.row + 1];
    
    return cell;
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    

    // 餐台状态1 空闲
    // 餐台状态 2 使用
    // 餐台状态 5 已结账
    DeskState *states = self.AllTable[indexPath.row];
    if ([states.dinnerStatus isEqualToString:@"2"]) {
        NSString *urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/bill/ajax/diancaiBillContent?returnJson=json&billId=%@&billType=1",ceshiIP,states.billId];
        NSLog(@"urlStr:%@",urlStr);
        
        [HttpTool GET:urlStr parameters:nil success:^(id responseObject) {
            NSLog(@"222222%@",responseObject);
            NSArray *arr = [responseObject objectForKey:@"dinerBillDishes"];
            
            self.jiKouArr  = [JiKou mj_objectArrayWithKeyValuesArray:arr];
            // add by manman for start of line
            //添加菜品部分信息
           // NSArray *tmpArra = [arr firstObject];
            for (NSDictionary *tmpDic in arr) {
                
                NSString *bdid = [tmpDic objectForKeyedSubscript:@"bdId"];
                NSString *dishName = [tmpDic objectForKeyedSubscript:@"dishesName"];
                
                NSDictionary *dishInfo = [[NSMutableDictionary alloc]initWithObjectsAndKeys:bdid,@"bdId",dishName,@"dishesName", nil ];
                [self.dishInfoArr addObject:dishInfo];

            }
            
            
            
            // end of line
            
//            for (CaiPG *tmpDish in arr) {
//                [self.orderDetilArr addObject:tmpDish];
//            }
//            

           self.orderDetilArr = [CaiPG mj_objectArrayWithKeyValuesArray:arr];
            if ([_delegate respondsToSelector:@selector(UsedViewControllerDeskDidChick:WithOrderList:DeskStates:whereFrom:)]) {

                [self.delegate UsedViewControllerDeskDidChick:self WithOrderList:self.orderDetilArr DeskStates:states whereFrom:@"used"];
            }
            if ([_delegate respondsToSelector:@selector(UsedViewControllerDeskDidChick:)]) {
                [self.delegate UsedViewControllerDeskDidChick:self.jiKouArr];
            }
            
        } failure:^(NSError *error) {
            NSLog(@"*********%@",error);
        }];
    }
    
     if([states.dinnerStatus isEqualToString:@"1"]) {
         
       
//      DeskViewCell *cell = (DeskViewCell *)[collectionView viewWithTag:indexPath];
         DeskViewCell *cell = (DeskViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
//         NSLog(@"ID%@",cell.ID);

         
//         DeskState *states = [[DeskState alloc]init];
         DeskState *states = self.AllTable[indexPath.row];
         //states.tabNo = ;
         
         NSString *str  = [NSString stringWithFormat:@"%@",cell.ID.text ];
         states.tabNo = str;
         
         if ([_delegate respondsToSelector:@selector(UsedViewControllerDeskDidChick:WithOrderList:DeskStates:whereFrom:)]) {
             
             [self.delegate UsedViewControllerDeskDidChick:self WithOrderList:self.orderDetilArr DeskStates:states whereFrom:@"emptyused"];
         }
         
         
     }
    
    
   
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
     return UIEdgeInsetsMake(40, 40, 40, 40);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 弹出等待窗口
- (void)showLoding{
    
    self.hub = [MBProgressHUD showHUDAddedTo:kKeyWindow animated:YES];
    self.hub.labelText = @"拼命加载中...";
    [self.hub show:YES];
}

- (void)hideLoding{
    
    [self.hub hide:YES];
}


- (NSMutableArray *)AllTable{
    
    if (_AllTable == nil) {
        _AllTable = [NSMutableArray array];
    }
    return _AllTable;
}

- (NSMutableArray *)AreasArr{
    
    if (_AreasArr == nil) {
        _AreasArr = [NSMutableArray array];
        
    }
    return _AreasArr;
}

- (NSMutableArray *)tmpArr{
    
    if (_tmpArr == nil) {
        _tmpArr = [NSMutableArray array];
    }
    return _tmpArr;
}

- (NSMutableArray *)orderDetilArr{
    
    if (_orderDetilArr == nil) {
        _orderDetilArr = [NSMutableArray array];
    }
    return _orderDetilArr;
}

- (NSMutableArray *)darkArr{
    
    if (_darkArr == nil) {
        _darkArr = [NSMutableArray array];
    }
    return _darkArr;
}

- (NSMutableArray *)greenArr{
    
    if (_greenArr == nil) {
        _greenArr = [NSMutableArray array];
    }
    return _greenArr;
}

- (NSMutableArray *)yellowArr{
    
    if (_yellowArr == nil) {
        _yellowArr = [NSMutableArray array];
    }
    return _yellowArr;
}

- (NSMutableArray *)redArr{
    
    if (_redArr == nil) {
        _redArr = [NSMutableArray array];
    }
    return _redArr;
}

- (NSMutableArray *)blueArr{
    
    if (_blueArr == nil) {
        _blueArr = [NSMutableArray array];
    }
    return _blueArr;
}

- (MBProgressHUD *)hub{
    
    if (_hub == nil) {
        _hub = [MBProgressHUD showHUDAddedTo:kKeyWindow animated:YES];
        _hub.labelText = @"拼命加载中...";
        _hub.dimBackground = YES;
    }
    return _hub ;
}
@end
