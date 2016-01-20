//
//  TimeTool.m
//  G2TestDemo
//
//  Created by lcc on 15/8/19.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import "TimeTool.h"

@implementation TimeTool

+ (NSString *)Vipzhuanhuanshijian:(NSString *)str{
    
    str = [str substringToIndex:10];
    char *tmpStr = (char *)[str UTF8String];
    char rst[20];
    digit2date(tmpStr, rst);
    NSString *sss = [NSString stringWithCString:rst encoding:NSUTF8StringEncoding];
    return  sss;
}

char *digit2date(char *idate,char *rst){
    
    if (idate == NULL) {
        return NULL;
    }
    long timel;
    time_t vidate;
    struct tm *vdate;
    timel=atoll(idate);
    vidate=(time_t)timel;
    vdate=localtime(&vidate);
    //    sprintf(rst,"%04d-%02d-%02d %02d:%02d:%02d",vdate->tm_year+1900,vdate->tm_mon+1,vdate->tm_mday,vdate->tm_hour,vdate->tm_min,vdate->tm_sec);
    sprintf(rst,"%04d-%02d-%02d",vdate->tm_year+1900,vdate->tm_mon+1,vdate->tm_mday);
//    printf("%s\n",rst);
    return rst;
}

+ (NSString *)JiaoYizhuanhuanshijian:(NSString *)str{
    
    str = [str substringToIndex:10];
    char *tmpStr = (char *)[str UTF8String];
    char rst[20];
    digit1date(tmpStr, rst);
    NSString *sss = [NSString stringWithCString:rst encoding:NSUTF8StringEncoding];
    return  sss;
}

char *digit1date(char *idate,char *rst){
    
    if (idate == NULL) {
        return NULL;
    }
    long timel;
    time_t vidate;
    struct tm *vdate;
    timel=atoll(idate);
    vidate=(time_t)timel;
    vdate=localtime(&vidate);
    //    sprintf(rst,"%04d-%02d-%02d %02d:%02d:%02d",vdate->tm_year+1900,vdate->tm_mon+1,vdate->tm_mday,vdate->tm_hour,vdate->tm_min,vdate->tm_sec);
    sprintf(rst,"%02d-%02d %02d:%02d:%02d",vdate->tm_mon+1,vdate->tm_mday,vdate->tm_hour,vdate->tm_min,vdate->tm_sec);
    //    printf("%s\n",rst);
    return rst;
}

+(NSString *)getCurrentDateStr
{
    
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    NSString *currentDateStr = [NSString stringWithFormat:@"%ld%ld%ld%ld%ld",[dateComponent month],[dateComponent day],[dateComponent hour],[dateComponent minute],[dateComponent second]];
    return currentDateStr;

    
}


+(NSString *)getRandomCharStr:(NSInteger) num
{
    NSArray *baseArray = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
    NSMutableString *resultStr = [NSMutableString string];
    if (num != 0) {
        
        for (int i = 0; i < num; i++) {
            [resultStr appendString:baseArray[arc4random()%26]];
            
        }
    }
    
    return  resultStr;
    
    
    
}


+(NSString *)getCurrentDateStr:(NSString *)format
{
    
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit|NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    NSString *currentDateStr = nil;
    if (format.length == 0) {
        currentDateStr = [NSString stringWithFormat:@"%ld%ld%ld%ld%ld%ld",[dateComponent year],[dateComponent month],[dateComponent day],[dateComponent hour],[dateComponent minute],[dateComponent second]];
    }
    else
    {
        currentDateStr = [NSString stringWithFormat:format,[dateComponent year],[dateComponent month],[dateComponent day],[dateComponent hour],[dateComponent minute],[dateComponent second]];
    }
    
    return currentDateStr;
    
}




@end
