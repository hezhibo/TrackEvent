//
//  ViewController.m
//  自动埋点test
//
//  Created by 何志博 on 2018/8/15.
//  Copyright © 2018年 何志博. All rights reserved.
//

#import "ViewController.h"
#import "StastisticsUtility.h"   // 自动埋点类

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"1");
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"测试" forState:UIControlStateNormal];
    button.frame = CGRectMake(100, 100, 200, 50);
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor whiteColor]];
    button.layer.cornerRadius = 5;
    button.layer.borderWidth = 1;
    button.layer.borderColor = [[UIColor blackColor] CGColor];
    [button addTarget:self action:@selector(test:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

#pragma mark - 测试自动埋点
- (void)test:(UIButton *)button {
    NSLog(@"点击了按钮");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
