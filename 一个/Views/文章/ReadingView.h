//
//  ReadingView.h
//  一个
//
//  Created by Lucky on 15/8/28.
//  Copyright (c) 2015年 Lucky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReadingModel.h"

/*
 UILabel *_dateLabel;
 UILabel *_titleLabel;
 UILabel *_authorLabel;
 
 UITextView *contentTextView;
 */
@interface ReadingView : UIView

@property (nonatomic) UIScrollView *readingScrollView;


@property (nonatomic) UILabel *dateLabel;
@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) UILabel *authorLabel;


@property (nonatomic) UILabel *contentLabel;


@property (nonatomic) UILabel *editerLabel;

@property (nonatomic) UIButton *loveButton;

///////////////////////////////////////////

@property (nonatomic) UIImageView *lineImageView;

@property (nonatomic) UILabel *authorNameLabel;
@property (nonatomic) UILabel *weiboNameLabel;

@property (nonatomic) UILabel *detailAuthorLabel;


@property (nonatomic) ReadingModel *readingModel;


@end
