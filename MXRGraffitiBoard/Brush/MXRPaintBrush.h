//
//  MXRPaintBrush.h
//  MXRGraffitiBoard
//
//  Created by minjing.lin on 2018/4/16.
//  Copyright © 2018年 minjing.lin. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@protocol MXRPaintBrush <NSObject>

/**
 *  线条粗细
 */
@property (nonatomic) CGFloat lineWidth;

/**
 *  线条颜色
 */
@property (nonatomic, strong) UIColor *lineColor;

/**
 *  需要重绘的矩形范围
 */
@property (nonatomic, readonly) CGRect redrawRect;

/**
 *  是否需要绘制
 */
@property (nonatomic, readonly) BOOL needsDraw;

/**
 *  绘制图案到上下文
 *
 *  @param context 上下文
 */
- (void)drawInContext:(CGContextRef)context;

/**
 *  从指定点开始
 *
 *  @param point 指定点（坐标）
 */
- (void)beginAtPoint:(CGPoint)point;

/**
 *  移动到指定点
 *
 *  @param point 指定点（坐标）
 */
- (void)moveToPoint:(CGPoint)point;

/**
 *  移动结束
 */
- (void)end;

@end
