//
//  MXRWindow.h
//  MXRGraffitiBoard
//
//  Created by minjing.lin on 2018/4/17.
//  Copyright © 2018年 minjing.lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MXRWindow : UIWindow

@property (nonatomic, assign) NSTimeInterval animationTime;

- (instancetype)initWithAnimationView:(UIView *)animationView;

- (void)showWithAnimationTime:(NSTimeInterval)second;

- (void)hideWithAnimationTime:(NSTimeInterval)second;


@end
