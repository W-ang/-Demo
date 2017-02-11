//
//  ViewController.m
//  QJKJAutoCycleScrollDemo
//
//  Created by YouchengLi on 2017/1/25.
//  Copyright © 2017年 深圳市齐家互联网科技股份有限公司. All rights reserved.
//

#import "ViewController.h"

#import "QJKJImageAutoCycleScroll.h"
#import "QJKJViewAutoCycleScroll.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //水平图片
    QJKJImageAutoCycleScroll *horizontalImageCycleScroll = [[QJKJImageAutoCycleScroll alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200) withScrollDirection:QJKJScrollHorizontal];
    horizontalImageCycleScroll.isPageControl = YES;
    horizontalImageCycleScroll.backgroundColor = [UIColor greenColor];
    horizontalImageCycleScroll.selectBlock = ^(id obj,NSInteger page){
        NSLog(@"图片 => %ld, %@",(long)page,obj);
    };
    [self.view addSubview:horizontalImageCycleScroll];
    
    //更新数据
    NSArray *horizontalImageArray = @[ @"ad1",@"ad2",@"ad3" ];
    [horizontalImageCycleScroll refreshUIWithArray:horizontalImageArray];
    
    //垂直文字
    QJKJViewAutoCycleScroll *verticalViewCycleScroll = [[QJKJViewAutoCycleScroll alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(horizontalImageCycleScroll.frame) + 20, [UIScreen mainScreen].bounds.size.width, 50) withScrollDirection:QJKJScrollVertical];
    verticalViewCycleScroll.backgroundColor = [UIColor greenColor];
    verticalViewCycleScroll.selectBlock = ^(id obj,NSInteger page){
        NSLog(@"文字 => %ld, %@",(long)page,obj);
    };
    [self.view addSubview:verticalViewCycleScroll];
    
    //更新数据
    NSArray *vertiacalLabelArray = @[ @[ @"通知告示", @"年前不放假的通知，你是该如何操作" ]
                                      ,@[ @"心灵鸡汤", @"有苦说不出，就只能换个环境过过" ]
                                      ,@[ @"账单缴费", @"2017年该缴费了，不然余额不足了" ] ];
    [verticalViewCycleScroll refreshUIWithArray:vertiacalLabelArray];
    
    
    //垂直图片
    QJKJImageAutoCycleScroll *verticalImageCycleScroll = [[QJKJImageAutoCycleScroll alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(verticalViewCycleScroll.frame) + 20, [UIScreen mainScreen].bounds.size.width, 200) withScrollDirection:QJKJScrollVertical];
    verticalImageCycleScroll.isPageControl = YES;
    verticalImageCycleScroll.backgroundColor = [UIColor greenColor];
    verticalImageCycleScroll.selectBlock = ^(id obj,NSInteger page){
        NSLog(@"图片 => %ld, %@",(long)page,obj);
    };
    [self.view addSubview:verticalImageCycleScroll];
    
    //更新数据
    NSArray *verticalImageArray = @[ @"ad1",@"ad2",@"ad3" ];
    [verticalImageCycleScroll refreshUIWithArray:verticalImageArray];
    
    //垂直文字
    QJKJViewAutoCycleScroll *horizontalViewCycleScroll = [[QJKJViewAutoCycleScroll alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(verticalImageCycleScroll.frame) + 20, [UIScreen mainScreen].bounds.size.width, 50) withScrollDirection:QJKJScrollHorizontal];
    horizontalViewCycleScroll.backgroundColor = [UIColor greenColor];
    horizontalViewCycleScroll.selectBlock = ^(id obj,NSInteger page){
        NSLog(@"文字 => %ld, %@",(long)page,obj);
    };
    [self.view addSubview:horizontalViewCycleScroll];
    
    //更新数据
    NSArray *horizontalLabelArray = @[ @[ @"通知告示", @"年前不放假的通知，你是该如何操作" ]
                                       ,@[ @"心灵鸡汤", @"有苦说不出，就只能换个环境过过" ]
                                       ,@[ @"账单缴费", @"2017年该缴费了，不然余额不足了" ] ];
    [horizontalViewCycleScroll refreshUIWithArray:horizontalLabelArray];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
