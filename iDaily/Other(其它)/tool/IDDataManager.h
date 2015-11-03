//
//  IDDataManager.h
//  iDaily
//
//  Created by Yin Yi on 15/9/22.
//  Copyright (c) 2015年 Yin Yi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IDHomeParam.h"
#import "FMDB.h"

@interface IDDataManager : NSObject

+ (void)addNews:(NSDictionary *)dict;

+ (void)addNewses:(NSArray *)dictArray;

+ (void)addDetails:(NSDictionary *)dict;


//读取缓存方法
+ (NSArray *)news;

+ (NSDictionary *)details;

@end
