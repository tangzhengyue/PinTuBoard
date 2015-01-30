//
//  PinTuBoardView.h
//  PinTuBoard
//
//  Created by Walle on 15/1/30.
//  Copyright (c) 2015年 Walle. All rights reserved.
//  拼图板视图，里面是一个个的小格子 头文件

#import <UIKit/UIKit.h>

@interface PinTuBoardView : UIView

@property (nonatomic, assign) NSInteger rows;
@property (nonatomic, assign) NSInteger columns;

- (instancetype)initWithRows:(NSInteger)rows Columns:(NSInteger)columns;
- (void) setDisplayViewWithImage:(UIImage *)img;
- (void)randomSubviews;
- (void)resetSubviews;

@end
