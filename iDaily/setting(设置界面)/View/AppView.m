//
//  AppView.m
//  iDaily
//
//  Created by 李璇 on 15/9/20.
//  Copyright (c) 2015年 Yin Yi. All rights reserved.
//

#import "AppView.h"
#import "UIImageView+WebCache.h"

@interface AppView ()
@property (weak, nonatomic) IBOutlet UIImageView *appImage;

@property (weak, nonatomic) IBOutlet UILabel *titleCNLabel;

@property (weak, nonatomic) IBOutlet UILabel *titleEGLabel;


@end

@implementation AppView
- (void)awakeFromNib {
    [self createButton];
}

- (void)setAppModel:(AppModel *)appModel {
    _appImage.layer.cornerRadius = 5;
    [_appImage setImageWithURL:[NSURL URLWithString:appModel.icon]];
    _titleCNLabel.text = appModel.name_grid;
    _titleEGLabel.text = appModel.desc_grid;
    
    _appImage.userInteractionEnabled = YES;
    
    
}

- (void)createButton {
    UIButton *_appButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _appButton.frame = self.bounds;
//    _appButton.backgroundColor = [UIColor yellowColor];
//    _appButton.alpha = 0.1;
//    [_appButton addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_appButton];
}

- (void)buttonAction {
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 375, 650)];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:self.appModel.url]];
    [self addSubview:webView];
    [webView loadRequest:request];
}


@end
