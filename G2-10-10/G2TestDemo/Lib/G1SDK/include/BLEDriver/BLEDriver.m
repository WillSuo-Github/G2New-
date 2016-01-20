//
//  BLEDriver.m
//  BLEDriver
//
//  Created by jimskyship on 14/11/20.
//  Copyright (c) 2014年 femtoapp. All rights reserved.
//

#import "BLEDriver.h"
#import "BleManager.h"
#import "ServerManager.h"
#import "Anasis8583Pack.h"
#import "AFNetworking.h"

#define bleManager [BleManager sharedManager]


#pragma mark -
#pragma mark - Thread Actions

/*
 *蓝牙扫描
 */
//void *thread_BleScanAction(void *arg)
//{
//    
//    while (!bleScaned && !bleScanTimeout) {
//        NSLog(@"ble scaning!");
//    }
//    
//    return 0;
//    
//}





#pragma mark - 
#pragma mark - ****DeviceDriverInterface****

int DeviceErrorFunc123(int error){
    
    return 0;
}

DeviceDriverInterface * GetBLEDeviceInterface()
{

    NSLog(@"GetBLEDeviceInterface start...");
    getbleinterface.DeviceOpen=&DeviceOpen;
    getbleinterface.DeviceClose=&DeviceClose;
    getbleinterface.DeviceDriverDestroy=&DeviceDriverDestroy;
    getbleinterface.DeviceState=&DeviceState;
    getbleinterface.DeviceDriverInit=&DeviceDriverInit;
    getbleinterface.DeviceDriverDestroy=&DeviceDriverDestroy;
    getbleinterface.RegisterReadPosDataFunc=&RegisterReadPosDataFunc;
    getbleinterface.RegisterErrorFunc=&RegisterErrorFunc;
    getbleinterface.WritePosData=&WritePosData;
    getbleinterface.WriteServerData =&WriteServerData;
    getbleinterface.RegisterReadServerDataFunc =&RegisterReadServerDataFunc;
    getbleinterface.GetMsTime = &GetMsTime;
    
    //deviceErrorFunc = &DeviceErrorFunc123;
    
    return &getbleinterface;
}



