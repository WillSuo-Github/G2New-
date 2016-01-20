//
//  NDlPrint.m
//  GITestDemo
//
//  Created by NDlan on 26/11/15.
//  Copyright © 2015年 Kyson. All rights reserved.
//

#import "NDlPrint.h"

@interface NDlPrint (){
    //ServerManager *server;
}

@property (strong,nonatomic) AsyncSocket *sock;
@property (nonatomic, retain) NSTimer        *connectTimer; // 计时器


- (NSInteger)socketOpen:(NSString*)addr port:(NSInteger)port;
- (NSInteger)socketClose;
@end

@implementation NDlPrint

+ (instancetype)initNDlPrint
{
    
    static NDlPrint *sharedObject = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedObject = [[super allocWithZone:NULL] init];
        sharedObject.sock = [[AsyncSocket alloc]init];

        sharedObject.sock.delegate = self;
        
    });
    
    return sharedObject;
    
}

-(void)demo{
    NSString *str = @"\n\n你好，北京！\n这里是神马和呢";
    NDlPrint *print=[NDlPrint initNDlPrint];
    [print socketOpenWithDefualtAddr];
    [print writeWithString:str];
    str = @"你好，上传！";
    [print writeWithString:str];
    str = @"你好，这里还是是呵呵呵呵呵！";
    [print writeWithString:str];
    
    str = @"你好，世界！时候是上海市";
    [print writeWithString:str];
    str = @"\n\n";
    [print writeWithString:str];
    [print socketClose];
}

-(void)writeWithData:(NSData *)data{
    
    NSLog(@"打印数据为:%@",data);
     //[self socketDefualt];
 
    [_sock writeData:data withTimeout:-1 tag:0];
    //[self socketClose];
}

-(void)writeWithString:(NSString *)data{
    NSLog(@"打印数据为:%@",data);
    unsigned long encode = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    
    NSData *printData=[data dataUsingEncoding:encode];
    
    [self writeWithData:printData];
    
}

//打开
- (NSInteger)socketOpen:(NSString*)addr port:(NSInteger)port
{

    if ([self.sock isConnected]) {
        [self.sock disconnect];
    }
    
    if (![_sock isConnected])
    {
        [_sock connectToHost:addr onPort:port withTimeout:-1 error:nil];
        
    }
    
    return 0;
}

//打开
- (NSInteger)socketOpenWithDefualtAddr
{
    NSString *ip = @"192.168.1.209";
    
    NSInteger port =50000;
    return [self socketOpen:ip port:port];

}


//关闭
- (NSInteger)socketClose
{
    if ([_sock isConnected])
    {
        [_sock disconnect];
    }
    return 0;
}


#pragma mark Delegate

- (void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err
{
    NSLog(@"willDisconnectWithError:%@",err);
}


- (void)onSocketDidDisconnect:(AsyncSocket *)sock
{
    NSLog(@"onSocketDidDisconnect");
}




#pragma mark  - 连接成功回调
-(void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString  *)host port:(UInt16)port
{
    NSLog(@"socket连接成功");
    
  
    
}

- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSLog(@"didReadData:%@",data);

    
    [self socketClose];
    
}

-(void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    NSLog(@"didWriteDataWithTag:%ld",tag);
    [sock readDataWithTimeout:-1 tag:0];
}

@end
