//
//  ConnectDeviceViewController.h
//  GITestDemo
//
//  Created by Femto03 on 14/12/1.
//  Copyright (c) 2014年 Kyson. All rights reserved.
//

#import "G1BaseViewController.h"

@interface ConnectDeviceViewController : G1BaseViewController

@property (strong, nonatomic) IBOutlet UILabel *bleStatusLabel;

@property (strong, nonatomic) IBOutlet UILabel *bluetoothName;
@property (strong, nonatomic) IBOutlet UILabel *SN;
@property (strong, nonatomic) IBOutlet UILabel *time;


@property (nonatomic, strong) UITableView *deviceTable;
@property (nonatomic, strong) UIView *deviceView;


@property (strong, nonatomic) IBOutlet UIButton *addBtn;

- (IBAction)bleConnectAction:(UIButton *)sender;

@end
