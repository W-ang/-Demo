//
//  QJKJImageAutoCycleScroll.m
//  LYCModuleManager
//
//  Created by YouchengLi on 2017/1/25.
//  Copyright © 2017年 深圳市齐家互联网科技股份有限公司. All rights reserved.
//

#import "QJKJImageAutoCycleScroll.h"

#import "QJKJImageAutoCycleScrollCell.h"

#import "QJKJCustomPageControl.h"

#define IMAGE_AUTO_TIME 3 //图片自动滚动时间间隔
#define IMAGE_INITIAL_POSITION 0 //图片初始位置

@implementation QJKJImageAutoCycleScroll {
    QJKJAutoCycleScroll     *_autoCycleScroll;
    QJKJCustomPageControl   *_customPageControl;
}

- (instancetype)initWithFrame:(CGRect)frame
          withScrollDirection:(QJKJScrollDirection)scrollDirection
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _autoCycleScroll = [[QJKJAutoCycleScroll alloc] initWithFrame:self.bounds
                                                                      withScrollDirection:scrollDirection
                                                                   withAutoScrollSequence:QJKJAutoPositiveSequence];
        _autoCycleScroll.registerBlock = ^(void) {
            return [QJKJImageAutoCycleScrollCell class];
        };
        _autoCycleScroll.cellBlock = ^(UICollectionView * collectionView,NSIndexPath *indexPath,id obj) {
            
            QJKJImageAutoCycleScrollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([QJKJImageAutoCycleScrollCell class]) forIndexPath:indexPath];
            
            if (!cell) {
                NSLog(@"未创建成功");
            }
            
            NSString *imageString = (NSString *)obj;
            [cell refreshUIWithString:imageString];
            
            return cell;
 
        };

        _autoCycleScroll.infiniteLoop = YES;
        _autoCycleScroll.autoScroll = YES;
        _autoCycleScroll.autoScrollTimeInterval = IMAGE_AUTO_TIME;
        _autoCycleScroll.initialPosition = IMAGE_INITIAL_POSITION;
        [self addSubview:_autoCycleScroll];
        
        _customPageControl = [[QJKJCustomPageControl alloc] initWithFrame:CGRectMake(10, CGRectGetHeight(self.frame) - 50, CGRectGetWidth(self.frame) - 10 * 2, 50)];
        _customPageControl.pageIndicatorTintColor = [UIColor whiteColor];
        _customPageControl.currentPageIndicatorTintColor = [UIColor redColor];
        [self addSubview:_customPageControl];
    }
    return self;
}

- (void)setIsPageControl:(BOOL)isPageControl {
    _customPageControl.hidden = !isPageControl;
}

/**
 刷新滚动图片资源
 
 @param array 图片资源数组
 */
- (void)refreshUIWithArray:(NSArray *)array {
    _customPageControl.numberOfPages = array.count;
    [_customPageControl refreshUI];
    
    
    __weak QJKJCustomPageControl *control = _customPageControl;
    _autoCycleScroll.showPageBlock = ^(NSInteger page){
        NSLog(@"图片 => %ld",(long)page);
        control.currentPage = page;
    };
    
    __weak QJKJImageAutoCycleScroll *weakSelf = self;
    _autoCycleScroll.selectPageBlock = ^(id obj,NSInteger page){
        NSLog(@"图片 => %ld, %@",(long)page,obj);
        
        __strong QJKJImageAutoCycleScroll *strongSelf = weakSelf;
        if (strongSelf.selectBlock) {
            strongSelf.selectBlock(obj,page);
        }
    };
    
    _autoCycleScroll.resourceArray = array;
    [_autoCycleScroll refreshAutoCycleScroll];

}

@end
