//
//  ReadingModel.h
//  一个
//
//  Created by Lucky on 15/8/31.
//  Copyright (c) 2015年 Lucky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReadingModel : NSObject

@property (nonatomic) NSString *strContMarketTime;//日期
@property (nonatomic) NSString *strContTitle;//文章标题
@property (nonatomic) NSString *strContAuthor;//作者
@property (nonatomic) NSString *strContent;//文章

@property (nonatomic) NSString *strContAuthorIntroduce;//责任编辑
@property (nonatomic) NSString *strPraiseNumber;//点赞数

@property (nonatomic) NSString *strAuthorN;
@property (nonatomic) NSString *sWbN;//微博名字
@property (nonatomic) NSString *sAuth;//作家介绍
@end
