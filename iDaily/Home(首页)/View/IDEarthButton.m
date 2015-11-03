//
//  IDEarthButton.m
//  iDaily
//
//  Created by Yin Yi on 15/9/17.
//  Copyright (c) 2015年 Yin Yi. All rights reserved.
//

#import "IDEarthButton.h"

@implementation IDEarthButton

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    
    
    return CGRectMake(3, 0, contentRect.size.width - 27, 46);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    return CGRectMake(70, 0, contentRect.size.width - 70, 46);
}


@end
