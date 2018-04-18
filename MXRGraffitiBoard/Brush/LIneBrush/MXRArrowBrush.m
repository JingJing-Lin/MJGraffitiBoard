//
//  MXRArrowBrush.m
//  MXRGraffitiBoard
//
//  Created by minjing.lin on 2018/4/18.
//  Copyright © 2018年 minjing.lin. All rights reserved.
//

#import "MXRArrowBrush.h"

/**
 *  箭头分叉的长度
 */
static const CGFloat kRamifyLength = 30;

/**
 *  箭头分叉和直线间的夹角
 */
static const CGFloat kRamifyAngle  = M_PI_4 * 0.6;

@interface MXRArrowBrush()

/**
 *  是否绘制箭头
 */
@property (nonatomic) BOOL showArrow;

/**
 *  沿箭头方向看,箭头左分支的端点
 */
@property (nonatomic) CGPoint leftRamifyPoint;

/**
 *  沿箭头方向看,箭头右分支的端点
 */
@property (nonatomic) CGPoint rightRamifyPoint;

@end

@implementation MXRArrowBrush

-(void)beginAtPoint:(CGPoint)point{
    
    [super beginAtPoint:point];
    
    self.leftRamifyPoint  = point;
    self.rightRamifyPoint = point;
}

- (void)moveToPoint:(CGPoint)point
{
    [super moveToPoint:point];
    
    // 到起点的距离小于箭头分叉长度1.5倍时不要绘制箭头,否则直线太短就俩分叉好难看.
    CGFloat dx = point.x - self.startPoint.x;
    CGFloat dy = point.y - self.startPoint.y;
    
    self.showArrow = ( (dx * dx + dy * dy) > (2.25 * kRamifyLength * kRamifyLength) );
}

- (void)end
{
    [super end];
    
    self.showArrow = NO;
}

- (void)configureContext:(CGContextRef)context
{
    [super configureContext:context];
    
    [self p_calculateRamifyPoint];
    
    CGFloat endX = self.currentPoint.x;
    CGFloat endY = self.currentPoint.y;
    
    // 画直线.
    CGContextMoveToPoint(context, self.startPoint.x, self.startPoint.y);
    CGContextAddLineToPoint(context, endX, endY);
    
    // 画左分叉.
    CGContextMoveToPoint(context, endX, endY);
    CGContextAddLineToPoint(context, self.leftRamifyPoint.x, self.leftRamifyPoint.y);
    
    // 画右分叉.
    CGContextMoveToPoint(context, endX, endY);
    CGContextAddLineToPoint(context, self.rightRamifyPoint.x, self.rightRamifyPoint.y);
    
}

- (void)drawInContext:(CGContextRef)context{
    
    if (!self.showArrow) return; // 小于显示距离则不显示箭头,如果当前显示了箭头,则箭头会消失,直到达到距离要求.
    
    [super drawInContext:context];
}
- (CGRect)redrawRect
{
    CGFloat minX = fmin(fmin(fmin(fmin(self.startPoint.x,
                                       self.previousPoint.x),
                                  self.currentPoint.x),
                             self.leftRamifyPoint.x),
                        self.rightRamifyPoint.x) - self.lineWidth / 2;
    
    CGFloat minY = fmin(fmin(fmin(fmin(self.startPoint.y,
                                       self.previousPoint.y),
                                  self.currentPoint.y),
                             self.leftRamifyPoint.y),
                        self.rightRamifyPoint.y) - self.lineWidth / 2;
    
    CGFloat maxX = fmax(fmax(fmax(fmax(self.startPoint.x,
                                       self.previousPoint.x),
                                  self.currentPoint.x),
                             self.leftRamifyPoint.x),
                        self.rightRamifyPoint.x) + self.lineWidth / 2;
    
    CGFloat maxY = fmax(fmax(fmax(fmax(self.startPoint.y,
                                       self.previousPoint.y),
                                  self.currentPoint.y),
                             self.leftRamifyPoint.y),
                        self.rightRamifyPoint.y) + self.lineWidth / 2;
    
    return CGRectMake(minX, minY, maxX - minX, maxY - minY);
}


#pragma mark - 计算分叉点

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wfloat-equal"
#pragma clang diagnostic ignored "-Wdirect-ivar-access"
/**
 计算左右两个分叉点.  待理解
 */
