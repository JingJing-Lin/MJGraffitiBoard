//
//  MXREraserBrush.m
//  MXRGraffitiBoard
//
//  Created by minjing.lin on 2018/4/17.
//  Copyright © 2018年 minjing.lin. All rights reserved.
//

#import "MXREraserBrush.h"

@implementation MXREraserBrush

- (void)configureContext:(CGContextRef)context {
    
    [super configureContext:context];
    
    // 橡皮只要在父类普通画笔的基础上将混合模式由默认的 normal 改为 clear 即可.
    CGContextSetBlendMode(context, kCGBlendModeClear);
    
}

@end
