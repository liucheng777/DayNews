//
//  IDHomeTopView.h
//  iDaily
//
//  Created by Yin Yi on 15/9/15.
//  Copyright (c) 2015年 Yin Yi. All rights reserved.
//  首页顶部视图

#import <UIKit/UIKit.h>

@interface IDHomeTopView : UIImageView
/**
 *  喜好按钮
 */
@property (weak,nonatomic) UIButton *rightButton;
/**
 *  天气按钮
 */
@property (weak,nonatomic) UIButton *weatherButton;
@property (nonatomic,strong)NSMutableArray *cityIdArray;
@end
