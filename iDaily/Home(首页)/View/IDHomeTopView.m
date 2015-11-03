//
//  IDHomeTopView.m
//  iDaily
//
//  Created by Yin Yi on 15/9/15.
//  Copyright (c) 2015年 Yin Yi. All rights reserved.
//

#import "IDHomeTopView.h"
#import "AFNetworking.h"
#import "CityModel.h"
#import "TmpModel.h"
#import "WeatherModel.h"
@implementation IDHomeTopView
{
    UILabel *cityLabel ;
    UILabel *tmpLabel;
    UIImageView *weatherView;
    
    
    NSMutableArray * cityList;
    NSMutableArray * tmpList;
    NSMutableArray * weatherList;
    
    NSMutableArray *_cityData;
    NSMutableArray *tmpArray1 ;
    NSMutableArray *weatherArray1;
    NSString *_urlString;
    
    
    NSDictionary *dataDic2;
    NSArray *dataArry ;
    NSDictionary *dataDic1;
    NSMutableArray *tmpArray;
    NSMutableArray *weatherArray;
}

- (void)setCityIdArray:(NSMutableArray *)cityIdArray {
    _cityIdArray = cityIdArray;
    
    [[NSUserDefaults standardUserDefaults]setObject:_cityIdArray forKey:@"CityIdArray"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}


- (instancetype)init {
    if (self = [super initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, IDTopBarHeight)]) {
        //设置天气界面顶部栏
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, IDScreemSize.width / 2 + 20, IDTopBarHeight - 2)];
        imageView.image = [UIImage imageNamed:@"TitleLogoLiteLandscape"];
        [self addSubview:imageView];
        
        UIView *lineButtom = [[UIView alloc] initWithFrame:CGRectMake(0, IDTopBarHeight - 2, IDScreemSize.width, 1)];
        lineButtom.backgroundColor = IDColor(229, 229, 229);
        [self addSubview:lineButtom];
        
        // 分割线
        UIView *lineOne = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame) + 10, 0, 1, IDTopBarHeight - 2)];
        lineOne.backgroundColor = IDColor(229, 229, 229);
        [self addSubview:lineOne];
        
        UIButton *weatherButton = [UIButton buttonWithType:UIButtonTypeCustom];
        weatherButton.frame = CGRectMake(CGRectGetMaxX(lineOne.frame), 0, 110, IDTopBarHeight - 1);
        weatherButton.titleLabel.font = [UIFont systemFontOfSize:15];
        //        [weatherButton setTitle:@"天气" forState:UIControlStateNormal];
        //        [weatherButton setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
        self.weatherButton = weatherButton;
        [self addSubview:weatherButton];
        
        //设置天气按钮的动态变化
        cityLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lineOne.frame), 0, 30, IDTopBarHeight-1)];
        cityLabel.font = [UIFont systemFontOfSize:13];
        cityLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:cityLabel];
        
        tmpLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lineOne.frame)+60, 0, 50, IDTopBarHeight-1)];
        tmpLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:tmpLabel];
        
        weatherView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lineOne.frame)+30, 0, 30, IDTopBarHeight-7)];
        [self addSubview:weatherView];
        
        
        UIView *lineTwo = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(weatherButton.frame), 0, 1, IDTopBarHeight - 1)];
        lineTwo.backgroundColor = IDColor(229, 229, 229);
        [self addSubview:lineTwo];
        
        UIImage *topBackgoundImage = [UIImage imageNamed:@"BackgroundHeaderPortraitFat"];
        self.image = topBackgoundImage;
        self.userInteractionEnabled = YES;
        
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        rightButton.frame = CGRectMake(CGRectGetMaxX(lineTwo.frame) - 5, 0, 50, IDTopBarHeight - 2);
        rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [rightButton setImage:[UIImage imageNamed:@"ButtonOfflineList"] forState:UIControlStateNormal];
        //        [rightButton setImage:[UIImage imageNamed:@"ButtonOfflineListHighlighted"] forState:UIControlStateHighlighted];
        self.rightButton = rightButton;
        [self addSubview:rightButton];
        
        [self _loadWeatherData];
    }
    return self;
}

