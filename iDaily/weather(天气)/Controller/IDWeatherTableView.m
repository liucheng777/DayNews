//
//  IDWeatherTableView.m
//  iDaily
//
//  Created by imac on 15/9/14.
//  Copyright (c) 2015年 Yin Yi. All rights reserved.
//

#import "IDWeatherTableView.h"
#import "IDWeatherTableViewCell.h"
#import "WeatherModel.h"
#import "CityModel.h"
#import "tmpModel.h"
#import "AFNetworking.h"
@class IDWeatherViewController;
@implementation IDWeatherTableView {
    
}

- (void)setCityList:(NSMutableArray *)cityList {
    _cityList = cityList;
    
    //    [[NSUserDefaults standardUserDefaults]setObject:_cityList forKey:@"cityList"];
    //    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [self reloadData];
}

- (void)setTmpList1:(NSMutableArray *)tmpList1 {
    _tmpList1 = tmpList1;
    
    [self reloadData];
    
}


- (void)setWeatherList:(NSMutableArray *)weatherList {
    _weatherList = weatherList;
    
    [self reloadData];
}


- (void)setCityIdArray:(NSMutableArray *)cityIdArray {
    _cityIdArray = cityIdArray;
    
    [[NSUserDefaults standardUserDefaults]setObject:_cityIdArray forKey:@"CityIdArray"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        [self _initTable];
    }
    return self;
    
}


- (void)awakeFromNib{
    [self _initTable];
    
}

//点击空白关闭键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    
    if (![touch.view isKindOfClass: [UITextField class]] || ![touch.view isKindOfClass: [UITextView class]]) {
        
        [self endEditing:YES];
        
    }
}

#pragma mark 网络请求


- (void)_initTable{
    //设置tableView的背景图片，与搜索栏颜色一致
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"BackgroundPattern"]];
    
    self.dataSource = self;
    self.delegate = self;
    //注册单元格
    UINib *nib  = [UINib nibWithNibName:@"IDWeatherTableViewCell" bundle:nil];
    [self registerNib:nib forCellReuseIdentifier:@"IDWeatherTableViewCell"];
    
}

