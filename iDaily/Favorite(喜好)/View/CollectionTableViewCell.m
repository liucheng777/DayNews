//
//  CollectionTableViewCell.m
//  Collectation
//
//  Created by mac on 15/9/21.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "CollectionTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "IDNewModel.h"

@interface CollectionTableViewCell()<UICollectionViewDataSource, UICollectionViewDelegate> {
    UICollectionView *_collectionView;
    NSMutableArray *_mArray;
    NSMutableArray *_tArray;
}

@end

@implementation CollectionTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [self _createView];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _createView];
    }
    return self;
}

- (void)_createView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(85, 60);
    flowLayout.sectionInset = UIEdgeInsetsMake(20, 30, 10, 10);
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.minimumLineSpacing = 10;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 10, 325, 90) collectionViewLayout:flowLayout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    [self addSubview:_collectionView];
    
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    CGRect frame = _collectionView.frame;
    if (_numberOfNews % 3 == 0) {
        frame.size.height = (_numberOfNews / 3) * 75 + 10;
    }else {
        frame.size.height = (_numberOfNews / 3 + 1) * 75 + 10;
    }
    _collectionView.frame = frame;
    
    return self.numberOfNews;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

    UIButton *button = [[UIButton alloc] initWithFrame:self.contentView.bounds];
    NSURL *url = [NSURL URLWithString:_mArray[indexPath.row]];
    [button setImageWithURL:url forState:UIControlStateNormal];
    
    cell.tag = [_tArray[indexPath.row] integerValue];
    [cell setBackgroundView:button];
    
    return cell;
}

- (void)setImageNames:(NSArray *)imageNames {
    _imageNames = imageNames;
    _mArray = [[NSMutableArray alloc] init];
    _tArray = [[NSMutableArray alloc] init];
    for (IDNewModel *news in self.imageNames) {
        [_mArray addObject:news.cover_landscape];
        [_tArray addObject:news.guid];
    }
    [_collectionView reloadData];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    NSLog(@"%li",cell.tag);
    
    NSString *string = [NSString stringWithFormat:@"%li",cell.tag];
    
    NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:string,@"guid", nil];
    
    NSNotification *notification = [[NSNotification alloc] initWithName:@"tianzhuan" object:nil userInfo:dict];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
