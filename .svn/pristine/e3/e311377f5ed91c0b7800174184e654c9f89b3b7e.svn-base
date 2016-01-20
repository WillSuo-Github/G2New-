//
//  DeskState.m
//  G2TestDemo
//
//  Created by lcc on 15/7/23.
//  Copyright (c) 2015年 ws. All rights reserved.
/*
 @property (nonatomic, copy) NSString *openTableTime;
 
 
 @property (nonatomic, copy) NSString *tabId;
 
 @property (nonatomic, copy) NSString *tabNo;
 
 @property (nonatomic, copy) NSString *areaId;
 
 @property (nonatomic, copy) NSString *isChedan;
 */

#import "DeskState.h"

@implementation DeskState

- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.dinnerStatus forKey:@"dinnerStatus"];
    [aCoder encodeObject:self.openTableTime forKey:@"openTableTime"];
    [aCoder encodeObject:self.tabId forKey:@"tabId"];
    [aCoder encodeObject:self.tabNo forKey:@"tabNo"];
    [aCoder encodeObject:self.areaId forKey:@"areaId"];
    [aCoder encodeObject:self.isChedan forKey:@"isChedan"];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    
    _dinnerStatus = [aDecoder decodeObjectForKey:@"dinnerStatus"];
    _openTableTime = [aDecoder decodeObjectForKey:@"openTableTime"];
    _tabId = [aDecoder decodeObjectForKey:@"tabId"];
    _tabNo = [aDecoder decodeObjectForKey:@"tabNo"];
    _areaId = [aDecoder decodeObjectForKey:@"areaId"];
    _isChedan = [aDecoder decodeObjectForKey:@"isChedan"];
    
    return self;
}


/*
 
 @property (nonatomic, copy) NSString *dinnerStatus;
 
 @property (nonatomic, copy) NSString *openTableTime;
 
 
 @property (nonatomic, copy) NSString *tabId;
 
 @property (nonatomic, copy) NSString *tabNo;
 
 @property (nonatomic, copy) NSString *areaId;
 
 @property (nonatomic, copy) NSString *isChedan;
 
 @property (nonatomic, copy) NSString *tabName;
 
 @property (nonatomic, copy) NSString *peopleCount;
 
 @property (nonatomic, copy) NSString *totalPrice;
 
 */


-(NSString *)description
{
    NSString *str  = [[NSString alloc]initWithFormat:@"dinnerStatus:%@,openTableTime:%@,tabId:%@,tabNo:%@,areaId:%@,isChedan:%@,tabName:%@,peopleCount:%@,totalPrice:%@",self.dinnerStatus,self.openTableTime,self.tabId,self.tabNo,self.areaId,self.isChedan,self.tabName,self.peopleCount,self.totalPrice];
    
    
    return str;
    
    
    
    
}
@end
