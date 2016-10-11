//
//  StaticSegmentControl.m
//  LBSegmentControl
//
//  Created by 你个LB on 16/10/11.
//  Copyright © 2016年 NGeLB. All rights reserved.
//

// 当前设备的物理尺寸
#define kScreen_width [UIScreen mainScreen].bounds.size.width
#define kScreen_height [UIScreen mainScreen].bounds.size.height

#import "StaticSegmentControl.h"

#import "LBSegmentControl.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"
#import "FifthViewController.h"
#import "SixthViewController.h"

@interface StaticSegmentControl ()

@end

@implementation StaticSegmentControl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 创建视图控制器
    FirstViewController * firstVC = [[FirstViewController alloc] init];
    SecondViewController * secondVC = [[SecondViewController alloc] init];
    ThirdViewController * thirdVC = [[ThirdViewController alloc] init];
    
    LBSegmentControl * segmentControl = [[LBSegmentControl alloc] initStaticTitlesWithFrame:CGRectMake(0, 20, kScreen_width, 45)];
    segmentControl.titles = @[@"第一页", @"第二页", @"第三页"];
    segmentControl.viewControllers = @[firstVC, secondVC, thirdVC];
    segmentControl.titleNormalColor = [UIColor blueColor];
    segmentControl.titleSelectColor = [UIColor redColor];
    [segmentControl setBottomViewColor:[UIColor blueColor]];
    segmentControl.isTitleScale = YES;
    
    [self.view addSubview:segmentControl];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
