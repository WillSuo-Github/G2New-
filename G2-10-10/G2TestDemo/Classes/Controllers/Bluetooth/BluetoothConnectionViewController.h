//
//  BluetoothConnectionViewController.h
//  G2TestDemo
//
//  Created by 吴狄 on 15/11/20.
//  Copyright © 2015年 ws. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BaseViewController.h"
#import "ScanViewController.h"
@interface BluetoothConnectionViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,ScanViewControllerDelegate>

@end
