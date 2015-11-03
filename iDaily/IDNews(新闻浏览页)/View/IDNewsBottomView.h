//
//  IDNewsBottomView.h
//  iDaily
//
//  Created by Yin Yi on 15/9/25.
//  Copyright (c) 2015年 Yin Yi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, IDBottomButtonType) {
    IDBottomButtonTypeBack = 210,
    IDBottomButtonTypeNext = 211,
    IDBottomButtonTypeLast = 222,
    IDBottomButtonTypShare = 223
};


@protocol IDNewsButtomViewDelegate <NSObject>

- (void)buttonAction:(UIButton *)button;

@end

@interface IDNewsBottomView : UIView

@property (nonatomic,assign) id<IDNewsButtomViewDelegate> delegate;


@end
