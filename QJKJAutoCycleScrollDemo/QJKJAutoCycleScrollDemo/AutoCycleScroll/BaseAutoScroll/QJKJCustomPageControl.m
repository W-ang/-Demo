//
//  QJKJCustomPageControl.m
//  LYCModuleManager
//
//  Created by YouchengLi on 2017/1/25.
//  Copyright © 2017年 深圳市齐家互联网科技股份有限公司. All rights reserved.
//

#import "QJKJCustomPageControl.h"

#define PAGECONTROL_DOT_WIDTH 8.f
#define PAGECONTROL_DOT_SPACE 4.f
#define PAGECONTROL_TAG 10000

@implementation QJKJCustomPageControl {
    UIButton *_selectDotButton;
    NSInteger _page;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialization];
    }
    return self;
}

//初始化
- (void)initialization {
    
    _numberOfPages = 0;
    _currentPage = 0;
    _pageIndicatorTintColor = [UIColor whiteColor];
    _currentPageIndicatorTintColor = [UIColor redColor];
    
}

- (void)setCurrentPage:(NSInteger)currentPage {
    _page = currentPage;
    
    UIButton *button = (UIButton *)[self viewWithTag:PAGECONTROL_TAG + _page];
    [self clickeDot:button];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
}

- (void)refreshUI {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    for (NSInteger i = 0; i < self.numberOfPages; i++) {
        UIButton *dotButton = [UIButton buttonWithType:UIButtonTypeCustom];
        dotButton.frame = CGRectMake((self.frame.size.width - ((PAGECONTROL_DOT_WIDTH + PAGECONTROL_DOT_SPACE)*(self.numberOfPages - 1) + PAGECONTROL_DOT_WIDTH)) / 2.0 + (PAGECONTROL_DOT_WIDTH + PAGECONTROL_DOT_SPACE) * i, self.frame.size.height / 2.0 - PAGECONTROL_DOT_WIDTH / 2.0, PAGECONTROL_DOT_WIDTH, PAGECONTROL_DOT_WIDTH);
        dotButton.layer.cornerRadius = PAGECONTROL_DOT_WIDTH / 2.0;
        dotButton.layer.masksToBounds = YES;
        dotButton.layer.borderColor = [UIColor grayColor].CGColor;
        dotButton.layer.borderWidth = 0.5;
        dotButton.tag = PAGECONTROL_TAG + i;
        
        [dotButton setImage:[QJKJCustomPageControl imageWithColor:_pageIndicatorTintColor] forState:UIControlStateNormal];
        [dotButton setImage:[QJKJCustomPageControl imageWithColor:_currentPageIndicatorTintColor] forState:UIControlStateSelected];
        [dotButton addTarget:self action:@selector(clickeDot:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:dotButton];
        
        if (_page == i) {
            _selectDotButton = dotButton;
        }
    }
    
    [self clickeDot:_selectDotButton];
}

- (void)clickeDot:(UIButton *)btn {
    _selectDotButton.selected = NO;
    _selectDotButton = btn;
    _selectDotButton.selected = YES;
}

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 8.0f, 8.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)imageWithColor:(UIColor *)color withFrame:(CGRect)frame
{
    UIGraphicsBeginImageContext(frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, frame);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
