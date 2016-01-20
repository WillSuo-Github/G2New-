//
//  BottomView.m
//  G2TestDemo
//
//  Created by lcc on 15/7/20.
//  Copyright (c) 2015年 ws. All rights reserved.
//
#define BottomMargin kScreenWidth * 4 /2048
#define BTNW ([UIScreen mainScreen].bounds.size.width - 2*BottomMargin - kScreenWidth * 200 / 2048)/2
#import "BottomView.h"
#import "MenuBtn.h"
#import "BaseBtn.h"

@interface BottomView(){
    
    UIButton *_btn;
//    MenuBtn *_menuBtn;
    UIButton *_UnUsedBtn;
    UIButton *_UsedBtn; //餐台按钮
    UIButton *_Unselletd;
}
@property (nonatomic, weak) MenuBtn *menuBtn;
@property (nonatomic, weak) UIImageView *imageV;
@property (nonatomic, strong) UIButton *selectedBtn;

@property (nonatomic, strong) UIImageView *firstImageView;
@property (nonatomic, strong) UIImageView *SecondImageView;
@end


@implementation BottomView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blackColor];
//        [self setUpBackImage];
        [self setUpMenuBtn];
        [self setUpUnUsed];
        [self setUpUsed];
//        [self setUpUnselletd];
        [self setUpMerginView1];
        [self setUpMerginView2];
        UIButton *btn = [[UIButton alloc] init];
        btn.tag = 1;
        
        [self BtnChick:btn];
        
        //_UnUsedBtn.selected = YES;

        
//        NSLog(@"%f",BTNWH);
        
    }
    return self;
}

//- (void)setUpUnselletd{
//    
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn setImage:[UIImage imageNamed:@"q_yjs29"] forState:UIControlStateNormal];
//    btn.imageView.contentMode = UIViewContentModeCenter;
//    NSString *unUsedStr = [NSString stringWithFormat:@"待结算(%d)",3];
//    [btn setTitle:unUsedStr forState:UIControlStateNormal];
//    [btn setBackgroundImage:[UIImage imageNamed:@"q_dbac2"] forState:UIControlStateSelected];
//    [btn addTarget:self action:@selector(BtnChick:) forControlEvents:UIControlEventTouchUpInside];
//    _Unselletd = btn;
//    [self addSubview:btn];
//}


- (void)setUpUsed{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn setImage:[UIImage imageNamed:@"q_ykt29"] forState:UIControlStateNormal];
//    btn.currImage = @"q_ykt";
//    [btn setBackgroundImage:[UIImage imageNamed:@"q_dbac2"] forState:UIControlStateSelected];
//    NSString *unUsedStr = [NSString stringWithFormat:@"已开台(%d)",24];
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 10);
    [btn setImageEdgeInsets:insets];
    [btn setImage:[UIImage imageNamed:@"hlk_ctzt"] forState:UIControlStateNormal];
    [btn setTitle:@"餐台状态" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor colorWithRed:86/255.0 green:93/255.0 blue:103/255.0 alpha:1]];
    [btn addTarget:self action:@selector(BtnChick:) forControlEvents:UIControlEventTouchUpInside];
    _UsedBtn = btn;
    [self addSubview:btn];
}


- (void)setUpUnUsed{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn setImage:[UIImage imageNamed:@"q_wkt1"] forState:UIControlStateNormal];
    btn.imageView.contentMode = UIViewContentModeCenter;
//    NSString *unUsedStr = [NSString stringWithFormat:@"未开台(%d)",12];
//    [btn setBackgroundImage:[UIImage imageNamed:@"q_dbac2"] forState:UIControlStateSelected];
    [btn setTitle:@"点单" forState:UIControlStateNormal];
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 10);
    [btn setImageEdgeInsets:insets];
    [btn setImage:[UIImage imageNamed:@"hlk_dd"] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor colorWithRed:86/255.0 green:93/255.0 blue:103/255.0 alpha:1]];
    [btn addTarget:self action:@selector(BtnChick:) forControlEvents:UIControlEventTouchUpInside];
    _UnUsedBtn = btn;
    [self addSubview:btn];
    
}

//初始化菜单栏
- (void)setUpMenuBtn{
    
    MenuBtn *btn = [[MenuBtn alloc] init];
    [btn setImage:[UIImage imageNamed:@"q_sh1"] forState:UIControlStateNormal];
    
//    [btn setBackgroundImage:[UIImage imageNamed:@"q_dbac1"] forState:UIControlStateHighlighted];

    [btn setBackgroundColor:[UIColor colorWithRed:86/255.0 green:93/255.0 blue:103/255.0 alpha:1]];
    //设置提示标签
    btn.bageNub = @"10";
    [btn addTarget:self action:@selector(BtnChick:) forControlEvents:UIControlEventTouchUpInside];
    _menuBtn = btn;
    
    [self addSubview:btn];
    
}

