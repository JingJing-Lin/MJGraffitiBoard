//
//  MXRBoardSettingView.h
//  MXRGraffitiBoard
//
//  Created by minjing.lin on 2018/4/17.
//  Copyright © 2018年 minjing.lin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,setType) {
    setTypePen,
    setTypeCamera,
    setTypeAlbum,  // 相册
    setTypeSave,    // 保存相册
    setTypeEraser,  // 橡皮
    setTypeBack, //撤销
    setTyperegeneration,  // 向前
    setTypeClearAll,
    setTypeOthers  //其它类型
};

typedef void(^boardSettingBlock)(setType type);

@interface MXRBoardSettingView : UIView

- (void)getSettingType:(boardSettingBlock)type;
- (CGFloat)getLineWidth;
- (UIColor *)getLineColor;

@end

//画笔展示的球
@interface ColorBall : UIView

@property (nonatomic, strong) UIColor *ballColor;
@property (nonatomic, assign) CGFloat ballSize;
@property (nonatomic, assign) CGFloat lineWidth;

@end
