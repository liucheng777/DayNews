//
//  IDNewsCell.m
//  iDaily
//
//  Created by Yin Yi on 15/9/25.
//  Copyright (c) 2015年 Yin Yi. All rights reserved.
//

#import "IDNewsCell.h"

@interface IDNewsCell ()
@property (nonatomic,weak) UILabel *contentLabel;
@end

@implementation IDNewsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *label = [[UILabel alloc] init];
        self.contentLabel = label;
        label.font = [UIFont systemFontOfSize:17];
        label.numberOfLines = 0;
        [self.contentView addSubview:label];
        
    }
    return self;
}

- (void)setContent:(NSString *)content {
    _content = content;
    
    CGFloat labelWidth = IDScreemSize.width - 40;
    CGFloat labelHeight = IDScreemSize.height - 183;
    CGSize maxSize = CGSizeMake(labelWidth, labelHeight);
    NSDictionary *attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:14]};
    CGSize contentSize = [content boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    self.contentLabel.frame = CGRectMake(20, 20, contentSize.width, contentSize.height);
    self.contentLabel.text = content;
}

@end
