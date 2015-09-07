//
//  QuestionModel.h
//  一个
//
//  Created by Lucky on 15/8/31.
//  Copyright (c) 2015年 Lucky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionModel : NSObject

@property (nonatomic) NSString *strQuestionMarketTime;
@property (nonatomic) NSString *strQuestionTitle;//提问title
@property (nonatomic) NSString *strQuestionContent;//提问描述

@property (nonatomic) NSString *strAnswerTitle;//回答title
@property (nonatomic) NSString *strAnswerContent;//回答描述

@property (nonatomic) NSString *sEditor;//编辑

@property (nonatomic) NSString *strPraiseNumber;//点赞数

@end
