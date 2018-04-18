//
//  MXRBaseBrush.m
//  MXRGraffitiBoard
//
//  Created by minjing.lin on 2018/4/16.
//  Copyright © 2018年 minjing.lin. All rights reserved.
//

#import "MXRBaseBrush.h"
#import "MXRPencilBrush.h"
#import "MXREraserBrush.h"
#import "MXRRectangleBrush.h"
#import "MXREllipseBrush.h"
#import "MXRCycleBrush.h"
#import "MXRSquareBrush.h"
#import "MXRLineBrush.h"
#import "MXRDashBrush.h"
#import "MXRArrowBrush.h"

@interface MXRBaseBrush()
/**
 *  是否需要绘制
 */
@property (nonatomic, readwrite) BOOL needsDraw;

/**
 *  初始点
 */
@property (nonatomic, readwrite) CGPoint startPoint;

/**
 *  上一点
 */
@property (nonatomic, readwrite) CGPoint previousPoint;

/**
 *  当前点
 */
@property (nonatomic, readwrite) CGPoint currentPoint;
@end

@implementation MXRBaseBrush
@synthesize lineWidth = _lineWidth, lineColor = _lineColor;


+ (id<MXRPaintBrush>)brushWithType:(BrushType)brushType {
   
    switch (brushType) {
        case BrushTypePencil:
            return [MXRPencilBrush new];
            
        case BrushTypeEraser:
            return [MXREraserBrush new];
            
        case BrushTypeLine:
            return [MXRLineBrush new];
            
        case BrushTypeDashLine:
            return [MXRDashBrush new];
            
        case BrushTypeRectangle:
            return [MXRRectangleBrush new];;
            
        case BrushTypeSquare:
            return [MXRSquareBrush new];
            
        case BrushTypeEllipse:
            return [MXREllipseBrush new];
            
        case BrushTypeCircle:
            return [MXRCycleBrush new];
            
        case BrushTypeArrow:
            return [MXRArrowBrush new];
            
    }
    return nil;
}
#pragma mark - PaintBrush 协议方法
    
- (void)beginAtPoint:(CGPoint)point {
    
    self.startPoint    = point;
    self.currentPoint  = point;
    self.previousPoint = point;
    self.needsDraw     = YES;
}
- (void)moveToPoint:(CGPoint)point {
    
    self.previousPoint = self.currentPoint;
    self.currentPoint  = point;
}

- (void)end {
    
    self.needsDraw = NO;
}

- (void)drawInContext:(CGContextRef)context {
    
    [self configureContext:context];
    
    // 画线只能通过空心来画
    CGContextStrokePath(context);
    //    CGContextFillPath(ctx);
    
}

- (CGRect)redrawRect {
    
    // 根据 起点, 上一点, 当前点 三点计算包含三点的最小重绘矩形.适用于画矩形,椭圆之类的图案.
    CGFloat minX = fmin(fmin(self.startPoint.x, self.previousPoint.x), self.currentPoint.x) - self.lineWidth / 2;
    CGFloat minY = fmin(fmin(self.startPoint.y, self.previousPoint.y), self.currentPoint.y) - self.lineWidth / 2;
    CGFloat maxX = fmax(fmax(self.startPoint.x, self.previousPoint.x), self.currentPoint.x) + self.lineWidth / 2;
    CGFloat maxY = fmax(fmax(self.startPoint.y, self.previousPoint.y), self.currentPoint.y) + self.lineWidth / 2;
    
    return CGRectMake(minX, minY, maxX - minX, maxY - minY);
    
}
#pragma mark - 配置上下文

- (void)configureContext:(CGContextRef)context {
    
    CGContextSetLineWidth(context, self.lineWidth);
    CGContextSetStrokeColorWithColor(context, self.lineColor.CGColor);
    //设置线条起点和终点的样式为圆角
    CGContextSetLineCap(context, kCGLineCapRound);
    //设置线条的转角的样式为圆角
    CGContextSetLineJoin(context, kCGLineJoinRound);
    
}
@end
