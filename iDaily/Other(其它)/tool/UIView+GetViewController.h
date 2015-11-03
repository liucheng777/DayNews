//
//  UIView+GetViewController.h
//  UIResponder
//
//  Created by Yin Yi on 15/8/15.
//  Copyright (c) 2015年 Yin Yi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (GetViewController)
- (UIViewController *)viewController:(UIView *)view;

- (UITableView *)tableView:(UIView *)view;
@end
