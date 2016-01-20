//
//  BottomView.m
//  G2TestDemo
//
//  Created by lcc on 15/7/20.
//  Copyright (c) 2015年 ws. All rights reserved.
//
#define BottomMargin kScreenWidth * 4 /2048
#define BTNW ([UIScreen mainScreen].bounds.size.width - 2*BottomMargin - kScreenWidth * 200 / 2048)/2

#import "NDLBusinessConfigure.h"
#import "BottomView.h"
#import "MenuBtn.h"
#import "BaseBtn.h"

@interface BottomView(){
    
    UIButton *_btn;
    //    MenuBtn *_menuBtn;
    UIButton *_UnUsedBtn;
    UIButton *_UsedBtn; //餐台按钮
    UIButton *_Unselletd;
    MenuBtn *_GouWuChe;//添加购物车按钮
}
@property (nonatomic, weak) MenuBtn *menuBtn;
@property (nonatomic, weak) UIImageView *imageV;
@property (nonatomic, strong) UIButton *selectedBtn;

@property (nonatomic, strong) UIImageView *firstImageView;
@property (nonatomic, strong) UIImageView *SecondImageView;
@property (strong,nonatomic) UIImageView *thirdImageView;
@end


@implementation BottomView

-(instancetype)initWithArr :(NSArray *)arr
{
    if (self = [super init]) {
        self.countStr = [NSArray arrayWithArray:arr];
        self.backgroundColor = [UIColor blackColor];
        [self setButtonViewV];
        if (self.countStr.count < 2) {
            UIButton *btn = [[UIButton alloc] init];
            btn.tag = 1;
            [self BtnChick:btn];
        }
        else{
            UIButton *btn = [[UIButton alloc] init];
            btn.tag = 2;
            [self BtnChick:btn];
        }
        
    }
    
    
    return  self;
}
//- (instancetype)initWithFrame:(CGRect)frame{
//
//    if (self = [super initWithFrame:frame]) {
//
//    }
//    return self;
//}


