//
//  MXRPaintingView.h
//  MXRGraffitiBoard
//
//  Created by minjing.lin on 2018/4/16.
//  Copyright © 2018年 minjing.lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MXRPaintBrush;

@interface MXRPaintingView : UIView

/**
 *  背景照片
 */
@property (nonatomic, strong) UIImage *backgroundImage;

/**
 *  画刷
 */
@property (nonatomic, strong) id<MXRPaintBrush> paintBrush;

/**
 *  能否撤销
 */
@property (nonatomic, readonly) BOOL canUndo;

/**
 *  能否恢复
 */
@property (nonatomic, readonly) BOOL canRedo;

/**
 *  撤销
 */
- (void)undo;

/**
 *  恢复
 */
- (void)redo;

/**
 *  清屏
 */
- (void)clear;

/**
 *  保存画板内容到系统相册
 */
- (void)saveToPhotosAlbum;

@end