unsigned long GetMsTime(){

    static unsigned long long  firstTime = 0;

    

    NSTimeInterval time = [[NSDate date] timeIntervalSince1970]*1000;
    
    if (firstTime == 0) {
        firstTime = time;
    }
    

    return time - firstTime;
}
int WriteServerData(unsigned char *data, int datalen){
    

    
    ServerManager *server = [ServerManager sharedManager];
    
    server.sock.delegate = server;
    
    
    NSString *ip = [[NSUserDefaults standardUserDefaults] objectForKey:kHostEditor];
    
    NSString *port = [[NSUserDefaults standardUserDefaults] objectForKey:kPortEditor];
    
    if ([server.sock isConnected]) {
        [server.sock disconnect];
    }
    
    if (![server.sock.connectedHost isEqualToString:ip] || server.sock.connectedPort != port.intValue) {
        [server.sock disconnect];
    }
   
    if (![server.sock isConnected]) {
 
         NSLog(@"host:%s,port:%d",ip.UTF8String,port.intValue);;
        
        [server SocketOpen:ip port:port.intValue];
        
    }else{
        NSLog(@"已经连接上服务器");
    }
    
    
    if (_quanjuQianDaoType == 0) {

        NSData *sendData = [NSData dataWithBytes:(const void *)data length:sizeof(char)*datalen];
        
        NSLog(@"WriteServerData:%@",sendData);
        
        [server writeData:sendData];
    }else{
        
        printf("^^^^^^^^^^%s\n",data);
        
        NSData *sendData = [NSData dataWithBytes:(const void *)data length:sizeof(char)*datalen];
        
//        NSLog(@"************:%@",sendData);
        

            //解析报文数据
        ClearRecvFlag();
        
        printf("*********\n");
        for (int i = 0; i <= datalen; i++) {
            BreakupRecvPack(data[i]);
        }

        printf("\n*********\n");
        
        for (int i = 0; i <= gTrack2Len; i++) {
            printf("%X",gTrack2[i]);
        }
        printf("\n*********\n");

            //批次号
        int gUserArea = BCDToInt(gUserArea60+1, 3);
        NSString *gUserAreaString = [NSString stringWithFormat:@"%.6d",gUserArea];
        NSString *picihao = gUserAreaString;
            //商户号
//        NSData *mcCodeData = [NSData dataWithBytes:(const void *)gMerchantCode length:sizeof( char)*15];
//        NSLog(@"!!!%@",mcCodeData);
//        NSString *mcCodeString = [[NSString alloc] initWithData:mcCodeData encoding:NSUTF8StringEncoding];
        NSString *shanghuhao = [[NSUserDefaults standardUserDefaults]stringForKey:kMposG1MerchantNo];
            //时间 gLocalTime[3]
        NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *dingdanshijian = [formatter stringFromDate:[NSDate date]];
        
            //卡号
        char bankCardStr[22]="";
        NSString *carNo;
        
            
            getBankCardNo(bankCardStr);
            carNo = [NSString stringWithUTF8String:bankCardStr];
            NSLog(@"+++++%@",carNo);


//            NSRange range = [carNo rangeOfString:@"Q"];
//            carNo = [carNo substringToIndex:range.location];
        if (carNo.length != 0) {
            NSString *firstStr = [carNo substringToIndex:2];
            if ([firstStr isEqualToString:@"99"]) {
                carNo = [carNo substringFromIndex:2];
            }
        }else{
            
            
            [[NSNotificationCenter defaultCenter] postNotificationName:jishixiaofeiChongxin object:nil];
            NSData *sendData = [NSData dataWithBytes:(const void *)data length:sizeof(char)*datalen];

            [server writeData:sendData];
            
            return 0;
        }

        
        
        
        NSLog(@"%@",carNo);
//        carNo = [carNo substringToIndex:carNo.length - 6];
        NSString *yinhangkahao = carNo;
//        NSString *yinhangkahao = @"6227002430090553397";
        
        NSString *suijiStr = [[NSUserDefaults standardUserDefaults] objectForKey:Kcitiaosuijishu];
        NSString *yonghuming = [[NSUserDefaults standardUserDefaults] objectForKey:kLoginPhoneNo];
        NSString *mimaStr = [[NSUserDefaults standardUserDefaults] objectForKey:KPassword];
        NSString *yewuleixing = @"realNameAuth";
        NSString *chanpinbianma = @"77007";
//        NSString *yanzhengleixing = @"3";
        NSString *name = [[NSUserDefaults standardUserDefaults] objectForKey:Kcitiaoxingming];
        NSString *yuliushoujihao = [[NSUserDefaults standardUserDefaults] objectForKey:Kcitiaoyuliushoujihao];
        NSString *shenfenzhenghao = [[NSUserDefaults standardUserDefaults] objectForKey:Kcitiaoshenfenzhenghao];
        NSString *validType = @"3";
        NSString *agentID = @"575558400002";
        
            //终端号
        NSData *terCodeData = [NSData dataWithBytes:(const void *)gTerminalCode length:sizeof( char)*8];
        NSString *zhongduanhao = [[NSString alloc] initWithData:terCodeData encoding:NSUTF8StringEncoding];
        
        
        
            //凭证号  gSysTraceAudit[3]
        int sysTraceAudit = BCDToInt(gSysTraceAudit, 3);
        NSString *pingzhenghao = [NSString stringWithFormat:@"%.6d",sysTraceAudit];
        
        NSString *orderID = [NSString stringWithFormat:@"%@%@",zhongduanhao,pingzhenghao];

        NSString *urlStr = [NSString stringWithFormat:@"http://%@:%@/MposApp/appToWebToPeripheral.action?",kServerIP,kServerPort];
        urlStr = [NSString stringWithFormat:@"%@userid=%@&userpws=%@&reqtype=%@&serCode=%@&merchantId=%@&orderId=%@&orderTime=%@&phoneNo=%@&bankCardNo=%@&idNo=%@&name=%@&validType=%@&authCode=%@&agentId=%@",urlStr,yonghuming,mimaStr,yewuleixing,chanpinbianma,shanghuhao,orderID,dingdanshijian,yuliushoujihao,yinhangkahao,shenfenzhenghao,name,validType,suijiStr,agentID];
        NSLog(@"--13----%@",urlStr);

        urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
        [mgr GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"%@",responseObject);
            if ([[responseObject objectForKey:@"responseCode"] isEqualToString:@"00"]) {
            
                
                NSData *sendData = [NSData dataWithBytes:(const void *)data length:sizeof(char)*datalen];
                
                NSLog(@"WriteServerData:%@",sendData);
                
                [server writeData:sendData];
            }else{
                
                [[NSNotificationCenter defaultCenter] postNotificationName:jishixiaofeiShibai object:nil];
                NSData *sendData = [NSData dataWithBytes:(const void *)data length:sizeof(char)*datalen];
                
                NSLog(@"WriteServerData:%@",sendData);
                
                [server writeData:sendData];
            }
         
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
        }];
        
        
    }
    
    
    
    return 0;
}
int RegisterReadServerDataFunc(DeviceReadDataFunc func){
    DeviceReadServerData = func;
    return 0;
}

