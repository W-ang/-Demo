//
//  QJKJViewAutoCycleScroll.h
//  LYCModuleManager
//
//  Created by YouchengLi on 2017/1/25.
//  Copyright © 2017年 深圳市齐家互联网科技股份有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "QJKJAutoCycleScroll.h"

/**
 点击某个view
 
 @param obj 对象
 @param page 页码
 */
typedef void(^QJKJViewAutoCycleScrollSelectBlock)(id obj,NSInteger page);

@interface QJKJViewAutoCycleScroll : UIView

- (instancetype)initWithFrame:(CGRect)frame
          withScrollDirection:(QJKJScrollDirection)scrollDirection;

/**
 点击view块
 */
@property (nonatomic, copy) QJKJViewAutoCycleScrollSelectBlock selectBlock;

/**
 刷新滚动view资源
 
 @param array 资源数组
 */
- (void)refreshUIWithArray:(NSArray *)array;

@end
