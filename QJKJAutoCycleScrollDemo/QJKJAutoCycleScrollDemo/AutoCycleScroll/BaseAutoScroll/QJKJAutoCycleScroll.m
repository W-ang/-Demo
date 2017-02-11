//
//  QJKJAutoCycleScroll.m
//  LYCModuleManager
//
//  Created by YouchengLi on 2017/1/24.
//  Copyright © 2017年 深圳市齐家互联网科技股份有限公司. All rights reserved.
//

#import "QJKJAutoCycleScroll.h"

//#import "QJKJAutoCycleScrollCell.h"

@interface QJKJAutoCycleScroll ()
<UICollectionViewDelegate,
UICollectionViewDataSource,
UIScrollViewDelegate>

@property (nonatomic, strong) UICollectionView *mainCollectionView;
//资源
@property (nonatomic, strong) NSMutableArray *resourceMArray;
//时间
@property (nonatomic, strong) NSTimer *autoTimer;
//滚动方向 默认QJKJScrollHorizontal
@property (nonatomic, assign) QJKJScrollDirection scrollDirection;
//自动滚动方向 默认QJKJAutoPositiveSequence
@property (nonatomic, assign) QJKJAutoScrollSequence autoScrollSequence;
//当前页码
@property (nonatomic, assign) NSInteger currentPage;

@end

@implementation QJKJAutoCycleScroll

- (instancetype)initWithFrame:(CGRect)frame
          withScrollDirection:(QJKJScrollDirection)scrollDirection
       withAutoScrollSequence:(QJKJAutoScrollSequence)autoScrollSequence
{
    self = [super initWithFrame:frame];
    if (self) {
        self.scrollDirection = scrollDirection;
        self.autoScrollSequence = autoScrollSequence;
        
        [self initialization];
        [self addSubview:self.mainCollectionView];
    }
    return self;
}

//初始化
- (void)initialization {
    
    _initialPosition = 0;
    _autoScroll = YES;
    _autoScrollTimeInterval = 5;
    _infiniteLoop = YES;
    
}

#pragma mark 私有方法

/**
 配置参数变更之后，请调用此函数进行刷新
 */
- (void)refreshAutoCycleScroll {
    if (self.registerBlock) {
        [_mainCollectionView registerClass:self.registerBlock() forCellWithReuseIdentifier:NSStringFromClass(self.registerBlock())];
    }
    
    [self.mainCollectionView reloadData];
    
    if (self.resourceMArray.count <= 1) {
        _infiniteLoop = NO;
        _autoScroll = NO;
    }
    
    //初始位置
    NSInteger page = 0;
    if (_initialPosition >= 0 && _initialPosition < self.resourceMArray.count - 2) {
        page = (_initialPosition + 1);
    }
    else {
        page = 1;
    }
    
    if (_scrollDirection == QJKJScrollHorizontal) {
        //水平
        [self.mainCollectionView setContentOffset:CGPointMake(CGRectGetWidth(self.mainCollectionView.frame) * page, 0) animated:YES];
    }
    else {
        //垂直
        [self.mainCollectionView setContentOffset:CGPointMake(0, CGRectGetHeight(self.mainCollectionView.frame) * page) animated:YES];
    }
    
    //自动滚动
    if (_autoScroll && _infiniteLoop) {
         [self setupTimer];
    }
}

/**
 数据处理

 @param array 数据源
 */
- (void)dataHandler:(NSArray *)array {
    [self.resourceMArray removeAllObjects];
    
    [self.resourceMArray addObjectsFromArray:array];
    
    // 3 - 1 - 2 - 3 - 1
    if (array.count > 1) {
        if (_infiniteLoop) {
            [self.resourceMArray insertObject:[array lastObject] atIndex:0];
            [self.resourceMArray addObject:[array firstObject]];
        }
    }

    NSLog(@"image source list=》%@",self.resourceMArray);
}

/**
 暂停自动滚动
 */
-(void)pauseAutoScroll {
    if (![_autoTimer isValid]) {
        return ;
    }
    [_autoTimer setFireDate:[NSDate distantFuture]];
}


/**
 激活自动滚动
 */
-(void)resumeAutoScroll
{
    if (![_autoTimer isValid]) {
        return ;
    }
    [_autoTimer setFireDate:[NSDate date]];
}

/**
 定时器
 */
- (void)setupTimer {
    if (self.autoTimer) {
        [self.autoTimer invalidate];
        self.autoTimer = nil;
    }
    
    self.autoTimer = [NSTimer scheduledTimerWithTimeInterval:_autoScrollTimeInterval target:self selector:@selector(automaticScroll) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.autoTimer forMode:NSRunLoopCommonModes];
}

- (void)automaticScroll {
    CGPoint point = self.mainCollectionView.contentOffset;
    
    if (_scrollDirection == QJKJScrollHorizontal) {
        if (_autoScrollSequence == QJKJAutoPositiveSequence) {
            //从左到右
            point.x += CGRectGetWidth(self.mainCollectionView.frame);
        }
        else {
            point.x -= CGRectGetWidth(self.mainCollectionView.frame);
        }
    }
    else {
        //垂直
        if (_autoScrollSequence == QJKJAutoPositiveSequence) {
            //从上到下
            point.y += CGRectGetHeight(self.mainCollectionView.frame);
        }
        else {
            point.y -= CGRectGetHeight(self.mainCollectionView.frame);
        }
    }
    
    [self.mainCollectionView setContentOffset:point animated:YES];
}

