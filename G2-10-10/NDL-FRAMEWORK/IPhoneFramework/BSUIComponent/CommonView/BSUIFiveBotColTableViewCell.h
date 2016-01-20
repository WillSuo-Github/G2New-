//
//  BSUIFiveBotColTableViewCell.h
//  G2TestDemo
//
//  Created by NDlan on 15/12/15.
//  Copyright © 2015年 ws. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSUITableMultCellOperation.h"
@interface BSUIFiveBotColTableViewCell : UITableViewCell<BSUITableMultCellOperation>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;



@property (weak, nonatomic) IBOutlet UIButton *imgButton;


@end
