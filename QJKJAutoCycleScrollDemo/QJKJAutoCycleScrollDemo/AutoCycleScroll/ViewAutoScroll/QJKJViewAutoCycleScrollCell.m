//
//  QJKJViewAutoCycleScrollCell.m
//  LYCModuleManager
//
//  Created by YouchengLi on 2017/1/25.
//  Copyright © 2017年 深圳市齐家互联网科技股份有限公司. All rights reserved.
//

#import "QJKJViewAutoCycleScrollCell.h"

@implementation QJKJViewAutoCycleScrollCell {
    UILabel *_typeLabel;
    UILabel *_contentLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _typeLabel = [[UILabel alloc] init];
        _typeLabel.font = [UIFont systemFontOfSize:14];
        _typeLabel.textColor = [UIColor redColor];
        [self addSubview:_typeLabel];
        
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.textColor = [UIColor blueColor];
        [self addSubview:_contentLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _typeLabel.frame = CGRectMake(10, 10, 70, CGRectGetHeight(self.frame) - 10 * 2);
    _contentLabel.frame = CGRectMake(CGRectGetMaxX(_typeLabel.frame) + 10, CGRectGetMinY(_typeLabel.frame), CGRectGetWidth(self.frame) - (CGRectGetMaxX(_typeLabel.frame) + 10) - 10, CGRectGetHeight(_typeLabel.frame));
}

- (void)refreshUIWithType:(NSString *)type
              withContent:(NSString *)content {
    _typeLabel.text = type;
    _contentLabel.text = content;
}

@end
