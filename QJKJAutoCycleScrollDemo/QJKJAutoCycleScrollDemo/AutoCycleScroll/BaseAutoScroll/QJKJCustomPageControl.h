//
//  QJKJCustomPageControl.h
//  LYCModuleManager
//
//  Created by YouchengLi on 2017/1/25.
//  Copyright © 2017年 深圳市齐家互联网科技股份有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QJKJCustomPageControl : UIView

/**
 总共数量
 */
@property (nonatomic, assign) NSInteger numberOfPages;

//当前位置
@property (nonatomic, assign) NSInteger currentPage;

/**
 未选中时颜色
 */
@property (nonatomic, strong) UIColor *pageIndicatorTintColor;

/**
 选中时颜色
 */
@property (nonatomic, strong) UIColor *currentPageIndicatorTintColor;

- (void)refreshUI;

@end
