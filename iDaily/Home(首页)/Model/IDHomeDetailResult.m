//
//  IDHomeDetailResult.m
//  iDaily
//
//  Created by Yin Yi on 15/9/22.
//  Copyright (c) 2015年 Yin Yi. All rights reserved.
//

#import "IDHomeDetailResult.h"
#import "MJExtension.h"
#import "IDDetailModel.h"

@implementation IDHomeDetailResult
- (void)setNews:(NSDictionary *)news {
    NSArray *key = [news allKeys];
    IDLog(@"%@",key);
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    for (NSInteger index = 0; index < key.count; index ++) {
        NSArray *data = news[key[index]];
        NSMutableArray *arr = [NSMutableArray array];
        for (NSDictionary *dic in data) {
            IDDetailModel *model = [[IDDetailModel alloc] initWithDataDic:dic];
            [arr addObject:model];
        }
        [dataDic setValue:arr forKey:key[index]];
    }
    _news = dataDic;
}
@end
