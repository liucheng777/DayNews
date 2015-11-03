//
//  UIView+GetViewController.m
//  UIResponder
//
//  Created by Yin Yi on 15/8/15.
//  Copyright (c) 2015年 Yin Yi. All rights reserved.
//

#import "UIView+GetViewController.h"

@implementation UIView (GetViewController)
- (UIViewController *)viewController:(UIView *)view{
    UIResponder *responder = view.nextResponder;
    while (responder != nil) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = responder.nextResponder;
    }
    return nil;
    
}

- (UITableView *)tableView:(UIView *)view {
    UIResponder *responder = view.nextResponder;
    while (responder != nil) {
        if ([responder isKindOfClass:[UITableView class]]) {
            return (UITableView *)responder;
        }
        responder = responder.nextResponder;
    }
    return nil;
}
@end
