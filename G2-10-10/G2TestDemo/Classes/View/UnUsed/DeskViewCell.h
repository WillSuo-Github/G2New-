//
//  DeskViewCell.h
//  G2TestDemo
//
//  Created by lcc on 15/7/28.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DeskState.h"

@interface DeskViewCell : UICollectionViewCell

@property (nonatomic, strong) DeskState *state;
@property (nonatomic, copy) NSString *tableName;

@property (weak, nonatomic) IBOutlet UILabel *ID;
@property (weak, nonatomic) IBOutlet UILabel *topFenGeXian;
@property (weak, nonatomic) IBOutlet UILabel *leftFenGeXian;

@property (weak, nonatomic) IBOutlet UILabel *rightFenGeXian;

@end
