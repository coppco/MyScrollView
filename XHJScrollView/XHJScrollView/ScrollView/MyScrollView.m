//
//  MyScrollView.m
//  XHJScrollView
//
//  Created by M-coppco on 15/12/3.
//  Copyright © 2015年 M-coppco. All rights reserved.
//

#import "MyScrollView.h"
#import "BlurImageView.h"   //毛玻璃效果
#import <UIImageView+WebCache.h>

#define kWidth [UIScreen mainScreen].bounds.size.width

@interface MyScrollView ()<iCarouselDataSource, iCarouselDelegate>

//数组
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) iCarousel *carousel;
@property (nonatomic, strong) NSTimer *timer;
//毛玻璃视图
@property (nonatomic, strong) BlurImageView *blurImageV;
@end

@implementation MyScrollView
- (instancetype)initWithFrame:(CGRect)frame dataArr:(NSArray *)dataArray type:(iCarouselType)type {
    self.dataArr = dataArray;
    
    self = [super initWithFrame:frame];
    if (self) {
        //毛玻璃背景图片
        self.blurImageV = [[BlurImageView alloc] initWithFrame:self.bounds];
        NSString *str = self.dataArr[0];
        if ([str hasPrefix:@"http"]) {
            [self.blurImageV sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"load.jpg"]];
        }else{
            self.blurImageV.image = [UIImage imageNamed:str];
        }
        [self addSubview:self.blurImageV];
        
        //轮播图
        self.carousel = [[iCarousel alloc] initWithFrame:self.bounds];
        self.carousel.delegate = self;
        self.carousel.dataSource = self;
        self.carousel.type = type;
        self.carousel.pagingEnabled = YES;
        self.carousel.scrollOffset = 0;
        [self addSubview:self.carousel];
        
        // 初始化pageControl
        self.pageControl = [[UIPageControl alloc] init];
        self.pageControl.numberOfPages = self.dataArr.count;
        self.pageControl.center = CGPointMake(self.center.x, self.bounds.size.height - 10);
        [self addSubview:self.pageControl];
    }
    return self;
}

+ (instancetype)myScrollViewWithFrame:(CGRect)frame dataArr:(NSArray *)dataArray type:(iCarouselType)type {
    return [[self alloc] initWithFrame:frame dataArr:dataArray type:type];
}

#pragma mark ---delegate,datasource
// 下面是carousel的代理方法和数据源方法,根据每个方法名可以清晰的指导其作用
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    return self.dataArr.count;
}
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    if (view == nil) {
        // 这里可以控制每张图的大小, 当然最好写在外部,方便我们调节
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:(CGRectMake(0, 0, 220, 300))];
        //图片不失真
//        imageV.contentMode = UIViewContentModeScaleAspectFit;
        NSString *str = self.dataArr[index];
        
        // 下面的判断是调用网络请求还是本地图片
        if ([str hasPrefix:@"http"]) {
            [imageV sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"load.jpg"]];
        }else{
            imageV.image = [UIImage imageNamed:str];
        }
        view = imageV;
    }
    return view;
}
- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index{
    if (self.clickAction) {
        self.clickAction(index, self.dataArr);
    }
}
//滚动的时候
- (void)carouselDidScroll:(iCarousel *)carousel{
    self.pageControl.currentPage = carousel.currentItemIndex;
    UIImageView *imageV = (UIImageView *)self.carousel.currentItemView;
    self.blurImageV.image = imageV.image;
}
- (void)carouselWillBeginDragging:(iCarousel *)carousel{
    
    //    [self removeTimer];
}
- (void)carouselDidEndDragging:(iCarousel *)carousel willDecelerate:(BOOL)decelerate{
    
    //    [self addTimer];
}


#pragma mark NSTimer计时器的使用
- (void)addTimer{
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
- (void)nextImage{
    
    NSInteger index = self.carousel.currentItemIndex + 1;
    if (index == self.dataArr.count) {
        index = 0;
    }
    [self.carousel scrollToItemAtIndex:index animated:YES];
    
    UIImageView *imageV = (UIImageView *)self.carousel.currentItemView;
    
    self.blurImageV.image = imageV.image;
}
- (void)removeTimer{
    
    [self.timer invalidate];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
