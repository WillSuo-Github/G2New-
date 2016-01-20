//
//  JYOrderViewController.m
//  G2TestDemo
//
//  Created by tencrwin on 15/12/8.
//  Copyright © 2015年 ws. All rights reserved.
//

#import "JYOrderViewController.h"
#import "JYProductManager.h"
#import "JYOrderTableViewCell.h"
#import "JYProductInfoModel.h"
#import "JYOrderCollectionViewCell.h"
#import "JYCategoryIDModel.h"
#import "JYMainViewController.h"
#import "BottomView.h"

@interface JYOrderViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
//首页珠宝
@property (weak, nonatomic) IBOutlet UICollectionView *jYMainCollection;

//滑动视图
@property (weak, nonatomic) IBOutlet UIView *TopView;
@property (nonatomic, strong) UIScrollView *topScrollView;
//collecttion 数据的数组
@property (strong,nonatomic) NSMutableArray *allProDuct;
// tableview 数据的数组
@property (strong,nonatomic) NSMutableArray *someProDuct;


@end

@implementation JYOrderViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化数据源
    self.allProDuct = [NSMutableArray array];
    self.someProDuct = [NSMutableArray array];
    
    [self setUpCollection];
    [self requestShangPin];
    //请求头信息
    [self requestShangPinCate];
}
//请求商品
-(void)requestShangPin{
    JYProductManager *manager = [[JYProductManager alloc]init];
    [manager obtainProduceInfoWithDic:nil block:^(id response, ErrorMessage *bsErrorMessage) {
        NSLog(@"%@",response);
        [self.allProDuct addObjectsFromArray:response];
        [self.jYMainCollection reloadData];
    }];
}
//请求头类别
-(void)requestShangPinCate{
    JYProductManager *manager = [[JYProductManager alloc]init];
    [manager obtainProduceInfoCateWithDic:nil block:^(id response, ErrorMessage *bsErrorMessage) {
        
        [self setUpTopViewWithCount:response];

    }];
}
//collectionview
-(void)setUpCollection{
    self.jYMainCollection.dataSource = self;
    self.jYMainCollection.delegate = self;
    self.jYMainCollection.allowsMultipleSelection = NO;
    //zhuce
     [self.jYMainCollection registerNib:[UINib nibWithNibName:@"JYOrderCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"wang"];
    

}
//tableView

-(void)setUpTopView{

}
#pragma mark collection代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    //ceshi
//    return 10;
    //正式
    return self.allProDuct.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //获得当前对象
    JYProductInfoModel *model = self.allProDuct[indexPath.row];
   static NSString *ID = @"wang";
    JYOrderCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.model = model;
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(150, 180);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //WHC 数据来了用
    JYProductInfoModel *model = self.allProDuct[indexPath.row];
    [self.someProDuct addObject:model];
    for (BottomView *view in [JYMainViewController sharedMainView].view.subviews) {
        if ([view isMemberOfClass:[BottomView class]]) {
            
        }
    }
    
    //发送通知
    [[NSNotificationCenter defaultCenter]postNotificationName:@"OrDerNoti" object:self.someProDuct];
    
    
  }
- (void)setUpTopViewWithCount:(NSArray*)arr1
{
    
    NSInteger count = arr1.count ;
    CGFloat btnx;
    CGFloat btnY;
    CGFloat btnW = 80;
    CGFloat btnH;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.TopView.bounds];
    self.topScrollView = scrollView;
    [self.TopView addSubview:scrollView];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.contentSize = CGSizeMake(btnW * count, self.TopView.frame.size.height);
    
    CGRect btnFrame = CGRectMake(0,0, 50, 40);
    for (int i = 0; i < count; ++i)
    {
        UIButton *btn = [[UIButton alloc] init];
        //        btnW = self.topView.width / count;
        btnH = self.TopView.frame.size.height -2 ;
        btnx = i * btnW;
        btnY = 6;
        btn.frame = CGRectMake(btnx, btnY, btnW
                               + 50, btnH);
        JYCategoryIDModel *model = arr1[i];
        UIButton *TmpButton = [self createUIButtonAutoLayoutSizeWithTitle:model.categoryName AndOriginalFramePosition:btnFrame];
        btnFrame = TmpButton.frame;
        btnFrame.origin.x += TmpButton.frame.size.width;
        TmpButton.tag = i+10;
                   [TmpButton addTarget:self action:@selector(topButtonChickS:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.topScrollView addSubview:TmpButton];
        
        
    }
    
    
    
    
}
#define PNZITI    [UIColor colorWithRed:85.0 / 255.0 green:90.0 / 255.0 blue:96.0 / 255.0 alpha:1.0f]
// button 按钮标题的自适应大小  设置button按钮的大小
-(UIButton *)createUIButtonAutoLayoutSizeWithTitle:(NSString *)titleStr AndOriginalFramePosition:(CGRect) btnFrame
{
    
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
    
    [btn setTitleColor:PNZITI forState:UIControlStateNormal];
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
    
    //
    //标题的高度不变 宽度变化
    titleSize.height = 30;
    //titleSize.width += 20;
    
    btn.frame = CGRectMake(btnFrame.origin.x +10 ,btnFrame.origin.y, titleSize.width +20,titleSize.height);
    
    
    
    //[self.topScrollView  addSubview:btn];
    return btn;
    
}

-(void)topButtonChickS:(UIButton*)sender{
    for (UIView *view in self.topScrollView.subviews)
    {
        view.layer.borderWidth = 0;
    }
    
    sender.layer.masksToBounds = YES;
    sender.layer.borderWidth = 1;
    sender.layer.borderColor = [[UIColor colorWithRed:78/255.0 green:152/255.0 blue:226/255.0 alpha:1] CGColor];
}



@end
