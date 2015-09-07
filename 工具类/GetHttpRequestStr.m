//
//  GetHttpRequestStr.m
//  一个
//
//  Created by Lucky on 15/9/4.
//  Copyright (c) 2015年 Lucky. All rights reserved.
//

#import "GetHttpRequestStr.h"

@implementation GetHttpRequestStr

+ (NSString *)getCurrentDate
{
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    
    NSString *currentDate = [dateformatter stringFromDate:senddate];
    
    return currentDate;
}

//http://bea.wufazhuce.com/OneForWeb/one/getHp_N?strDate=2015-09-04&strRow=1
+ (NSString *)getHomeRequestStr:(NSInteger)currentIndex
{
    NSString *currentDate = [GetHttpRequestStr getCurrentDate];
    currentIndex += 1;
    
    NSString *requestStr = [NSString stringWithFormat:@"http://bea.wufazhuce.com/OneForWeb/one/getHp_N?strDate=%@&strRow=%ld",currentDate,(long)currentIndex];
    
    return requestStr;
    
}

//http://bea.wufazhuce.com/OneForWeb/one/getC_N?strDate=2015-09-04&strRow=1&strMS=1
+ (NSString *)getReadingRequestStr:(NSInteger)currentIndex
{
    NSString *currentDate = [GetHttpRequestStr getCurrentDate];
    currentIndex += 1;
    
    NSString *requestStr = [NSString stringWithFormat:@"http://bea.wufazhuce.com/OneForWeb/one/getC_N?strDate=%@&strRow=%ld&strMS=1",currentDate,(long)currentIndex];
    
    return requestStr;
}

//http://bea.wufazhuce.com/OneForWeb/one/getQ_N?strDate=2015-09-04&strUi=249216&strRow=1
+ (NSString *)getQuestionRequestStr:(NSInteger)currentIndex
{
    NSString *currentDate = [GetHttpRequestStr getCurrentDate];
    currentIndex += 1;
    
    NSString *requestStr = [NSString stringWithFormat:@"http://bea.wufazhuce.com/OneForWeb/one/getQ_N?strDate=%@&strUi=249216&strRow=%ld",currentDate,(long)currentIndex];
    
    return requestStr;
}

//http://bea.wufazhuce.com/OneForWeb/one/o_f?strDate=2015-09-04&strRow=1
+ (NSString *)getThingsRequestStr:(NSInteger)currentIndex
{
    NSString *currentDate = [GetHttpRequestStr getCurrentDate];
    currentIndex += 1;
    
    NSString *requestStr = [NSString stringWithFormat:@"http://bea.wufazhuce.com/OneForWeb/one/o_f?strDate=%@&strRow=%ld",currentDate,(long)currentIndex];
    
    return requestStr;
}
@end
