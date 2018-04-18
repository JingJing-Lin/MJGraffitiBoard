//
//  MXRLineBrush.m
//  MXRGraffitiBoard
//
//  Created by minjing.lin on 2018/4/18.
//  Copyright © 2018年 minjing.lin. All rights reserved.
//

#import "MXRLineBrush.h"

@implementation MXRLineBrush

- (void)configureContext:(CGContextRef)context{
    
    [super configureContext:context];
    
    // 直线工具在基类的基础上将 初始点 和 当前点连线即可.
    CGContextMoveToPoint(context, self.startPoint.x, self.startPoint.y);
    CGContextAddLineToPoint(context, self.currentPoint.x, self.currentPoint.y);
}
@end
