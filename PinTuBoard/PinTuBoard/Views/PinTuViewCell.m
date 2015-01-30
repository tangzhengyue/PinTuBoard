//
//  PinTuViewCell.m
//  PinTuBoard
//
//  Created by Walle on 15/1/30.
//  Copyright (c) 2015年 Walle. All rights reserved.
//  拼图板的一个小格子视图 实现文件

#import "PinTuViewCell.h"

@implementation PinTuViewCell

- (void)drawRect:(CGRect)rect
{
    if (!_image) {
        return;
    }
    
    // 绘制小格子的边框
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextAddRect(ctx, rect);
    [[UIColor lightGrayColor] set];
    CGContextFillPath(ctx);
    
    int radius = 5;
    CGMutablePathRef pathLine = CGPathCreateMutable();
    CGPathMoveToPoint(pathLine, NULL, radius, 0);
    CGPathAddLineToPoint(pathLine, NULL, rect.size.width - radius, 0);
    CGPathAddArc(pathLine, NULL, rect.size.width - radius, radius, radius, -M_PI_2, 0, 0);
    CGPathAddLineToPoint(pathLine, NULL, rect.size.width, rect.size.height - radius);
    CGPathAddArc(pathLine, NULL, rect.size.width - radius, rect.size.height - radius, radius, 0, M_PI_2, 0);
    CGPathAddLineToPoint(pathLine, NULL, rect.size.width - radius, rect.size.height);
    CGPathAddArc(pathLine, NULL, radius, rect.size.height - radius, radius, M_PI_2, M_PI, 0);
    CGPathAddLineToPoint(pathLine, NULL, 0, radius);
    CGPathAddArc(pathLine, NULL, radius, radius, radius, M_PI, -M_PI_2, 0);
    
    
    CGContextAddPath(ctx, pathLine);
    
    CGContextClip(ctx);
    
    [_image drawInRect:rect];
    
    CGContextMoveToPoint(ctx, rect.size.width, 0);
    CGContextAddLineToPoint(ctx, rect.size.width, rect.size.height - radius);
    CGContextAddArc(ctx, rect.size.width - radius, rect.size.height - radius, radius, 0, M_PI_2, 0);
    CGContextAddLineToPoint(ctx, 0, rect.size.height);
    
    
    [[UIColor grayColor] set];
    CGContextSetLineWidth(ctx, 2);
    CGContextStrokePath(ctx);
    
    CGContextMoveToPoint(ctx, 0, rect.size.height);
    CGContextAddLineToPoint(ctx, 0, radius);
    CGContextAddArc(ctx, radius, radius, radius, M_PI, -M_PI_2, 0);
    CGContextAddLineToPoint(ctx, rect.size.width, 0);
    
    [[UIColor whiteColor] set];
    CGContextSetLineWidth(ctx, 2);
    CGContextStrokePath(ctx);
}

@end
