//
//  MyNetWorkQuery.h
//  天气预报
//
//  Created by kangkathy on 15/8/28.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyNetWorkQuery : NSObject


+ (void)requestData:(NSString *)urlString HTTPMethod:(NSString *)method completionHandle:(void(^)(id))block;

@end
