//
//  MySetViewController.m
//  iDaily
//
//  Created by 李璇 on 15/9/23.
//  Copyright (c) 2015年 Yin Yi. All rights reserved.
//

#import "MySetViewController.h"

@interface MySetViewController ()

@end

@implementation MySetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self _createTableView];
}

//- (void)_createTableView {
//    UITableView *tabelView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
//    tabelView.delegate = self;
//    tabelView.dataSource = self;
//    [self.view addSubview:tabelView];
//}
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 6;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    if (section == 0) {
//        return 5;
//    }
//    else if (section == 1) {
//        return 4;
//    }
//    else if (section == 2) {
//        return 2;
//    }
//    else if (section == 3) {
//        return 4;
//    }
//    else if (section == 4) {
//        return 5;
//    }
//    else {
//        return 1;
//    }
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
//    }
//    return cell;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 30;
    }
    if (section == 1) {
        return 60;
    }
    return 40;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, 100, 40)];
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = [UIColor grayColor];
    if (section == 0) {
        label.text = @"   浏览设置";
        
        return label;
    }
    if (section == 1) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, IDScreemSize.width, 60)];
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 30)];
        label1.font = [UIFont systemFontOfSize:13];
        label1.textColor = [UIColor grayColor];
        label1.text = @"   繁简转换需要退出并重新进入程序";
        [view addSubview:label1];
        
        label.frame = CGRectMake(0, 30, 100, 30);
        label.text = @"   更新设置";
        [view addSubview:label];
        
        return view;
    }
    if (section == 2) {
        label.text = @"   个人设置";
        return label;
    }
    if (section == 3) {
        label.text = @"   关于";
        return label;
    }
    
    return nil;
}




@end