/**
 调整位置
 
 @param scrollView scrollView
 */
- (void)adjustLocation:(UIScrollView *)scrollView {
    
    if (_scrollDirection == QJKJScrollHorizontal) {
        
        NSInteger page = (NSInteger)scrollView.contentOffset.x / CGRectGetWidth(self.mainCollectionView.frame);

        if (_infiniteLoop) {
            //水平
            if (page == 0) {
                [self.mainCollectionView setContentOffset:CGPointMake(CGRectGetWidth(self.mainCollectionView.frame) * (self.resourceMArray.count - 2), 0) animated:NO];
                self.currentPage = (NSInteger)scrollView.contentOffset.x / CGRectGetWidth(self.mainCollectionView.frame);
                
            }
            else if (page == self.resourceMArray.count - 1) {
                [self.mainCollectionView setContentOffset:CGPointMake(CGRectGetWidth(self.mainCollectionView.frame) * 1, 0) animated:NO];
                self.currentPage = (NSInteger)scrollView.contentOffset.x / CGRectGetWidth(self.mainCollectionView.frame);
                
            }
            else {
                self.currentPage = page;
                
            }
        }

    }
    else {
        NSInteger page = (NSInteger)scrollView.contentOffset.y / CGRectGetHeight(self.mainCollectionView.frame);

        if (_infiniteLoop) {
            if (page == 0) {
                [self.mainCollectionView setContentOffset:CGPointMake(0, CGRectGetHeight(self.mainCollectionView.frame) * (self.resourceMArray.count - 2)) animated:NO];
                self.currentPage = (NSInteger)scrollView.contentOffset.y / CGRectGetHeight(self.mainCollectionView.frame);
                
            }
            else if (page == self.resourceMArray.count - 1) {
                [self.mainCollectionView setContentOffset:CGPointMake(0, CGRectGetHeight(self.mainCollectionView.frame) * 1) animated:NO];
                self.currentPage = (NSInteger)scrollView.contentOffset.y / CGRectGetHeight(self.mainCollectionView.frame);
                
            }
            else {
                self.currentPage = page;
                
            }
        }
        
    }

    if (self.showPageBlock) {
        self.showPageBlock(self.resourceMArray.count == 1 ? 0 : self.currentPage - 1);
    }
    
}

#pragma mark - UIScrollViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.selectPageBlock) {
        if (self.resourceMArray.count == 1) {
            id obj = [self.resourceMArray firstObject];
            self.selectPageBlock(obj,0);
        }
        else if (self.resourceMArray.count > 1) {
            
            id obj = self.resourceMArray[indexPath.row - 1];
            self.selectPageBlock(obj,indexPath.row - 1);
        }
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.resourceMArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.cellBlock) {
        if (indexPath.row < self.resourceMArray.count) {
            id obj = self.resourceMArray[indexPath.row];
            return self.cellBlock(collectionView,indexPath,obj);
        }
        else {
            return self.cellBlock(collectionView,indexPath,nil);
        }
    }
    else {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class]) forIndexPath:indexPath];
        return cell;
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    NSLog(@"scrollViewDidEndDragging");
    
    if (!decelerate) {
        
    }
    
    [self setupTimer];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
//    DLog(@"scrollViewWillBeginDragging");
    if (self.autoTimer) {
        [self.autoTimer invalidate];
        self.autoTimer = nil;
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidEndDecelerating");
  
    [self adjustLocation:scrollView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidEndScrollingAnimation");
   
    [self adjustLocation:scrollView];
}

#pragma mark - life cycle

//解决当父View释放时，当前视图因为被Timer强引用而不能释放的问题
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (!newSuperview) {
        [self.autoTimer invalidate];
        self.autoTimer = nil;
    }
}

//解决当timer释放后 回调scrollViewDidScroll时访问野指针导致崩溃
- (void)dealloc {
    self.mainCollectionView.delegate = nil;
    self.mainCollectionView.dataSource = nil;
}

#pragma mark - getters or setters

- (void)setResourceArray:(NSArray *)resourceArray {
    
    [self dataHandler:resourceArray];
}

- (UICollectionView *)mainCollectionView {
    if (!_mainCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        if (self.scrollDirection == QJKJScrollHorizontal) {
            flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        }
        else {
            flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        }
        flowLayout.itemSize = CGSizeMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.sectionInset = UIEdgeInsetsZero;

        _mainCollectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        _mainCollectionView.pagingEnabled = YES;
        _mainCollectionView.delegate = self;
        _mainCollectionView.dataSource = self;
        _mainCollectionView.pagingEnabled = YES;
        _mainCollectionView.bounces = NO;
        _mainCollectionView.backgroundColor = [UIColor greenColor];

        [_mainCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
    }
    return _mainCollectionView;
}

- (NSMutableArray *)resourceMArray {
    if (!_resourceMArray) {
        _resourceMArray = [NSMutableArray array];
    }
    return _resourceMArray;
}

@end
