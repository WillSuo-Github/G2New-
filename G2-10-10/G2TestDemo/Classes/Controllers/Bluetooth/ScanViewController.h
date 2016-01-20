//
//  ScanViewController.h
//  G2TestDemo
//
//  Created by 吴狄 on 15/11/22.
//  Copyright © 2015年 ws. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ScanViewController;

@protocol  ScanViewControllerDelegate <NSObject>
-(void)scanViewControllerdidFinishScan :(ScanViewController *)vc result:(NSString*)str;
@end


@interface ScanViewController : UIViewController
@property (nonatomic, weak) id<ScanViewControllerDelegate> delegate;
@end
