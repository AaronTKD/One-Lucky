//
//  ReadViewController.m
//  一个
//
//  Created by Lucky on 15/8/26.
//  Copyright (c) 2015年 Lucky. All rights reserved.
//

#import "ReadViewController.h"
#import "AFNetworking.h"
#import "ReadingView.h"
#import "CountStrHeight.h"
#import "ReadingModel.h"
#import "iCarousel.h"

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height


@interface ReadViewController ()<iCarouselDataSource, iCarouselDelegate, UIActionSheetDelegate>
{
    BOOL flag;     // 导航栏按钮点击
    
    // 当前一共有多少篇文章，默认为3篇
    //    NSInteger numberOfItems;
    
    // 保存当前查看过的数据
    NSMutableDictionary *readItems;
    
    // 最后展示的 item 的下标
    NSInteger lastConfigureViewForItemIndex;
    // 当前是否正在右拉刷新标记
    BOOL isRefreshing;
    
}
@property (nonatomic, strong) iCarousel *carousel;

@end

@implementation ReadViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        UIImage *deselectedImage = [[UIImage imageNamed:@"tabbar_item_reading"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *selectedImage = [[UIImage imageNamed:@"tabbar_item_reading_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        // 底部导航item
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:@"文章" image:nil tag:0];
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


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    readItems = [[NSMutableDictionary alloc] init];
    lastConfigureViewForItemIndex = 0;
    isRefreshing = NO;
    
    //create carousel
    [self _createCarousel];
    
    [self requestReadingContentAtIndex:0];

  
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
    
    //        return numberOfItems;
    return readItems.allKeys.count;
}


- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(nullable UIView *)view {
    
    ReadingView *_readingView = nil;
    
    //create new view if no view is available for recycling
    if (view == nil) {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0,kWidth, kHeight)];
        _readingView = [[ReadingView alloc] initWithFrame:view.bounds];
        [view addSubview:_readingView];
    } else {
        _readingView = (ReadingView *)view.subviews[0];
    }
    _readingView.readingModel = readItems[[@(index) stringValue]];
    
    
    return view;
    
    
}

- (void)insertItems
{
    //    NSInteger index = MAX(0, self.carousel.currentItemIndex);
#warning change 加在后面
    NSInteger index = MAX(0, _carousel.currentItemIndex)+1 ;
    
    
    [self requestReadingContentAtIndex:index];
    
    
    [_carousel insertItemAtIndex:index animated:YES];
    
}

#pragma mark -
- (void)carouselDidScroll:(iCarousel *)carousel {
    
    NSLog(@"%f",carousel.scrollOffset);
    if (carousel.scrollOffset >= 0.35) {
        
        
        [self insertItems];
        
    }
    //    NSLog(@"count:%ld",readItems.allKeys.count);
    
}


#pragma mark - Network Requests
- (void)requestReadingContentAtIndex:(NSInteger)index {
    
    NSString *requestStr = [GetHttpRequestStr getReadingRequestStr:index];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [manager GET:requestStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSDictionary *dict = [responseObject objectForKey:@"contentEntity"];
        
        //        NSLog(@"ReadingViewController - dict = %@",dict);
        
        ReadingModel *model = [[ReadingModel alloc] init];
        
        NSString *strContent = [dict objectForKey:@"strContent"];
        model.strContent = [strContent stringByReplacingOccurrencesOfString:@"<br>" withString:@"\r\n"];//文章
        
        NSString *dateStr = [dict objectForKey:@"strContMarketTime"];//日期
        model.strContMarketTime = [ChangeDateType changeToNoneHomeDateType:dateStr];
        
        //不能直接对_readingView的model属性赋值。。。。因为只有Model全部改变的时候 才能seetNeedsLayout
        //       要弄个空Model 然后model 赋值给model
        
        model.strContTitle = [dict objectForKey:@"strContTitle"];//文章标题
        model.strContAuthor = [dict objectForKey:@"strContAuthor"];//作者
        model.strContAuthorIntroduce = [dict objectForKey:@"strContAuthorIntroduce"];//编辑
        model.strPraiseNumber = [dict objectForKey:@"strPraiseNumber"];
        model.strAuthorN = [dict objectForKey:@"strContAuthor"];//作者名字
        model.sWbN = [dict objectForKey:@"sWbN"];//微博名字
        
        model.sAuth = [dict objectForKey:@"sAuth"];//作者介绍
        
        
        [readItems setObject:model forKey:[@(index) stringValue]];
        
        //        [_carousel reloadItemAtIndex:index animated:YES];
        [_carousel reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    
    
}

@end
