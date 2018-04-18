//
//  MXRCycleBrush.m
//  MXRGraffitiBoard
//
//  Created by minjing.lin on 2018/4/18.
//  Copyright © 2018年 minjing.lin. All rights reserved.
//

#import "MXRCycleBrush.h"

@implementation MXRCycleBrush


- (CGRect)rectToDraw {
    
    CGRect  rect   = super.rectToDraw;
    CGFloat radius = MIN(ABS(self.startPoint.x - self.currentPoint.x),
                         ABS(self.startPoint.y - self.currentPoint.y));
    
    rect.size = CGSizeMake(radius, radius);
    
    CGFloat startX   = self.startPoint.x,   startY   = self.startPoint.y;
    CGFloat currentX = self.currentPoint.x, currentY = self.currentPoint.y;
    
    // 对原点进行调整,让圆圈始终围绕起点变换大小位置.
    if (currentX < startX) {
        rect.origin.x += startX - currentX - radius;
    }
    if (currentY < startY) {
        rect.origin.y += startY - currentY - radius;
    }
    
    return rect;
    
}

- (CGRect)redrawRect {
    
    // 调整重绘矩形范围,使之匹配实际的圆形.
    CGRect  rect   = super.redrawRect;
    CGSize  size   = rect.size;
    CGPoint origin = rect.origin;
    
    CGFloat startX   = self.startPoint.x,   startY   = self.startPoint.y;
    CGFloat currentX = self.currentPoint.x, currentY = self.currentPoint.y;
    
    if (size.height > size.width) {
        if (currentY < startY) {
            origin.y += size.height - size.width;
        }
        size.height = size.width;
    }
    
    if (size.width > size.height) {
        if (currentX < startX) {
            origin.x += size.width - size.height;
        }
        size.width = size.height;
    }
    
    return (CGRect) { origin, size };
    
}

@end
