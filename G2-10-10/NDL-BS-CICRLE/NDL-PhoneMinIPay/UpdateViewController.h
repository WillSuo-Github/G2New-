//
//  UpdateViewController.h
//  GITestDemo
//
//  Created by 吴狄 on 14/12/31.
//  Copyright (c) 2014年 Kyson. All rights reserved.
//

#import "G1BaseViewController.h"
#import "CustomAlertView.h"
@interface UpdateViewController : G1BaseViewController <UIPickerViewDelegate,UIPickerViewDataSource>

@property (strong, nonatomic) IBOutlet UIProgressView *progressView;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;

- (IBAction)check:(id)sender;

- (IBAction)download:(id)sender;

- (IBAction)update:(id)sender;
@end
