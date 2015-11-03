//
//  IDHomeViewCell.h
//  iDaily
//
//  Created by Yin Yi on 15/9/15.
//  Copyright (c) 2015年 Yin Yi. All rights reserved.
//  首页单元格


#import <UIKit/UIKit.h>
#import "IDNewModel.h"
//#import "IDDetailModel.h"


@interface IDHomeViewCell : UITableViewCell <UITableViewDataSource,UITableViewDelegate>
/**
 *  新闻首页图文模型
 */
@property (nonatomic,strong) IDNewModel *news;
/**
 *  新闻地图页面数据
 */
@property (nonatomic,strong) NSArray *detail;
@end
