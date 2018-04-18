//
//  MXRDrawCommon.h
//  MXRGraffitiBoard
//
//  Created by minjing.lin on 2018/4/17.
//  Copyright © 2018年 minjing.lin. All rights reserved.
//

#ifndef __MXRDrawCommon__H__
#define __MXRDrawCommon__H__

#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString * const CollectionImageBoardViewID;
UIKIT_EXTERN NSString * const ImageBoardNotification;
UIKIT_EXTERN NSString * const SendColorAndWidthNotification;

/**改变背景**/
UIKIT_EXTERN NSString * const Action_changebackground;
/**画**/
UIKIT_EXTERN NSString * const Action_playing;
/**回退**/
UIKIT_EXTERN NSString * const Action_return;
/**向前**/
UIKIT_EXTERN NSString * const Action_goforward;
/**清屏**/
UIKIT_EXTERN NSString * const Action_clearAll;

#endif
