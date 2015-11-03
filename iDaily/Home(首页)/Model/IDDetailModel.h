//
//  IDDetailModel.h
//  iDaily
//
//  Created by Yin Yi on 15/9/16.
//  Copyright (c) 2015年 Yin Yi. All rights reserved.
//  新闻地图列表模型
/*
 {
 "guid": 15330,
 "type": 5,
 "cat": "12",
 "title": "Céline 北京新光天地精品店",
 "pubdate": "February 13, 2014",
 "archive_timestamp": 1392220800,
 "pubdate_timestamp": 1392275280,
 "lastupdate_timestamp": 1425960475,
 "author": "",
 "source": "北京新光天地",
 "link_share": "http://idai.ly",
 "has_caption": 1,
 "has_news": 1,
 "latitude": 39.910855,
 "longitude": 116.479656,
 "geo_span": 0.0015,
 "summary": "",
 "content": "店铺地址：北京市建国路87号新光天地一层M1021号商铺D4013 / 4053 号商铺<br />\r\n垂询电话：010-57382610",
 "coordinate_sets": [],
 "entry_imgs": []
 }
 */
/*
 {
 "guid": 38629,
 "type": 3,
 "cat": "4",
 "title": "栃木茨城降罕见暴雨 5万3千人受避难指示",
 "pubdate": "September 13, 2015",
 "archive_timestamp": 1442073600,
 "pubdate_timestamp": 1442153820,
 "lastupdate_timestamp": 1442153847,
 "author": "",
 "source": "朝日新闻中文网",
 "link_source": "http://asahichinese.com/article/society/AJ201509100045",
 "link_share": "http://idai.ly",
 "has_caption": 1,
 "has_news": 1,
 "summary": "",
 "content": "受温带低气压(转自18号台风)影响，栃木、茨城两县降罕见暴雨。气象厅10日，向两县发布了大雨特别预警。<br />\r\n<br />\r\n枥木县鹿沼市除了临河的2栋住宅被冲走，还发生了泥石流导致1人失踪，救援行动仍在继续。日光市也发生了山体滑坡，被卷入其中的2名男性有1人昏迷不醒、情况危急。茨城县常总市和古河市发生河川泛滥和决堤，茨城县已向自卫队发出救灾派遣请求。<br />\r\n<br />\r\n据截至10日上午8点半的总务省消防厅消息汇总，已向茨城、栃木和千叶县的约5万3千人发出避难指示，向全国范围内约42万5千户、约92万6千人发出避难劝告。之后，受害范围则继续扩大。<div class=\"quote\">\n<div class=\"arrow\"></div>\n<p>From: <a href=\"http://asahichinese.com/article/society/AJ201509100045#inapp\">http://asahichinese.com/article/society/AJ201509100045</a></p></div>",
 "coordinate_sets": [],
 "entry_imgs": []
 }
 */

#import "BaseModel.h"




@interface IDDetailModel : BaseModel
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
 *  日期
 */
@property (nonatomic,copy) NSString *pubdate;
@property (nonatomic,strong) NSNumber *archive_timestamp;
@property (nonatomic,strong) NSNumber *pubdate_timestamp;
@property (nonatomic,strong) NSNumber *lastupdate_timestamp;
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



@end
