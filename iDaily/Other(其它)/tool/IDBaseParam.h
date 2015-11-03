//
//  IDBaseParam.h
//  iDaily
//
//  Created by Yin Yi on 15/9/22.
//  Copyright (c) 2015年 Yin Yi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDBaseParam : NSObject
/**
 *  请求基本参数
*/
//page=1&ver=iphone&app_ver=20
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger app_ver;
@property (nonatomic, copy) NSString *ver;

+ (instancetype)param;
@end
