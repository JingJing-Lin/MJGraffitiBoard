//
//  MXRSquareBrush.m
//  MXRGraffitiBoard
//
//  Created by minjing.lin on 2018/4/18.
//  Copyright © 2018年 minjing.lin. All rights reserved.
//

#import "MXRSquareBrush.h"

@implementation MXRSquareBrush

- (void)drawInContext:(CGContextRef)context {
    
//    [self configureContext:context];
//
//    // 由于继承自圆类,原点会自动调整的,直接画矩形即可.
//    CGContextStrokeRect(context, self.rectToDraw);
    
    //实心圆
    CGContextSetFillColorWithColor(context, self.lineColor.CGColor);
    CGContextFillRect(context, self.rectToDraw);
    
}

@end
