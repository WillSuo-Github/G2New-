//
//  SecondViewController.m
//  KT-BUSINESS-SELLER
//
//  Created by admin on 15/7/6.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "NDLBankMarketController.h"

@interface NDLBankMarketController ()
@property (nonatomic, weak) BSFCRollingADImageUIView *imagePlayer;
@property (nonatomic, weak) BSFCRollingADImageUIView *imagePlayerB;
@end

@implementation NDLBankMarketController
@dynamic tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    BSTableSection *bsTable=[BSTableSection
                             initWithHeaderVcClassContent:@"社交圈"//章节显示标题
                             imageName:@"xy"//章节显示图标
                             headerViewClass:nil//章节显示视图
                             cellIdentifier:@"BSUIFiveBotColTableViewCell"//采用的TableViewCell
                             cellClass:[BSUIFiveBotColTableViewCell class]//TableViewCell实现
                             
                             storyboard:@"KTWaterDetailsViewController"
                             colCapatibilty:3//每个章节的row数量
                             bsContent:nil];
    
    [self addImagePlay];
    
    
    BSTableContentObject *recommend=[BSTableContentObject initWithContentObject:@"流存宝"
                                                                     methodName:nil imageName:@"jrcs_01"
                                                                       colClass:nil];
    //recommend.noNeedLoginCheck=YES;
    
    [bsTable addBSTableContent:recommend sectionHeader:@"社交圈"];
    
    
    BSTableContentObject *commu=[BSTableContentObject
                                 initWithContentObject:@"合伙人"
                                 methodName:nil imageName:@"jrcs_02"
                                 vcClass:nil];
    
    [bsTable addBSTableContent:commu sectionHeader:@"社交圈"];
    
    
    BSTableContentObject *tech=[BSTableContentObject initWithContentObject:@"微存宝" methodName:nil imageName:@"jrcs_new_03" colClass:nil];
    [bsTable addBSTableContent:tech sectionHeader:@"社交圈"];
    
    
    BSTableContentObject *appointment=[BSTableContentObject initWithContentObject:@"理财金" methodName:nil imageName:@"my_security" colClass:nil];
    [bsTable addBSTableContent:appointment sectionHeader:@"社交圈"];
    
    BSTableContentObject *friendCircle=[BSTableContentObject initWithContentObject:@"朋友帮" methodName:nil imageName:@"jrcs_04" colClass:nil];
    [bsTable addBSTableContent:friendCircle sectionHeader:@"社交圈"];
    
    BSTableContentObject *balance=[BSTableContentObject initWithContentObject:@"余额" methodName:nil imageName:@"balance2" colClass:nil];
    [bsTable addBSTableContent:balance sectionHeader:@"社交圈"];

    
    BSTableContentObject *lifeService=[BSTableContentObject initWithContentObject:@"轮播图" methodName:nil imageName:nil
                                                                         colClass:nil];
    lifeService.noNeedLoginCheck=YES;
    lifeService.colCapatibilty=1;
    //添加轮播
    [self addImagePlayerB];
    lifeService.display=self.imagePlayerB ;
    [bsTable addBSTableContent:lifeService sectionHeader:@"轮播广告A"];
    
    
    BSTableContentObject *nongjiayuan=[BSTableContentObject initWithContentObject:@"流存贷" methodName:nil imageName:@"jrcs_05" colClass:nil];
    //BSUIFiveColTableViewCell
    nongjiayuan.colCapatibilty=2;
    nongjiayuan.cellIdentifier=@"BSUIFiveColTableViewCell";
    nongjiayuan.cellClazz=[BSUIFiveColTableViewCell class];
    [bsTable addBSTableContent:nongjiayuan sectionHeader:@"其它商圈"];
    
    BSTableContentObject *mk=[BSTableContentObject initWithContentObject:@"信用贷" methodName:nil imageName:@"jrcs_06" colClass:nil];
    mk.colCapatibilty=2;
    mk.cellIdentifier=@"BSUIFiveColTableViewCell";
    mk.cellClazz=[BSUIFiveColTableViewCell class];
    [bsTable addBSTableContent:mk sectionHeader:@"其它商圈"];
    
   
    
    BSTableContentObject *discountemk=[BSTableContentObject initWithContentObject:@"POS贷" methodName:nil imageName:@"finance_2" colClass:nil];
    discountemk.colCapatibilty=2;
    discountemk.cellIdentifier=@"BSUIFiveColTableViewCell";
    discountemk.cellClazz=[BSUIFiveColTableViewCell class];

    [bsTable addBSTableContent:discountemk sectionHeader:@"其它商圈"];
    [bsTable addBSTableContent:discountemk sectionHeader:@"其它商圈"];
    
    
    BSTableContentObject *mortgage=[BSTableContentObject initWithContentObject:@"抵押贷" methodName:nil imageName:@"finance_2" colClass:nil];
    mortgage.colCapatibilty=2;
    mortgage.cellIdentifier=@"BSUIFiveColTableViewCell";
    mortgage.cellClazz=[BSUIFiveColTableViewCell class];

    [bsTable addBSTableContent:mortgage sectionHeader:@"其它商圈"];

    [self addImagePlay];
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 170)];
    [self.tableView.tableHeaderView addSubview :self.imagePlayer];
    [super setValue:bsTable forKey:@"bSTableObjects"];
    
}

/**
 *  添加头部图片轮播器
 */
- (void)addImagePlayerB{
    //
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 0; i < 3; i++){
        NSString *imgName = [NSString stringWithFormat:@"mkB%d.png",i+1];
        [tempArray addObject:imgName];
    }
    
    self.imagePlayerB =[BSFCRollingADImageUIView initADImageUIViewWith:tempArray playerDelegate:self urls:nil height:6];
}
/**
 *  添加头部图片轮播器
 */
- (void)addImagePlay{
    //
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 0; i < 3; i++){
        NSString *imgName = [NSString stringWithFormat:@"mkA%d.png",i+1];
        [tempArray addObject:imgName];
    }
    
    self.imagePlayer =[BSFCRollingADImageUIView initADImageUIViewWith:tempArray playerDelegate:self urls:nil height:6];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return BSMarginX(120);
    
}

/**
 *每个section底部标题高度（实现这个代理方法后前面 sectionHeaderHeight 设定的高度无效）
 */
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return BSMarginY(0);
}
/**
 *每个section底部标题高度（实现这个代理方法后前面 sectionHeaderHeight 设定的高度无效）
 */
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return BSMarginY(0);
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return nil;
}

@end