//- (void)setUpBackImage{
//    
//    UIImageView *imageV = [[UIImageView alloc] init];
//    imageV.image = [UIImage imageNamed:@"q_dbac(2)"];
//    _imageV = imageV;
//    [self addSubview:imageV];
//}

- (void)setUpMerginView1{
    
    UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ndy"]];
    self.firstImageView = imageV;
    [self addSubview:imageV];
}

- (void)setUpMerginView2{
    
    UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ndy"]];
    self.SecondImageView = imageV;
    [self addSubview:imageV];
}

- (void)layoutSubviews{
    

    for (int i = 0; i < self.subviews.count; ++i) {
        if ([self.subviews[i] isKindOfClass:[UIButton class]]) {
            UIButton *btn = self.subviews[i];
            btn.tag = i;
        }
    }
    
    [super layoutSubviews];
    CGFloat H = kBottomHeight;
    CGFloat W = [UIScreen mainScreen].bounds.size.width;
    CGFloat X = 0;
    CGFloat Y = [UIScreen mainScreen].bounds.size.height - H;
    self.frame = CGRectMake(X, Y, W, H);
    
    _imageV.frame = self.bounds;
    
    CGFloat menuBtnX = 0;
    CGFloat menuBtnY = 0;
    CGFloat menuBtnH = self.height;
    CGFloat menuBtnW = kScreenWidth * 200 / 2048;
    _menuBtn.frame = CGRectMake(menuBtnX, menuBtnY, menuBtnW, menuBtnH);
    
    CGFloat unUsedX = CGRectGetMaxX(_menuBtn.frame) + BottomMargin;
    CGFloat unUsedY = 0;
    CGFloat unUsedH = self.height;
    CGFloat unUsedW = BTNW;
    _UnUsedBtn.frame = CGRectMake(unUsedX, unUsedY, unUsedW, unUsedH);
    
    CGFloat UsedX = CGRectGetMaxX(_UnUsedBtn.frame) + BottomMargin;
    CGFloat UsedY = 0;
    CGFloat UsedW = BTNW;
    CGFloat UsedH = self.height;
    _UsedBtn.frame = CGRectMake(UsedX, UsedY, UsedW, UsedH);
    
//    CGFloat UnUsedX = CGRectGetMaxX(_UsedBtn.frame) + BottomMargin;
//    CGFloat UnUsedY = 0;
//    CGFloat UnUsedW = BTNW;
//    CGFloat UnUsedH = self.height;
//    _Unselletd.frame = CGRectMake(UnUsedX, UnUsedY, UnUsedW, UnUsedH);
    CGFloat margin1X = CGRectGetMaxX(_menuBtn.frame);
    CGFloat margin1Y = 0;
    CGFloat margin1W = 2;
    CGFloat margin1H = self.height;
    _firstImageView.frame = CGRectMake(margin1X, margin1Y, margin1W, margin1H);
    
    CGFloat margin2X = CGRectGetMaxX(_UnUsedBtn.frame);
    CGFloat margin2Y = 0;
    CGFloat margin2W = 2;
    CGFloat margin2H = self.height;
    _SecondImageView.frame = CGRectMake(margin2X, margin2Y, margin2W, margin2H);

}

- (void)BtnChick:(UIButton *)btn{
    

    if (btn.tag != 0) {
//        _UnUsedBtn.selected = NO;
//        self.selectedBtn.selected = NO;
//        self.selectedBtn = btn;
//        self.selectedBtn.selected = YES;
        if (btn.tag == 1)
        {
            
            
                
                [_UnUsedBtn setBackgroundColor:[UIColor colorWithRed:62/225.0 green:69/225.0 blue:80/255.0 alpha:1]];
            
                
                [_UsedBtn setBackgroundColor:[UIColor colorWithRed:86/255.0 green:93/255.0 blue:103/255.0 alpha:1]];
            
        }else if(btn.tag == 2)
        {
            
            
                
                [_UsedBtn setBackgroundColor:[UIColor colorWithRed:62/225.0 green:69/225.0 blue:80/255.0 alpha:1]];
            
                
                [_UnUsedBtn setBackgroundColor:[UIColor colorWithRed:86/255.0 green:93/255.0 blue:103/255.0 alpha:1]];
            
        }
        
    }
    
    
    
    if ([self.delegate respondsToSelector:@selector(BottomViewDidChick:withButton:whereFromStr:)]) {
        [self.delegate BottomViewDidChick:self withButton:btn whereFromStr:@""];
    }
}

@end
