//
//  IDNewModel.h
//  iDaily
//
//  Created by Yin Yi on 15/9/16.
//  Copyright (c) 2015年 Yin Yi. All rights reserved.
//  首页的新闻界面模型
/*
 {
 "guid": 38721,
 "type": 1,
 "title": "September 15, 2015",
 "cover_thumb": "http://pic.yupoo.com/fotomag/EXhRxIcv/sfXph.jpg",
 "cover_landscape": "http://pic.yupoo.com/fotomag/EXhRyuuy/L58rV.jpg",
 "cover_landscape_hd": "http://pic.yupoo.com/fotomag/EXhRz3GL/D9q4B.jpg",
 "pubdate": "September 15, 2015",
 "archive_timestamp": 1442246400,
 "pubdate_timestamp": 1442318340,
 "lastupdate_timestamp": 1442322305,
 "author": "",
 "source": "",
 "link_share": "http://m.idai.ly/se/1c1R2u",
 "link_wechat": "http://m.idai.ly/se/1c1R2u",
 "title_wechat_tml": "September 15, 2015 | iDaily 每日全球最佳新闻图片",
 "latitude": 83.0262188534,
 "longitude": 127.96875,
 "geo_span": 0.15,
 "content": "美国宇航员 Scott Kelly 从国际空间站拍摄的地球图像，左下角为水星和月球。51岁的 Scott Kelly 将在空间站驻留342天，时间跨度约为普通驻留任务的两倍。此次任务是为了研究长期失重环境对人体的影响，以此为载人火星项目做准备。摄影师：Scott Kelly",
 "news_count": 6
 },

 link_website	:	http://c.admaster.com.cn/c/a58236,b686224,c1858,i0,m101,h#inapp
 link_website_inside	:	http://c.admaster.com.cn/c/a58236,b686224,c1858,i0,m101,h#inapp
 link_share	:	http://m.idai.ly/se/ab74UR
 link_wechat	:	http://m.idai.ly/se/ab74UR
 website_title_inside	:	点击官网
 enable_wechat	:	1
 location_limit	:	3
 content	:	全新精品店是亚太区第一家完整延续 CÉLINE 伦敦旗舰店设计理念的精品店，采用精细工艺和原石材质对内部空间进行翻新装饰，经典与摩登融合统一。
 
	track_urls		[1]
 
 0	:	http://v.admaster.com.cn/i/a58236,b686224,c1858,i0,m202,h
 
	coordinate_sets		[20]
 
	entry_imgs		[0]
 
	ui_sets		{1}
 
 photo_grid_auto_play	:	1
 
 album_count	:	3
 
	album		[3]
 
	0		{29}
 
 guid	:	36312
 
 type	:	1
 
 cat	:	16
 
 title	:	上海IFC精品店开幕
 
 cover_thumb	:	http://pic.yupoo.com/fotomag/EQfx2tn0/3c3oA.jpg
 
 cover_landscape	:	http://pic.yupoo.com/fotomag/EQfx7Bzy/OAbRp.jpg
 
 cover_landscape_hd	:	http://pic.yupoo.com/fotomag/EQfxpTfX/nNgRb.jpg
 pubdate	:	July 31, 2015
 archive_timestamp	:	1438272000
 pubdate_timestamp	:	1438331340
 lastupdate_timestamp	:	1439350712
 author	:
 source	:
 link_website	:	http://c.admaster.com.cn/c/a58236,b686224,c1858,i0,m101,h#inapp
 link_website_inside	:	http://c.admaster.com.cn/c/a58236,b686224,c1858,i0,m101,h#inapp
 link_share	:	http://m.idai.ly/se/9bfJ8C
 link_wechat	:	http://m.idai.ly/se/9bfJ8C
 website_title_inside	:	点击官网
 has_caption	:	1
 has_news	:	1
 has_store	:	1
 is_banner	:	1
 enable_wechat	:	1
 location_limit	:	3
 summary	:	第四屏2
 content	:	全新精品店是亚太区第一家完整延续 CÉLINE 伦敦旗舰店设计理念的精品店，采用精细工艺和原石材质对内部空间进行翻新装饰，经典与摩登融合统一。
	coordinate_sets		[20]
	entry_imgs		[0]
 news_count	: 21
 */
 

#import "BaseModel.h"

@interface IDNewModel : BaseModel
/**
 *  编号
 */
@property (nonatomic,strong) NSNumber *guid;
/**
 *  类型 3为新闻 5为广告
 */
@property (nonatomic,strong) NSNumber *type;
/**
 *  标题
 */
@property (nonatomic,copy) NSString *title;
/**
 *  cat
 */
@property (nonatomic,copy) NSString *cat;
/**
 *  大图片
 */
@property (nonatomic,copy) NSString *cover_landscape_hd;
/**
 *  中图片
 */
@property (nonatomic,copy) NSString *cover_landscape;
/**
 *  小图片
 */
@property (nonatomic,copy) NSString *cover_thumb;
/**
 *  日期
 */
@property (nonatomic,copy) NSString *pubdate;
@property (nonatomic,copy) NSString *archive_timestamp;
@property (nonatomic,copy) NSString *pubdate_timestamp;
@property (nonatomic,copy) NSString *lastupdate_timestamp;
/**
 *  来源
 */
@property (nonatomic,copy) NSString *source;
/**
 *  来源链接
 */
@property (nonatomic,copy) NSString *link_source;
/**
 *  分享链接
 */
@property (nonatomic,copy) NSString *link_share;
/**
 *  微信分享
 */
@property (nonatomic,copy) NSString *link_wechat;
/**
 *  内容
 */
@property (nonatomic,copy) NSString *content;
/**
 *  纬度
 */
@property (nonatomic,strong) NSNumber *latitude;
/**
 *  经度
 */
@property (nonatomic,strong) NSNumber *longitude;
/**
 *  跨度
 */
@property (nonatomic,strong) NSNumber *geo_span;
/**
 *  新闻条数
 */
@property (nonatomic,strong) NSNumber *news_count;
/**
 *   link_website
 */
@property (nonatomic,copy) NSString *link_website;
/**
 *  website_title_inside
 */
@property (nonatomic,copy) NSString *website_title_inside;
/**
 *  坐标数据
 */
@property (nonatomic,strong) NSArray *coordinate_sets;
/**
 *  album
 */
@property (nonatomic,strong) NSArray *album;
/**
 *  子单元格个数
 */


@property (nonatomic,strong) NSNumber *album_count;

@end
