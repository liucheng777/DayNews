//
//  IDWeatherTableViewCell.h
//  iDaily
//
//  Created by imac on 15/9/14.
//  Copyright (c) 2015年 Yin Yi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityModel.h"
@interface IDWeatherTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *cityNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImageView;
@property (weak, nonatomic) IBOutlet UILabel *tdlabel;
@property (weak, nonatomic) IBOutlet UILabel *tmrLabel;
@property (weak, nonatomic) IBOutlet UILabel *futureLabel1;
@property (weak, nonatomic) IBOutlet UILabel *futureLabel2;
@property (weak, nonatomic) IBOutlet UILabel *futureLabel3;
@property (weak, nonatomic) IBOutlet UIImageView *tdImageView;
@property (weak, nonatomic) IBOutlet UIImageView *tmrImageView;
@property (weak, nonatomic) IBOutlet UIImageView *ftImageView1;
@property (weak, nonatomic) IBOutlet UIImageView *ftImageView2;
@property (weak, nonatomic) IBOutlet UIImageView *ftImageView3;
@end
