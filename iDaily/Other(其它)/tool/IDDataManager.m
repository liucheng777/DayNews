//
//  IDDataManager.m
//  iDaily
//
//  Created by Yin Yi on 15/9/22.
//  Copyright (c) 2015年 Yin Yi. All rights reserved.
//

#import "IDDataManager.h"

@implementation IDDataManager
static FMDatabaseQueue *_queque;
static NSDate *_lastUpDataTime;
+ (void)initialize {
    // 沙盒路径
    NSString *fileName = [NSHomeDirectory() stringByAppendingFormat: @"/Documents/%@", @"sqlite.rdb"];
    IDLog(@"%@",fileName);
    // 创建队列
    _queque = [FMDatabaseQueue databaseQueueWithPath:fileName];
    
    // 创表
    [_queque inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"create table if not exists t_news (id integer primary key autoincrement,idstr text, dict blob);"];
        [db executeUpdate:@"create table if not exists t_detail (id integer primary key autoincrement, dict blob);"];
    }];
    
}

+ (void)addNews:(NSDictionary *)dict {
    _lastUpDataTime = [NSDate date];
    [_queque inDatabase:^(FMDatabase *db) {
        NSString *idstr = dict[@"guid"];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dict];
        [db executeUpdate:@"insert into t_news (idstr, dict) values(?, ?)", idstr, data];
    }];
}

+ (void)addNewses:(NSArray *)dictArray {
    for (NSDictionary *dic in dictArray) {
        [self addNews:dic];
    }
}

+ (NSArray *)news{
    __block NSMutableArray *news = nil;
    [_queque inDatabase:^(FMDatabase *db) {
        news =[NSMutableArray array];

        FMResultSet *rs = [db executeQuery:@"select * from t_news"];
        while (rs.next) {
            NSData *data = [rs dataForColumn:@"dict"];
            NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            [news addObject:dict];
        }
    }];
    
//    NSDate *currentDate = [NSDate date];
//    NSTimeInterval secondsInterval= [currentDate timeIntervalSinceDate:_lastUpDataTime];
//    if (secondsInterval > 20) {
//        return nil;
//    }
    return news;
    
    
    
    
}

+ (void)addDetails:(NSDictionary *)dict {
    [_queque inDatabase:^(FMDatabase *db) {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dict];
        [db executeUpdate:@"insert into t_detail (dict) values(?)", data];
    }];
}

+ (NSDictionary *)details{
    __block NSDictionary *details = nil;
    [_queque inDatabase:^(FMDatabase *db) {
        details =[[NSDictionary alloc] init];
        
        FMResultSet *rs = [db executeQuery:@"select * from t_detail"];
        while (rs.next) {
            NSData *data = [rs dataForColumn:@"dict"];
            NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            details = dict;
        }
    }];
    NSDate *currentDate = [NSDate date];
    NSTimeInterval secondsInterval= [currentDate timeIntervalSinceDate:_lastUpDataTime];
    if (secondsInterval > 20) {
        return nil;
    }
    return details;
}

@end
