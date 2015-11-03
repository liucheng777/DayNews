//
//  IDHomeTableView.h
//  iDaily
//
//  Created by Yin Yi on 15/9/15.
//  Copyright (c) 2015年 Yin Yi. All rights reserved.
//  首页tableView

#import <UIKit/UIKit.h>

@interface IDHomeTableView : UITableView <UITableViewDelegate,UITableViewDataSource>
/**
 *  新闻图文的数据
 */
@property (nonatomic,strong) NSArray *dataArr;
/**
 *  地图更多页面数据
 */
@property (nonatomic,strong) NSDictionary *detailDic;
@end
