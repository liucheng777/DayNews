//
//  IDHomeTableView.m
//  iDaily
//
//  Created by Yin Yi on 15/9/15.
//  Copyright (c) 2015年 Yin Yi. All rights reserved.
//

#import "IDHomeTableView.h"
#import "IDHomeViewCell.h"

#define IDCellID @"homeCell"
@implementation IDHomeTableView
#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        self.pagingEnabled = YES;
        self.backgroundColor = [UIColor clearColor];
        self.showsVerticalScrollIndicator = NO;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}
#pragma mark - 数据传输部分
/**
 *  首页图文数据
 */
- (void)setDataArr:(NSArray *)dataArr {
    _dataArr = dataArr;
//    IDLog(@"%@",dataArr);
    [self reloadData];
}

/**
 *  地图详情页数据
 */
- (void)setDetailDic:(NSDictionary *)detailDic {
    _detailDic = detailDic;
//    IDLog(@"%@",detailDic);
    [self reloadData];
}

#pragma mark - 单元格设置
/**
 *  单元格行高
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return IDScreemSize.width;
}


/**
 *  单元格个数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}

/**
 *  单元格定制
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IDHomeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDCellID];
    if (cell == nil) {
        cell = [[IDHomeViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDCellID];
        cell.transform = CGAffineTransformMakeRotation(M_PI / 2);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    // 新闻图文数据传递
    cell.news = self.dataArr[indexPath.row];
    // 详情数据传递
//    NSInteger guid = [cell.news.guid integerValue];
    NSString *key = [NSString stringWithFormat:@"%@",cell.news.guid];
    cell.detail = self.detailDic[key];
    IDLog(@"%@",cell.detail);
    return cell;
    
}


@end
