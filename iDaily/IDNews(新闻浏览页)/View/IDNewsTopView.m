//
//  IDNewsTopView.m
//  iDaily
//
//  Created by Yin Yi on 15/9/25.
//  Copyright (c) 2015年 Yin Yi. All rights reserved.
//

#import "IDNewsTopView.h"
#import "UIImageView+WebCache.h"

@interface IDNewsTopView ()
@property (nonatomic,weak) UILabel *title;
@property (nonatomic,weak) UIImageView *titleImageView;
@end


@implementation IDNewsTopView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIImageView *titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 4, 60, 38)];
        self.titleImageView = titleImageView;
        [self addSubview:titleImageView];
        
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(80, 3, 200, 40)];
        self.title = title;
        [self addSubview:title];
        
        UIView *lineTop = [[UIView alloc] initWithFrame:CGRectMake(0, 46, IDScreemSize.width, 1)];
        lineTop.backgroundColor = IDColor(229, 229, 229);
        [self addSubview:lineTop];
        
    }
    return self;
    
}

- (void)setDate:(NSString *)date {
    _date = date;
    self.title.text = date;
}

- (void)setTitleImageUrl:(NSString *)titleImageUrl {
    _titleImageUrl = titleImageUrl;
    NSURL *url = [NSURL URLWithString:titleImageUrl];
    [self.titleImageView setImageWithURL:url];
}


@end