- (void)p_calculateRamifyPoint{
    
    CGFloat startX = self.startPoint.x, startY = self.startPoint.y;
    CGFloat endX   = self.currentPoint.x, endY = self.currentPoint.y;
    
    CGFloat dx = endX - startX;
    CGFloat dy = endY - startY;
    
    CGFloat θ = atan(ABS(dy / dx)); // 箭头分叉与直线的夹角为 θ.
    
    if (dx > 0 && dy < 0) {      // 第一象限.
        _leftRamifyPoint.x  = endX - kRamifyLength * cos(θ - kRamifyAngle);
        _leftRamifyPoint.y  = endY + kRamifyLength * sin(θ - kRamifyAngle);
        
        _rightRamifyPoint.x = endX - kRamifyLength * sin(M_PI_2 - kRamifyAngle - θ);
        _rightRamifyPoint.y = endY + kRamifyLength * cos(M_PI_2 - kRamifyAngle - θ);
    }
    else if (dx < 0 && dy < 0) { // 第二象限.
        _leftRamifyPoint.x  = endX - kRamifyLength * sin(θ + kRamifyAngle - M_PI_2);
        _leftRamifyPoint.y  = endY + kRamifyLength * cos(θ + kRamifyAngle - M_PI_2);
        
        _rightRamifyPoint.x = endX + kRamifyLength * cos(θ - kRamifyAngle);
        _rightRamifyPoint.y = endY + kRamifyLength * sin(θ - kRamifyAngle);
    }
    else if (dx < 0 && dy > 0) { // 第三象限.
        _leftRamifyPoint.x  = endX + kRamifyLength * cos(θ - kRamifyAngle);
        _leftRamifyPoint.y  = endY - kRamifyLength * sin(θ - kRamifyAngle);
        
        _rightRamifyPoint.x = endX - kRamifyLength * sin(θ + kRamifyAngle - M_PI_2);
        _rightRamifyPoint.y = endY - kRamifyLength * cos(θ + kRamifyAngle - M_PI_2);
    }
    else if (dx > 0 && dy > 0) { // 第四象限.
        _leftRamifyPoint.x  = endX - kRamifyLength * cos(θ - kRamifyAngle);
        _leftRamifyPoint.y  = endY - kRamifyLength * sin(θ - kRamifyAngle);
        
        _rightRamifyPoint.x = endX + kRamifyLength * sin(θ + kRamifyAngle - M_PI_2);
        _rightRamifyPoint.y = endY - kRamifyLength * cos(θ + kRamifyAngle - M_PI_2);
    }
    else if (dx > 0 && dy == 0) { // x 正轴.
        _leftRamifyPoint.x  = endX - kRamifyLength * cos(kRamifyAngle);
        _leftRamifyPoint.y  = endY - kRamifyLength * sin(kRamifyAngle);
        
        _rightRamifyPoint.x = _leftRamifyPoint.x;
        _rightRamifyPoint.y = endY + kRamifyLength * sin(kRamifyAngle);
    }
    else if (dx < 0 && dy == 0) { // x 负轴.
        _leftRamifyPoint.x  = endX + kRamifyLength * cos(kRamifyAngle);
        _leftRamifyPoint.y  = endY + kRamifyLength * sin(kRamifyAngle);
        
        _rightRamifyPoint.x = _leftRamifyPoint.x;
        _rightRamifyPoint.y = endY - kRamifyLength * sin(kRamifyAngle);
    }
    else if (dx == 0 && dy < 0) { // y 正轴.
        _leftRamifyPoint.x  = endX - kRamifyLength * sin(kRamifyAngle);
        _leftRamifyPoint.y  = endY + kRamifyLength * cos(kRamifyAngle);
        
        _rightRamifyPoint.x = endX + kRamifyLength * sin(kRamifyAngle);
        _rightRamifyPoint.y = _leftRamifyPoint.y;
    }
    else if (dx == 0 && dy > 0) { // y 负轴.
        _leftRamifyPoint.x  = endX + kRamifyLength * sin(kRamifyAngle);
        _leftRamifyPoint.y  = endY - kRamifyLength * cos(kRamifyAngle);
        
        _rightRamifyPoint.x = endX - kRamifyLength * sin(kRamifyAngle);
        _rightRamifyPoint.y = _leftRamifyPoint.y;
    }
    else {
        // 原点不用考虑.
    }
}
#pragma clang diagnostic pop

@end

/**
 atan 和 atan2 都是求反正切函数，如：有两个点 point(x1,y1), 和 point(x2,y2);
 那么这两个点形成的斜率的角度计算方法分别是：
 float angle = atan( (y2-y1)/(x2-x1) );
 或
 float angle = atan2( y2-y1, x2-x1 );
 
 atan 和 atan2 区别：
 1、参数的填写方式不同；
 2、atan2 的优点在于 如果 x2-x1等于0 依然可以计算，但是atan函数就会导致程序出错
 
 */
