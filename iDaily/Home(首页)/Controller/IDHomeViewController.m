//
//  IDHomeViewController.m
//  iDaily
//
//  Created by Yin Yi on 15/9/14.
//  Copyright (c) 2015年 Yin Yi. All rights reserved.
//  主页视图控制器

#import "IDHomeViewController.h"
#import "IDHomeTopView.h"
#import "IDWeatherViewController.h"
#import "AppDelegate.h"
#import "IDHomeTableView.h"
#import "TabBarController.h"
#import "IDNewsTool.h"
#import "IDNewModel.h"
#import "IDDetailModel.h"
#import "MJRefresh.h"
#import "IDDataManager.h"

@interface IDHomeViewController () <IIViewDeckControllerDelegate>
@property (weak,nonatomic) UIImageView *bgImageView;
@property (nonatomic,strong) NSArray *dataArr;
@property (nonatomic,strong) NSDictionary *detailData;
@property (nonatomic,weak) IDHomeTableView *tableView;
@end

@implementation IDHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 加载数据
//    [self setupNewsData];
    
    
    // 创建视图
    [self setupView];
    // 创建刷新控件 并且获取数据
    [self setupRefreshView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moveToPage:) name:IDTiaoZhuanNotification object:nil];
    
}




#pragma mark - 界面设置
/**
 *  配置主界面
 */
- (void)setupView {
    
    // 0.设置背景
    UIImageView *bgimageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, IDScreemSize.width, IDScreemSize.height)];
    self.bgImageView = bgimageView;
    bgimageView.userInteractionEnabled = YES;
    bgimageView.image = [UIImage imageNamed:@"Background"];
    bgimageView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgimageView];
    
    // 1.头部视图
    IDHomeTopView *topView = [[IDHomeTopView alloc] init];
    [topView.rightButton addTarget:self action:@selector(favoriteButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [topView.weatherButton addTarget:self action:@selector(weatherButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgImageView addSubview:topView];
    
    // 2.新闻显示视图
    CGRect frame = CGRectMake(0, 0, IDScreemSize.height - IDTopBarHeight, IDScreemSize.width);
    IDHomeTableView *tableView = [[IDHomeTableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    tableView.center = CGPointMake(IDScreemSize.width / 2, IDScreemSize.height / 2 + IDTopBarHeight / 2);
    tableView.transform =  CGAffineTransformMakeRotation(-M_PI / 2);
    self.tableView = tableView;
    [self.bgImageView addSubview:tableView];
}
/**
 *  集成刷新控件
 */
- (void)setupRefreshView {
    // 1.右拉刷新
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshNewData)];
    [self.tableView.header beginRefreshing];
    [NSTimer timerWithTimeInterval:10 target:self.tableView.header selector:@selector(endRefreshing) userInfo:nil repeats:NO];
    // 2.左拉刷新
}



#pragma mark - 数据获取
/**
 *  获取新闻数据
 */
- (void)setupNewsData {
    // 读取首页数据
    [IDNewsTool newsWithParam:[[IDHomeParam alloc] init] success:^(IDHomeNewsResult *result) {
//        self.dataArr = [NSMutableArray array];
//        for (int index = 0; index < responseObject.count; index ++) {
//            IDNewModel *news = [[IDNewModel alloc] initWithDataDic:responseObject[index]];
//            [self.dataArr addObject:news];
//        }
        self.tableView.dataArr = result.news;
        self.dataArr = result.news;
        [self.tableView.header endRefreshing];

    } failure:^(NSError *error) {
        IDLog(@"%@",error);
        [self.tableView.header endRefreshing];
    }];
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    [manager GET:IDGetNewsURL parameters:nil success:^(AFHTTPRequestOperation *operation, NSArray *responseObject) {
//        self.dataArr = [NSMutableArray array];
//        for (int index = 0; index < responseObject.count; index ++) {
//            IDNewModel *news = [[IDNewModel alloc] initWithDataDic:responseObject[index]];
//            [self.dataArr addObject:news];
//        }
//        self.tableView.dataArr = self.dataArr;
//        [self.tableView.header endRefreshing];
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        IDLog(@"%@",error);
//        [self.tableView.header endRefreshing];
//    }];
    
    // 读取MAP数据
    [IDNewsTool detailNewsWithParam:[[IDHomeParam alloc] init] success:^(IDHomeDetailResult *result) {
//        NSArray *key = [responseObject allKeys];
//        IDLog(@"%@",key);
//        NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
//        for (NSInteger index = 0; index < key.count; index ++) {
//            NSArray *data = responseObject[key[index]];
//            NSMutableArray *arr = [NSMutableArray array];
//            for (NSDictionary *dic in data) {
//                IDDetailModel *model = [[IDDetailModel alloc] initWithDataDic:dic];
//                [arr addObject:model];
//            }
//            [dataDic setValue:arr forKey:key[index]];
//        }
        self.detailData = result.news;
        self.tableView.detailDic = self.detailData;
    } failure:^(NSError *error) {
        IDLog(@"%@",error);
    }];
    
//    [manager GET:IDGetDetailURL parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
//        NSArray *key = [responseObject allKeys];
//        IDLog(@"%@",key);
//        NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
//        for (NSInteger index = 0; index < key.count; index ++) {
//            NSArray *data = responseObject[key[index]];
//            NSMutableArray *arr = [NSMutableArray array];
//            for (NSDictionary *dic in data) {
//                IDDetailModel *model = [[IDDetailModel alloc] initWithDataDic:dic];
//                [arr addObject:model];
//            }
//            [dataDic setValue:arr forKey:key[index]];
//        }
//        self.detailData = dataDic;
//        self.tableView.detailDic = self.detailData;
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        IDLog(@"%@",error);
//
//    }];
}

/**
 *  数据缓存
 */
- (void)saveNewsData {
    
}

#pragma mark - 事件处理
/**
 *  喜好按钮点击事件
 */
- (void)favoriteButtonAction:(UIButton *)button {
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    IIViewDeckController *vc = app.deckController;
    TabBarController *fvc = (TabBarController *)vc.leftController;
    fvc.DataArray = _dataArr;
    [vc toggleLeftViewAnimated:YES];
}
                               
/**
 *  天气按钮点击事件
 */
- (void)weatherButtonAction:(UIButton *)button {
    IDWeatherViewController *wvc = [[IDWeatherViewController alloc] init];
    [self presentViewController:wvc animated:YES completion:nil];
}
                               
/**
*  右拉刷新事件
*/
- (void)refreshNewData {
    [self setupNewsData];
}

/**
 *  左拉刷新事件
 */
- (void)refreshOldData {
   
}

/**
 *  跳转单元格
 */
- (void)moveToPage:(NSNotification *)notification {
    NSInteger index = [notification.object[@"guid"] integerValue];
    if (index) {
        IDLog(@"%---------li",index);
        
        for (NSInteger i = 0; i < _dataArr.count; i ++) {
            IDNewModel *news = _dataArr[i];
            if ([news.guid integerValue] == index) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
                [self.tableView selectRowAtIndexPath:indexPath animated:nil scrollPosition:UITableViewScrollPositionNone];
                
                return;
            }
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