#pragma mark 读取天气数据



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.cityList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 55;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    IDWeatherTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IDWeatherTableViewCell"];
    if (cell == nil) {
        cell = [[IDWeatherTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"IDWeatherTableViewCell"];
        //设置Cell风格
        
    }
    //设置Cell的背景图片
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UIImage *weatherImage = [UIImage imageNamed:@"BackgroundWeatherRow"];
    
    cell.weatherImageView.image = weatherImage;
    
    //加载城市列表
    CityModel *model = self.cityList[indexPath.row];
    
    cell.cityNameLabel.text = model.city;
    
    //加载气温数据
    NSArray *tmpArray = self.tmpList1[indexPath.row];
    
    TmpModel *tmpModel1 = tmpArray[0];
    TmpModel *tmpModel2 = tmpArray[1];
    TmpModel *tmpModel3 = tmpArray[2];
    TmpModel *tmpModel4 = tmpArray[3];
    TmpModel *tmpModel5 = tmpArray[4];
    
    cell.tdlabel.text = [NSString stringWithFormat:@"%@/%@°C",tmpModel1.min,tmpModel1.max];
    cell.tmrLabel.text = [NSString stringWithFormat:@"%@/%@°C",tmpModel2.min,tmpModel2.max];
    cell.futureLabel1.text = [NSString stringWithFormat:@"%@/%@°C",tmpModel3.min,tmpModel3.max];
    cell.futureLabel2.text = [NSString stringWithFormat:@"%@/%@°C",tmpModel4.min,tmpModel4.max];
    cell.futureLabel3.text = [NSString stringWithFormat:@"%@/%@°C",tmpModel5.min,tmpModel5.max];
    
    //加载天气数据
    NSArray *wtArray = self.weatherList[indexPath.row];
    WeatherModel *wtModel1 = wtArray[0];
    WeatherModel *wtModel2 = wtArray[1];
    WeatherModel *wtModel3 = wtArray[2];
    WeatherModel *wtModel4 = wtArray[3];
    WeatherModel *wtModel5 = wtArray[4];
    switch ([wtModel1.code_d intValue]) {
        case 100:
            cell.tdImageView.image = [UIImage imageNamed:@"IconWeatherSunny"];
            break;
        case 101:
            cell.tdImageView.image = [UIImage imageNamed:@"IconWeatherCloudy"];
            break;
        case 104:
            cell.tdImageView.image = [UIImage imageNamed:@"IconWeatherOvercast"];
            break;
        case 300:
            cell.tdImageView.image = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 301:
            cell.tdImageView.image = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 302:
            cell.tdImageView.image = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 303:
            cell.tdImageView.image = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 304:
            cell.tdImageView.image = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 305:
            cell.tdImageView.image = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 306:
            cell.tdImageView.image = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 307:
            cell.tdImageView.image = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 308:
            cell.tdImageView.image = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 309:
            cell.tdImageView.image = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 310:
            cell.tdImageView.image = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 311:
            cell.tdImageView.image = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 312:
            cell.tdImageView.image = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 313:
            cell.tdImageView.image = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 400:
            cell.tdImageView.image = [UIImage imageNamed:@"IconWeatherSnowy"];
        default:
            cell.tdImageView.image = [UIImage imageNamed:@"IconWeatherCloudy"];
            break;
    }
    
    switch ([wtModel2.code_d intValue]) {
        case 100:
            cell.tmrImageView.image = [UIImage imageNamed:@"IconWeatherSunny"];
            break;
        case 101:
            cell.tmrImageView.image = [UIImage imageNamed:@"IconWeatherCloudy"];
            break;
        case 104:
            cell.tmrImageView.image = [UIImage imageNamed:@"IconWeatherOvercast"];
            break;
        case 300:
            cell.tmrImageView.image = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 301:
            cell.tmrImageView.image = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 302:
            cell.tmrImageView.image = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 303:
            cell.tmrImageView.image = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 304:
            cell.tmrImageView.image = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 305:
            cell.tmrImageView.image = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 306:
            cell.tmrImageView.image = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 307:
            cell.tmrImageView.image = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 308:
            cell.tmrImageView.image = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 309:
            cell.tmrImageView.image = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 310:
            cell.tmrImageView.image = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 311:
            cell.tmrImageView.image = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 312:
            cell.tmrImageView.image = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 313:
            cell.tmrImageView.image = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 400:
            cell.tmrImageView.image = [UIImage imageNamed:@"IconWeatherSnowy"];
        default:
            cell.tmrImageView.image = [UIImage imageNamed:@"IconWeatherCloudy"];
            break;
    }
    
    switch ([wtModel3.code_d intValue]) {
        case 100:
            cell.ftImageView1.image = [UIImage imageNamed:@"IconWeatherSunny"];
            break;
        case 101:
            cell.ftImageView1.image = [UIImage imageNamed:@"IconWeatherCloudy"];
            break;
        case 104:
            cell.ftImageView1.image = [UIImage imageNamed:@"IconWeatherOvercast"];
            break;
        case 300:
            cell.ftImageView1.image = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 301:
            cell.ftImageView1.image= [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 302:
            cell.ftImageView1.image= [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 303:
            cell.ftImageView1.image = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 304:
            cell.ftImageView1.image = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 305:
            cell.ftImageView1.image = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 306:
            cell.ftImageView1.image = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 307:
            cell.ftImageView1.image = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 308:
            cell.ftImageView1.image = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 309:
            cell.ftImageView1.image = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 310:
            cell.ftImageView1.image = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 311:
            cell.ftImageView1.image = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 312:
            cell.ftImageView1.image = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 313:
            cell.ftImageView1.image = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 400:
            cell.ftImageView1.image = [UIImage imageNamed:@"IconWeatherSnowy"];
        default:
            cell.ftImageView1.image = [UIImage imageNamed:@"IconWeatherCloudy"];
            break;
    }
    
    switch ([wtModel4.code_d intValue]) {
        case 100:
            cell.ftImageView2.image = [UIImage imageNamed:@"IconWeatherSunny"];
            break;
        case 101:
            cell.ftImageView2.image = [UIImage imageNamed:@"IconWeatherCloudy"];
            break;
        case 104:
            cell.ftImageView2.image = [UIImage imageNamed:@"IconWeatherOvercast"];
            break;
        case 300:
            cell.ftImageView2.image = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 301:
            cell.ftImageView2.image= [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 302:
            cell.ftImageView2.image= [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 303:
            cell.ftImageView2.image = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 304:
            cell.ftImageView2.image = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 305:
            cell.ftImageView2.image = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 306:
            cell.ftImageView2.image = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 307:
            cell.ftImageView2.image = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 308:
            cell.ftImageView2.image = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 309:
            cell.ftImageView2.image = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 310:
            cell.ftImageView2.image = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 311:
            cell.ftImageView2.image = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 312:
            cell.ftImageView2.image = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 313:
            cell.ftImageView2.image = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 400:
            cell.ftImageView2.image = [UIImage imageNamed:@"IconWeatherSnowy"];
        default:
            cell.ftImageView2.image = [UIImage imageNamed:@"IconWeatherCloudy"];
            break;
    }
    
    switch ([wtModel5.code_d intValue]) {
        case 100:
            cell.ftImageView3.image = [UIImage imageNamed:@"IconWeatherSunny"];
            break;
        case 101:
            cell.ftImageView3.image = [UIImage imageNamed:@"IconWeatherCloudy"];
            break;
        case 104:
            cell.ftImageView3.image = [UIImage imageNamed:@"IconWeatherOvercast"];
            break;
        case 300:
            cell.ftImageView3.image = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 301:
            cell.ftImageView3.image= [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 302:
            cell.ftImageView3.image= [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 303:
            cell.ftImageView3.image = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 304:
            cell.ftImageView3.image = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 305:
            cell.ftImageView3.image = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 306:
            cell.ftImageView3.image = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 307:
            cell.ftImageView3.image = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 308:
            cell.ftImageView3.image = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 309:
            cell.ftImageView3.image = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 310:
            cell.ftImageView3.image = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 311:
            cell.ftImageView3.image = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 312:
            cell.ftImageView3.image = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 313:
            cell.ftImageView3.image = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 400:
            cell.ftImageView3.image = [UIImage imageNamed:@"IconWeatherSnowy"];
        default:
            cell.ftImageView3.image = [UIImage imageNamed:@"IconWeatherCloudy"];
            break;
    }
    
    return cell;
    
}

#pragma mark 编辑表视图

//删除cell
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self.cityList removeObjectAtIndex:indexPath.row];
        [self.tmpList1 removeObjectAtIndex:indexPath.row];
        [self.weatherList removeObjectAtIndex:indexPath.row];
        
        NSMutableArray *mutaArray = [[NSMutableArray alloc] init];
        [mutaArray addObjectsFromArray:self.cityIdArray];
        [mutaArray removeObjectAtIndex:indexPath.row];
        self.cityIdArray = mutaArray;
        
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
}

//移动列表

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    // NSLog(@"from(%i)-to(%i)", sourceIndexPath.row, destinationIndexPath.row);
    id obj1 = [_cityList objectAtIndex:sourceIndexPath.row];
    [_cityList removeObjectAtIndex:sourceIndexPath.row];
    [_cityList insertObject:obj1 atIndex:destinationIndexPath.row];
    
    id obj2 = [_tmpList1 objectAtIndex:sourceIndexPath.row];
    [_tmpList1 removeObjectAtIndex:sourceIndexPath.row];
    [_tmpList1 insertObject:obj2 atIndex:destinationIndexPath.row];
    
    id obj3 = [_weatherList objectAtIndex:sourceIndexPath.row];
    [_weatherList removeObjectAtIndex:sourceIndexPath.row];
    [_weatherList insertObject:obj3 atIndex:destinationIndexPath.row];
    [self reloadData];
    
    
    NSMutableArray *mutaArray = [[NSMutableArray alloc] init];
    [mutaArray addObjectsFromArray:self.cityIdArray];
    id obj4 = [mutaArray objectAtIndexedSubscript:sourceIndexPath.row];
    [mutaArray removeObjectAtIndex:sourceIndexPath.row];
    [mutaArray insertObject:obj4 atIndex:destinationIndexPath.row];
    self.cityIdArray = mutaArray;
    
}

@end
