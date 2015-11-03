//
//  HistoryViewController.m
//  Collectation
//
//  Created by mac on 15/9/20.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "HistoryViewController.h"
#import "AFNetworking.h"
#import "CollectionTableViewCell.h"
#import "NSString+WeekDay.h"
#import "IDNewModel.h"
#import "IIViewDeckController.h"
#import "IDHomeViewController.h"

@interface HistoryViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>{
    UITableView *_tableView;
    NSOperationQueue *_queue;
    NSMutableArray *_dataAllArray;
    NSMutableArray *_dayArray;
    NSMutableArray *_timeArray;
    NSMutableArray *_dataArray;
    UIView *_setView;
    NSString *_stateStr;
}

@end

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _stateStr = @"Wi-Fi可用时";
    [self _createNavBar];
    [self _loadData];
    [self _createTableView];
    [self _createSet];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Background@2x"]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_showSet) name:@"tongzhi1" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_hiddenSet) name:@"tongzhi2" object:nil];
}


- (void)setDataArr:(NSArray *)dataArr {
    _dataArr = dataArr;
    [self _loadData];
    
}

- (void)_loadData {
//    NSString *urlString = @"http://idaily-cdn.idai.ly/api/list/v3/iphone/zh-hans";
//
//    NSDictionary *params = @{@"age":@"1",@"ver":@"ipone",@"app_ver":@"20"};
//    //(2)构造请求参数格式化对象
//    
//    AFHTTPRequestSerializer *requestSerilizer = [AFHTTPRequestSerializer serializer];
//    
//    //(3)通过请求参数格式化对象来构造request
//    NSMutableURLRequest *request = [requestSerilizer requestWithMethod:@"GET" URLString:urlString parameters:params error:nil];
//    
//    //(4)构造线程对象
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    
//    //构造响应格式化对象确定数据的解析方式:默认是Json解析
//    operation.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
//    
//    //(5)发送异步网络请求
//    _queue = [[NSOperationQueue alloc] init];
//    [_queue addOperation:operation];
//    
    
    //(6)监听数据传输
    _dataAllArray = [[NSMutableArray alloc] init];
    _dayArray = [[NSMutableArray alloc] init];
    _dataArray = [[NSMutableArray alloc] init];
    _timeArray = [[NSMutableArray alloc] init];
    for (IDNewModel *news in self.dataArr) {
        if ([news.cat isEqualToString: @"6"]) {
            [_dataAllArray addObject:news];
        }
    }
    if (_dataAllArray.count) {
        IDNewModel *news = _dataAllArray[0];
        NSString *string1 = news.pubdate;
        [_dayArray addObject:string1];
        NSString *string2 = news.pubdate_timestamp;
        [_timeArray addObject:string2];
    }
    int i = 0;
    for (IDNewModel *news in _dataAllArray) {
        if (![news.pubdate isEqualToString:_dayArray[i]]) {
            [_dayArray addObject:news.pubdate];
            [_timeArray addObject:news.pubdate_timestamp];
            i++;
        }
    }

    for (int j = 0; j < _dayArray.count; j++) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (int i = 0; i < _dataAllArray.count; i++) {
            IDNewModel *news = _dataAllArray[i];
            if ([news.pubdate isEqualToString:_dayArray[j]]) {
                [array addObject:_dataAllArray[i]];
            }
        }
        
        [_dataArray addObject:array];
    }
    [_tableView reloadData];

}

- (void)_createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, self.view.bounds.size.width - 30, self.view.bounds.size.height - 89)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dayArray.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 375, 42)];
    
    NSString *timeString = _timeArray[section];
    NSDate *senddate=[NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]];
    NSDateFormatter  *dateformatter1=[[NSDateFormatter alloc] init];
    [dateformatter1 setDateFormat:@"yyyy年M月"];
    NSString *locationString1=[dateformatter1 stringFromDate:senddate];
    
    NSDateFormatter  *dateformatter2=[[NSDateFormatter alloc] init];
    [dateformatter2 setDateFormat:@"d"];
    NSString *locationString2=[dateformatter2 stringFromDate:senddate];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 18, 15, 15)];
    imageView.image = [UIImage imageNamed:@"BackgroundColumnTipBoxTouch"];
    
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(55, 25, 200, 12)];
    label1.text = [NSString stringWithFormat:@"%@",locationString1];
    label1.font = [UIFont systemFontOfSize:10];
    label1.textColor = [UIColor blackColor];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(25, 5, 200, 42)];
    label2.text = [NSString stringWithFormat:@"%@",locationString2];
    label2.font = [UIFont fontWithName:@"Helvetica-Bold" size:22];
    label2.textColor = [UIColor blackColor];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(55, 15, 200, 12)];
    NSString *string = [NSString weekdayStringFromDate:senddate];
    label3.text = [NSString stringWithFormat:@"%@",string];
    label3.font = [UIFont systemFontOfSize:10];
    label3.textColor = [UIColor blackColor];
    
    [view addSubview:label1];
    [view addSubview:label2];
    [view addSubview:label3];
    [view addSubview:imageView];
    
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    CollectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[CollectionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    NSArray *array = _dataArray[indexPath.section];
    cell.numberOfNews = array.count;
    cell.imageNames = array;
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 42;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *array = _dataArray[indexPath.section];
    if (array.count % 3 == 0) {
        return (array.count / 3) * 75 + 10;
    }else {
        return (array.count / 3 + 1) * 75 + 10;
    }
}

