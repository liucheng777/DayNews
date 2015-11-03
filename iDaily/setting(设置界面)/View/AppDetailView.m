//
//  AppDetailView.m
//  iDaily
//
//  Created by 李璇 on 15/9/20.
//  Copyright (c) 2015年 Yin Yi. All rights reserved.
//

#import "AppDetailView.h"
#import "UIImageView+WebCache.h"

@interface AppDetailView ()
@property (weak, nonatomic) IBOutlet UIImageView *appImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *introduceLabel;
@property (weak, nonatomic) IBOutlet UIButton *freeButton;

@end

@implementation AppDetailView

- (void)awakeFromNib {
//    [_freeButton addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setAppModel:(AppModel *)appModel {
    _appImage.layer.cornerRadius = 5;
    [_appImage setImageWithURL:[NSURL URLWithString:appModel.icon]];
    
    _titleLabel.text = appModel.name;
    _titleLabel.textColor = [UIColor blackColor];
    
    _introduceLabel.text = appModel.desc;
    _introduceLabel.textColor = [UIColor blackColor];
    
}


- (void)buttonAction {
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 375, 650)];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:self.appModel.url]];
    [self addSubview:webView];
    [webView loadRequest:request];
}


@end
