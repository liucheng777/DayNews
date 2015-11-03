//
//  IDSettingViewController.m
//  iDaily
//
//  Created by Yin Yi on 15/9/14.
//  Copyright (c) 2015年 Yin Yi. All rights reserved.
//

#import "IDSettingViewController.h"
#import "MyNetWorkQuery.h"
#import "AppModel.h"
#import "AppView.h"
#import "AppDetailView.h"
#import "MySetViewController.h"


@interface IDSettingViewController () {
    UITableView *_advertiseTableView;
    NSMutableArray *_appDatas;
    NSArray *_appDistributeArray;
}

@end

@implementation IDSettingViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor purpleColor];
    self.navigationController.navigationBar.translucent = NO;
    [self _creatTableview];
    [self requestData];
    
    
}

- (void)requestData {
    [MyNetWorkQuery requestData:@"?ver=iphone&app_ver=20" HTTPMethod:@"GET" completionHandle:^(id result) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self loadData:result];
            [_advertiseTableView reloadData];
        });

    }];
}

- (void)loadData:(NSDictionary *)result {
    _appDistributeArray = [[NSArray alloc]init];
    _appDistributeArray = result[@"grids"];
    
    _appDatas = [[NSMutableArray alloc]init];
    for (NSDictionary *dic in result[@"apps"]) {
        AppModel *app = [[AppModel alloc] initWithDataDic:dic];
        [_appDatas addObject:app];
    }
}


//自定义导航栏
- (void)setNav {
    // 1.背景图片
    UIImageView *bgimageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, IDScreemSize.width, IDScreemSize.height)];
    bgimageView.userInteractionEnabled = YES;
    bgimageView.image = [UIImage imageNamed:@"Background"];
    [self.view addSubview:bgimageView];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Background"] forBarMetrics:UIBarMetricsDefault];
//    // 2.设置顶部工具栏
//    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, IDScreemSize.width, IDTopBarHeight)];
//    topView.backgroundColor = [UIColor clearColor];
//    // 分割线
//    UIView *lineButtom = [[UIView alloc] initWithFrame:CGRectMake(0, IDTopBarHeight - 2, IDScreemSize.width, 1)];
//    lineButtom.backgroundColor = IDColor(229, 229, 229);
//    [topView addSubview:lineButtom];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 5, 50, IDTopBarHeight - 2);
    rightButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [rightButton setTitle:@"返回" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    
//    [topView addSubview:rightButton];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationItem.leftBarButtonItem = leftItem;
//    [self.navigationController.view addSubview:topView];

    
}

- (void)_creatTableview {
    //设置导航栏
    [self setNav];
    
    // 1.设置表视图
    _advertiseTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, IDTopBarHeight + 50, IDScreemSize.width, IDScreemSize.height - 96) style:UITableViewStyleGrouped];
    _advertiseTableView.delegate = self;
    _advertiseTableView.dataSource = self;
    _advertiseTableView.backgroundColor = [UIColor clearColor];
    _advertiseTableView.showsHorizontalScrollIndicator = NO;
    _advertiseTableView.showsVerticalScrollIndicator = NO;
    
    // 2.表视图的头视图
    UIView *tableHead = [[UIView alloc] initWithFrame:CGRectMake(0, 46, IDScreemSize.width, 50)];
    NSArray *images = @[@"IconOfflineSettings",
                        @"IconOfflineLoading",
                        @"IconMoreGuide",
                        @"IconMoreFeedback"];
    
    NSArray *names = @[@"设置",
                       @"分享",
                       @"指南",
                       @"反馈"];
    
    //第一组四个按钮
        CGFloat buttonWidth = (IDScreemSize.width - 25)/ 4;
        for (int index = 0; index < 4; index++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake((index + 1)*5 + index * buttonWidth, 0, buttonWidth, 40) ;
            [button setBackgroundImage:[UIImage imageNamed:@"tableCell_single.png"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:images[index]] forState:UIControlStateNormal];
            [button setTitle:names[index] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            //按钮添加动作
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            //设置按钮的tag值
            button.tag = 100 + index;
            [tableHead addSubview:button];
    }
    
    [self.view addSubview:tableHead];
    
    [self.view addSubview:_advertiseTableView];
}


#pragma mark - 按钮点击事件
- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//头视图四个按钮动作
- (void)buttonAction:(UIButton *)sender {
    if (sender.tag == 100) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Set" bundle:nil];
        UITableViewController *tableVC = [storyboard instantiateInitialViewController];
        [self.navigationController pushViewController:tableVC animated:YES];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section >= 0 && section < 4) {
        return 1;
    }
    else if (section == 5) {
        return 1;
    }
    return 4;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [[UITableViewCell alloc]init];
