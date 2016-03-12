//
//  LWXScrollView.h
//  ScrollViewDemo
//
//  Created by student on 16/2/25.
//  Copyright © 2016年 student. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LWXScrollView : UIView


@property (nonatomic, assign) BOOL autoMoveEnabled;//是否开启自动滚动


- (instancetype)initWithFrame:(CGRect)frame withImageArray:(NSArray *)image;


@end
