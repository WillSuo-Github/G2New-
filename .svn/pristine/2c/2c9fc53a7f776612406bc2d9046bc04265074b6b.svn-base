//
//  ContributionGraph.m
//  G2TestDemo
//
//  Created by ws on 15/9/9.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import "ContributionGraph.h"
#import "NSDate+TEAExtensions.h"
#import <objc/runtime.h>


@interface ContributionGraph ()

@property (nonatomic) NSUInteger gradeCount;
@property (nonatomic, strong) NSMutableArray *gradeMinCutoff;
@property (nonatomic, strong) NSDate *graphMonth;
@property (nonatomic, strong) NSMutableArray *colors;

@end

@implementation ContributionGraph



- (void)daySelected:(id)sender
{
    NSDictionary *data = (NSDictionary *)objc_getAssociatedObject(sender, @"dynamic_key");
    if ([self.delegate respondsToSelector:@selector(dateTapped:)]) {
        [self.delegate dateTapped:data];
    }
}

#pragma mark Setters

- (void)setDelegate:(id<ContributionGraphDataSource>)delegate
{
    _delegate = delegate;
    [self setNeedsDisplay];
}

- (void)setCellSize:(CGFloat)cellSize
{
    _cellSize = cellSize;
    [self setNeedsDisplay];
}

- (void)setCellSpacing:(CGFloat)cellSpacing
{
    _cellSpacing = cellSpacing;
    [self setNeedsDisplay];
}


@end
