//
//  MXREllipseBrush.m
//  MXRGraffitiBoard
//
//  Created by minjing.lin on 2018/4/18.
//  Copyright © 2018年 minjing.lin. All rights reserved.
//

#import "MXREllipseBrush.h"

@implementation MXREllipseBrush

-(void)drawInContext:(CGContextRef)context{
    
    [self configureContext:context];
    
    //椭圆的边框
    CGContextStrokeEllipseInRect(context, self.rectToDraw);
    
    //实心圆
//    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
//    CGContextFillEllipseInRect(context, self.rectToDraw);

    
}

@end