- (void)_createNavBar {
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 80, 15)];
    label1.text = @"TimeLine";
    [label1 setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
    label1.textColor = [UIColor blackColor];
    
    [self.navigationController.navigationBar addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(100, 15, 100, 15)];
    label2.text = @"全球时间线";
    label2.font = [UIFont systemFontOfSize:15];
    label2.textColor = [UIColor grayColor];
    
    [self.navigationController.navigationBar addSubview:label2];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 83, 0, 43, 46)];
    [button setBackgroundImage:[UIImage imageNamed:@"ButtonClose"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:button];
    
}

- (void)_createSet {
    
    _setView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 81, self.view.bounds.size.width, 32)];
    _setView.hidden = YES;
    [self.view addSubview:_setView];
    
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, (self.view.bounds.size.width - 62)/2, 32)];
    [button1 setImage:[UIImage imageNamed:@"IconOfflineCloud"] forState:UIControlStateNormal];
    [button1 setTitle:@"离线全部图片" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button1.titleLabel.font = [UIFont systemFontOfSize:15];
    [button1 setBackgroundImage:[UIImage imageNamed:@"ButtonMoreBg"] forState:UIControlStateNormal];
    //    [button1 setFont:[UIFont systemFontOfSize:18]];
    [_setView addSubview:button1];
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - 62)/2, 0, (self.view.bounds.size.width - 62)/2, 32)];
    [button2 setImage:[UIImage imageNamed:@"IconOfflineTrash"] forState:UIControlStateNormal];
    [button2 setTitle:@"清除图片缓存" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button2.titleLabel.font = [UIFont systemFontOfSize:15];
    [button2 setBackgroundImage:[UIImage imageNamed:@"ButtonMoreBg"] forState:UIControlStateNormal];
    button2.tag = 2;
    [button2 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_setView addSubview:button2];
    
    UIButton *button3 = [[UIButton alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - 62), 0, 32, 32)];
    [button3 setImage:[UIImage imageNamed:@"IconOfflineSettings"] forState:UIControlStateNormal];
    [button3 setBackgroundImage:[UIImage imageNamed:@"ButtonMoreBg"] forState:UIControlStateNormal];
    button3.tag = 3;
    [button3 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_setView addSubview:button3];
}

- (void)_showSet {
    [UIView animateWithDuration:0.3 animations:^{
        _setView.hidden = NO;
    }];
}

- (void)_hiddenSet {
    [UIView animateWithDuration:0.3 animations:^{
        _setView.hidden = YES;
    }];
}

- (void)back {
    [self.tabBarController.viewDeckController closeLeftViewAnimated:YES duration:0.3
                                        completion:^(IIViewDeckController *controller, BOOL success)
     {
         if (success) {
             IDHomeViewController *apiVC = [[IDHomeViewController alloc] init];
             self.viewDeckController.centerController = apiVC;
             self.view.userInteractionEnabled = YES;
         }
     }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == _tableView)
    {
        CGFloat sectionHeaderHeight = 64; //sectionHeaderHeight
        if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >= 0) {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        } else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
    }
}

- (void)buttonAction:(UIButton *)button {
    if (button.tag == 2) {
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"是否要清除所有图片缓存" delegate:self cancelButtonTitle:@"还是算了" destructiveButtonTitle:@"清除所有缓存" otherButtonTitles:nil, nil];
        sheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
        sheet.tag = 1;
        [sheet showInView:self.view];
    }else if (button.tag == 3) {
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:[NSString stringWithFormat:@"图片离线设置:%@",_stateStr] delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"任何时候",@"Wi-Fi可用时",@"不缓存图片", nil];
        sheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
        sheet.tag = 2;
        [sheet showInView:self.view];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0 && actionSheet.tag == 1) {
        NSLog(@"清除缓存");
        //        NSString *homePath = NSHomeDirectory();
        //        NSArray *subFilePath = @[@"/Library/Caches/com.mac.Collectation/",@"/Library/Caches/com.hackemist.SDWebImageCache.default/"];
        //
        //        for (NSString *filePath in subFilePath) {
        //            NSString *subFile = [homePath stringByAppendingPathComponent:filePath];
        //            NSFileManager *fileManager = [NSFileManager defaultManager];
        //
        //            NSArray *fileNames = [fileManager subpathsOfDirectoryAtPath:subFile error:nil];
        //            for (NSString *fileName in fileNames) {
        //                NSString *file = [subFile stringByAppendingPathComponent:fileName];
        //                [fileManager removeItemAtPath:file error:nil];
        //
        //            }
        //        }
        
    }
    else if (buttonIndex == 0 && actionSheet.tag == 2) {
        _stateStr = @"任何时候";
    }
    else if (buttonIndex == 1 && actionSheet.tag == 2) {
        _stateStr = @"Wi-Fi可用时";
    }
    else if (buttonIndex == 2 && actionSheet.tag == 2) {
        _stateStr = @"不缓存图片";
    }
}



- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
