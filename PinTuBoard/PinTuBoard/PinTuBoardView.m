//
//  PinTuBoardView.m
//  PinTuBoard
//
//  Created by Walle on 15/1/30.
//  Copyright (c) 2015年 Walle. All rights reserved.
//  拼图板视图，里面是一个个的小格子 头文件

#import "PinTuBoardView.h"
#import "PinTuViewCell.h"

@interface PinTuBoardView ()
{
    NSMutableArray *_arySubViews;
}
@end

@implementation PinTuBoardView

- (instancetype)initWithRows:(NSInteger)rows Columns:(NSInteger)columns
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        _rows = rows;
        _columns = columns;
    }
    
    return self;
}

- (void) setDisplayViewWithImage:(UIImage *)img
{
    if (!_arySubViews) {
        _arySubViews = [NSMutableArray array];
    }
    
    for (NSInteger i = 0; i < _arySubViews.count; i++) {
        PinTuViewCell *view = [_arySubViews objectAtIndex:i];
        [view removeFromSuperview];
    }
    
    [_arySubViews removeAllObjects];
    
    for (int i = 0; i < _rows * _columns - 1; ++i) {
        PinTuViewCell *view = [[PinTuViewCell alloc] init];
        view.tag = i;
        view.nCurIndex = i;
        [self resetViewPosition:view];
        
        // 设置view显示的图片
        CGRect frame = view.frame;
        CGFloat scaleWidth = img.size.width / self.bounds.size.width;
        CGFloat scaleHeight = img.size.height / self.bounds.size.height;
        CGRect rect = CGRectMake(frame.origin.x * scaleWidth, frame.origin.y * scaleHeight, frame.size.width * scaleWidth, frame.size.height * scaleHeight);
        CGImageRef imgRef = CGImageCreateWithImageInRect([img CGImage], rect);
        view.image = [UIImage imageWithCGImage:imgRef];
        
        [_arySubViews addObject:view];
        
        [self addSubview:view];
        
        //设置四个方向的轻扫
        //向左
        UISwipeGestureRecognizer *swipeleft=[[UISwipeGestureRecognizer alloc]init];
        //设置轻扫的方向
        swipeleft.direction=UISwipeGestureRecognizerDirectionLeft;
        [view addGestureRecognizer:swipeleft];
        [swipeleft addTarget:self action:@selector(swipeleftView:)];
        
        //向右
        UISwipeGestureRecognizer *swiperight=[[UISwipeGestureRecognizer alloc]init];
        //设置轻扫的方向
        swiperight.direction=UISwipeGestureRecognizerDirectionRight;
        [view addGestureRecognizer:swiperight];
        [swiperight addTarget:self action:@selector(swiperightView:)];
        
        //向下
        UISwipeGestureRecognizer *swipedown=[[UISwipeGestureRecognizer alloc]init];
        //设置轻扫的方向
        swipedown.direction=UISwipeGestureRecognizerDirectionDown;
        [view addGestureRecognizer:swipedown];
        [swipedown addTarget:self action:@selector(swipedownView:)];
        
        //向上
        UISwipeGestureRecognizer *swipeup=[[UISwipeGestureRecognizer alloc]init];
        //设置轻扫的方向
        swipeup.direction=UISwipeGestureRecognizerDirectionUp;
        [view addGestureRecognizer:swipeup];
        [swipeup addTarget:self action:@selector(swipeupView:)];
    }
}

-(void)swipeleftView:(UISwipeGestureRecognizer *)swipe
{
    PinTuViewCell *view = (PinTuViewCell *)[swipe view];
    int nCurIndex = (int)view.nCurIndex;
    
    if (nCurIndex % _columns == 0) {
        return;
    }
    
    int nLeftIndex = nCurIndex - 1;
    if ([self isEmptyAtIndex:nLeftIndex]) {
        [UIView animateWithDuration:0.2 animations:^{
            view.nCurIndex = nLeftIndex;
            [self resetViewPosition:view];
        }];
    }
}

-(void)swiperightView:(UISwipeGestureRecognizer *)swipe
{
    PinTuViewCell *view = (PinTuViewCell *)[swipe view];
    int nCurIndex = (int)view.nCurIndex;
    
    if (nCurIndex % _columns == _columns - 1) {
        return;
    }
    
    int nRightIndex = nCurIndex + 1;
    if ([self isEmptyAtIndex:nRightIndex]) {
        [UIView animateWithDuration:0.2 animations:^{
            view.nCurIndex = nRightIndex;
            [self resetViewPosition:view];
        }];
    }
}

-(void)swipedownView:(UISwipeGestureRecognizer *)swipe
{
    PinTuViewCell *view = (PinTuViewCell *)[swipe view];
    int nCurIndex = (int)view.nCurIndex;
    
    if (nCurIndex >= (_columns * _rows - _columns)) {
        return;
    }
    
    int nDownIndex = (int)(nCurIndex + _columns);
    if ([self isEmptyAtIndex:nDownIndex]) {
        [UIView animateWithDuration:0.2 animations:^{
            view.nCurIndex = nDownIndex;
            [self resetViewPosition:view];
        }];
    }
}

-(void)swipeupView:(UISwipeGestureRecognizer *)swipe
{
    PinTuViewCell *view = (PinTuViewCell *)[swipe view];
    int nCurIndex = (int)view.nCurIndex;
    
    if (nCurIndex < _columns) {
        return;
    }
    
    int nUpIndex = (int)(nCurIndex - _columns);
    if ([self isEmptyAtIndex:nUpIndex]) {
        [UIView animateWithDuration:0.2 animations:^{
            view.nCurIndex = nUpIndex;
            [self resetViewPosition:view];
        }];
    }
}

- (void)randomSubviews
{
    NSInteger count = _arySubViews.count;
    if (count > 0) {
        // 生成一个随机数组
        NSMutableArray *aryIndex = [NSMutableArray array];
        for (NSInteger i = 0; i <= count;) {
            NSInteger index = arc4random() % (count+1);
            if ([aryIndex containsObject:[NSNumber numberWithInteger:index]]) {
                continue;
            }
            
            [aryIndex addObject:[NSNumber numberWithInteger:index]];
            i++;
        }
        
        for (NSInteger i = 0; i < count; i++) {
            PinTuViewCell *view = [_arySubViews objectAtIndex:i];
            if (!view) {
                return;
            }
            
            view.nCurIndex = [[aryIndex objectAtIndex:i] intValue];
            [self resetViewPosition:view];
        }
    }
}

- (void)resetSubviews
{
    for (NSInteger i = 0; i < _arySubViews.count; i++) {
        PinTuViewCell *view = [_arySubViews objectAtIndex:i];
        if (view.tag != view.nCurIndex) {
            view.nCurIndex = view.tag;
            [self resetViewPosition:view];
        }
    }
}

-(BOOL)isEmptyAtIndex:(int)index
{
    for (int i = 0; i < _arySubViews.count; ++i) {
        PinTuViewCell *view = (PinTuViewCell *)[_arySubViews objectAtIndex:i];
        if (view.nCurIndex == index) {
            return NO;
        }
    }
    
    return YES;
}

-(void)resetViewPosition:(PinTuViewCell *)view
{
    if (view == nil) {
        return;
    }
    
    NSInteger index = view.nCurIndex;
    
    CGFloat x = self.bounds.size.width/_columns * (index%_columns);
    CGFloat y = self.bounds.size.height/_rows * (index/_columns);
    CGRect frame = CGRectMake(x, y, self.bounds.size.width/_columns, self.bounds.size.height/_rows);
    view.frame = frame;
}

@end
