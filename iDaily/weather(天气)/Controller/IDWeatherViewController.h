//
//  IDWeatherViewController.h
//  iDaily
//
//  Created by Yin Yi on 15/9/14.
//  Copyright (c) 2015年 Yin Yi. All rights reserved.
//

#import "IDBaseViewController.h"
#import "IDWeatherTableView.h"
@interface IDWeatherViewController : IDBaseViewController<UITextFieldDelegate>
@property (nonatomic,strong)IDWeatherTableView *weatherTableView;

@end
