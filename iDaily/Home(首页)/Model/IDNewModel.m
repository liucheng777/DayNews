//
//  IDNewModel.m
//  iDaily
//
//  Created by Yin Yi on 15/9/16.
//  Copyright (c) 2015年 Yin Yi. All rights reserved.
//

#import "IDNewModel.h"


@implementation IDNewModel



- (NSArray *)album {
    if (_album) {
        NSMutableArray *newAlbum = [NSMutableArray array];
        for (NSDictionary *dic in _album) {
            IDNewModel *model = [[IDNewModel alloc] initWithDataDic:dic];
            [newAlbum addObject:model];
        }
        return newAlbum;
    }
    return _album;
}
@end
