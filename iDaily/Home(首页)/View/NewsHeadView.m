//
//  NewsHeadView.m
//  iDaily
//
//  Created by Yin Yi on 15/9/20.
//  Copyright (c) 2015年 Yin Yi. All rights reserved.
//

#import "NewsHeadView.h"
#import "IDBottomView.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import <CoreLocation/CoreLocation.h>

#define IDImageCell @"IDHomeImageCell"
@interface NewsHeadView () <CLLocationManagerDelegate>
@property (nonatomic,weak) UILabel *title;
@property (nonatomic,weak) UIImageView *cellImageView;
@property (nonatomic,weak) UILabel *contentLabel;
@property (nonatomic,weak) UICollectionView *collectionView;
@property (nonatomic,weak) IDBottomView *bottomView;
@property (nonatomic,weak) UIButton *selectedButton;

@end

@implementation NewsHeadView
{
    CLLocationManager *_locationManager;
}
-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}

#pragma mark - 视图
/* 视图搭建  */
- (void)setupView {
    // 1.创建主图视图
    UIImageView *mainImageView = [[UIImageView alloc] init];
    self.cellImageView = mainImageView;
    [self addSubview:mainImageView];
    
    // 2.创建标题
    UILabel *title = [[UILabel alloc] init];
    self.title = title;
    title.font = [UIFont boldSystemFontOfSize:20];
    [self addSubview:title];
    
    // 3.内容视图
    UILabel *label = [[UILabel alloc] init];
    self.contentLabel = label;
    label.font = [UIFont systemFontOfSize:14];
    label.numberOfLines = 0;
    [self addSubview:label];
    
    // 4.小图片视图
//    CGFloat imageWid = (IDScreemSize.width - 80) / 5;
    for (int index = 0; index < 5; index ++) {
        
        UIButton *imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        if (index == 0) {
            self.selectedButton = imageButton;
        }
        imageButton.tag = 110 + index;
        [imageButton addTarget:self action:@selector(selectImageButton:) forControlEvents:UIControlEventTouchUpInside];
        imageButton.hidden = YES;
        [self addSubview:imageButton];
    }
    
    
    // 5.底部视图
    IDBottomView *bottomView = [[IDBottomView alloc] init];
    self.bottomView = bottomView;
    [self addSubview:bottomView];
    //    [self setupBottomView];
    //    UIButton *test = [[UIButton alloc] initWithFrame:CGRectMake(10, 130, 20, 20)];
    //    test.backgroundColor = [UIColor redColor];
    //    [self addSubview:test];
    
}

/* 布局  */
- (void)layoutSubviews {
    [super layoutSubviews];
    // 1.创建主图视图
    self.cellImageView.frame = CGRectMake(0, 25, IDScreemSize.width, IDScreemSize.width * .72);
    
    // 2.创建标题
    self.title.frame = CGRectMake(20, CGRectGetMaxY(self.cellImageView.frame) + 20, IDScreemSize.width - 40, 30);
    
    // 3.内容视图
    CGFloat labelWidth = IDScreemSize.width - 44;
    CGFloat labelHeight = 150;
    CGSize maxSize = CGSizeMake(labelWidth, labelHeight);
    NSDictionary *attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:14]};
    CGSize content = [self.news.content boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    self.contentLabel.frame = CGRectMake(22, CGRectGetMaxY(self.title.frame) + 8, labelWidth, content.height);
    // 4.小图片视图
    CGFloat imageWid = (IDScreemSize.width - 80) / 5;
    for (int index = 0; index < 5; index ++) {
        UIButton *imageButton = (UIButton *)[self viewWithTag:110 + index];
        imageButton.frame = CGRectMake(20 + (imageWid + 10) * index, CGRectGetMaxY(self.contentLabel.frame) + 20, imageWid, 40);
    }
    
    // 5.底部视图
    self.bottomView.frame = CGRectMake(0, IDScreemSize.height - 92, IDScreemSize.width, 46);
    
}

- (void)location{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        // 当IOS版本大于8.0
        if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0) {
            [_locationManager requestWhenInUseAuthorization];
        }
    }
    [_locationManager setDesiredAccuracy: kCLLocationAccuracyBest];
    _locationManager.delegate = self;
    [_locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    [manager stopUpdatingLocation];
    CLLocation *location = [locations lastObject];
    CLLocation* dist=[[CLLocation alloc] initWithLatitude:[_news.latitude doubleValue] longitude:[_news.longitude doubleValue]];
    
    CLLocationDistance kilometers=[location distanceFromLocation:dist]/1000;
    IDLog(@"距离:%.2f",kilometers);
    self.bottomView.distance = kilometers;
}

#pragma mark - 数据处理
- (void)setNews:(IDNewModel *)news {
    _news = news;
    IDLog(@"%@",_news.content);
    [self loadData:news];
    // 取消先前button的显示
    for (int index = 0; index < 5; index ++) {
        UIButton *imageButton = (UIButton *)[self viewWithTag:110 + index];
        imageButton.hidden = YES;
    }
    
    [self setNeedsLayout];
    // 小按钮
    if ([news.album_count boolValue]) {
        for (NSInteger index = 0; index < [news.album_count integerValue]+1; index ++) {
            if (index == 0) {
                UIButton *button = (UIButton *)[self viewWithTag:110 + index];
                button.hidden = NO;
                [button setImageWithURL:[NSURL URLWithString:news.cover_thumb] forState:UIControlStateNormal];

            }else if (index < 5) {
                UIButton *button = (UIButton *)[self viewWithTag:110 + index];
                IDNewModel *new = news.album[index - 1];
                button.hidden = NO;
                
                [button setImageWithURL:[NSURL URLWithString:new.cover_thumb] forState:UIControlStateNormal];
            }
        }
    }
    [self location];
}

- (void)loadData:(IDNewModel *)news {
    self.title.text = news.title;
    self.contentLabel.text = news.content;
    
    NSURL *imageURL = [NSURL URLWithString:news.cover_landscape];
    [self.cellImageView setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"placehold"]];
}


- (void)selectImageButton:(UIButton *)button {
    if (_selectedButton != button) {
        _selectedButton = button;
        if (button.tag == 110) {
            [self loadData:self.news];
        }else {
            IDNewModel *new = self.news.album[button.tag - 111];
            [self loadData:new];
        }
    }
}

@end