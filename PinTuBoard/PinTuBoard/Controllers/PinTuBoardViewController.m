//
//  PinTuBoardViewController.m
//  PinTuBoard
//
//  Created by Walle on 15/1/30.
//  Copyright (c) 2015年 Walle. All rights reserved.
//  拼图板游戏主界面实现文件

#import "PinTuBoardViewController.h"
#import "PinTuBoardView.h"

#define MARGIN 10                           // 控件间距
#define BOARD_TO_VIEW_HEIGHT_RATE 0.75      // 拼图视图占手机屏幕的高度比

@interface PinTuBoardViewController ()
{
    PinTuBoardView *_contentView;
    UIImageView *_previewImage;
}

@end

@implementation PinTuBoardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    CGSize sizeParentView = self.view.bounds.size;
    UIImage *img = [UIImage imageNamed:@"defaultPic.png"];
    
    if (!_contentView) {
        _contentView = [[PinTuBoardView alloc] initWithRows:4 Columns:3];
        
        _contentView.frame = CGRectMake(MARGIN, sizeParentView.height * (1 - BOARD_TO_VIEW_HEIGHT_RATE), sizeParentView.width - 2 * MARGIN, sizeParentView.height * BOARD_TO_VIEW_HEIGHT_RATE - MARGIN);
        
        [self.view addSubview:_contentView];
        
        [_contentView setDisplayViewWithImage:img];
    }
    
    // 调整预览图片的位置
    if (!_previewImage) {
        _previewImage = [[UIImageView alloc] init];
        _previewImage.image = img;
        
        CGRect preImageFrame = CGRectZero;
        preImageFrame.origin.x = MARGIN;
        preImageFrame.origin.y = MARGIN;
        preImageFrame.size.height = sizeParentView.height * (1 - BOARD_TO_VIEW_HEIGHT_RATE) - 2 * MARGIN;
        preImageFrame.size.width = _contentView.bounds.size.width * preImageFrame.size.height / _contentView.bounds.size.height;
        _previewImage.frame = preImageFrame;
        
        [self.view addSubview:_previewImage];
    }
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
