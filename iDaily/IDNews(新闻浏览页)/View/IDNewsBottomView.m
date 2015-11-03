//
//  IDNewsBottomView.m
//  iDaily
//
//  Created by Yin Yi on 15/9/25.
//  Copyright (c) 2015年 Yin Yi. All rights reserved.
//

#import "IDNewsBottomView.h"

@implementation IDNewsBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        // 返回按钮
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.tag = IDBottomButtonTypeBack;
        backButton.frame = CGRectMake(0, 0, IDScreemSize.width * .2, IDTopBarHeight);
        [backButton addTarget:self.delegate action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [backButton setImage:[UIImage imageNamed:@"ButtonEntryToolClose"] forState:UIControlStateNormal];
        [self addSubview:backButton];
        
        // 分享按钮
        UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        shareButton.tag = IDBottomButtonTypShare;
//        shareButton.backgroundColor = [UIColor redColor];
        shareButton.frame = CGRectMake(IDScreemSize.width * .2, 0, IDScreemSize.width * .6, IDTopBarHeight);
        [shareButton addTarget:self.delegate action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [shareButton setImage:[UIImage imageNamed:@"ButtonShareBlack"] forState:UIControlStateNormal];
        [self addSubview:shareButton];
        
        // 上一页
        UIButton *lastButton = [UIButton buttonWithType:UIButtonTypeCustom];
        lastButton.tag = IDBottomButtonTypeLast;
        lastButton.frame = CGRectMake(IDScreemSize.width * .8, 0, IDScreemSize.width * .1, IDTopBarHeight);
        [lastButton addTarget:self.delegate action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [lastButton setImage:[UIImage imageNamed:@"ButtonEntryToolBack"] forState:UIControlStateNormal];
        [self addSubview:lastButton];
        
        // 下一页
        UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        nextButton.tag = IDBottomButtonTypeNext;
        nextButton.frame = CGRectMake(IDScreemSize.width * .9, 0, IDScreemSize.width * .1, IDTopBarHeight);
        [nextButton addTarget:self.delegate action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [nextButton setImage:[UIImage imageNamed:@"ButtonEntryToolForward"] forState:UIControlStateNormal];
        [self addSubview:nextButton];
        
        // 分割线
        UIView *lineTop = [[UIView alloc] initWithFrame:CGRectMake(0, 0, IDScreemSize.width, 1)];
        lineTop.backgroundColor = IDColor(229, 229, 229);
        [self addSubview:lineTop];
        
        
    }
    return self;
}




@end
