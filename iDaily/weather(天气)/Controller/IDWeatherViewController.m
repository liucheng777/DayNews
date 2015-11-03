//
//  IDWeatherViewController.m
//  iDaily
//
//  Created by Yin Yi on 15/9/14.
//  Copyright (c) 2015年 Yin Yi. All rights reserved.
//

#import "IDWeatherViewController.h"
#import "AFNetworking.h"
#import "WeatherModel.h"
#import "CityModel.h"
#import "TmpModel.h"

@interface IDWeatherViewController ()
//@property (nonatomic,strong)NSMutableArray *cityIdArray;


@end

@implementation IDWeatherViewController
{
    
    UITextField *_searchField;
    NSDictionary * plistDic;
    BOOL _isEdit ;
    
    
    
    NSString *_urlString;
    
    
    
    NSDictionary *dataDic2;
    NSArray *dataArry ;
    NSDictionary *dataDic1;
    NSMutableArray *tmpArray;
    NSMutableArray *weatherArray;
    
    
    NSMutableArray *_cityData ;
    NSMutableArray *tmpArray1;
    NSMutableArray *weatherArray1 ;
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.selectedIndex = 2;
    
    //读取plist文件
    NSString *filrPath = [[NSBundle mainBundle]pathForResource:@"CityList" ofType:@"plist"];
    plistDic = [[NSDictionary alloc]initWithContentsOfFile:filrPath];
    [self _createTable];
    [self _loadData];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
}
- (void)_createTable{
    
    //创建weatherTableView
    _weatherTableView = [[IDWeatherTableView alloc] initWithFrame:CGRectMake(0, 46, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64)];
    
    [self.view addSubview:_weatherTableView];
    
    
    //设置天气界面顶部栏
    
    UIImage *topBackgoundImage = [UIImage imageNamed:@"BackgroundHeaderPortraitFat"];
    
    UIImageView *topView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 46)];
    
    topView.image = topBackgoundImage;
    
    [self.view addSubview:topView];
    
    //------------BackgroundLine------------
    
    UIImage *topBackgoundLineImage = [UIImage imageNamed:@"BackgroundLine"];
    UIImageView *topBackgoundLineView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 45, [UIScreen mainScreen].bounds.size.width, 1)];
    topBackgoundLineView.image = topBackgoundLineImage;
    [topView addSubview:topBackgoundLineView];
    //----------设置左边title图片----------
    
    UIImage *topTitleImage = [UIImage imageNamed:@"TitleLogoLiteLandscape"];
    
    UIImageView *topTitleView = [[UIImageView alloc]initWithImage:topTitleImage];
    
    topTitleView.contentMode = UIViewContentModeTopLeft;
    
    topTitleView.clipsToBounds = YES;
    
    topTitleView.frame = CGRectMake(0, 10, 65, 32);
    [topView addSubview:topTitleView];
    
    //设置左边titleLabel
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 10, 150, 32)];
    titleLabel.text = @"全国天气预报";
    
    titleLabel.font = [UIFont systemFontOfSize:12];
    [topView addSubview:titleLabel];
    
    
    topView.userInteractionEnabled = YES;
    
    //设置关闭天气界面按钮
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-43, 0, 43, 46);
    
    [backButton setBackgroundImage:[UIImage imageNamed:@"ButtonClose"] forState:UIControlStateNormal];
    
    [backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [topView addSubview:backButton];
    
    //设置天气界面编辑按钮
    
    _isEdit = YES;
    UIButton *editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    editButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-86, 0, 43, 46);
    
    [editButton setBackgroundImage:[UIImage imageNamed:@"ButtonEdit"] forState:UIControlStateNormal];
    [editButton addTarget:self action:@selector(editButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [topView addSubview:editButton];
    
    //设置搜索栏及其弹出键盘
    
    _weatherTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 60)];
    UIImage *searchImage = [UIImage imageNamed:@"BackgroundWeatherSearch"];
    
    UIImageView *searchView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 60)];
    searchView.image = searchImage;
    [_weatherTableView.tableHeaderView addSubview:searchView];
    
    _searchField = [[UITextField alloc]initWithFrame:CGRectMake(50, 10, [UIScreen mainScreen].bounds.size.width-50, 40)];
    [searchView addSubview:_searchField];
    _searchField.placeholder = @"搜索并添加城市";
    _searchField.delegate = self;
    //[_searchField becomeFirstResponder];
    
    searchView.userInteractionEnabled = YES;
    
    
    //通过手势关闭天气界面
    //    UISwipeGestureRecognizer *swiperGestureRecognizer1 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swiperAction:)];
    //    swiperGestureRecognizer1.direction = UISwipeGestureRecognizerDirectionRight;
    //    [_weatherTableView addGestureRecognizer:swiperGestureRecognizer1];
    
    //    UISwipeGestureRecognizer *swiperGestureRecognizer2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swiperAction:)];
    //    swiperGestureRecognizer2.direction = UISwipeGestureRecognizerDirectionDown;
    //    [self.view addGestureRecognizer:swiperGestureRecognizer2];
}

