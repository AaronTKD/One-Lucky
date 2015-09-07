//
//  QuestionViewController.m
//  一个
//
//  Created by Lucky on 15/8/26.
//  Copyright (c) 2015年 Lucky. All rights reserved.
//

#import "QuestionViewController.h"
#import "AFNetworking.h"
#import "QuestionView.h"
#import "QuestionModel.h"
#import "iCarousel.h"
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height




@interface QuestionViewController ()<iCarouselDataSource, iCarouselDelegate, UIActionSheetDelegate>
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

@implementation QuestionViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        UIImage *deselectedImage = [[UIImage imageNamed:@"tabbar_item_question"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *selectedImage = [[UIImage imageNamed:@"tabbar_item_question_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        // 底部导航item
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:@"问题" image:nil tag:0];
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

- (void)dealloc
{
    //it's a good idea to set these to nil here to avoid
    //sending messages to a deallocated viewcontroller
    _carousel.delegate = nil;
    _carousel.dataSource = nil;
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
    
    QuestionView *_questionView = nil;
    
    //create new view if no view is available for recycling
    if (view == nil) {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0,kWidth, kHeight)];
        _questionView = [[QuestionView alloc] initWithFrame:view.bounds];
        [view addSubview:_questionView];
    } else {
        _questionView = (QuestionView *)view.subviews[0];
    }

    _questionView.questionModel = readItems[[@(index) stringValue]];
    
    
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
    
    NSString *requestStr = [GetHttpRequestStr getQuestionRequestStr:index];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [manager GET:requestStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSDictionary *questionAdEntityDic = [responseObject objectForKey:@"questionAdEntity"];
        

        QuestionModel *model = [[QuestionModel alloc] init];
        
        //日期date
        NSString *dateStr = [questionAdEntityDic objectForKey:@"strQuestionMarketTime"];
        model.strQuestionMarketTime = [ChangeDateType changeToNoneHomeDateType:dateStr];
        
        //问题title
        model.strQuestionTitle = [questionAdEntityDic objectForKey:@"strQuestionTitle"];
        //问题content
        model.strQuestionContent = [questionAdEntityDic objectForKey:@"strQuestionContent"];
        
        
        //回答title
        model.strAnswerTitle = [questionAdEntityDic objectForKey:@"strAnswerTitle"];
        //回答content
        model.strAnswerContent = [[questionAdEntityDic objectForKey:@"strAnswerContent"] stringByReplacingOccurrencesOfString:@"<br>" withString:@"\r\n"];
        
        //编辑
        model.sEditor = [questionAdEntityDic objectForKey:@"sEditor"];
        
        //点赞数
        model.strPraiseNumber = [questionAdEntityDic objectForKey:@"strPraiseNumber"];
        
        [readItems setObject:model forKey:[@(index) stringValue]];
        
        //        [_carousel reloadItemAtIndex:index animated:YES];
        [_carousel reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}


//=================================


//#pragma mark -
//#pragma mark iCarousel methods
//
//
//
//- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
//{
//    
//    
//    //create new view if no view is available for recycling
//    if (view == nil)
//    {
//        
//        view = [[UIImageView alloc] initWithFrame:self.view.bounds];
////        view.contentMode = UIViewContentModeCenter;
//        
//        NSString *requestStr = [GetHttpRequestStr getQuestionRequestStr:viewIndex];
//        
//        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
//        [manager GET:requestStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            
//            
//            NSDictionary *questionAdEntityDic = [responseObject objectForKey:@"questionAdEntity"];
//            
//            _questionView = [[QuestionView alloc] init];
//            [view addSubview:_questionView];
//            QuestionModel *model = [[QuestionModel alloc] init];
//            
//            //日期date
//            NSString *dateStr = [questionAdEntityDic objectForKey:@"strQuestionMarketTime"];
//            model.strQuestionMarketTime = [ChangeDateType changeToNoneHomeDateType:dateStr];
//            
//            //问题title
//            model.strQuestionTitle = [questionAdEntityDic objectForKey:@"strQuestionTitle"];
//            //问题content
//            model.strQuestionContent = [questionAdEntityDic objectForKey:@"strQuestionContent"];
//            
//            
//            //回答title
//            model.strAnswerTitle = [questionAdEntityDic objectForKey:@"strAnswerTitle"];
//            //回答content
//            model.strAnswerContent = [[questionAdEntityDic objectForKey:@"strAnswerContent"] stringByReplacingOccurrencesOfString:@"<br>" withString:@"\r\n"];
//            
//            //编辑
//            model.sEditor = [questionAdEntityDic objectForKey:@"sEditor"];
//            
//            //点赞数
//            model.strPraiseNumber = [questionAdEntityDic objectForKey:@"strPraiseNumber"];
//            
//            
//            _questionView.questionModel = model;
//            
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            NSLog(@"Error: %@", error);
//        }];
//    }
//    
//    
//    
//    return view;
//}
//

@end
