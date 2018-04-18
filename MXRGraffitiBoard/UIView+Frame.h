//
//  UIView+Frame.h
//  MXRGraffitiBoard
//
//  Created by minjing.lin on 2018/4/17.
//  Copyright © 2018年 minjing.lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

@property(nonatomic,assign) CGFloat x;
@property(nonatomic,assign) CGFloat y;


@property(nonatomic,assign) CGFloat width;
@property(nonatomic,assign) CGFloat height;

@property(nonatomic,assign) CGFloat centerX;
@property(nonatomic,assign) CGFloat centerY;

@property(nonatomic,assign) CGSize size;

@end
