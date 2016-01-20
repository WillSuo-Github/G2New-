//
//  BarChart.m
//  G2TestDemo
//
//  Created by ws on 15/9/9.
//  Copyright (c) 2015年 ws. All rights reserved.
//
#define BLUEDIY [UIColor colorWithRed:106.0/255 green:175.0/255 blue:232.0/255 alpha:1];
#import "BarChart.h"

@implementation BarChart

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadDefaults];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super initWithCoder:decoder];
    if (self) {
        [self loadDefaults];
    }
    return self;
}

- (void)loadDefaults
{
    self.opaque = NO;
    
    _xLabels = nil;
    
    _autoMax = YES;
    
    _barColor = BLUEDIY;
    _barSpacing = 8;
    _backgroundColor = [UIColor colorWithWhite:0.97 alpha:1];
    _roundToPixel = YES;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    double max = self.autoMax ? [[self.data valueForKeyPath:@"@max.self"] doubleValue] : self.max;
    CGFloat barMaxHeight = CGRectGetHeight(rect);
    NSInteger numberOfBars = self.data.count;
    CGFloat barWidth = (CGRectGetWidth(rect) - self.barSpacing * (numberOfBars - 1)) / numberOfBars;
    CGFloat barWidthRounded = ceil(barWidth);
  //调整barChart的下面字体大小
    if (self.xLabels) {
        CGFloat fontSize = 8;
        
        CGFloat labelsTopMargin = ceil(fontSize * 0.44);
        barMaxHeight -= (fontSize + labelsTopMargin + 3);
        
        [self.xLabels enumerateObjectsUsingBlock:^(NSString *label, NSUInteger idx, BOOL *stop) {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init] ;
            paragraphStyle.alignment = NSTextAlignmentCenter;
            
            [label drawInRect:CGRectMake(idx * (barWidth + self.barSpacing), barMaxHeight + labelsTopMargin, barWidth, fontSize * 1.2)
               withAttributes:@{
                                NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue" size:fontSize],
                                NSForegroundColorAttributeName:[UIColor colorWithWhite:0.1 alpha:1],
                                NSParagraphStyleAttributeName:paragraphStyle,
                                }];
        }];
    }
    
    for (NSInteger i = 0; i < numberOfBars; i += 1)
    {
        CGFloat barHeight = (max == 0 ? 0 : barMaxHeight * [self.data[i] floatValue] / max);
        if (barHeight > barMaxHeight) {
            barHeight = barMaxHeight;
        }
        if (self.roundToPixel) {
            barHeight = (int)barHeight;
        }
        
        CGFloat x = floor(i * (barWidth + self.barSpacing));
        
        [self.backgroundColor setFill];
        CGRect backgroundRect = CGRectMake(x, 0, barWidthRounded, barMaxHeight);
        CGContextFillRect(context, backgroundRect);
        
        UIColor *barColor = self.barColors ? self.barColors[i % self.barColors.count] : self.barColor;
        [barColor setFill];
        CGRect barRect = CGRectMake(x, barMaxHeight - barHeight, barWidthRounded, barHeight);
        CGContextFillRect(context, barRect);
    }
}

#pragma mark Setters

- (void)setData:(NSArray *)data
{
    _data = data;
    [self setNeedsDisplay];
}

- (void)setXLabels:(NSArray *)xLabels
{
    _xLabels = xLabels;
    [self setNeedsDisplay];
}

- (void)setMax:(CGFloat)max
{
    _max = max;
    [self setNeedsDisplay];
}

- (void)setAutoMax:(BOOL)autoMax
{
    _autoMax = autoMax;
    [self setNeedsDisplay];
}

- (void)setBarColors:(NSArray *)barColors
{
    _barColors = barColors;
    [self setNeedsDisplay];
}

- (void)setBarColor:(UIColor *)barColor
{
    _barColor = barColor;
    [self setNeedsDisplay];
}

- (void)setBarSpacing:(NSInteger)barSpacing
{
    _barSpacing = barSpacing;
    [self setNeedsDisplay];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    _backgroundColor = backgroundColor;
    [self setNeedsDisplay];
}


@end