//设置关闭天气界面按钮动作
- (void)backButtonAction:(UIButton*)button {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//设置编辑天气界面按钮动作

- (void)editButtonAction:(UIButton *)button{
    
    if (_isEdit) {
        [UIView animateWithDuration:0.3 animations:^{
            
            _weatherTableView.editing = YES;
        }];
        _isEdit = NO;
    }
    else {
        [UIView animateWithDuration:0.3 animations:^{
            
            _weatherTableView.editing = NO;
            _isEdit = YES;
        }];
    }
}

//右滑下滑关闭视图
- (void) swiperAction:(UISwipeGestureRecognizer *)swipeGestureRecongnzer {
    
    if (swipeGestureRecongnzer.direction == UISwipeGestureRecognizerDirectionRight) {
        self.modalPresentationStyle = UIModalTransitionStyleFlipHorizontal ;
        [self dismissViewControllerAnimated:YES completion:nil];
    }else if ( swipeGestureRecongnzer .direction == UISwipeGestureRecognizerDirectionDown){
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


#pragma mark 网络数据请求
- (void)_loadData {
    
    
    //读取本地化存储数据
    _weatherTableView.cityIdArray = [[NSUserDefaults standardUserDefaults]objectForKey:@"CityIdArray"];
    
    if (_weatherTableView.cityIdArray.count == 0) {
        _weatherTableView.cityIdArray =[NSMutableArray arrayWithObjects:plistDic[@"杭州"],plistDic[@"北京"],plistDic[@"上海"], nil];
    }
    
    //开始请求数据
    _weatherTableView.cityList = [[NSMutableArray alloc]init];
    _weatherTableView.tmpList1 = [[NSMutableArray alloc]init];
    _weatherTableView.weatherList = [[NSMutableArray alloc]init];
    
    _cityData = [[NSMutableArray alloc]init];
    tmpArray1 = [[NSMutableArray alloc]init];
    weatherArray1 = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < _weatherTableView.cityIdArray.count; i ++) {
        _urlString= [NSString stringWithFormat:@"https://api.heweather.com/x3/weather?cityid=%@&key=a5ed4998d56d49aea1f663b10b5ef6a7",_weatherTableView.cityIdArray[i]];
        
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:_urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            //请求城市名
            dataArry = responseObject[@"HeWeather data service 3.0"];
            dataDic1 = dataArry[0];
            dataDic2 = dataDic1[@"basic"];
            
            CityModel *_cityModel = [[CityModel alloc]initWithDataDic:dataDic2];
            [_cityData addObject:_cityModel];
            _weatherTableView.cityList = _cityData;
            
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
            
            _weatherTableView.tmpList1 = tmpArray1;
            
            [weatherArray1 addObject:weatherArray];
            _weatherTableView.weatherList = weatherArray1;
            [_weatherTableView reloadData];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            IDLog(@"%@",error);
        }];
        
    }
    
}

