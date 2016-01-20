//
//  LBLiferServiceControllerViewController.m
//  KTAPP
//
//  Created by admin on 15/6/29.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "NDLLiferCircleController.h"
#import "BSUIFrameworkHeader.h"
//#import "LBControllerHeader.h"

@interface NDLLiferCircleController ()
@property (nonatomic, weak) BSFCRollingADImageUIView *imagePlayer;
@property (nonatomic, weak) BSFCRollingADImageUIView *imagePlayerB;
@end

@implementation NDLLiferCircleController
@dynamic tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    BSTableSection *bsTable=[BSTableSection
                             initWithHeaderVcClassContent:@"社交圈"//章节显示标题
                             imageName:@"xy"//章节显示图标
                             headerViewClass:nil//章节显示视图
                             cellIdentifier:@"BSUIFiveColTableViewCell"//采用的TableViewCell
                             cellClass:[BSUIFiveColTableViewCell class]//TableViewCell实现
                             
                             storyboard:@"KTWaterDetailsViewController"
                             colCapatibilty:2//每个章节的row数量
                             bsContent:nil];
    
    [self addImagePlay];
    BSTableContentObject *socialService=[BSTableContentObject initWithContentObject:@"轮播图" methodName:nil imageName:nil
                                                                         colClass:nil];
    socialService.noNeedLoginCheck=YES;
    socialService.colCapatibilty=1;
    //添加轮播
   
    socialService.display=self.imagePlayer;
    //[bsTable addBSTableContent:socialService sectionHeader:@"轮播广告"];

    
    BSTableContentObject *recommend=[BSTableContentObject initWithContentObject:@"朋友圈"
                                                                     methodName:nil imageName:@"sns_friend"
                                                                       colClass:nil];
    //recommend.noNeedLoginCheck=YES;
    
    [bsTable addBSTableContent:recommend sectionHeader:@"社交圈"];
    
    
    BSTableContentObject *commu=[BSTableContentObject
                                 initWithContentObject:@"扫一扫"
                                 methodName:nil imageName:@"sns_sweep"
                                 vcClass:nil];
    
    [bsTable addBSTableContent:commu sectionHeader:@"社交圈"];
    
    
    BSTableContentObject *tech=[BSTableContentObject initWithContentObject:@"通讯录" methodName:nil imageName:@"sns_shake" colClass:nil];
    [bsTable addBSTableContent:tech sectionHeader:@"社交圈"];
    

    BSTableContentObject *appointment=[BSTableContentObject initWithContentObject:@"群聊" methodName:nil imageName:@"group_chat" colClass:nil];
    [bsTable addBSTableContent:appointment sectionHeader:@"社交圈"];
    

    BSTableContentObject *lifeService=[BSTableContentObject initWithContentObject:@"轮播图" methodName:nil imageName:nil
                                                                         colClass:nil];
    lifeService.noNeedLoginCheck=YES;
    lifeService.colCapatibilty=1;
    //添加轮播
    [self addImagePlayerB];
    lifeService.display=self.imagePlayerB ;
    [bsTable addBSTableContent:lifeService sectionHeader:@"轮播广告A"];
    
 
    BSTableContentObject *nongjiayuan=[BSTableContentObject initWithContentObject:@"锁屏广告" methodName:nil imageName:@"sns_05" colClass:nil];
  
    [bsTable addBSTableContent:nongjiayuan sectionHeader:@"其它商圈"];
    
    BSTableContentObject *mk=[BSTableContentObject initWithContentObject:@"五公里商圈" methodName:nil imageName:@"sns_nearby" colClass:nil];

    [bsTable addBSTableContent:mk sectionHeader:@"其它商圈"];
    
    BSTableContentObject *drinkmk=[BSTableContentObject initWithContentObject:@"分期付" methodName:nil imageName:@"sfxy" colClass:nil];

    [bsTable addBSTableContent:drinkmk sectionHeader:@"其它商圈"];
    
    
    BSTableContentObject *discountemk=[BSTableContentObject initWithContentObject:@"邀请朋友" methodName:nil imageName:@"sns_08" colClass:nil];
 
    [bsTable addBSTableContent:discountemk sectionHeader:@"其它商圈"];
    
    
    
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
        NSString *imgName = [NSString stringWithFormat:@"socialB%d.png",i+1];
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
        NSString *imgName = [NSString stringWithFormat:@"socialA%d.png",i+1];
        [tempArray addObject:imgName];
    }
    
    self.imagePlayer =[BSFCRollingADImageUIView initADImageUIViewWith:tempArray playerDelegate:self urls:nil height:6];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return BSMarginX(110);
    
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
