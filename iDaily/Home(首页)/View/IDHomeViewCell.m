//
//  IDHomeViewCell.m
//  iDaily
//
//  Created by Yin Yi on 15/9/15.
//  Copyright (c) 2015年 Yin Yi. All rights reserved.
//

#import "IDHomeViewCell.h"
#import "NewsHeadView.h"
#import "MapNewsListCell.h"
#import <MapKit/MapKit.h>
#import "IDDetailModel.h"
#import "IDNewsViewController.h"
#import "UIView+GetViewController.h"

#define IDTableCell @"tableViewCell"
@interface IDHomeViewCell () <MKMapViewDelegate>
@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,weak) NewsHeadView *headView;
@property (nonatomic,weak) UIButton *mapButton;
@property (nonatomic,weak) MKMapView *mapView;
@end

@implementation IDHomeViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, IDScreemSize.width, IDScreemSize.height - 46)];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.pagingEnabled = YES;
        tableView.showsVerticalScrollIndicator = NO;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor clearColor];
        self.tableView = tableView;
        NewsHeadView *headView = [[NewsHeadView alloc] initWithFrame:CGRectMake(0, 0, IDScreemSize.width, IDScreemSize.height - 46)];
        tableView.tableHeaderView = headView;
        self.headView = headView;
        [self.contentView addSubview:tableView];
        
        
    }
    return self;
}

#pragma mark - 数据填充
- (void)setDetail:(NSArray *)detail {
    _detail = detail;
    [self.tableView reloadData];
}

- (void)setNews:(IDNewModel *)news {
    _news = news;
    self.headView.news = news;
    [self.tableView reloadData];
}

#pragma mark - 配置表视图
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _detail.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MapNewsListCell *cell = [tableView dequeueReusableCellWithIdentifier:IDTableCell];
    if (cell == nil) {
        cell = [[MapNewsListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDTableCell];
    }
    cell.detail = _detail[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MKMapView *mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, IDScreemSize.width, 180)];
    self.mapView = mapView;
    mapView.userTrackingMode = MKUserTrackingModeNone;
    mapView.delegate = self;
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = [self.news.latitude doubleValue];
    coordinate.longitude = [self.news.longitude doubleValue];
    MKCoordinateRegion region;
    region.span.latitudeDelta = 0.1;
    region.span.longitudeDelta = 0.1;
    region.center = coordinate;
    MKPointAnnotation *ann = [[MKPointAnnotation alloc] init];
    ann.coordinate = coordinate;
    [mapView addAnnotation:ann];
    // 设置显示位置(动画)
    [mapView setRegion:region animated:YES];
    // 设置地图显示的类型及根据范围进行显示
    [mapView regionThatFits:region];
    
    UIButton *mapButton = [UIButton buttonWithType:UIButtonTypeCustom];
    mapButton.frame = CGRectMake(IDScreemSize.width - 40, 140, 30, 30);
    [mapButton setImage:[UIImage imageNamed:@"ButtonMapExpand"] forState:UIControlStateNormal];
    self.mapButton = mapButton;
    [mapView addSubview:mapButton];
    return mapView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 180;
}

- (MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation:(id <MKAnnotation>)annotation
{
    MKPinAnnotationView *pinView = nil;
    
    static NSString *defaultPinID = @"com.invasivecode.pin";
    pinView = (MKPinAnnotationView *)[mV dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
    if ( pinView == nil ) pinView = [[MKPinAnnotationView alloc]
                                      initWithAnnotation:annotation reuseIdentifier:defaultPinID];
    pinView.pinColor = MKPinAnnotationColorRed;
    pinView.canShowCallout = YES;
    pinView.animatesDrop = YES;
    return pinView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    IDNewsViewController *nvc = [[IDNewsViewController alloc] init];
    nvc.news = self.detail[indexPath.row];
    nvc.topImageURL = self.news.cover_thumb;
    [[self viewController:self] presentViewController:nvc animated:YES completion:nil];
}


#pragma mark - 按钮点击事件
/**
 *  地图放大按钮
 */
//- (void)mapViewZoomChange {
//    self.mapView;
//    
//    
//}
//

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
