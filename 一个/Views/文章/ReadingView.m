//
//  ReadingView.m
//  一个
//
//  Created by Lucky on 15/8/28.
//  Copyright (c) 2015年 Lucky. All rights reserved.
//

#import "ReadingView.h"
#import "CountStrHeight.h"
@interface ReadingView ()


@end

@implementation ReadingView

- (void)setReadingModel:(ReadingModel *)readingModel
{
    _readingModel = readingModel;
    
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self loadData];
    
}

- (void)loadData
{

    _dateLabel.text = _readingModel.strContMarketTime;
    self.titleLabel.text = self.readingModel.strContTitle;
    self.authorLabel.text = self.readingModel.strContAuthor;
    
    
    
    self.contentLabel.text = self.readingModel.strContent;
    _contentLabel.text = _readingModel.strContent;//////
    
    
    self.editerLabel.text = self.readingModel.strContAuthorIntroduce;
    self.weiboNameLabel.text = self.readingModel.sWbN;
    self.detailAuthorLabel.text = self.readingModel.sAuth;
    
    //日期
    self.dateLabel.frame = CGRectMake(10, 10, kWidth/2, 20);
    
    //文章标题
    self.titleLabel.frame = CGRectMake(10, 50, kWidth/2, 20);
    
    //作者
    self.authorLabel.frame = CGRectMake(10, 80, kWidth/2, 20);
    
    //文章内容
    CGFloat strContentHeight = [CountStrHeight countHeightForStr:self.readingModel.strContent FontType:[UIFont systemFontOfSize:15] RowWidth:kWidth-20];
    
    _contentLabel.lineBreakMode = NSLineBreakByCharWrapping;
    _contentLabel.numberOfLines = 0;
    _contentLabel.font = [UIFont systemFontOfSize:15];
    [_contentLabel sizeToFit];
    _contentLabel.backgroundColor = [UIColor clearColor];
    
    CGRect contentStrFrame = _contentLabel.frame;
    contentStrFrame = CGRectMake(10, 100, kWidth-20, strContentHeight);
    
    _contentLabel.frame = contentStrFrame;
    

    
    
    //编辑
    self.editerLabel.text = self.readingModel.strContAuthorIntroduce;
    self.editerLabel.frame = CGRectMake(10, 100+strContentHeight+20+30, kWidth-20, 20);
    
    //点赞按钮
    
    //分割线
    CGFloat lineHeight = 93+strContentHeight+50+49+30;
    self.lineImageView.frame = CGRectMake(10, lineHeight, kWidth-20, 2);
    
    //--------------------->显示有问题
    //作者名字
    NSMutableDictionary *dicWidth = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:18] forKey:NSFontAttributeName];
    CGSize authorNameSize = [self.readingModel.strAuthorN boundingRectWithSize:CGSizeMake(375, 0.0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dicWidth context:nil].size;
    self.authorNameLabel.frame = CGRectMake(10, lineHeight+30, authorNameSize.width, 20);
    //作者名字忘记赋值了
    self.authorNameLabel.text = self.readingModel.strAuthorN;

    
    //作者微博
    self.weiboNameLabel.frame = CGRectMake(authorNameSize.width+15, lineHeight+30, 150, 15);
    self.weiboNameLabel.text = self.readingModel.sWbN;

    
    //作者介绍
    CGFloat detailAuthorHeight = [CountStrHeight countHeightForStr:self.readingModel.sAuth FontType:[UIFont systemFontOfSize:14] RowWidth:kWidth-20];

    self.detailAuthorLabel.frame = CGRectMake(10, lineHeight+55, kWidth-20, detailAuthorHeight+10);
    self.detailAuthorLabel.font = [UIFont systemFontOfSize:14];
    _detailAuthorLabel.lineBreakMode = NSLineBreakByCharWrapping;
    _detailAuthorLabel.numberOfLines = 0;
    [_detailAuthorLabel sizeToFit];
    _detailAuthorLabel.backgroundColor = [UIColor clearColor];
    

    self.frame = CGRectMake(0, 0, kWidth, kHeight);
    _readingScrollView.contentSize = CGSizeMake(kWidth, lineHeight+270);


}




- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
//        self.scrollEnabled = YES;

        _readingScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _readingScrollView.scrollEnabled = YES;
        [self addSubview:_readingScrollView];
        
        
        //
        self.dateLabel = [[UILabel alloc] init];
        [_readingScrollView addSubview:self.dateLabel];
        
        //
        self.titleLabel = [[UILabel alloc] init];
        [_readingScrollView  addSubview:self.titleLabel];
        
        //
        self.authorLabel = [[UILabel alloc] init];
        [_readingScrollView  addSubview:self.authorLabel];
        
        //
        _contentLabel = [[UILabel alloc] init];
        [_readingScrollView  addSubview:_contentLabel];
        
        
        
        
        
        
        
        //
        self.editerLabel = [[UILabel alloc] init];
        [_readingScrollView  addSubview:self.editerLabel];
        
        //
        self.lineImageView = [[UIImageView alloc] init];
        self.lineImageView.image = [UIImage imageNamed:@"que_line"];
        
        [_readingScrollView  addSubview:self.lineImageView];
        
        
        
        //
        self.authorNameLabel = [[UILabel alloc] init];
        [_readingScrollView  addSubview:self.authorNameLabel];
        
        
        //
        self.weiboNameLabel = [[UILabel alloc] init];
        [_readingScrollView  addSubview:self.weiboNameLabel];
        
        
        //
        _detailAuthorLabel = [[UILabel alloc] init];
        [_readingScrollView  addSubview:_detailAuthorLabel];

        
    }
    
    return self;
}

@end
