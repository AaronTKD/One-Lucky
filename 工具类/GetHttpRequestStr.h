//
//  GetHttpRequestStr.h
//  一个
//
//  Created by Lucky on 15/9/4.
//  Copyright (c) 2015年 Lucky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetHttpRequestStr : NSObject

+ (NSString *)getHomeRequestStr:(NSInteger)currentIndex;
+ (NSString *)getReadingRequestStr:(NSInteger)currentIndex;
+ (NSString *)getQuestionRequestStr:(NSInteger)currentIndex;
+ (NSString *)getThingsRequestStr:(NSInteger)currentIndex;

@end