int WritePosData(unsigned char *data, int datalen)
{
    NSLog(@"WritePosData....%d",datalen);
//    unsigned char *test = "In contemporary business and science a project is a collaborative enterprise, involving research or design, that is carefully planned to achieve a particular aim. Projects can be further defined as temporary rather than permanent social systems or work systems that are";
//    sprintf(data,"%s",test);
    
    
    for (int i=0; i<datalen; i++) {
        printf("%.2x",data[i]);
        if (i%2 !=0) {
            printf(" ");
        }
    }
    printf("\n");
    

    if (bleManager.imBT.connected) {

        if (_type == 1 || _type == 2) {
            ClearRecvFlag();
            
            for (int i = 0; i <= datalen; i++) {
                if (BreakupRecvPack(data[i]) == 0) {
                    NSLog(@"scc");
                    _type =0;
                    char bankCardStr[22]="";
                    getBankCardNo(bankCardStr);
                    NSLog(@"银行卡号%@",[NSString stringWithUTF8String:bankCardStr]);
                } else {
                    //NSLog(@"fail");
                }
            }
            
        }
        


        NSData *sendData;
        int num = 20;
        while (datalen - num >0) {
            
            sendData = [NSData dataWithBytes:(const void *)data length:sizeof( char)*num];
            [bleManager.imBT writeValue:sendData];
            data = data + num;
            datalen -=num;
            [NSThread sleepForTimeInterval:0.01];
        }
        
        if (datalen >0) {
            sendData = [NSData dataWithBytes:(const void *)data length:sizeof( char)*datalen];
            [bleManager.imBT writeValue:sendData];
        }
//        
//        NSData *sendData = [NSData dataWithBytes:(const void *)data length:sizeof( char)*datalen];
//        [bleManager.imBT writeValue:sendData];
        return 0;
    }
   
    
    return -1;
}

int RegisterReadPosDataFunc(DeviceReadDataFunc func)
{
    //蓝牙读取到数据时候，会执行func回调函数，这里保存了该函数指针。
    NSLog(@"readdatafunction registered.");
    DeviceReadPosData=func;
    //蓝牙读取到数据后，根据该函数指针执行回调通知上层SDK，回调格式：datavaluechanged(unsigned char *data, int datalen);
    return 0;
}


int DeviceDriverInit()
{
    NSLog(@"DeviceDriverInit");
    [bleManager startBleManager];
    
    return 0;
}

int DeviceOpen()
{
    NSLog(@"DeviceOpen");
    
    if (bleManager.imBT.isConnected) {
        NSLog(@"open = 0");
        return 0;
    }

    return -1;
}

int DeviceClose()
{
    NSLog(@"DeviceClose");
    
    [bleManager.imBT disconnectPeripheral:nil];
    
    return 0;
}

int DeviceDriverDestroy()
{
    NSLog(@"DeviceDriverDestory");
    return 0;
}

int DeviceState()
{

    if (bleManager.imBT.isConnected) {
        
        NSLog(@"DeviceState:设备已经连接");
        
        return 0;
    }else{
        
        NSLog(@"DeviceState:设备已断开");
        
    }
    
    return -1;
}

int RegisterErrorFunc(DeviceErrorFunc func)
{
    deviceErrorFunc = func;
    return 0;
}




