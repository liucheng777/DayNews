//
//  CollectionTableViewCell.h
//  Collectation
//
//  Created by mac on 15/9/21.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionTableViewCell : UITableViewCell

@property (nonatomic, assign) NSInteger numberOfNews;
@property (nonatomic, strong) NSArray *imageNames;

- (void)setImageNames:(NSArray *)imageNames;

@end
