//
//  MXRDashBrush.m
//  MXRGraffitiBoard
//
//  Created by minjing.lin on 2018/4/18.
//  Copyright © 2018年 minjing.lin. All rights reserved.
//

#import "MXRDashBrush.h"

@implementation MXRDashBrush

- (void)configureContext:(CGContextRef)context{
    
    [super configureContext:context];
    
    // 虚线在父类直线的基础上设置虚线性质即可.
    CGFloat lengths[2] = {self.lineWidth,self.lineWidth * 2};
    CGContextSetLineDash(context, 0, lengths, 2);
    
    // lengths的值｛10,10｝表示先绘制10个点，再跳过10个点，如此反复
    
    // 如果把lengths值改为｛10, 20, 10｝，则表示先绘制10个点，跳过20个点，绘制10个点，跳过10个点，再绘制20个点，如此反复

    // 注意count的值等于lengths数组的长度
}

@end
