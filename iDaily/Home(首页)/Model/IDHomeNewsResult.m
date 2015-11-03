//
//  IDHomeNewsResult.m
//  iDaily
//
//  Created by Yin Yi on 15/9/22.
//  Copyright (c) 2015年 Yin Yi. All rights reserved.
//

#import "IDHomeNewsResult.h"
#import "MJExtension.h"
#import "IDNewModel.h"


@implementation IDHomeNewsResult
- (void)setNews:(NSArray *)news {
    NSMutableArray *newNews = [NSMutableArray array];
    for (int index = 0; index < news.count; index ++) {
        IDNewModel *newsModel = [[IDNewModel alloc] initWithDataDic:news[index]];
        IDLog(@"%@",news[index]);
        [newNews addObject:newsModel];
    }
    _news = newNews;
}
@end
