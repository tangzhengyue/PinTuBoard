//
//  PinTuViewCell.h
//  PinTuBoard
//
//  Created by Walle on 15/1/30.
//  Copyright (c) 2015年 Walle. All rights reserved.
//  拼图板的一个小格子视图 头文件

#import <UIKit/UIKit.h>

@interface PinTuViewCell : UIView

@property(nonatomic, assign) CGRect rect;
@property(nonatomic, assign) NSInteger nCurIndex;
@property(nonatomic, strong) UIImage *image;

@end
