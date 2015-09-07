//
//  PersonViewController.m
//  一个
//
//  Created by Lucky on 15/8/26.
//  Copyright (c) 2015年 Lucky. All rights reserved.
//

#import "PersonViewController.h"
#import "UIImageView+WebCache.h"
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

@interface PersonViewController ()
{
    UITableView *_tableView;
    NSArray *_labelArray;
    NSArray *_imageArray;
}

@end

@implementation PersonViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        UIImage *deselectedImage = [[UIImage imageNamed:@"tabbar_item_person"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *selectedImage = [[UIImage imageNamed:@"tabbar_item_person_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        // 底部导航item
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:@"个人" image:nil tag:0];
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
    
    [self _setArray];
    [self _setTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)_setArray
{
    _labelArray = [[NSArray alloc] init];
    _imageArray = [[NSArray alloc] init];
    _labelArray = @[@"浙江温州的黄鹤",@"设置",@"关于"];
    
    UIImage *headImage = [UIImage imageNamed:@"headImage.jpeg"];
    UIImage *setImage = [UIImage imageNamed:@"setting@2x"];
    UIImage *aboutImage = [UIImage imageNamed:@"copyright@2x"];
    
    _imageArray = @[headImage,setImage,aboutImage];
    
}

- (void)_setTableView
{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    
//    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 5)];
//    UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 5)];
//    lineImageView.image = [UIImage imageNamed:@"que_line"];
//    [lineView addSubview:lineImageView];
//    
//    [_tableView setTableFooterView:lineView];
    
    _tableView.tableFooterView = [[UIView alloc] init];//去除多余单元格的下划线
    
    [_tableView setSeparatorInset:(UIEdgeInsetsMake(0, 0, 0, 0))];//单元格的下划线占满屏幕的宽度
    //注册
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = _labelArray[indexPath.row];
    cell.imageView.image = _imageArray[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//显示右边的箭头
    

    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}


@end
