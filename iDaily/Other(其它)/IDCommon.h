//
//  IDCommon.h
//  iDaily
//
//  Created by Yin Yi on 15/9/14.
//  Copyright (c) 2015年 Yin Yi. All rights reserved.
//

#ifndef iDaily_IDCommon_h
#define iDaily_IDCommon_h
// 版本
#define IDDeviceVersion [[UIDevice currentDevice].systemVersion doubleValue]
// rgb颜色
#define IDColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 上端bar的高度
#define IDTopBarHeight 46

// 屏幕尺寸
#define IDScreemSize [UIScreen mainScreen].bounds.size

// 调试时候的输出方法
#ifdef DEBUG
#define IDLog(...) NSLog(__VA_ARGS__)
#else
#define IDLog(...)
#endif

// 页面跳转请求通知
#define IDTiaoZhuanNotification @"IDTiaoZhuanNotification"

// 网络请求各项参数
//   主页链接
#define IDGetNewsURL @"http://idaily-cdn.idai.ly/api/list/v3/iphone/zh-hans?page=1&ver=iphone&app_ver=20"
//   详情页链接
#define IDGetDetailURL @"http://idaily-cdn.idai.ly/api/list/v3/news/zh-hans?page=1&ver=iphone&app_ver=20"

#endif
