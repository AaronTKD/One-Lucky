//
//  HomeModel.h
//  一个
//
//  Created by Lucky on 15/8/31.
//  Copyright (c) 2015年 Lucky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeModel : NSObject

@property (nonatomic) NSString *strHpId;//期刊号
//@property (nonatomic) NSString *strMarketTime;//时间：2015-08-31

@property (nonatomic) NSString *day;
@property (nonatomic) NSString *monthAndYear;

@property (nonatomic) NSString *strHpTitle;//VOL.1059
@property (nonatomic) NSString *strAuthor;//纸飞机&王黑白TrixieWang 作品
@property (nonatomic) NSString *strContent;//格言

@property (nonatomic) NSString *strThumbnailUrl;//缩略图
@property (nonatomic) NSString *strOriginalImgUrl;//手指点击原图
@property (nonatomic) NSString *strPn;//点赞数

@end
