//
//  HomeView.m
//  一个
//
//  Created by Lucky on 15/8/27.
//  Copyright (c) 2015年 Lucky. All rights reserved.
//

#import "HomeView.h"
#import "CountStrHeight.h"
#import "UIImageView+WebCache.h"
@interface HomeView ()

@end

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

@implementation HomeView

- (void)setHomeModel:(HomeModel *)homeModel
{
    _homeModel = homeModel;
    
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    /*
     @property (nonatomic) UILabel *strHpTitleLabel;//VOL
     @property (nonatomic) UIImageView *strThumbnailUrlImageView;//缩略图
     @property (nonatomic) UIImageView *strOriginalImgUrlImageView;//原图
     @property (nonatomic) UILabel *strAuthorStr;//作者
     @property (nonatomic) UILabel *strContentStr;//格言
     @property (nonatomic) UILabel *dayLabel;//日期/日
     @property (nonatomic) UILabel *monthLabel;//日期/月和年
     @property (nonatomic) UILabel *strPnLabel;//点赞
     */
    
    _strHpTitleLabel.text = _homeModel.strHpTitle;
    [_strThumbnailUrlImageView sd_setImageWithURL:[NSURL URLWithString:_homeModel.strThumbnailUrl]];
    
    NSString *authorStr = [_homeModel.strAuthor stringByReplacingOccurrencesOfString:@"&" withString:@"\r\n"];
    _strAuthorLabel.text = authorStr;
    _strContentLabel.text = _homeModel.strContent;
    _dayLabel.text = _homeModel.day;
    _monthLabel.text = _homeModel.monthAndYear;
    _strPnLabel.text = _homeModel.strPn;
    
    
    //VOL
    _strHpTitleLabel.frame = CGRectMake(10, 10, kWidth/2, 12);
    _strHpTitleLabel.font = [UIFont systemFontOfSize:12];
    _strHpTitleLabel.backgroundColor = [UIColor clearColor];
    _strHpTitleLabel.textColor = [UIColor grayColor];
    
    //缩略图
    _strThumbnailUrlImageView.frame = CGRectMake(10, 49, kWidth-20, (kWidth-20)*0.68);
    
    CGFloat imageHeight = 49 + (kWidth-20)*0.68 +20;
    
    
    //画名和作者
    
    NSMutableDictionary *dicWidth = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:14] forKey:NSFontAttributeName];
    CGSize authorSize = [_strAuthorLabel.text boundingRectWithSize:CGSizeMake(kWidth, 0.0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dicWidth context:nil].size;
    
    
    CGFloat authorLabelHeight = [CountStrHeight countHeightForStr:_strAuthorLabel.text FontType:[UIFont systemFontOfSize:14] RowWidth:kWidth-20];
    _strAuthorLabel.textAlignment = NSTextAlignmentRight;
    _strAuthorLabel.lineBreakMode = NSLineBreakByCharWrapping;
    _strAuthorLabel.numberOfLines = 0;
    _strAuthorLabel.font = [UIFont systemFontOfSize:14];
    _strAuthorLabel.backgroundColor = [UIColor clearColor];
    _strAuthorLabel.textColor = [UIColor grayColor];
    _strAuthorLabel.frame = CGRectMake(kWidth-10-authorSize.width, imageHeight, authorSize.width, authorLabelHeight);
    [_strAuthorLabel sizeToFit];
    
    
    //内容
    CGFloat contentHeight = imageHeight + authorLabelHeight + 20;
    CGFloat contentLabelHeight = [CountStrHeight countHeightForStr:_strContentLabel.text FontType:[UIFont systemFontOfSize:14] RowWidth:kWidth-65];
    _strContentLabel.frame = CGRectMake(75, contentHeight, kWidth-85, contentLabelHeight);
    _strContentLabel.backgroundColor = [UIColor clearColor];
//    _strContentLabel.textColor = [UIColor whiteColor];
    _strContentLabel.font = [UIFont systemFontOfSize:14];
    _strContentLabel.lineBreakMode = NSLineBreakByCharWrapping;
    _strContentLabel.numberOfLines = 0;
    [_strContentLabel sizeToFit];
    
    //内容背景
    _contBackImageView.frame = CGRectMake(65, contentHeight-5, kWidth-85+5, contentLabelHeight+10);
    
    //日
    _dayLabel.frame = CGRectMake(10, contentHeight, 45, 45);
    _dayLabel.backgroundColor = [UIColor clearColor];
    _dayLabel.font = [UIFont systemFontOfSize:35];
    
    //月和年
    _monthLabel.frame = CGRectMake(10, contentHeight+45, 85, 20);
    _monthLabel.font = [UIFont systemFontOfSize:14];
    _monthLabel.backgroundColor = [UIColor clearColor];
    _monthLabel.textColor = [UIColor grayColor];
    
    
    
    
    
    
    self.frame = CGRectMake(0, 0, kWidth, kHeight);
    
    _homeScrollView.contentSize = CGSizeMake(kWidth, contentHeight+contentLabelHeight + 150);
    
}



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _homeScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        [self addSubview:_homeScrollView];
        
        _strHpTitleLabel = [[UILabel alloc] init];
        [_homeScrollView addSubview:_strHpTitleLabel];
        
        _strThumbnailUrlImageView = [[UIImageView alloc] init];
        [_homeScrollView addSubview:_strThumbnailUrlImageView];
        
        //    _strOriginalImgUrlImageView = [[UIImageView alloc] init];
        //    [self addSubview:_strOriginalImgUrlImageView];
        
        _strAuthorLabel = [[UILabel alloc] init];
        [_homeScrollView addSubview:_strAuthorLabel];
        
        
        _contBackImageView = [[UIImageView alloc] init];
        _contBackImageView.image = [UIImage imageNamed:@"contBack@2x"];
        [_homeScrollView addSubview:_contBackImageView];
        
        _strContentLabel = [[UILabel alloc] init];
        [_homeScrollView addSubview:_strContentLabel];
        
        _dayLabel = [[UILabel alloc] init];
        [_homeScrollView addSubview:_dayLabel];
        
        _monthLabel = [[UILabel alloc] init];
        [_homeScrollView addSubview:_monthLabel];
        
        _strPnLabel = [[UILabel alloc] init];
        [_homeScrollView addSubview:_strPnLabel];
        
       
        
    }
    
    return self;
}



@end
