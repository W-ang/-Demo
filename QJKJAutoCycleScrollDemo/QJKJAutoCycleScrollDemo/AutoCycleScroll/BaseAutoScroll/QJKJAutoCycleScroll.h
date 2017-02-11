//
//  QJKJAutoCycleScroll.h
//  LYCModuleManager
//
//  Created by YouchengLi on 2017/1/24.
//  Copyright © 2017年 深圳市齐家互联网科技股份有限公司. All rights reserved.
//

// --自动循环滚动
#import <UIKit/UIKit.h>

//自动滚动方向
typedef enum : NSUInteger {
    QJKJAutoPositiveSequence = 1,//正序 从上到下或从左到右
    QJKJAutoReverseSequence = 2,//反序 从下到上或从右到左
} QJKJAutoScrollSequence; //根据滚动方向决定从上到下还是从左到右

//滚动方向
typedef enum : NSUInteger {
    QJKJScrollVertical = 1,//垂直方向
    QJKJScrollHorizontal = 2,//水平方向
} QJKJScrollDirection;

#pragma mark - 相关回调

/**
 当前页面的页码值返回

 @param page 页码值
 */
typedef void(^QJKJAutoCycleScrollShowPageBlock)(NSInteger page);

/**
 点击当前页面的页码

 @param obj 页码值
 */
typedef void(^QJKJAutoCycleScrollSelectPageBlock)(id obj,NSInteger page);

/**
 自定义cell

 @param collectionView 控件
 @param indexPath 位置
 @param obj 数据 不要使用传入的数组资源进行刷新
 @return cell
 */
typedef UICollectionViewCell*(^QJKJAutoCycleScrollCellBlock)(UICollectionView * collectionView,NSIndexPath *indexPath,id obj);


/**
 注册块

 @return 注册
 */
typedef Class(^QJKJAutoCycleScrollRegisterBlock)(void);

@interface QJKJAutoCycleScroll : UIView

- (instancetype)initWithFrame:(CGRect)frame
          withScrollDirection:(QJKJScrollDirection)scrollDirection
       withAutoScrollSequence:(QJKJAutoScrollSequence)autoScrollSequence;

#pragma mark - 相关配置

/**
 资源
 */
@property (nonatomic, copy)     NSArray *resourceArray;

/**
 是否无限循环 默认无限循环 数组个数小于1不起作用，不能循环滚动
 */
@property (nonatomic, assign)   BOOL infiniteLoop;

/**
 是否自动滚动 默认自动滚动 数组个数小于1不起作用，不能自动滚动
 */
@property (nonatomic, assign)   BOOL autoScroll;

/**
 自动滚动时间间隔 默认5s
 */
@property (nonatomic, assign)   NSInteger autoScrollTimeInterval;

/**
 初始化位置 默认0
 */
@property (nonatomic, assign)   NSInteger initialPosition;

/**
 当前页面页码
 */
@property (nonatomic, copy)     QJKJAutoCycleScrollShowPageBlock showPageBlock;

/**
 点击当前页面
 */
@property (nonatomic, copy)     QJKJAutoCycleScrollSelectPageBlock selectPageBlock;

/**
 自定义cell配置
 */
@property (nonatomic, copy)     QJKJAutoCycleScrollCellBlock cellBlock;

/**
 注册块
 */
@property (nonatomic, copy)     QJKJAutoCycleScrollRegisterBlock registerBlock;

#pragma mark - 开始使用

/**
 配置参数变更之后，请调用此函数进行刷新
 */
- (void)refreshAutoCycleScroll;

/**
 暂停自动滚动
 */
-(void)pauseAutoScroll;

/**
 激活自动滚动
 */
-(void)resumeAutoScroll;

@end
