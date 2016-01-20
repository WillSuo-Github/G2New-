//
//  ThirdPayDataManager.h
//  G2TestDemo
//
//  Created by ws on 15/12/23.
//  Copyright © 2015年 ws. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NDLThirdPayDataManager : NSObject

typedef void (^httpResponseSuccess)(id responseObject ,NSString *errorMessage);


-(void)requestPaymentMethodBlock:(httpResponseSuccess )block;


@end
