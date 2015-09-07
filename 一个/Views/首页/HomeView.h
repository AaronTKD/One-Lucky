//
//  HomeView.h
//  一个
//
//  Created by Lucky on 15/8/27.
//  Copyright (c) 2015年 Lucky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"

@interface HomeView : UIView

@property (nonatomic) UIScrollView *homeScrollView;

@property (nonatomic) UILabel *strHpTitleLabel;//VOL
@property (nonatomic) UIImageView *strThumbnailUrlImageView;//缩略图
@property (nonatomic) UIImageView *strOriginalImgUrlImageView;//原图
@property (nonatomic) UILabel *strAuthorLabel;//作者
@property (nonatomic) UILabel *strContentLabel;//格言
@property (nonatomic) UILabel *dayLabel;//日期/日
@property (nonatomic) UILabel *monthLabel;//日期/月和年
@property (nonatomic) UILabel *strPnLabel;//点赞

@property (nonatomic) UIImageView *contBackImageView;

@property (nonatomic) HomeModel *homeModel;

@end
