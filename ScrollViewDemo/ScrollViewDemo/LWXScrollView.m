//
//  LWXScrollView.m
//  ScrollViewDemo
//
//  Created by student on 16/2/25.
//  Copyright © 2016年 student. All rights reserved.
//

#import "LWXScrollView.h"


//宏常用的常量
#define kWIDTH self.bounds.size.width
#define kHEIGHT self.bounds.size.height
#define kCount (self.imageArray.count + 2)


@interface LWXScrollView ()<UIScrollViewDelegate> {
    
    NSTimer    *_timer;
    

}

@property (nonatomic, strong) UIScrollView  *scrollView;


@property (nonatomic, strong) NSArray       *imageArray;

@end

@implementation LWXScrollView


#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame withImageArray:(NSArray *)image {
    self = [super initWithFrame:frame];
    if (self) {
        
        _imageArray = image;
        
        [self initView];
        
    }
    
    return self;
}



#pragma mark - 懒加载初始化对象
- (UIScrollView *)scrollView {
    
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:_scrollView];
    }
    return _scrollView;
}


#pragma mark - 初始化视图
- (void)initView {
    
    CGSize contentSize = self.bounds.size;
    contentSize.width *= kCount;
    self.scrollView.contentSize = contentSize;
    self.scrollView.contentOffset = CGPointMake(kWIDTH, 0);
    
    for (NSInteger i = 0; i < kCount; i++) {
        
        UIImage *image;
        
        
        //首末两端分别多放一张图片。
        if (i != 0 && i != (kCount - 1)) {
            
            image = _imageArray[i - 1];
        }else if(i == 0){
            image = [_imageArray lastObject];
        }else{
            image = [_imageArray firstObject];
        }
        
        
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(i * kWIDTH, 0, kWIDTH, kHEIGHT)];
        
        img.image = image;
        
        [_scrollView addSubview:img];
    }
    
}


#pragma mark - 代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
   
    CGFloat offSize = scrollView.contentOffset.x;
    
    
    if (offSize < kWIDTH) {
        
        self.scrollView.contentOffset = CGPointMake(kWIDTH * (kCount - 2), 0);
    
    }
    
    if (offSize > kWIDTH * (kCount - 2)) {
        self.scrollView.contentOffset = CGPointMake(kWIDTH, 0);

    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    
    CGPoint offSize = scrollView.contentOffset;
    
    if (offSize.x < 0){
        self.scrollView.contentOffset = CGPointMake(kWIDTH * (kCount - 2), 0);

    }
    
    if (offSize.x > (kCount - 1) * kWIDTH) {
        self.scrollView.contentOffset = CGPointMake(kWIDTH, 0);
    }
}

//下面两个方法分别用于手动拖拽时停止自动滚动
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (self.autoMoveEnabled) {
        [self initTimer];
    }
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (self.autoMoveEnabled) {
        [self stopTimer];
    }
    
}


#pragma mark - 重写自动滚动set方法
- (void)setAutoMoveEnabled:(BOOL)autoMoveEnabled {
    
    if (_autoMoveEnabled != autoMoveEnabled) {
        
        _autoMoveEnabled = autoMoveEnabled;
    }
    
    if (_autoMoveEnabled) {
        
        [self initTimer];
    }
    
    if (!_autoMoveEnabled) {
        
        [self stopTimer];
    }
    
}

- (void)initTimer {
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timerRun) userInfo:nil repeats:YES];
    
    _timer = timer;
    
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)timerRun {
    
    CGPoint offset = self.scrollView.contentOffset;
    
    NSInteger page = (offset.x + 20)/kWIDTH;
    
    [self.scrollView setContentOffset:CGPointMake((page + 1) * kWIDTH, 0) animated:YES];
    

}


- (void)stopTimer {
    
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    

    
}

- (void)dealloc {
    
    [self stopTimer];
}

@end
