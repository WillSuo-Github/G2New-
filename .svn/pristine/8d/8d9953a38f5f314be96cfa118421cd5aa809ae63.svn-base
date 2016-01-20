//
//  JYSettingManager.m
//  G2TestDemo
//
//  Created by NDlan on 12/12/15.
//  Copyright © 2015年 ws. All rights reserved.
//

#import "JYSettingManager.h"

@implementation JYSettingManager

+(JYSettingManager *) settingManager
{
    static JYSettingManager *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
    
}

-(void)requestSetingInfo:(NSString *)param block:(NDlHttpResponse)block{
    NSLog(@"珠宝业务逻辑");
}
@end
