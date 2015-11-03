//
//  app.h
//  iDaily
//
//  Created by 李璇 on 15/9/19.
//  Copyright (c) 2015年 Yin Yi. All rights reserved.
//

#import "BaseModel.h"

@interface AppModel : BaseModel

@property (nonatomic,copy)NSString *desc;
@property (nonatomic,copy)NSString *desc_grid;
@property (nonatomic,strong)NSNumber *hnd_id;
@property (nonatomic,copy)NSString *icon;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *name_grid;
@property (nonatomic,copy)NSString *url;


@end
