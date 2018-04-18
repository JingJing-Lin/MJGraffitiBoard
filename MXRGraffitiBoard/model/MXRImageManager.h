//
//  MXRImageManager.h
//  MXRGraffitiBoard
//
//  Created by minjing.lin on 2018/4/16.
//  Copyright © 2018年 minjing.lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@import UIKit;

@interface MXRImageManager : NSObject

/**
 *  获取图片管理者
 *
 *  @return 图片管理者
 */
+ (instancetype)sharedImageManger;

/**
 *  添加图片
 *
 *  @param image 图片
 */
- (void)addImage:(UIImage *)image;

/**
 *  是否可以撤销
 *
 *  @return 是否
 */
- (BOOL)canUndo;

/**
 *  获取撤销操作的图片
 *
 *  @return 图片
 */
- (UIImage *)imageForUndo;

/**
 *  是否可以恢复
 *
 *  @return 是否
 */
- (BOOL)canRedo;

/**
 *  获取恢复操作的图片
 *
 *  @return 图片
 */
- (UIImage *)imageForRedo;

/**
 *  移除所有图片
 */
- (void)removeAllImages;

@end
