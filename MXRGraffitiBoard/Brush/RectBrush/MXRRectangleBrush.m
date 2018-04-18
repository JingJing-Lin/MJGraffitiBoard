//
//  MXRRectangleBrush.m
//  MXRGraffitiBoard
//
//  Created by minjing.lin on 2018/4/18.
//  Copyright © 2018年 minjing.lin. All rights reserved.
//

#import "MXRRectangleBrush.h"

@implementation MXRRectangleBrush

-(void)drawInContext:(CGContextRef)context{
    [self configureContext:context];
    
    // 这里选择重写此方法自己画,因为在 configureContext 中添加路径的话会影响子类.
    
    CGContextStrokeRect(context, self.rectToDraw);
}

// 定义椭圆/矩形的左上角位置，宽度，高度
-(CGRect)rectToDraw{
    return (CGRect){
        MIN(self.startPoint.x, self.currentPoint.x),
        MIN(self.startPoint.y, self.currentPoint.y),
        ABS(self.startPoint.x - self.currentPoint.x),
        ABS(self.startPoint.y - self.currentPoint.y),
    };
}
@end
