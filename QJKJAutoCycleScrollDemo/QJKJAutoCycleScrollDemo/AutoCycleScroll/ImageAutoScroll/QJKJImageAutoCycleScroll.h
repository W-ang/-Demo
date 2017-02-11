//
//  QJKJImageAutoCycleScroll.h
//  LYCModuleManager
//
//  Created by YouchengLi on 2017/1/25.
//  Copyright © 2017年 深圳市齐家互联网科技股份有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "QJKJAutoCycleScroll.h"

/**
 点击某张图片

 @param obj 图片对象
 @param page 页码
 */
typedef void(^QJKJImageAutoCycleScrollSelectBlock)(id obj,NSInteger page);

@interface QJKJImageAutoCycleScroll : UIView

- (instancetype)initWithFrame:(CGRect)frame
          withScrollDirection:(QJKJScrollDirection)scrollDirection;


/**
 是否使用pageController
 */
@property (nonatomic, assign) BOOL isPageControl;

/**
 点击图片块
 */
@property (nonatomic, copy) QJKJImageAutoCycleScrollSelectBlock selectBlock;

/**
 刷新滚动图片资源

 @param array 图片资源数组
 */
- (void)refreshUIWithArray:(NSArray *)array;

@end
