//
//  IDNewsTool.m
//  iDaily
//
//  Created by Yin Yi on 15/9/22.
//  Copyright (c) 2015年 Yin Yi. All rights reserved.
//

#import "IDNewsTool.h"
#import "IDNetWorkingManager.h"
#import "MJExtension.h"
#import "IDDataManager.h"
#import "IDNewModel.h"

@implementation IDNewsTool
+ (void)newsWithParam:(IDHomeParam *)param success:(void (^)(IDHomeNewsResult *result))success failure:(void (^)(NSError *error))failure {
    NSArray *newsArray = [IDDataManager news];
    NSDictionary *firstNews = [newsArray firstObject];
    NSDate *currentDate = [NSDate date];
//    NSTimeInterval *tis = [firstNews.pubdate_timestamp intValue];
    NSDate *pubdate = [NSDate dateWithTimeIntervalSince1970:[firstNews[@"pubdate_timestamp"] floatValue]];
    NSTimeInterval secondsInterval= [currentDate timeIntervalSinceDate:pubdate];
    if (secondsInterval > 60 * 60 * 24) {
        [IDNetWorkingManager getWithURL:IDGetNewsURL params:param.keyValues success:^(NSArray *json) {
            // 缓存
            [IDDataManager addNewses:json];
            
            
            IDHomeNewsResult *result = [[IDHomeNewsResult alloc] init];
            result.news = json;
            if (success) {
                success(result);
            }
        } failure:^(NSError *error) {
            if (failure) {
                failure(error);
            }
        }];
    } else {
        if (success) {
            IDHomeNewsResult *result = [[IDHomeNewsResult alloc] init];
            result.news = newsArray;
            success(result);
        }
    }
//    if (newsArray.count) {
//        if (success) {
//            IDHomeNewsResult *result = [[IDHomeNewsResult alloc] init];
//            result.news = newsArray;
//            success(result);
//        }
//    } else {
//           }
}

/**
 *  加载地图页的新闻数据
 */
+ (void)detailNewsWithParam:(IDHomeParam *)param success:(void (^)(IDHomeDetailResult *result))success failure:(void (^)(NSError *error))failure {
//    NSDictionary *details = [IDDataManager details];
//    if (details.count) {
//        if (success) {
//            IDHomeDetailResult *result = [[IDHomeDetailResult alloc] init];
//            result.news = details;
//            success(result);
//        }
//
//    } else {
    [IDNetWorkingManager getWithURL:IDGetDetailURL params:param.keyValues success:^(NSDictionary *json) {
        IDHomeDetailResult *result = [[IDHomeDetailResult alloc] init];
        [IDDataManager addDetails:json];
        result.news = json;
        if (success) {
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
//    }

}
@end
