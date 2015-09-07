//
//  ChangeDateType.m
//  一个
//
//  Created by Lucky on 15/9/1.
//  Copyright (c) 2015年 Lucky. All rights reserved.
//

#import "ChangeDateType.h"

@implementation ChangeDateType

+ (NSArray *)changeToHomeDateType:(NSString *)dateStr
{
    NSArray *array = [dateStr componentsSeparatedByString:@"-"];
    
    NSString *yearKey = array[0];
    NSString *monthKey = array[1];
    NSString *dayKey = array[2];
    
    NSArray *monthKeysArray = @[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12"];
    NSArray *monthObjectsArray = @[@"Jan",@"Feb",@"Mar",@"Apr",@"May",@"Jun",@"Jul",@"Aug",@"Sept",@"October",@"Nov",@"Dec"];
    
    NSDictionary *monthDic = [[NSDictionary alloc] initWithObjects:monthObjectsArray forKeys:monthKeysArray];
    
    
    NSString *month = [monthDic objectForKey:monthKey];
    NSString *monthAndYear = [NSString stringWithFormat:@"%@,%@",month,yearKey];
    
    NSArray *fullDateArray = @[dayKey,monthAndYear];
    return fullDateArray;
}

+ (NSString *)changeToNoneHomeDateType:(NSString *)dateStr
{
    NSArray *array = [dateStr componentsSeparatedByString:@"-"];
    
    NSString *yearKey = array[0];
    NSString *monthKey = array[1];
    NSString *dayKey = array[2];
    
    NSArray *monthKeysArray = @[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12"];
    NSArray *monthObjectsArray = @[@"January",@"February",@"March",@"April",@"May",@"June",@"July",@"August",@"September",@"October",@"November",@"December"];
    
    NSDictionary *monthDic = [[NSDictionary alloc] initWithObjects:monthObjectsArray forKeys:monthKeysArray];
    
    
    NSString *month = [monthDic objectForKey:monthKey];
    
    NSString *fullDateStr = [NSString stringWithFormat:@"%@,%@,%@",month,dayKey,yearKey];
    
    return fullDateStr;
}

@end
