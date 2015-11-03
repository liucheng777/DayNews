//
//  CollectionViewController.m
//  Collectation
//
//  Created by mac on 15/9/20.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "CollectionViewController.h"
#import "IIViewDeckController.h"
#import "IDHomeViewController.h"

@interface CollectionViewController ()<UIActionSheetDelegate>{
    UIView *_setView;
    NSString *_stateStr;
}

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _stateStr = @"Wi-Fi可用时";
    [self _createNavBar];
    self.view.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_showSet) name:@"tongzhi1" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_hiddenSet) name:@"tongzhi2" object:nil];
}

- (void)_createNavBar {
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 80, 15)];
    label1.text = @"Favourite";
    [label1 setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
    label1.textColor = [UIColor blackColor];
    
    [self.navigationController.navigationBar addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(100, 15, 100, 15)];
    label2.text = @"我的收藏";
    label2.font = [UIFont systemFontOfSize:15];
    label2.textColor = [UIColor grayColor];
    
    [self.navigationController.navigationBar addSubview:label2];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 83, 0, 43, 46)];
    [button setBackgroundImage:[UIImage imageNamed:@"ButtonClose"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:button];
    
    
    _setView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 81, self.view.bounds.size.width, 32)];
    _setView.hidden = YES;
    [self.view addSubview:_setView];
    
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, (self.view.bounds.size.width - 62)/2, 32)];
    [button1 setImage:[UIImage imageNamed:@"IconOfflineCloud"] forState:UIControlStateNormal];
    [button1 setTitle:@"离线全部图片" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button1.titleLabel.font = [UIFont systemFontOfSize:15];
    [button1 setBackgroundImage:[UIImage imageNamed:@"ButtonMoreBg"] forState:UIControlStateNormal];
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

@end
