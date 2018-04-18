//
//  MXRPaintingLayer.h
//  MXRGraffitiBoard
//
//  Created by minjing.lin on 2018/4/16.
//  Copyright © 2018年 minjing.lin. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@import UIKit;

@protocol MXRPaintBrush;

@interface MXRPaintingLayer : CALayer

/**
 *  能否撤销
 */
@property (nonatomic, readonly) BOOL canUndo;

/**
 *  能否恢复
 */
@property (nonatomic, readonly) BOOL canRedo;

/**
 *  画刷对象
 */
@property (nonatomic, strong) id<MXRPaintBrush> paintBrush;

/**
 *  触摸事件响应,于四个触摸事件发生时调用此方法并将 UITouch 传入
 *
 *  @param touch Touch
 */
- (void)touchAction:(UITouch *)touch;

/**
 *  清屏
 */
- (void)clear;

/**
 *  撤销
 */
- (void)undo;

/**
 *  恢复
 */
- (void)redo;


@end
