//
//  JySetingViewController.m
//  G2TestDemo
//
//  Created by wjy on 15/12/4.
//  Copyright © 2015年 ws. All rights reserved.
//

#import "JySetingViewController.h"
#import "YuDingViewController.h"
#import "PrintViewController.h"
#import "XiuGaiMiMaViewController.h"
#import "SettingAboutViewController.h"

@interface JySetingViewController ()

@end

@implementation JySetingViewController
@synthesize  tableView;
@dynamic contentView;
-(void)viewDidLoad
{

    [super viewDidLoad];
    
   
}


-(NSArray *)SetSettingMenu
{
    
    return [NSArray arrayWithObjects:@"预定设置",@"打印设置",@"修改密码",@"帮助",@"关于", nil];
}


-(void)DidSelectMenuIndex:(NSInteger)index
{
    
    
    
    if (index == 0 ) {
        YuDingViewController *yuding = [[YuDingViewController alloc] init];
        self.label.text=@"操作设置";
        yuding.view.backgroundColor = [UIColor whiteColor];
        // [self.view insertSubview:yuding.view atIndex:0];
        [self SetUpContentViewWithViewController:yuding];
        
    }else if (index == 1){
        //cell.backgroundColor = [UIColor redColor];
        PrintViewController *print = [[PrintViewController alloc] init];
        self.label.text=@"打印设置";
        //[self.view insertSubview:print.view atIndex:0];
        [self SetUpContentViewWithViewController:print];
    }else if (index== 2){
        //cell.backgroundColor = [UIColor redColor];
        XiuGaiMiMaViewController *xiugai = [[XiuGaiMiMaViewController alloc] init];
        self.label.text=@"修改密码";
        //[self.view insertSubview:xiugai.view atIndex:0];
        [self SetUpContentViewWithViewController:xiugai];
        
    }else if (index == 4){
        //cell.backgroundColor = [UIColor redColor];
        SettingAboutViewController *settingAboutVC = [[SettingAboutViewController alloc] init];
        self.label.text=@"关于";
        NSLog(@" setting about 。。。");
        settingAboutVC.view.backgroundColor = [UIColor redColor];
        //[self.view insertSubview:settingAboutVC.view atIndex:0];
        //[self SetUpContentViewWithViewController:settingAboutVC];
        if ([self.settingDelegate respondsToSelector:@selector(didSelectMenuIndex:target:)]) {
            [self.settingDelegate didSelectMenuIndex:self target:settingAboutVC];
        }
    }
    
    
    
    
}

-(void)didSelectMenuIndex:(UIViewController *)setingViewController target:(UIViewController *)controller
{
    
    SetingViewController *setingView=setingViewController;
    for (UIView *view in setingView.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    setingView.tmpViewController = controller;
    [setingView.contentView addSubview:controller.view];
}

- (void)SetUpContentViewWithViewController:(UIViewController *)controller{
   
   for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    self.tmpViewController = controller;
    [self.contentView addSubview:controller.view];
}

@end
