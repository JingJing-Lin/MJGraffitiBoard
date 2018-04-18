//
//  MXRWindow.m
//  MXRGraffitiBoard
//
//  Created by minjing.lin on 2018/4/17.
//  Copyright © 2018年 minjing.lin. All rights reserved.
//

#import "MXRWindow.h"

@interface MXRWindow()

@property (nonatomic, weak) UIView *animationView;

@end

@implementation MXRWindow

- (instancetype)initWithAnimationView:(UIView *)animationView {
    
    if (self = [super initWithFrame:[[UIScreen mainScreen] bounds]]) {
        
        self.windowLevel = UIWindowLevelAlert;
        self.animationView = animationView;
        [self addSubview:self.animationView];
        
        [[NSNotificationCenter defaultCenter] addObserverForName:@"hideTopWindow" object:nil queue:nil usingBlock:^(NSNotification *note) {
            [self hideWithAnimationTime:self.animationTime];
        }];
        
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    CGPoint touchPoint = [[touches anyObject] locationInView:self];
//    if (!CGRectContainsPoint(self.animationView.frame, touchPoint)){
//        [self hideWithAnimationTime:self.animationTime];
//    }
    // mjfix 暂且这样
    BOOL isEqual = CGPointEqualToPoint(touchPoint, CGPointMake(0, 736));
    if (!isEqual) {
         [self hideWithAnimationTime:self.animationTime];
    }
    
}

- (void)showWithAnimationTime:(NSTimeInterval)second {
    
    self.animationTime  = second;
    [self makeKeyAndVisible];
    [UIView animateWithDuration:self.animationTime delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [UIView animateWithDuration:0.1 animations:^{
            self.animationView.transform = CGAffineTransformMakeTranslation(0, -self.animationView.bounds.size.height);
        }];
    } completion:^(BOOL finished) {
        self.hidden = NO;
    }];
}

- (void)hideWithAnimationTime:(NSTimeInterval)second {
    
    self.animationTime  = second;
    [UIView animateWithDuration:self.animationTime delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [UIView animateWithDuration:0.1 animations:^{
            self.animationView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            self.hidden = YES;
        }];
    } completion:^(BOOL finished) {
    }];
}

#pragma mark - delloc

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"hideTopWindow" object:nil];
    
}
@end
