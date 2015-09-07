//
//  QuestionView.m
//  一个
//
//  Created by Lucky on 15/8/31.
//  Copyright (c) 2015年 Lucky. All rights reserved.
//

#import "QuestionView.h"
#import "CountStrHeight.h"

@implementation QuestionView

- (void)setQuestionModel:(QuestionModel *)questionModel
{
    _questionModel = questionModel;
   
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //日期
    self.dateLabel.text = self.questionModel.strQuestionMarketTime;
    self.dateLabel.frame = CGRectMake(10, 10, kWidth/2, 20);
    
    //问题图标
    _questionImageView.frame = CGRectMake(10, 55, 44, 44);
    
    
    //问题
    self.questionLabel.text = self.questionModel.strQuestionTitle;
    CGFloat questionStrHeight = [CountStrHeight countHeightForStr:_questionModel.strQuestionTitle FontType:[UIFont systemFontOfSize:17] RowWidth:kWidth-20];
    _questionLabel.font = [UIFont systemFontOfSize:17];
    _questionLabel.backgroundColor = [UIColor clearColor];
    _questionLabel.lineBreakMode = NSLineBreakByCharWrapping;
    _questionLabel.numberOfLines = 0;
    [_questionLabel sizeToFit];
    _questionLabel.frame = CGRectMake(60, 55, kWidth-70, questionStrHeight);
    
    CGFloat questionTextHeight = 55 + questionStrHeight +25;
    
    //问题详细描述
    self.detailQuestionLabel.text = self.questionModel.strQuestionContent;
    
    CGFloat detailQuestionTextHeight = [CountStrHeight countHeightForStr:_questionModel.strQuestionContent FontType:[UIFont systemFontOfSize:17] RowWidth:kWidth-20];
    _detailQuestionLabel.font = [UIFont systemFontOfSize:17];
    _detailQuestionLabel.lineBreakMode = NSLineBreakByCharWrapping;
    _detailQuestionLabel.numberOfLines = 0;
    [_detailQuestionLabel sizeToFit];
    _detailQuestionLabel.frame = CGRectMake(10, questionTextHeight, kWidth-20, detailQuestionTextHeight);
    

    
    //分割线
    CGFloat lineHeight = questionTextHeight + detailQuestionTextHeight + 25;
    _lineImageView.frame = CGRectMake(10, lineHeight, kWidth-20, 2);
    
    
    //回答图标
    _answerImageView.frame = CGRectMake(10, lineHeight + 27, 44, 44);
    
    //回答的人
    self.answerLabel.text = self.questionModel.strAnswerTitle;
    
    CGFloat answerTextHeight = [CountStrHeight countHeightForStr:_questionModel.strAnswerTitle FontType:[UIFont systemFontOfSize:17] RowWidth:kWidth-20] +20;
    
    _answerLabel.font = [UIFont systemFontOfSize:17];
    _answerLabel.lineBreakMode = NSLineBreakByCharWrapping;
    _answerLabel.numberOfLines = 0;
    [_answerLabel sizeToFit];
    _answerLabel.frame = CGRectMake(60, lineHeight+27, kWidth-70, answerTextHeight);
    

    
    //详细答案
    CGFloat detailHeight = lineHeight + 2 + answerTextHeight +25;
    
    CGFloat detailAnswerTextHeight = [CountStrHeight countHeightForStr:_questionModel.strAnswerContent FontType:[UIFont systemFontOfSize:17] RowWidth:kWidth-20];
    
    _detailAnswerLabel.font = [UIFont systemFontOfSize:17];
    _detailAnswerLabel.lineBreakMode = NSLineBreakByCharWrapping;
    _detailAnswerLabel.numberOfLines = 0;
    [_detailAnswerLabel sizeToFit];
    self.detailAnswerLabel.text = self.questionModel.strAnswerContent;
    _detailAnswerLabel.frame = CGRectMake(10, detailHeight, kWidth-20, detailAnswerTextHeight+50);
    
    //编辑
    self.editerLabel.text = self.questionModel.sEditor;
    
    CGFloat editerHeight = detailHeight + detailAnswerTextHeight + 50;
    
    _editerLabel.frame = CGRectMake(10, editerHeight, kWidth/2, 25);
    
    
    self.frame = CGRectMake(0, 0, kWidth, kHeight);
    _questionScrollView.contentSize = CGSizeMake(kWidth, editerHeight +200);
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _questionScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        [self addSubview:_questionScrollView];
        
        self.dateLabel = [[UILabel alloc] init];
        [_questionScrollView addSubview:self.dateLabel];
        
        self.questionImageView = [[UIImageView alloc] init];
        _questionImageView.image = [UIImage imageNamed:@"que_img"];
        [_questionScrollView addSubview:self.questionImageView];
        
        self.questionLabel = [[UILabel alloc] init];
        [_questionScrollView addSubview:self.questionLabel];
        
        self.detailQuestionLabel = [[UILabel alloc] init];
        [_questionScrollView addSubview:self.detailQuestionLabel];
        
        self.lineImageView = [[UIImageView alloc] init];
        _lineImageView.image = [UIImage imageNamed:@"que_line"];
        [_questionScrollView addSubview:self.lineImageView];
        
        self.answerImageView = [[UIImageView alloc] init];
        _answerImageView.image = [UIImage imageNamed:@"ans_img"];
        [_questionScrollView addSubview:self.answerImageView];
        
        self.answerLabel= [[UILabel alloc] init];
        [_questionScrollView addSubview:self.answerLabel];
        
        self.detailAnswerLabel = [[UILabel alloc] init];
        [_questionScrollView addSubview:self.detailAnswerLabel];
        
        self.editerLabel = [[UILabel alloc] init];
        [_questionScrollView addSubview:self.editerLabel];
        
        
        
        
    }
    return self;
}
@end