- (void)setButtonViewV{
    //1 菜单
    MenuBtn *btn3 = [[MenuBtn alloc] init];
    [btn3 setImage:[UIImage imageNamed:@"q_sh1"] forState:UIControlStateNormal];
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 10);
    
    [btn3 setBackgroundColor:[UIColor colorWithRed:86/255.0 green:93/255.0 blue:103/255.0 alpha:1]];
    //设置提示标签
    btn3.bageNub = @"10";
    [btn3 addTarget:self action:@selector(BtnChick:) forControlEvents:UIControlEventTouchUpInside];
    _menuBtn = btn3;
    [self addSubview:btn3];
    //按钮2
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn1.imageView.contentMode = UIViewContentModeCenter;
    
    
    [btn1 setTitle:_countStr[0] forState:UIControlStateNormal];
    [btn1 setImageEdgeInsets:insets];
    [btn1 setImage:[UIImage imageNamed:@"hlk_dd"] forState:UIControlStateNormal];
    [btn1 setBackgroundColor:[UIColor colorWithRed:86/255.0 green:93/255.0 blue:103/255.0 alpha:1]];
    [btn1 addTarget:self action:@selector(BtnChick:) forControlEvents:UIControlEventTouchUpInside];
    _UnUsedBtn = btn1;
    [self addSubview:btn1];
    //按钮3
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setImageEdgeInsets:insets];
    [btn setImage:[UIImage imageNamed:@"hlk_ctzt"] forState:UIControlStateNormal];
    [btn setTitle:_countStr[1] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor colorWithRed:86/255.0 green:93/255.0 blue:103/255.0 alpha:1]];
    [btn addTarget:self action:@selector(BtnChick:) forControlEvents:UIControlEventTouchUpInside];
    _UsedBtn = btn;
    [self addSubview:btn];
    //购物车按钮
    if (self.countStr.count > 2) {
        MenuBtn *btn4 = [MenuBtn buttonWithType:UIButtonTypeCustom];
        
        [btn4 setImageEdgeInsets:insets];
        //根据传过来的数组
        [btn4 setTitle:self.countStr[2] forState:UIControlStateNormal];
        btn4.bageNub = @"10";
        [btn4 setBackgroundColor:[UIColor colorWithRed:86/255.0 green:93/255.0 blue:103/255.0 alpha:1]];
        [btn4 addTarget:self action:@selector(BtnChick:) forControlEvents:UIControlEventTouchUpInside];
        _GouWuChe = btn4;
        [self addSubview:btn4];
        //添加线条3
        UIImageView *imageV2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ndy"]];
        self.thirdImageView = imageV2;
        [self addSubview:imageV2];
    }
    
    
    
    // 线条1
    UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ndy"]];
    self.firstImageView = imageV;
    [self addSubview:imageV];
    //线条2
    UIImageView *imageV1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ndy"]];
    self.SecondImageView = imageV1;
    [self addSubview:imageV1];
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
    
    CGFloat addGouWuChe = menuBtnW / 2;
    
    CGFloat unUsedX = CGRectGetMaxX(_menuBtn.frame) + BottomMargin;
    CGFloat unUsedY = 0;
    CGFloat unUsedH = self.height;
    CGFloat unUsedW = BTNW;
    if (self.countStr.count > 2) {
        _UnUsedBtn.frame = CGRectMake(unUsedX, unUsedY, unUsedW - addGouWuChe, unUsedH);
    }else{
        _UnUsedBtn.frame = CGRectMake(unUsedX, unUsedY, unUsedW, unUsedH);
    }
    
    CGFloat UsedX = CGRectGetMaxX(_UnUsedBtn.frame) + BottomMargin;
    CGFloat UsedY = 0;
    CGFloat UsedW = BTNW;
    CGFloat UsedH = self.height;
    if (self.countStr.count > 2) {
        _UsedBtn.frame = CGRectMake(UsedX, UsedY, UsedW - addGouWuChe, UsedH);
        //购物车
        CGFloat GouWX = CGRectGetMaxX(_UsedBtn.frame);
        CGFloat GouWY = 0;
        CGFloat GouWW = kScreenWidth * 200 / 2048;;
        CGFloat GouWH = self.height;
        _GouWuChe.frame = CGRectMake(GouWX + 2, GouWY, GouWW, GouWH);
    }else{
        _UsedBtn.frame = CGRectMake(UsedX, UsedY, UsedW, UsedH);
    }
    
    
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
    if (self.countStr.count > 2) {
        CGFloat margin2X = CGRectGetMaxX(_UsedBtn.frame);
        CGFloat margin2Y = 0;
        CGFloat margin2W = 2;
        CGFloat margin2H = self.height;
        _thirdImageView.frame = CGRectMake(margin2X, margin2Y, margin2W, margin2H);
    }
    
}

- (void)BtnChick:(UIButton *)btn{
    
    if (btn.tag != 0) {
        
        if (btn.tag == 1)
        {
            
            
            
            [_UnUsedBtn setBackgroundColor:[UIColor colorWithRed:62/225.0 green:69/225.0 blue:80/255.0 alpha:1]];
            
            
            [_UsedBtn setBackgroundColor:[UIColor colorWithRed:86/255.0 green:93/255.0 blue:103/255.0 alpha:1]];
            [_GouWuChe setBackgroundColor:[UIColor colorWithRed:86/255.0 green:93/255.0 blue:103/255.0 alpha:1]];
            
        }else if(btn.tag == 2)
        {
            
            
            
            [_UsedBtn setBackgroundColor:[UIColor colorWithRed:62/225.0 green:69/225.0 blue:80/255.0 alpha:1]];
            
            
            [_UnUsedBtn setBackgroundColor:[UIColor colorWithRed:86/255.0 green:93/255.0 blue:103/255.0 alpha:1]];
            [_GouWuChe setBackgroundColor:[UIColor colorWithRed:86/255.0 green:93/255.0 blue:103/255.0 alpha:1]];
            
        }
        else{
            [_GouWuChe setBackgroundColor:[UIColor colorWithRed:62/225.0 green:69/225.0 blue:80/255.0 alpha:1]];
            
            [_UsedBtn setBackgroundColor:[UIColor colorWithRed:86/255.0 green:93/255.0 blue:103/255.0 alpha:1]];
            [_UnUsedBtn setBackgroundColor:[UIColor colorWithRed:86/255.0 green:93/255.0 blue:103/255.0 alpha:1]];
            
        }
        
    }
    
    
    
    if ([self.delegate respondsToSelector:@selector(BottomViewDidChick:withButton:whereFromStr:)]) {
        [self.delegate BottomViewDidChick:self withButton:btn whereFromStr:@""];
    }
}

@end
