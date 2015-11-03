//
//  IDBottonView.m
//  iDaily
//
//  Created by Yin Yi on 15/9/17.
//  Copyright (c) 2015年 Yin Yi. All rights reserved.
//

#import "IDBottomView.h"
#import "UIView+GetViewController.h"
#import "IDEarthButton.h"
#import "IDSettingViewController.h"

@interface IDBottomView ()
@property (nonatomic,weak) IDEarthButton *earthButton;
@end


@implementation IDBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 界面搭建
        [self setupView];
    }
    return self;
}
/**
 *  搭建界面
 */
- (void)setupView {
    
    // 分割线
    UIView *lineTop = [[UIView alloc] initWithFrame:CGRectMake(0, 0, IDScreemSize.width, 1)];
    lineTop.backgroundColor = IDColor(229, 229, 229);
    [self addSubview:lineTop];
    
    UIView *lineOne = [[UIView alloc] initWithFrame:CGRectMake(IDScreemSize.width / 2 + 30, 0, 1, 46)];
    lineOne.backgroundColor = IDColor(229, 229, 229);
    [self addSubview:lineOne];
    
    CGFloat lineTwoX =(IDScreemSize.width / 2 + 40) / 2 + IDScreemSize.width / 2;
    UIView *lineTwo = [[UIView alloc] initWithFrame:CGRectMake(lineTwoX, 0, 1, 46)];
    lineTwo.backgroundColor = IDColor(229, 229, 229);
    [self addSubview:lineTwo];
    
    // 按钮宽度
    CGFloat buttonW = (IDScreemSize.width - lineTwoX + 10)- 1;
    
    // 设置分享
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.frame = CGRectMake(CGRectGetMaxX(lineOne.frame), 0, buttonW, 46);
    [shareButton setImage:[UIImage imageNamed:@"ButtonShareBlack"] forState:UIControlStateNormal];
    [shareButton setImage:[UIImage imageNamed:@"ButtonShareBlackHighlighted"] forState:UIControlStateHighlighted];
    [shareButton addTarget:self action:@selector(shareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:shareButton];
    
    // 设置距离
    IDEarthButton *earthButton = [IDEarthButton buttonWithType:UIButtonTypeCustom];
    earthButton.frame = CGRectMake(0, 0, IDScreemSize.width / 2 + 50, 46);
    [earthButton setImage:[UIImage imageNamed:@"ButtonNewsBlack"] forState:UIControlStateNormal];
    [earthButton setImage:[UIImage imageNamed:@"ButtonNewsBlackHighlighted"] forState:UIControlStateHighlighted];
    [earthButton setTitleColor:IDColor(147, 147, 147) forState:UIControlStateNormal];
    earthButton.titleLabel.font = [UIFont systemFontOfSize:15];
    earthButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [earthButton addTarget:self action:@selector(earthButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.earthButton = earthButton;
    [self addSubview:earthButton];
    
    // 设置更多
    UIButton *moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    moreButton.frame = CGRectMake(CGRectGetMaxX(lineTwo.frame), 0, buttonW, 46);
    [moreButton setImage:[UIImage imageNamed:@"ButtonMore"] forState:UIControlStateNormal];
    [moreButton setImage:[UIImage imageNamed:@"ButtonMoreHighlighted"] forState:UIControlStateHighlighted];
    [moreButton addTarget:self action:@selector(settingButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:moreButton];
    
    
}

- (void)setDistance:(double)distance {
    _distance = distance;
    NSString *distanceStr = [NSString stringWithFormat:@"%.2f KM",distance];
    [self.earthButton setTitle:distanceStr forState:UIControlStateNormal];
}

#pragma mark - 事件设置
/**
 *  分享按钮点击
 */
- (void)shareButtonAction:(UIButton *)button {
    
}
/**
 *  距离按钮点击
 */
- (void)earthButtonAction:(UIButton *)button {
    
}
/**
 *  设置按钮点击
 */
- (void)settingButtonAction:(UIButton *)button {
    UIViewController *vc = [self viewController:self];
    
    IDSettingViewController *svc = [[IDSettingViewController alloc] init];
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:svc];
    [vc presentViewController:nav animated:YES completion:nil];
}

@end
