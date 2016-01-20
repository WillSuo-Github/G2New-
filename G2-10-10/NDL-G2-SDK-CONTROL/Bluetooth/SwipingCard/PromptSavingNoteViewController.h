//
//  PromptSavingNoteViewController.h
//  G2TestDemo
//
//  Created by 吴狄 on 15/12/2.
//  Copyright © 2015年 ws. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "ZhiFuChuanDiPG.h"
#import "SwipingCardProtocol.h"
@interface PromptSavingNoteViewController : BaseViewController
@property(strong,nonatomic) ZhiFuChuanDiPG *zhifuchuandi;
@property(retain,nonatomic) id<SwipingCardProtocol> delegate;
@end
