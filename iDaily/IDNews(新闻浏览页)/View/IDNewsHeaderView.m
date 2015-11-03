//
//  IDNewsHearderView.m
//  iDaily
//
//  Created by Yin Yi on 15/9/25.
//  Copyright (c) 2015年 Yin Yi. All rights reserved.
//

#import "IDNewsHeaderView.h"


@interface IDNewsHeaderView ()
@property (nonatomic,weak) UILabel *sourceLabel;
@property (nonatomic,weak) UILabel *titleLabel;
@property (nonatomic,weak) UILabel *dateLabel;

@end

@implementation IDNewsHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UILabel *sourceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, IDScreemSize.width - 20, 20)];
        self.sourceLabel = sourceLabel;
        sourceLabel.textColor = [UIColor grayColor];
        sourceLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:sourceLabel];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(sourceLabel.bounds), IDScreemSize.width - 20, 50)];
        self.titleLabel = titleLabel;
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.font = [UIFont boldSystemFontOfSize:17];
        titleLabel.numberOfLines = 0;
        [self addSubview:titleLabel];
        
        UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(titleLabel.bounds) + 20, IDScreemSize.width - 20, 20)];
        self.dateLabel = dateLabel;
        dateLabel.textColor = [UIColor grayColor];
        dateLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:dateLabel];
        
        
        UIView *lineTop = [[UIView alloc] initWithFrame:CGRectMake(0, 90, IDScreemSize.width, 1)];
        lineTop.backgroundColor = IDColor(229, 229, 229);
        [self addSubview:lineTop];
        
        
    }
    return self;
}

- (void)setDate:(NSString *)date {
    _date = date;
    self.dateLabel.text = date;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}

- (void)setSource:(NSString *)source {
    _source = source;
    self.sourceLabel.text = source;
}

@end
