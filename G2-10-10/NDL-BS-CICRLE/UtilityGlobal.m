//
//  UtilityGlobal.m
//  G2TestDemo
//
//  Created by ws on 15/12/19.
//  Copyright © 2015年 ws. All rights reserved.
//

#import "UtilityGlobal.h"

@implementation UtilityGlobal









+(NSString*) gen_uuid
{
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    
    CFRelease(uuid_ref);
    NSString *uuid = [NSString stringWithFormat:@"%@",uuid_string_ref];
    
    CFRelease(uuid_string_ref);
    NSString *uuidS = [uuid stringByReplacingOccurrencesOfString:@"-" withString:@""];
    return uuidS;
}

@end
