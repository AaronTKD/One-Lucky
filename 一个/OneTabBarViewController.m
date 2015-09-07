//
//  OneTabBarViewController.m
//  一个
//
//  Created by Lucky on 15/8/26.
//  Copyright (c) 2015年 Lucky. All rights reserved.
//

#import "OneTabBarViewController.h"
#import "HomeViewController.h"
#import "ReadViewController.h"
#import "QuestionViewController.h"
#import "ThingsViewController.h"
#import "PersonViewController.h"


@interface OneTabBarViewController ()

@end

@implementation OneTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _createViewControllers];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark -createViewControllers
- (void)_createViewControllers
{
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    ReadViewController *readVC = [[ReadViewController alloc] init];
    QuestionViewController *questionVC = [[QuestionViewController alloc] init];
    ThingsViewController *thingsVC = [[ThingsViewController alloc] init];
    PersonViewController *personVC = [[PersonViewController alloc] init];
    
    NSArray *vcArray = @[homeVC,readVC,questionVC,thingsVC,personVC];
    NSMutableArray *navArray = [[NSMutableArray alloc] init];
    for (int i = 0; i<5; i++) {
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vcArray[i]];
        [navArray addObject:nav];
    }
    
    self.viewControllers = navArray;
    
}



@end