#pragma mark 搜索功能实现
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    
    //判断搜索栏是否为空
    if (_searchField.text.length<=0) {
        UIAlertView *altView = [[UIAlertView alloc]initWithTitle:@"输入框不能为空" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [altView show];
        
    }
    else {
        
        NSString *cityName = _searchField.text;
        NSArray *cityNameArray = [plistDic allKeys];
        
        //判断用户输入的城市名是否存在于字典中
        for (int i = 0; i < plistDic.count; i ++) {
            if ([cityName isEqualToString:cityNameArray[i]]&&[_weatherTableView.cityIdArray containsObject:plistDic[cityName]]==NO) {
                
                //取相应城市名对应的城市id填入api的url中
                NSString *searchUrl = [NSString stringWithFormat:@"https://api.heweather.com/x3/weather?cityid=%@&key=a5ed4998d56d49aea1f663b10b5ef6a7",plistDic[cityName]];
                
                
                AFHTTPRequestOperationManager *searchManager = [AFHTTPRequestOperationManager manager];
                [searchManager GET:searchUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    
                    NSArray *dataAarray = responseObject[@"HeWeather data service 3.0"];
                    NSDictionary *s_dataDic1 =dataAarray[0];
                    NSDictionary *s_dataDic2 = s_dataDic1[@"basic"];
                    
                    CityModel *s_cityModel = [[CityModel alloc]initWithDataDic:s_dataDic2];
                    [_cityData addObject:s_cityModel];
                    _weatherTableView.cityList = _cityData;
                    
                    //请求天气数据
                    NSMutableArray *s_tmpArray = [[NSMutableArray alloc]init];
                    NSMutableArray *s_weatherArray = [[NSMutableArray alloc]init];
                    NSArray *s_array = s_dataDic1[@"daily_forecast"];
                    NSDictionary *s_dic = [[NSDictionary alloc]init];
                    
                    for (int index = 0; index <= 4; index ++) {
                        s_dic= s_array[index];
                        TmpModel *s_tmpModel = [[TmpModel alloc]initWithDataDic:s_dic[@"tmp"]];
                        [s_tmpArray addObject:s_tmpModel];
                        WeatherModel * s_wtModel = [[WeatherModel alloc]initWithDataDic:s_dic[@"cond"]];
                        [s_weatherArray addObject:s_wtModel];
                    }
                    
                    
                    [tmpArray1 addObject:s_tmpArray];
                    
                    _weatherTableView.tmpList1 = tmpArray1;
                    
                    [weatherArray1 addObject:s_weatherArray];
                    _weatherTableView.weatherList = weatherArray1;
                    [_weatherTableView reloadData];
                    
                    
                    //调用cityIdArray的点语法，将新搜索到的城市保存于本地
                    NSMutableArray *mutaArray = [[NSMutableArray alloc] init];
                    [mutaArray addObjectsFromArray:_weatherTableView.cityIdArray];
                    [mutaArray addObject:plistDic[cityName]];
                    _weatherTableView.cityIdArray = mutaArray;
                    
                    
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    NSLog(@"%@",error);
                }];
                UIAlertView *getCityView = [[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"已添加%@",cityName] message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [getCityView show];
                
            }
            
        }
        
        //如果未到该城市，则弹出提示
        
        if (![cityNameArray containsObject:cityName]) {
            UIAlertView *notFoundView = [[UIAlertView alloc]initWithTitle:@"未找到该城市" message:nil     delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            //notFoundView.alertViewStyle = UIAlertViewStyleDefault;
            [notFoundView show];
            
        }
        
    }
    
    //收起键盘
    [textField resignFirstResponder];
    [textField endEditing:YES];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    [textField resignFirstResponder];
}



//点击空白关闭键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    
    if (![touch.view isKindOfClass: [UITextField class]] || ![touch.view isKindOfClass: [UITextView class]]) {
        
        [self.view endEditing:YES];
        
    }
}


//将return键的文字显示设置为搜索按钮
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    textField.returnKeyType = UIReturnKeySearch;
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
 #pragma mark - Navigation
 
 */

@end