//    NSArray *images = @[@"IconOfflineSettings@3x.png",
//                        @"IconOfflineSettings@3x.png",
//                        @"IconOfflineSettings@3x.png",
//                        @"IconOfflineSettings@3x.png"];
//    
//    NSArray *names = @[@"设置",
//                       @"分享",
//                       @"指南",
//                       @"反馈"];

    //第一组四个按钮
//    if (indexPath.section == 0) {
//        CGFloat buttonWidth = (IDScreemSize.width - 25)/ 4;
//        for (int index = 0; index < 4; index++) {
//            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//            button.frame = CGRectMake((index + 1)*5 + index * buttonWidth, 0, buttonWidth, 40) ;
//            [button setBackgroundImage:[UIImage imageNamed:@"tableCell_single.png"] forState:UIControlStateNormal];
//            [button setImage:[UIImage imageNamed:images[index]] forState:UIControlStateNormal];
//            [button setTitle:names[index] forState:UIControlStateNormal];
//            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//            
//            [cell.contentView addSubview:button];
//        }
//    }
//    
    if (indexPath.section >= 0 && indexPath.section < 4) {
        NSArray *apps = [_appDistributeArray[indexPath.section] objectForKey:@"apps"];
        
//        if (indexPath.row > 2) {
//            return cell;
//        }
        for (AppModel *appModel in _appDatas) {
            NSInteger id1 = [appModel.hnd_id integerValue];
            NSInteger id2 = [apps[0] integerValue];
            
            NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"AppDetailVIew" owner:nil options:nil];
            AppDetailView *appDetailView = [[AppDetailView alloc]init];
            appDetailView = [array lastObject];
            
            if (id1 == id2) {
                appDetailView.appModel = appModel;
                appDetailView.frame = cell.bounds;
                [cell.contentView addSubview:appDetailView];
                
            }
        }

    }
    
    //第六组单元格设计
    if (indexPath.section == 4 ) {
        
        
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, self.view.bounds.size.width, 35)];
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = [UIColor grayColor];
        
        NSInteger number = indexPath.section + indexPath.row;
        
        label.text = [_appDistributeArray[number] objectForKey:@"title"];
        [cell.contentView addSubview:label];
        
        NSArray *apps = [_appDistributeArray[number] objectForKey:@"apps"];
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(15, 40, 360, 90)];
        if (apps.count <= 5) {
            for (int index = 0; index < apps.count; index++) {
                for (AppModel *appModel in _appDatas) {
                    NSInteger id1 = [appModel.hnd_id integerValue];
                    NSInteger id2 = [apps[index] integerValue];
                    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"AppView" owner:nil options:nil];
                   // AppView *appView = [[AppView alloc]init];
                   AppView * appView = [array lastObject];
                    if (id1 == id2) {
                        
                        appView.appModel = appModel;
                        appView.frame = CGRectMake(index * 72, 0, 72, 90);
                        [view addSubview:appView];
                        [cell.contentView addSubview:view];
                        
                    }
                    
                }
            }
            

        }
        else if (apps.count > 5){
            view.frame = CGRectMake(15, 40, 360, 180);
            for (int arrage = 0; arrage < 2; arrage ++) {
                if (arrage == 0) {
                    for (int index = 0; index < apps.count; index++) {
                        for (AppModel *appModel in _appDatas) {
                            NSInteger id1 = [appModel.hnd_id integerValue];
                            NSInteger id2 = [apps[index] integerValue];
                            NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"AppView" owner:nil options:nil];
                            AppView *appView = [[AppView alloc]init];
                            appView = [array lastObject];
                            
                            if (id1 == id2) {
                                
                                appView.appModel = appModel;
                                appView.frame = CGRectMake(index * 72, 0, 72, 90);
                                [view addSubview:appView];
                                [cell.contentView addSubview:view];

                            }
                            
                        }
                    }
                    
                }
                else {
                    for (int index = 5; index < apps.count; index++) {
                        for (AppModel *appModel in _appDatas) {
                            NSInteger id1 = [appModel.hnd_id integerValue];
                            NSInteger id2 = [apps[index] integerValue];
                            
                            NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"AppView" owner:nil options:nil];
                            AppView *appView = [[AppView alloc]init];
                            appView = [array lastObject];
                            
                            if (id1 == id2) {
                                
                                appView.appModel = appModel;
                                appView.frame = CGRectMake((index-5) * 72, 90, 72, 90);
                                [view addSubview:appView];
                                [cell.contentView addSubview:view];
                            }
                            
                        }
                    }
                    
                }
                
            }
        }
     }
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section >= 0 && indexPath.section < 4) {
        return 70;
    }
    if (indexPath.section == 4) {
        if (indexPath.row == 0) {
            return 130;
        }
        else {
            return 220;
        }
    }
    if (indexPath.section == 5) {
        return 90;
    }
    return 50;
}

@end
