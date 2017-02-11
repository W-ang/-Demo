//
//  QJKJViewAutoCycleScroll.m
//  LYCModuleManager
//
//  Created by YouchengLi on 2017/1/25.
//  Copyright © 2017年 深圳市齐家互联网科技股份有限公司. All rights reserved.
//

#import "QJKJViewAutoCycleScroll.h"

#import "QJKJAutoCycleScroll.h"
#import "QJKJViewAutoCycleScrollCell.h"

#define VIEW_AUTO_TIME 3 //图片自动滚动时间间隔
#define VIEW_INITIAL_POSITION 0 //图片初始位置

@implementation QJKJViewAutoCycleScroll{
    QJKJAutoCycleScroll     *_autoCycleScroll;

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
            return [QJKJViewAutoCycleScrollCell class];
        };
        _autoCycleScroll.cellBlock = ^(UICollectionView * collectionView,NSIndexPath *indexPath,id obj) {
            
            QJKJViewAutoCycleScrollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([QJKJViewAutoCycleScrollCell class]) forIndexPath:indexPath];
            
            if (!cell) {
                NSLog(@"未创建成功");
            }
            
            NSArray *array = (NSArray *)obj;
            [cell refreshUIWithType:[array firstObject] withContent:[array lastObject]];
            
            return cell;
            
        };
        
        _autoCycleScroll.infiniteLoop = YES;
        _autoCycleScroll.autoScroll = YES;
        _autoCycleScroll.autoScrollTimeInterval = VIEW_AUTO_TIME;
        _autoCycleScroll.initialPosition = VIEW_INITIAL_POSITION;
        [self addSubview:_autoCycleScroll];
        
    }
    return self;
}

/**
 刷新滚动图片资源
 
 @param array 图片资源数组
 */
- (void)refreshUIWithArray:(NSArray *)array {

    _autoCycleScroll.showPageBlock = ^(NSInteger page){
        NSLog(@"文字 => %ld",(long)page);
    };
    
    __weak QJKJViewAutoCycleScroll *weakSelf = self;
    _autoCycleScroll.selectPageBlock = ^(id obj,NSInteger page){
        NSLog(@"文字 => %ld, %@",(long)page,obj);
        
        __strong QJKJViewAutoCycleScroll *strongSelf = weakSelf;
        if (strongSelf.selectBlock) {
            strongSelf.selectBlock(obj,page);
        }
    };
    
    _autoCycleScroll.resourceArray = array;
    [_autoCycleScroll refreshAutoCycleScroll];
    
}

@end
