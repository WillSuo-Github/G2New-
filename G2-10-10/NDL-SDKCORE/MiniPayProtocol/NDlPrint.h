//
//  NDlPrint.h
//  GITestDemo
//
//  Created by NDlan on 26/11/15.
//  Copyright © 2015年 Kyson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AsyncSocket.h"


@interface NDlPrint : NSObject<AsyncSocketDelegate>

+ (instancetype)initNDlPrint;

-(void )demo;
-(void)writeWithData:(NSData *)data;

-(void)writeWithString:(NSString *)data;

- (NSInteger)socketOpenWithDefualtAddr;
- (NSInteger)socketClose;

@end
