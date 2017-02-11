//
//  QJKJImageAutoCycleScrollCell.m
//  LYCModuleManager
//
//  Created by YouchengLi on 2017/1/25.
//  Copyright © 2017年 深圳市齐家互联网科技股份有限公司. All rights reserved.
//

#import "QJKJImageAutoCycleScrollCell.h"

@implementation QJKJImageAutoCycleScrollCell {
    UIImageView *_contentImageView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _contentImageView = [[UIImageView alloc] init];
//        _contentImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_contentImageView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _contentImageView.frame = self.bounds;
}

- (void)refreshUIWithString:(NSString *)string {
    _contentImageView.image = [UIImage imageNamed:string];
}

@end
