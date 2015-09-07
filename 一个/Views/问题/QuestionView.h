//
//  QuestionView.h
//  一个
//
//  Created by Lucky on 15/8/31.
//  Copyright (c) 2015年 Lucky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionModel.h"
@interface QuestionView : UIView

@property (nonatomic) UIScrollView *questionScrollView;

@property (nonatomic) UILabel *dateLabel;//日期
@property (nonatomic) UIImageView *questionImageView;//问题图标

@property (nonatomic) UILabel *questionLabel;//问题
@property (nonatomic) UILabel *detailQuestionLabel;//问题详细描述

@property (nonatomic) UIImageView *lineImageView;//分割线

@property (nonatomic) UIImageView *answerImageView;//回答图标

@property (nonatomic) UILabel *answerLabel;//回答的人
@property (nonatomic) UILabel *detailAnswerLabel;//详细答案

@property (nonatomic) UILabel *editerLabel;//编辑


@property (nonatomic) QuestionModel *questionModel;//model
@end
