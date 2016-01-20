//
//  JiLuCaiViewCell.h
//  G2TestDemo
//
//  Created by lcc on 15/8/20.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CaiPG.h"

@interface JiLuCaiViewCell : UITableViewCell

@property (nonatomic, strong) CaiPG *caipg;

@property (weak, nonatomic) IBOutlet UILabel *xuhao;

@end
