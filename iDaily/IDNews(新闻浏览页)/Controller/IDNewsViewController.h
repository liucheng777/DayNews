//
//  IDNewsViewController.h
//  iDaily
//
//  Created by Yin Yi on 15/9/24.
//  Copyright (c) 2015年 Yin Yi. All rights reserved.
//

#import "IDBaseViewController.h"
#import "IDDetailModel.h"

@interface IDNewsViewController : IDBaseViewController
@property (nonatomic,strong) IDDetailModel *news;
@property (nonatomic,copy) NSString *topImageURL;
@end
