//
//  MyScrollView.h
//  XHJScrollView
//
//  Created by M-coppco on 15/12/3.
//  Copyright © 2015年 M-coppco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iCarousel.h>

@interface MyScrollView : UIView

- (instancetype)initWithFrame:(CGRect)frame dataArr:(NSArray *)dataArray type:(iCarouselType)type;

+ (instancetype)myScrollViewWithFrame:(CGRect)frame dataArr:(NSArray *)dataArray type:(iCarouselType)type;

// 这个可有可无
@property (nonatomic, strong) UIPageControl *pageControl;


// 定义一个block属性,传出点击的index和dataArr
@property (nonatomic, strong) void (^clickAction)(NSInteger index, NSArray *dataArr);

@end
