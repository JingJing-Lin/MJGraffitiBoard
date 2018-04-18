//
//  MXRGraffitiBoardViewController.h
//  MXRGraffitiBoard
//
//  Created by minjing.lin on 2018/4/16.
//  Copyright © 2018年 minjing.lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MXRGraffitiBoardViewController;

typedef NS_ENUM(NSInteger, actionOpen) {
    actionOpenAlbum,
    actionOpenCamera
};

@protocol MXRGraffitiBoardViewControllerDelegate <NSObject>

- (void)drawView:(MXRGraffitiBoardViewController *)graffitiBoardVC action:(actionOpen)action;

@end

@interface MXRGraffitiBoardViewController : UIViewController


@property (nonatomic, weak) id<MXRGraffitiBoardViewControllerDelegate> delegate;
@end
