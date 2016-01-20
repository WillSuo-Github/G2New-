//
//  hardwareInterface.h
//  G2TestDemo
//
//  Created by ws on 15/11/12.
//  Copyright © 2015年 ws. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

//#define SingletonH(methodName) + (instancetype)shared##methodName;
@interface HardwareInterface : NSObject

/**
 *  打印指令
 */
+ (void)printCommandAction;

+ (void)showAction ;




@end
