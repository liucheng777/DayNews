//
//  IDWeatherTableView.h
//  iDaily
//
//  Created by imac on 15/9/14.
//  Copyright (c) 2015年 Yin Yi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IDWeatherTableView : UITableView<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,strong)NSMutableArray *cityList;
@property (nonatomic,strong)NSMutableArray *tmpList1;
@property (nonatomic,strong)NSMutableArray *weatherList;
@property (nonatomic,strong)NSMutableArray *cityIdArray;
@end
