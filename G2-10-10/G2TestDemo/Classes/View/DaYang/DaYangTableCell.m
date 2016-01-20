//
//  DaYangTableCell.m
//  G2TestDemo
//
//  Created by lcc on 15/9/18.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import "DaYangTableCell.h"

@interface DaYangTableCell ()

@property (weak, nonatomic) IBOutlet UILabel *title;


@end


@implementation DaYangTableCell

- (void)awakeFromNib {
    // Initialization code
    self.title.textColor = [UIColor colorWithRed:151/255.0 green:151/255.0 blue:151/255.0 alpha:1];
    self.title.font = [UIFont boldSystemFontOfSize:17];
    
}


- (void)setTableName:(NSString *)tableName{
    
    _tableName = tableName;
    self.title.text = tableName;
}
@end
