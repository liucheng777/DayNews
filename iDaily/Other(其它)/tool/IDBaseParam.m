//
//  IDBaseParam.m
//  iDaily
//
//  Created by Yin Yi on 15/9/22.
//  Copyright (c) 2015年 Yin Yi. All rights reserved.
//

#import "IDBaseParam.h"

@implementation IDBaseParam
- (id)init
{
    if (self = [super init]) {
        self.page = 1;
        self.ver = @"iphone";
        self.app_ver = 20;
    }
    return self;
}

+ (instancetype)param
{
    return [[self alloc] init];
}
@end