- (void)_loadWeatherData {
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"CityList" ofType:@"plist"];
    NSDictionary *plistDic = [[NSDictionary alloc]initWithContentsOfFile:filePath];
    //读取本地化存储数据
    _cityIdArray = [[NSUserDefaults standardUserDefaults]objectForKey:@"CityIdArray"];
    
    if (_cityIdArray.count == 0) {
        _cityIdArray =[NSMutableArray arrayWithObjects:plistDic[@"杭州"],plistDic[@"北京"],plistDic[@"上海"],plistDic[@"广州"],plistDic[@"天津"],plistDic[@"香港"],plistDic[@"台北"], nil];
    }
    
    //开始请求数据
    cityList = [[NSMutableArray alloc]init];
    tmpList = [[NSMutableArray alloc]init];
    weatherList = [[NSMutableArray alloc]init];
    
    _cityData = [[NSMutableArray alloc]init];
    tmpArray1 = [[NSMutableArray alloc]init];
    weatherArray1 = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < _cityIdArray.count; i ++) {
        _urlString= [NSString stringWithFormat:@"https://api.heweather.com/x3/weather?cityid=%@&key=a5ed4998d56d49aea1f663b10b5ef6a7",_cityIdArray[i]];
        
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:_urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            //请求城市名
            dataArry = responseObject[@"HeWeather data service 3.0"];
            dataDic1 = dataArry[0];
            dataDic2 = dataDic1[@"basic"];
            
            CityModel *_cityModel = [[CityModel alloc]initWithDataDic:dataDic2];
            [_cityData addObject:_cityModel];
            //_weatherTableView.cityList = _cityData;
            cityList = _cityData;
            //请求天气数据
            tmpArray = [[NSMutableArray alloc]init];
            weatherArray = [[NSMutableArray alloc]init];
            NSArray *array = dataDic1[@"daily_forecast"];
            NSDictionary *dic = [[NSDictionary alloc]init];
            for (int index = 0; index <= 4; index ++) {
                dic= array[index];
                TmpModel *tmpModel = [[TmpModel alloc]initWithDataDic:dic[@"tmp"]];
                [tmpArray addObject:tmpModel];
                WeatherModel * wtModel = [[WeatherModel alloc]initWithDataDic:dic[@"cond"]];
                [weatherArray addObject:wtModel];
            }
            
            [tmpArray1 addObject:tmpArray];
            tmpList = tmpArray1;
            [weatherArray1 addObject:weatherArray];
            weatherList = weatherArray1;
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            IDLog(@"%@",error);
        }];
        
    }
    
    //    [UIView animateWithDuration:1 delay:5 options:UIViewAnimationOptionRepeat animations:^{
    //
    //        [self abcTimer:nil];
    //
    //    } completion:nil];
    
    
    
    // 创建定时器
    [NSTimer scheduledTimerWithTimeInterval:3      // 调用的时间间隔
                                     target:self       // 方法对执行者
                                   selector:@selector(abcTimer:)    // 方法选择器
                                   userInfo:nil              // 参数
                                    repeats:YES];   // 是否循环调用
    
    //
    //    //[[NSRunLoop currentRunLoop] run];
    
}
- (void)abcTimer:(NSTimer *)timer
{
    /*
     // 获取定时器的参数
     NSString *string = timer.userInfo;
     NSLog(@"timer, userinfo:%@", string);
     
     // 让定时器失效(停止定时器)
     [timer invalidate];
     */
    
    static int i = 0;
    if (i == _cityIdArray.count) {
        i=0;
    }
    
    static CGFloat alpha1 = 1.0;
    cityLabel.alpha = alpha1;
    tmpLabel.alpha = alpha1;
    weatherView.alpha =alpha1;
    if (alpha1 == 0.0) {
        alpha1 = 1.0;
        [UIView animateWithDuration:1 animations:^{
            
            cityLabel.alpha = alpha1;
            tmpLabel.alpha = alpha1;
            weatherView.alpha =alpha1;
        }];
    }
    
    //加载城市列表
    
    CityModel *model = cityList[i];
    cityLabel.text = model.city;
    //加载气温
    TmpModel *tmpModel1 = tmpList[i][0];
    tmpLabel.text = [NSString stringWithFormat:@"%@/%@°C",tmpModel1.min,tmpModel1.max];
    //加载天气图片
    WeatherModel *wtModel1 = weatherList[i][0];
    switch ([wtModel1.code_d intValue]) {
        case 100:
            weatherView.image = [UIImage imageNamed:@"IconWeatherSunny"];
            break;
        case 101:
            weatherView.image  = [UIImage imageNamed:@"IconWeatherCloudy"];
            break;
        case 104:
            weatherView.image  = [UIImage imageNamed:@"IconWeatherOvercast"];
            break;
        case 300:
            weatherView.image  = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 301:
            weatherView.image  = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 302:
            weatherView.image  = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 303:
            weatherView.image  = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 304:
            weatherView.image  = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 305:
            weatherView.image  = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 306:
            weatherView.image  = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 307:
            weatherView.image  = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 308:
            weatherView.image  = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 309:
            weatherView.image  = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 310:
            weatherView.image  = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 311:
            weatherView.image  = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 312:
            weatherView.image  = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 313:
            weatherView.image  = [UIImage imageNamed:@"IconWeatherRainy"];
            break;
        case 400:
            weatherView.image  = [UIImage imageNamed:@"IconWeatherSnowy"];
        default:
            weatherView.image  = [UIImage imageNamed:@"IconWeatherCloudy"];
            break;
    }
    i++;
    
    
    
    if (alpha1 == 1.0) {
        alpha1 = 0.0;
        [UIView animateWithDuration:3 animations:^{
            cityLabel.alpha = alpha1;
            tmpLabel.alpha = alpha1;
            weatherView.alpha =alpha1;
        }];
    }
}

@end
