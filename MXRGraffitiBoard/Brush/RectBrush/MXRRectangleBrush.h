//
//  MXRRectangleBrush.h
//  MXRGraffitiBoard
//
//  Created by minjing.lin on 2018/4/18.
//  Copyright © 2018年 minjing.lin. All rights reserved.
//

#import "MXRBaseBrush.h"

@interface MXRRectangleBrush : MXRBaseBrush


/**
 获取用于椭圆/矩形绘制的矩形范围
 */
@property (nonatomic, readonly) CGRect rectToDraw;

@end
