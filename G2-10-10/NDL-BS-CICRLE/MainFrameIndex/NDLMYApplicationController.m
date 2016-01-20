//
//  NDLMYApplicationController.m
//  G2TestDemo
//
//  Created by NDlan on 15/12/15.
//  Copyright © 2015年 ws. All rights reserved.
//

#import "NDLMYApplicationController.h"
@interface NDLMYApplicationController()<BSImagePlayerDelegate>
@property (nonatomic, weak) BSFCRollingADImageUIView *imagePlayer;
@property (nonatomic, weak) BSFCRollingADImageUIView *imagePlayerB;
@end

@implementation NDLMYApplicationController
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
    
    
    BSTableContentObject *recommend=[BSTableContentObject initWithContentObject:@"普卡"
                                                                     methodName:nil imageName:@"fqf"
                                                                       colClass:nil];
    
    [bsTable addBSTableContent:recommend sectionHeader:@"社交圈"];
    
    
    BSTableContentObject *commu=[BSTableContentObject
                                 initWithContentObject:@"  积分"
                                 methodName:nil imageName:@"my_integral"
                                 vcClass:nil];
    
    [bsTable addBSTableContent:commu sectionHeader:@"社交圈"];
    
    
    BSTableContentObject *tech=[BSTableContentObject initWithContentObject:@"  卡包" methodName:nil imageName:@"sfxy" colClass:nil];
    [bsTable addBSTableContent:tech sectionHeader:@"社交圈"];
    
    
    BSTableContentObject *appointment=[BSTableContentObject initWithContentObject:@"珊瑚金币" methodName:nil imageName:@"sfj" colClass:nil];
    [bsTable addBSTableContent:appointment sectionHeader:@"社交圈"];
    
    BSTableContentObject *friendCircle=[BSTableContentObject initWithContentObject:@"  消息" methodName:nil imageName:@"my_01" colClass:nil];
    [bsTable addBSTableContent:friendCircle sectionHeader:@"社交圈"];
    
    BSTableContentObject *balance=[BSTableContentObject initWithContentObject:@"  安全" methodName:nil imageName:@"my_security" colClass:nil];
    [bsTable addBSTableContent:balance sectionHeader:@"社交圈"];
    
    
    BSTableContentObject *lifeService=[BSTableContentObject initWithContentObject:@"轮播图" methodName:nil imageName:nil
                                                                         colClass:nil];
    lifeService.noNeedLoginCheck=YES;
    lifeService.colCapatibilty=1;
    //添加轮播
    [self addImagePlayerB];
    lifeService.display=self.imagePlayerB ;
    [bsTable addBSTableContent:lifeService sectionHeader:@"轮播广告A"];
    
    
    BSTableContentObject *nongjiayuan=[BSTableContentObject initWithContentObject:@"姗姗信用" methodName:nil imageName:@"sfxy" colClass:nil];

    nongjiayuan.cellClazz=[BSUIFiveColTableViewCell class];
    [bsTable addBSTableContent:nongjiayuan sectionHeader:@"其它商圈"];
    
    BSTableContentObject *mk=[BSTableContentObject initWithContentObject:@"二维码推广" methodName:nil imageName:@"my_binary" colClass:nil];

    [bsTable addBSTableContent:mk sectionHeader:@"其它商圈"];
    
    
    
    BSTableContentObject *discountemk=[BSTableContentObject initWithContentObject:@"佣金管理" methodName:nil imageName:@"yjgl" colClass:nil];

    [bsTable addBSTableContent:discountemk sectionHeader:@"其它商圈"];

    
    
    BSTableContentObject *mortgage=[BSTableContentObject initWithContentObject:@"红包" methodName:nil imageName:@"red_paper" colClass:nil];

    
    [bsTable addBSTableContent:mortgage sectionHeader:@"其它商圈"];
    
    mortgage=[BSTableContentObject initWithContentObject:@"爱心捐赠" methodName:nil imageName:@"my_love" colClass:nil];
    
    
    [bsTable addBSTableContent:mortgage sectionHeader:@"其它商圈"];
    
    
    mortgage=[BSTableContentObject initWithContentObject:@"  收藏" methodName:nil imageName:@"sc" colClass:nil];
    
    
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
        NSString *imgName = [NSString stringWithFormat:@"my%d.png",i+1];
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
