//
//  IDNewsViewController.m
//  iDaily
//
//  Created by Yin Yi on 15/9/24.
//  Copyright (c) 2015年 Yin Yi. All rights reserved.
//

#import "IDNewsViewController.h"
#import "IDNewsHeaderView.h"
#import "IDNewsBottomView.h"
#import "IDNewsTopView.h"
#import "IDNewsCell.h"

@interface IDNewsViewController () <IDNewsButtomViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,weak) IDNewsTopView *topView;
@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,weak) IDNewsHeaderView *headView;
@property (nonatomic,weak) IDNewsBottomView *bottomView;

@end

@implementation IDNewsViewController

- (instancetype)init {
    if (self = [super init]) {
        [self setupView];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setupView];
}

#pragma mark - 建立视图
- (void)setupView {
    // 0.设置背景
    UIImageView *bgimageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, IDScreemSize.width, IDScreemSize.height)];
    bgimageView.userInteractionEnabled = YES;
    bgimageView.image = [UIImage imageNamed:@"Background"];
    bgimageView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgimageView];
    
    // 1.创建顶部标题栏
    IDNewsTopView *topView = [[IDNewsTopView alloc] initWithFrame:CGRectMake(0, 0, IDScreemSize.width, IDTopBarHeight)];
    self.topView = topView;

    [self.view addSubview:topView];
    
    // 2.创建中间内容视图
    IDNewsHeaderView *headView = [[IDNewsHeaderView alloc] initWithFrame:CGRectMake(0, 0, IDScreemSize.width, 80)];

    self.headView = headView;
    
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 46, IDScreemSize.width, IDScreemSize.height - 92)];
    tableView.tableHeaderView = headView;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    
    // 3.创建底部工具栏
    IDNewsBottomView *bottomView = [[IDNewsBottomView alloc] initWithFrame:CGRectMake(0, IDScreemSize.height - IDTopBarHeight, IDScreemSize.width, IDTopBarHeight)];
    bottomView.delegate = self;
    [self.view addSubview:bottomView];
    
}

- (void)setNews:(IDDetailModel *)news {
    _news = news;
    
    self.topView.date = news.pubdate;
        self.headView.date = news.pubdate;
    self.headView.title = news.title;
    self.headView.source = news.source;
    
}

-(void)setTopImageURL:(NSString *)topImageURL {
    _topImageURL = topImageURL;
//    self.topView.titleImageUrl = topImageURL;
    [self.topView setTitleImageUrl:topImageURL];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return IDScreemSize.height - 183;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IDNewsCell *cell = [[IDNewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"newsCell"];
    cell.content = self.news.content;
    return cell;
}

// 按钮点击事件
- (void)buttonAction:(UIButton *)button {
    switch (button.tag) {
        case IDBottomButtonTypeBack:
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
            
        default:
            break;
    }
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
