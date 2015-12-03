//
//  BlurImageView.m
//  XHJScrollView
//
//  Created by M-coppco on 15/12/3.
//  Copyright © 2015年 M-coppco. All rights reserved.
//

#import "BlurImageView.h"

@implementation BlurImageView
-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.effectView = [[UIVisualEffectView alloc] initWithFrame:self.bounds];
        self.effectView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        [self addSubview:self.effectView];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
