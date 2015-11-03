//
//  MapNewsListCell.m
//  iDaily
//
//  Created by Yin Yi on 15/9/20.
//  Copyright (c) 2015年 Yin Yi. All rights reserved.
//

#import "MapNewsListCell.h"

@interface MapNewsListCell ()
@property (nonatomic, weak) UILabel *title;
@property (nonatomic, weak) UILabel *souce;
@property (nonatomic, weak) UILabel *date;
@end

@implementation MapNewsListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        // 1.来源
        UILabel *souce = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 300, 15)];
        souce.tintColor = IDColor(144, 144, 144);
        souce.font = [UIFont systemFontOfSize:16];
        self.souce = souce;
        [self.contentView addSubview:souce];
        
        // 2.标题
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(souce.frame), IDScreemSize.width - 70, 40)];
        title.font = [UIFont boldSystemFontOfSize:16];
        title.numberOfLines = 2;
        self.title = title;
        [self.contentView addSubview:title];
        
        // 3.日期
        UILabel *date = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(title.frame), 200, 15)];
        date.textColor = IDColor(144, 144, 144);
        date.font = [UIFont systemFontOfSize:13];
        self.date = date;
        [self.contentView addSubview:date];
        
    }
    return self;
}

#pragma mark - 数据填充
- (void)setDetail:(IDDetailModel *)detail {
    _detail = detail;
    self.date.text = detail.pubdate;
    self.title.text = detail.title;
    self.souce.text = detail.source;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
