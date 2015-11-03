//
//  IDNewsTool.h
//  iDaily
//
//  Created by Yin Yi on 15/9/22.
//  Copyright (c) 2015年 Yin Yi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IDHomeParam.h"
#import "IDHomeNewsResult.h"
#import "IDHomeDetailResult.h"

@interface IDNewsTool : NSObject
/**
 *  加载首页的新闻
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)newsWithParam:(IDHomeParam *)param success:(void (^)(IDHomeNewsResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  加载地图页的新闻数据
 */
+ (void)detailNewsWithParam:(IDHomeParam *)param success:(void (^)(IDHomeDetailResult *result))success failure:(void (^)(NSError *error))failure;
@end
