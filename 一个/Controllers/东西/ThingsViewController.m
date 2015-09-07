//
//  ThingsViewController.m
//  一个
//
//  Created by Lucky on 15/8/26.
//  Copyright (c) 2015年 Lucky. All rights reserved.
//

#import "ThingsViewController.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "ThingsModel.h"
#import "ThingsView.h"
#import "iCarousel.h"


#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

@interface ThingsViewController ()<iCarouselDataSource, iCarouselDelegate, UIActionSheetDelegate>
{
    BOOL flag;     // 导航栏按钮点击
    
    iCarousel *_carousel;
    
    // 当前一共有多少篇文章，默认为3篇
    NSInteger numberOfItems;
    
    // 保存当前查看过的数据
    NSMutableDictionary *readItems;
    
    // 最后展示的 item 的下标
    NSInteger lastConfigureViewForItemIndex;
    // 当前是否正在右拉刷新标记
    BOOL isRefreshing;
}


@end

@implementation ThingsViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {

        
        UIImage *deselectedImage = [[UIImage imageNamed:@"tabbar_item_thing"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *selectedImage = [[UIImage imageNamed:@"tabbar_item_thing_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        // 底部导航item
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:@"东西" image:nil tag:0];
        tabBarItem.image = deselectedImage;
        tabBarItem.selectedImage = selectedImage;
        self.tabBarItem = tabBarItem;
        
        //顶部导航titleView
        UIImageView *titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth-10, 0, 20, 20)];
        titleImageView.image = [UIImage imageNamed:@"navLogo@2x.png"];
        
        titleImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        self.navigationItem.titleView = titleImageView;
    }
    
    return self;
}


#pragma mark -
#pragma mark View lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    
    numberOfItems = 0;
    readItems = [[NSMutableDictionary alloc] init];
    lastConfigureViewForItemIndex = 0;
    isRefreshing = NO;
    
    [self _createCarousel];
    
    [self requestHomeContentAtIndex:0];


    
}


- (void)_createCarousel {
    
    _carousel = [[iCarousel alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_carousel];
    _carousel.type = iCarouselTypeLinear;
    _carousel.delegate = self;
    _carousel.dataSource = self;
}


#pragma mark - iCarouselDataSource

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    
    //    return numberOfItems;
    return readItems.allKeys.count;
}


- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(nullable UIView *)view {
    
    ThingsView *_thingsView = nil;
    
    //create new view if no view is available for recycling
    if (view == nil) {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0,kWidth, kHeight)];
        _thingsView = [[ThingsView alloc] initWithFrame:view.bounds];
        [view addSubview:_thingsView];
    } else {
        _thingsView = (ThingsView *)view.subviews[0];
    }
    
    _thingsView.thingsModel = readItems[[@(index) stringValue]];
    
    
    return view;
    
    
}



- (void)insertItem
{
    //    NSInteger index = MAX(0, self.carousel.currentItemIndex);
#warning change 加在后面
    NSInteger index = MAX(0, _carousel.currentItemIndex)+1;
    
    [self requestHomeContentAtIndex:index];
    //    [items insertObject:@(_carousel.numberOfItems) atIndex:(NSUInteger)index];
    [_carousel insertItemAtIndex:index animated:YES];
}

#pragma mark -
- (void)carouselDidScroll:(iCarousel *)carousel {
    
    NSLog(@"%f",carousel.scrollOffset);
    if (carousel.scrollOffset >= 0.35) {
        
        [self insertItem];
        
    }
    
}


#pragma mark - Network Requests

// 右拉刷新
- (void)refreshing {
    if (readItems.allKeys.count > 0) {// 避免第一个还未加载的时候右拉刷新更新数据
        //        [self showHUDWithText:@""];
        isRefreshing = YES;
        [self requestHomeContentAtIndex:0];
    }
}

- (void)requestHomeContentAtIndex:(NSInteger)index {
    NSString *requestStr = [GetHttpRequestStr getThingsRequestStr:index];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:requestStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *entTgDic = [responseObject objectForKey:@"entTg"];
        
        ThingsModel *model = [[ThingsModel alloc] init];
        
        
        
        //时间
        NSString *dateStr = [entTgDic objectForKey:@"strTm"];
        model.strTm = [ChangeDateType changeToNoneHomeDateType:dateStr];
        
        model.strBu = [entTgDic objectForKey:@"strBu"];
        
        
        
        
        //title
        model.strTt = [entTgDic objectForKey:@"strTt"];
        
        model.strTc = [entTgDic objectForKey:@"strTc"];
        
        
        
        [readItems setObject:model forKey:[@(index) stringValue]];
        
        //        [_carousel reloadItemAtIndex:index animated:YES];
        [_carousel reloadData];
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    
    
}





@end
