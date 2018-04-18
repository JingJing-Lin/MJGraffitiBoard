//
//  MXRBoardSettingView.m
//  MXRGraffitiBoard
//
//  Created by minjing.lin on 2018/4/17.
//  Copyright © 2018年 minjing.lin. All rights reserved.
//

#import "MXRBoardSettingView.h"
#import "UIView+Frame.h"
#import "MXRDrawCommon.h"
#import "MXRBallColorModel.h"
#import "MJExtension.h"

static NSString * const collectionCellID = @"collectionCellID";

@interface MXRBoardSettingView ()<UICollectionViewDataSource,UICollectionViewDelegate> {
    
    NSIndexPath *_lastIndexPath;
    BOOL isBallColor;
    
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet ColorBall *ballView;
@property (weak, nonatomic) IBOutlet UISlider *sliderView;
/// 铅笔
@property (weak, nonatomic) IBOutlet UIButton *pencilBtn;
/// 橡皮擦
@property (weak, nonatomic) IBOutlet UIButton *eraserBtn;
/// 其它
@property (weak, nonatomic) IBOutlet UIButton *otherBtn;


@property (nonatomic, strong) NSArray *colors;
@property (nonatomic, strong) NSArray *colorSelectModels;
@property (nonatomic, copy) boardSettingBlock stype;
@end
@implementation MXRBoardSettingView

- (void)awakeFromNib{
    
    [super awakeFromNib];
    
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
     [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:collectionCellID];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    if (!_lastIndexPath) {
        //设置默认是属性
        [self collectionView:self.collectionView didSelectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
        self.ballView.ballSize = 0;
        [self pencil:nil];
    }
}

- (void)getSettingType:(boardSettingBlock)type {
    
    self.stype = type;
    
}

- (CGFloat)getLineWidth {
    
    return self.ballView.lineWidth;
    
}

- (UIColor *)getLineColor {
    
    return self.ballView.ballColor;
    
}

#pragma mark  事件
// 滑竿
- (IBAction)slide:(UISlider*)sender {
    self.ballView.ballSize = sender.value;
}
- (IBAction)pencil:(id)sender {
    if (self.stype) {
        
        [self.pencilBtn setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
        [self.eraserBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.otherBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        self.stype(setTypePen);
    }
}

// 橡皮擦
- (IBAction)eraser:(id)sender {
    if (self.stype) {
        
        [self.eraserBtn setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
        [self.pencilBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.otherBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        self.stype(setTypeEraser);
    }
}

// 撤销
- (IBAction)back:(id)sender {
    if (self.stype) {
        self.stype(setTypeBack);
    }
}

// 还原
- (IBAction)revocation:(id)sender {
    if (self.stype) {
        self.stype(setTyperegeneration);
    }
}

// 删除
- (IBAction)clearAll:(id)sender {
    if (self.stype) {
        self.stype(setTypeClearAll);
    }
}
// 相册
- (IBAction)photo:(id)sender {
    if (self.stype) {
        self.stype(setTypeAlbum);
    }
}
// 保存
- (IBAction)save:(id)sender {
    if (self.stype) {
        self.stype(setTypeSave);
    }
}
- (IBAction)otherEvent:(id)sender {
    
    if (self.stype) {
        
        [self.otherBtn setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
        [self.pencilBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.eraserBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        self.stype(setTypeOthers);
    }
    
   
}


- (IBAction)camera:(id)sender {
    if (self.stype) {
        self.stype(setTypeCamera);
    }
}



#pragma mark  collectionView delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.colorSelectModels.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellID forIndexPath:indexPath];
    MXRBallColorModel *model = self.colorSelectModels[indexPath.item];
    cell.backgroundColor = self.colors[[model.ballColor integerValue]];
    cell.layer.cornerRadius = 3;
    if (model.isBallColor) {
        cell.layer.borderWidth = 3;
        cell.layer.borderColor = [UIColor purpleColor].CGColor;
    }else{
        cell.layer.borderWidth = 0;
    }
    cell.layer.masksToBounds = YES;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_lastIndexPath) {
        MXRBallColorModel *lastModel = self.colorSelectModels[_lastIndexPath.item];
        lastModel.isBallColor = NO;
        [self.collectionView reloadItemsAtIndexPaths:@[_lastIndexPath]];
    }
    _lastIndexPath = indexPath;

    MXRBallColorModel *model = self.colorSelectModels[indexPath.item];
    self.ballView.ballColor = self.colors[[model.ballColor integerValue]];;
    model.isBallColor = YES;
    [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
}

#pragma mark - lazy

- (NSArray *)colorSelectModels
{
    if (!_colorSelectModels) {
        //        isBallColor
        NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:@(0),@"ballColor", nil];
        NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:@(1),@"ballColor", nil];
        NSDictionary *dic3 = [NSDictionary dictionaryWithObjectsAndKeys:@(2),@"ballColor", nil];
        NSDictionary *dic4 = [NSDictionary dictionaryWithObjectsAndKeys:@(3),@"ballColor", nil];
        NSDictionary *dic5 = [NSDictionary dictionaryWithObjectsAndKeys:@(4),@"ballColor", nil];
        NSDictionary *dic6 = [NSDictionary dictionaryWithObjectsAndKeys:@(5),@"ballColor", nil];
        NSDictionary *dic7 = [NSDictionary dictionaryWithObjectsAndKeys:@(6),@"ballColor", nil];
        NSArray *array = [NSArray arrayWithObjects:dic1,
                          dic2,
                          dic3,
                          dic4,
                          dic5,
                          dic6,
                          dic7,
                          nil];
         _colorSelectModels = [MXRBallColorModel mj_objectArrayWithKeyValuesArray:array];
       
    }
    return _colorSelectModels;
}


- (NSArray *)colors {
    if (!_colors) {
        _colors = [NSArray arrayWithObjects:
                   [UIColor colorWithRed:0.92 green:0.26 blue:0.27 alpha:1],
                   [UIColor colorWithRed:0.95 green:0.59 blue:0.28 alpha:1],
                   [UIColor colorWithRed:0.88 green:0.85 blue:0.25 alpha:1],
                   [UIColor colorWithRed:0.5 green:0.88 blue:0.25 alpha:1],
                   [UIColor colorWithRed:0.32 green:0.86 blue:0.87 alpha:1],
                   [UIColor colorWithRed:0.18 green:0.48 blue:0.88 alpha:1],
                   [UIColor colorWithRed:0.6 green:0.24 blue:0.88 alpha:1],
                   nil];
    }
    return _colors;
}
@end

@implementation ColorBall

- (void)awakeFromNib
{
    self.backgroundColor = [UIColor clearColor];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 0);
    
    CGContextSetStrokeColorWithColor(context, self.ballColor.CGColor);
    
    // x,y为圆点坐标，radius半径，startAngle为开始的弧度，endAngle为 结束的弧度，clockwise 0为顺时针，1为逆时针。
//    CGContextAddArc(context, self.centerX, self.centerY, self.centerX, 0, 2 * M_PI, 0);
    
    CGContextSetFillColorWithColor(context, self.ballColor.CGColor);
    
    CGContextAddEllipseInRect(context, self.bounds);
    
    CGContextDrawPath(context, kCGPathFill);
    
}
- (void)setBallColor:(UIColor *)ballColor {
    
    _ballColor = ballColor;
    
    [self setNeedsDisplay];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:SendColorAndWidthNotification object:nil];
    
}
- (void)setBallSize:(CGFloat)ballSize
{
    _ballSize = ballSize;
    
    //缩放
    CGFloat vaule = 0.3 * (1 - ballSize) + ballSize;
    
    self.transform = CGAffineTransformMakeScale(vaule, vaule);
    
    self.lineWidth = self.width / 2.0;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:SendColorAndWidthNotification object:nil];
    
}
@end
