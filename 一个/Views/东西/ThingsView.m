//
//  ThingsView.m
//  一个
//
//  Created by Lucky on 15/8/31.
//  Copyright (c) 2015年 Lucky. All rights reserved.
//

#import "ThingsView.h"
#import "UIImageView+WebCache.h"
#import "CountStrHeight.h"

@implementation ThingsView

- (void)setThingsModel:(ThingsModel *)thingsModel
{

    _thingsModel = thingsModel;
    
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
     [super layoutSubviews];
    
    //日期
    _strTmLabel.text = _thingsModel.strTm;
    _strTmLabel.frame = CGRectMake(10, 10, kWidth/2, 20);
    
    //图片
    [_strBuImageView sd_setImageWithURL:[NSURL URLWithString:_thingsModel.strBu]];
    _strBuImageView.frame = CGRectMake(10, 55, kWidth-20, kWidth-20);
    
    CGFloat imageHeight = 55 + kWidth-20 + 25;
    
    //标题
    _strTtLabel.text = _thingsModel.strTt;
    _strTtLabel.backgroundColor = [UIColor clearColor];
    _strTtLabel.lineBreakMode = NSLineBreakByCharWrapping;
    _strTtLabel.numberOfLines = 0;
    [_strTtLabel sizeToFit];
    _strTtLabel.font = [UIFont systemFontOfSize:20];
    CGFloat ttTextHeight = [CountStrHeight countHeightForStr:_thingsModel.strTt FontType:[UIFont systemFontOfSize:20] RowWidth:kWidth/3*2];
    _strTtLabel.frame = CGRectMake(10, imageHeight, kWidth/3*2, ttTextHeight);
    
    
    
    //neir
    CGFloat tcHeight = imageHeight + ttTextHeight + 25;
    
    CGFloat tcTextHeight = [CountStrHeight countHeightForStr:_thingsModel.strTc FontType:[UIFont systemFontOfSize:17] RowWidth:kWidth-20];
    
    _strTcLabel.text = _thingsModel.strTc;
    _strTcLabel.backgroundColor = [UIColor clearColor];
    _strTcLabel.lineBreakMode = NSLineBreakByCharWrapping;
    _strTcLabel.numberOfLines = 0;
    [_strTcLabel sizeToFit];
    
    _strTcLabel.frame = CGRectMake(10, tcHeight, kWidth-20, tcTextHeight);
    _strTcLabel.font = [UIFont systemFontOfSize:17];
    
    
    CGFloat fullHeight = tcHeight + tcTextHeight + 140;
    
    self.frame = CGRectMake(0, 0, kWidth, kHeight);
    _thingsScrollView.contentSize = CGSizeMake(kWidth, fullHeight);

}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _thingsScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        [self addSubview:_thingsScrollView];
        
        _strTmLabel = [[UILabel alloc] init];
        [_thingsScrollView addSubview:_strTmLabel];
        
        _strBuImageView = [[UIImageView alloc] init];
        [_thingsScrollView addSubview:_strBuImageView];
        
        _strTtLabel = [[UILabel alloc] init];
        [_thingsScrollView addSubview:_strTtLabel];
        
        _strTcLabel = [[UILabel alloc] init];
        [_thingsScrollView addSubview:_strTcLabel];
        
        
    }
    return self;
}

@end
