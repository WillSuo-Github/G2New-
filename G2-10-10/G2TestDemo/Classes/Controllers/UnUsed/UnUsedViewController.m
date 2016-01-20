//
//  UnUsedViewController.m
//  G2TestDemo
//
//  Created by Mac on 15/7/21.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import "UnUsedViewController.h"


#import "OriginalContentView.h"
#import "AFNetworking.h"

#import "MJExtension.h"
#import "MJRefresh.h"
#import "DeskState.h"
#import "DeskViewCell.h"
#import "KYPathAnimationRefreshControl.h"
#import "KYRefreshControl.h"
#import "DeskViewCell.h"
#import "AreaStates.h"


@interface UnUsedViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) OriginalContentView *originalV;
@property (nonatomic, strong) NSMutableArray *AllTable;
@property (nonatomic, strong) NSMutableArray *UnUsedArr;
@property (nonatomic, strong) UICollectionView *collect;

@property (nonatomic, strong) NSMutableArray *AreasArr;

@property (nonatomic, strong) NSMutableArray *tmpArr;

@property (nonatomic, strong) UIView *suoyin;
@end

@implementation UnUsedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.frame = CGRectMake(0, 0, kScreenWidth + koriginalWidth, kScreenHeight);

    [self setUpCollectionView];
    [self requestDeskInfo];

    [self setUpOriginalMenuView];
}


- (void)setUpCollectionView{
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.minimumInteritemSpacing = 5;
    flowLayout.minimumLineSpacing = 20;
    flowLayout.sectionInset = UIEdgeInsetsMake(30, 30, 30, 30);
    flowLayout.itemSize = CGSizeMake(kdeskWidth, kdeskHeight);
    
    UICollectionView *collect = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kBottomHeight) collectionViewLayout:flowLayout];
    collect.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(RefreshBegin)];
    _collect = collect;
    collect.alwaysBounceVertical = YES;
    collect.backgroundColor = [UIColor whiteColor];
    [self.collect registerClass:[DeskViewCell class] forCellWithReuseIdentifier:@"cell"];
    collect.dataSource = self;
    collect.delegate = self;
    
    [self.view addSubview:collect];
}

//- (void)RefreshBegin{
//    
//    
////    if (<#condition#>) {
////        <#statements#>
////    }
//    [self requestDeskInfo];
//}




- (void)requestDeskInfo{
    
    NSString *urlS = [NSString stringWithFormat:@"%@/canyin-frontdesk/index/ajax/table/list?returnJson=json&search_EQ_dinnerStatus=",ceshiIP];
    
    [self.AllTable removeAllObjects];
    [self.AreasArr removeAllObjects];

    
    AFHTTPRequestOperationManager *mgr1 = [AFHTTPRequestOperationManager manager];
    [mgr1 POST:urlS parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@",operation.responseObject);
        [self.collect.header endRefreshing];
        NSDictionary *dict = [responseObject objectForKey:@"tables"];
        NSArray *arr = [dict objectForKey:@"content"];
        [self.AllTable removeAllObjects];
        _AllTable = [DeskState objectArrayWithKeyValuesArray:arr];
        
        [self getUnUsedDiskWithArray:self.AllTable];

        
        NSArray *areas = [responseObject objectForKey:@"roleTableAreas"];
        _AreasArr = [AreaStates objectArrayWithKeyValuesArray:areas];
        
        [self.tmpArr removeAllObjects];
        
        for (int i = 0; i < self.AreasArr.count; ++i) {
            AreaStates *areas = self.AreasArr[i];
            
            NSMutableArray *array = [NSMutableArray array];
//            NSLog(@"%@",areas);
            for (int j = 0; j < self.UnUsedArr.count; ++j) {
                DeskState *states = self.UnUsedArr[j];
                if (states.areaId == areas.areaId) {
                    [array addObject:states];
                    
                }
            }
            if (array.count) {
                [self.tmpArr addObject:array];
                
            }
        }
        NSLog(@"+++++%@",self.tmpArr);
        [self.collect reloadData];
        
        
        [self setUpSuoyin];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.collect.header endRefreshing];
        NSLog(@"%@",error);
    }];
}


- (void)setUpSuoyin{
    
    
    CGFloat w = 25;
    CGFloat h = self.tmpArr.count * 30;
    CGFloat y = (kScreenHeight - h) / 2;
    CGFloat x = kScreenWidth - w;
    
    
    UIView *suoyin = [[UIView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    //    suoyin.backgroundColor = [UIColor orangeColor];
    _suoyin = suoyin;
    [self setUpSuoyinSubView];
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

/**
 *  获取未开台的数量
 *
 *  @param arr 获取到的所有桌子
 *
 *  @return 未开台的桌子
 */
- (NSArray *)getUnUsedDiskWithArray:(NSArray *)arr{
    [self.UnUsedArr removeAllObjects];
    for (DeskState *s in arr) {
        
        if ([s.dinnerStatus isEqualToString:@"1"]) {
            [self.UnUsedArr addObject:s];
        }
        
    }
    return self.UnUsedArr;
    
}

#pragma mark - UICollectionView的数据源和代理方法

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    

    return self.tmpArr.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    NSArray *arr = self.tmpArr[section];
    return arr.count;
}



// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"cell";
    [collectionView registerNib:[UINib nibWithNibName:@"DeskViewCell" bundle:nil] forCellWithReuseIdentifier:ID];
    DeskViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    DeskState *states = self.tmpArr[indexPath.section][indexPath.row];
    cell.state = states;

//    cell.tableName = [NSString stringWithFormat:@"%c%ld",indexPath.section + 65,indexPath.row + 1];
  
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
//    NSLog(@"%ld",self.collect.subviews.count);
    DeskState *states = self.tmpArr[indexPath.section][indexPath.row];
//    _originalV.deskSt = states;
//    _originalV.tableId = [NSString stringWithFormat:@"%c%ld",indexPath.section + 65,indexPath.row + 1];
    [UIView animateWithDuration:0.5 animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(-koriginalWidth, 0);
        
        self.Hidden = NO;
    }];
}

- (void)setUpOriginalMenuView{

    OriginalContentView *originalV = [[OriginalContentView alloc] initWithFrame:CGRectMake(kScreenWidth, 0, koriginalWidth, kScreenHeight - kBottomHeight)];
    _originalV = originalV;
    [self.view addSubview:originalV];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 懒加载代码

- (NSMutableArray *)AllTable{
    
    if (_AllTable == nil) {
        _AllTable = [NSMutableArray array];
    }
    return _AllTable;
}

- (NSMutableArray *)UnUsedArr{
    
    if (_UnUsedArr == nil) {
        _UnUsedArr = [NSMutableArray array];
    }
    return _UnUsedArr;
}


- (NSMutableArray *)tmpArr{
    
    if (_tmpArr == nil) {
        _tmpArr = [NSMutableArray array];
    }
    return _tmpArr;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
