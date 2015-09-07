//
//  ThingsView.h
//  一个
//
//  Created by Lucky on 15/8/31.
//  Copyright (c) 2015年 Lucky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThingsModel.h"

@interface ThingsView : UIView

@property (nonatomic) UIScrollView *thingsScrollView;

@property (nonatomic) UILabel *strTmLabel;
@property (nonatomic) UIImageView *strBuImageView;
@property (nonatomic) UILabel *strTtLabel;
@property (nonatomic) UILabel *strTcLabel;

@property (nonatomic) ThingsModel *thingsModel;
@end
