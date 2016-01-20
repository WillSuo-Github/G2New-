//
//  ServerManager.h
//  GITestDemo
//
//  Created by 吴狄 on 14/12/17.
//  Copyright (c) 2014年 Kyson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AsyncSocket.h"
@interface ServerManager : NSObject<AsyncSocketDelegate>

+ (instancetype)sharedManager;

//连接服务器
- (NSInteger)SocketOpen:(NSString*)addr port:(NSInteger)port;
//关闭连接
- (NSInteger)SocketClose;
//写数据
-(void)writeData:(NSData *)data;

@property (strong,nonatomic) AsyncSocket *sock;

@end
