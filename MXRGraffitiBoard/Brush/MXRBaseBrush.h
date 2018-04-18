//
//  MXRBaseBrush.h
//  MXRGraffitiBoard
//
//  Created by minjing.lin on 2018/4/16.
//  Copyright © 2018年 minjing.lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MXRPaintBrush.h"
@import UIKit;
/**
 *  涂鸦工具
 */
typedef NS_ENUM(NSUInteger, BrushType) {
    /**
     *  画笔
     */
    BrushTypePencil,
    /**
     *  橡皮
     */
    BrushTypeEraser,
    /**
     *  直线
     */
    BrushTypeLine,
    /**
     *  虚线
     */
    BrushTypeDashLine,
    /**
     *  矩形
     */
    BrushTypeRectangle,
    /**
     *  方形
     */
    BrushTypeSquare,
    /**
     *  椭圆
     */
    BrushTypeEllipse,
    /**
     *  正圆
     */
    BrushTypeCircle,
    /**
     *  箭头
     */
    BrushTypeArrow,
};

@interface MXRBaseBrush : NSObject<MXRPaintBrush>

/**
 *  初始点
 */
@property (nonatomic, readonly) CGPoint startPoint;

/**
 *  上一点
 */
@property (nonatomic, readonly) CGPoint previousPoint;

/**
 *  当前点
 */
@property (nonatomic, readonly) CGPoint currentPoint;

/**
 *  配置上下文
 *
 *  @param context 上下文
 */
- (void)configureContext:(CGContextRef)context;

/**
 *  创建对应类型的涂鸦工具
 *
 *  @param brushType 涂鸦类型
 *
 *  @return 涂鸦工具代理协议
 */
+ (id<MXRPaintBrush>)brushWithType:(BrushType)brushType;

@end
