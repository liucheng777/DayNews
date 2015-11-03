//
//  TabBarController.m
//  Collectation
//
//  Created by mac on 15/9/20.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "TabBarController.h"
#import "NavViewController.h"
#import "HistoryViewController.h"
#import "CollectionViewController.h"

@interface TabBarController (){
    NSInteger _index;
}

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    _index = 0;
//    [self _createSubControllers];
//    [self _createTabBar];
}

- (void)setDataArray:(NSArray *)DataArray {
    _DataArray = DataArray;
    _index = 0;
    [self _createSubControllers];
    [self _createTabBar];
}

- (void)_createTabBar {
    //    移除UITabBarButton
    for (UIView *view in self.tabBar.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([view isKindOfClass:class]) {
            [view removeFromSuperview];
        }
    }
    
    CGFloat itemWidth = (self.view.bounds.size.width - 30) / 3;
    
    NSArray *nameArray = @[@"列表",@"收藏",@"离线"];
    NSArray *imgNameArray = @[@"ButtonOfflineList",@"",@"IconOfflineLoading"];
    
    for (int i = 0; i < 3; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i * itemWidth, 0, itemWidth, 49)];
        [button setTitle:nameArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:imgNameArray[i]] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3];
        button.tag = i;
        [button addTarget:self action:@selector(_selectAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.tabBar addSubview:button];
    }

}

- (void)_selectAction:(UIButton *)button {
    if (button.tag < 2) {
        self.selectedIndex = button.tag;
    }
    else{
        if (_index == 0) {
            NSNotification *notification = [[NSNotification alloc] initWithName:@"tongzhi1" object:nil userInfo:nil];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            _index = 1;
        }
        else {
            NSNotification *notification = [[NSNotification alloc] initWithName:@"tongzhi2" object:nil userInfo:nil];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            _index = 0;
        }
    }
}

- (void)_createSubControllers {
    HistoryViewController *hisVC = [[HistoryViewController alloc] init];
    hisVC.dataArr = self.DataArray;
    CollectionViewController *cotVC = [[CollectionViewController alloc] init];
    
    NavViewController *nav1 = [[NavViewController alloc] initWithRootViewController:hisVC];
    NavViewController *nav2 = [[NavViewController alloc] initWithRootViewController:cotVC];
    
    self.viewControllers = @[nav1,nav2];
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
