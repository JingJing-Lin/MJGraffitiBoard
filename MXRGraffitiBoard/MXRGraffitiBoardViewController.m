//
//  MXRGraffitiBoardViewController.m
//  MXRGraffitiBoard
//
//  Created by minjing.lin on 2018/4/16.
//  Copyright © 2018年 minjing.lin. All rights reserved.
//

#import "MXRGraffitiBoardViewController.h"
#import "MXRPaintingView.h"
#import "MXRBaseBrush.h"
#import "MXRBoardSettingView.h"
#import "MXRWindow.h"
#import "MXRDrawCommon.h"
#import "ZYQAssetPickerController.h"

@interface MXRGraffitiBoardViewController ()<ZYQAssetPickerControllerDelegate,MXRGraffitiBoardViewControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (strong, nonatomic) MXRPaintingView *paintingView;
@property (nonatomic, strong) MXRBoardSettingView *settingBoard;
@property (nonatomic, strong) MXRWindow * drawWindow;



@end

@implementation MXRGraffitiBoardViewController

#pragma mark - 初始化

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"手绘";
    [self.view addSubview:self.paintingView];
    [self addObserver];
    [self setupPaintBrush];
    [self creatRightBarButtonItem];
    [self showSettingBoard];
}

-(void) setupPaintBrush {
    
    self.paintingView.paintBrush = [MXRBaseBrush brushWithType:BrushTypePencil];
    self.paintingView.paintBrush.lineWidth = self.settingBoard.getLineWidth;
    self.paintingView.paintBrush.lineColor = self.settingBoard.getLineColor;
    
    self.delegate = self;
    
}

- (void)creatRightBarButtonItem {
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"工具" style:UIBarButtonItemStyleBordered target:self action:@selector(rightAction)];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

-(MXRPaintingView*)paintingView{
    if (!_paintingView) {
        _paintingView = [[MXRPaintingView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        _paintingView.backgroundColor = [UIColor whiteColor];
    }
    return _paintingView;
}
- (void)rightAction {
    
    [self showSettingBoard];
}

- (void)addObserver {
    
//    [[NSNotificationCenter defaultCenter] addObserverForName:ImageBoardNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
//        NSString *str = [note.userInfo objectForKey:@"imageBoardName"];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            self.paintingView.backgroundImage = [UIImage imageNamed:str];
//        });
//    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:SendColorAndWidthNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.paintingView.paintBrush.lineWidth = self.settingBoard.getLineWidth;
            self.paintingView.paintBrush.lineColor = self.settingBoard.getLineColor;
        });
    }];
}

#pragma mark Action

-(void)showActionSheet{
    
    __weak typeof(self) weakSelf = self;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"画笔类型" message:nil preferredStyle: UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];

    UIAlertAction *deleteAction1 = [UIAlertAction actionWithTitle:@"直线" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf setBrushType:BrushTypeLine];
    }];

    UIAlertAction *deleteAction2 = [UIAlertAction actionWithTitle:@"虚线" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf setBrushType:BrushTypeDashLine];
    }];
    
    UIAlertAction *deleteAction3 = [UIAlertAction actionWithTitle:@"矩形" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf setBrushType:BrushTypeRectangle];
    }];
    
    UIAlertAction *deleteAction4 = [UIAlertAction actionWithTitle:@"方形" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf setBrushType:BrushTypeSquare];
    }];
    UIAlertAction *deleteAction5 = [UIAlertAction actionWithTitle:@"椭圆" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf setBrushType:BrushTypeEllipse];
    }];
    UIAlertAction *deleteAction6 = [UIAlertAction actionWithTitle:@"正圆" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf setBrushType:BrushTypeCircle];
    }];
    UIAlertAction *deleteAction7 = [UIAlertAction actionWithTitle:@"箭头" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf setBrushType:BrushTypeArrow];
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:deleteAction1];
    [alertController addAction:deleteAction2];
    [alertController addAction:deleteAction3];
    [alertController addAction:deleteAction4];
    [alertController addAction:deleteAction5];
    [alertController addAction:deleteAction6];
    [alertController addAction:deleteAction7];
    [self presentViewController:alertController animated:YES completion:nil];

}

/**
 设置画笔类型

 @param brushType 涂鸦工具
 */
-(void)setBrushType:(BrushType)brushType{
    
    id<MXRPaintBrush> paintBrush;
    paintBrush = [MXRBaseBrush brushWithType:brushType];
    paintBrush.lineWidth = self.settingBoard.getLineWidth;
    paintBrush.lineColor = self.settingBoard.getLineColor;
    self.paintingView.paintBrush = paintBrush;
}

#pragma mark self delegate

- (void)drawView:(MXRGraffitiBoardViewController *)graffitiBoardVC action:(actionOpen)action{
    switch (action) {
        case actionOpenAlbum:
        {
            ZYQAssetPickerController *picker = [[ZYQAssetPickerController alloc]init];
            picker.maximumNumberOfSelection = 1;
            picker.assetsFilter = [ALAssetsFilter allAssets];
            picker.showEmptyGroups = NO;
            picker.delegate = self;
            [self presentViewController:picker animated:YES completion:nil];
        }
            break;
        case actionOpenCamera:
        {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                
                UIImagePickerController * piclVc = [[UIImagePickerController alloc]init];
                piclVc.sourceType = UIImagePickerControllerSourceTypeCamera;
                piclVc.allowsEditing  = YES;
                piclVc.delegate  = self;
                [self presentViewController:piclVc animated:YES completion:nil];
            }else{
                UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您没有相机权限" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alter show];
            }
        }
            break;
            
        default:
            break;
    }
}


#pragma mark - ZYQAssetPickerController Delegate
- (void)assetPickerController:(ZYQAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets{
    
    __block NSMutableArray *marray = [NSMutableArray array];
    for(int i=0;i<assets.count;i++){
        ZYQAsset *asset = assets[i];
        asset.getFullScreenImage = ^(UIImage *result) {
            [marray addObject:result];
            [self.paintingView setBackgroundImage:[marray firstObject]];
        };
    }
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage * image = info[UIImagePickerControllerEditedImage];
    // 如果该图片大于2M，会自动旋转90度；否则不旋转
    [self.paintingView setBackgroundImage:image];
    
    __weak typeof(self) weakSelf = self;
    [picker dismissViewControllerAnimated:YES completion:^{
        [weakSelf.paintingView setBackgroundImage:image];
    }];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    __weak typeof(self) weakSelf = self;
    [picker dismissViewControllerAnimated:YES completion:^{
        [weakSelf showSettingBoard];
    }];
}

#pragma mark - SettingBoard
- (MXRBoardSettingView *)settingBoard
{
    if (!_settingBoard) {
        _settingBoard = [[[NSBundle mainBundle] loadNibNamed:@"MXRBoardSettingView" owner:nil options:nil] firstObject];
        _settingBoard.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 170);
        
        __weak typeof(self) weakSelf = self;
        [_settingBoard getSettingType:^(setType type) {
            switch (type) {
                case setTypeEraser: //橡皮
                {
                    [weakSelf setBrushType:BrushTypeEraser];
                }
                    break;
                case setTypeBack:
                {
                    if(weakSelf.paintingView.canUndo) {
                        
                        [weakSelf.paintingView undo];
                    }
                }
                    break;
                case setTyperegeneration:
                {
                    if(weakSelf.paintingView.canRedo) {
                        
                        [weakSelf.paintingView redo];
                    }
                }
                    break;
                case setTypeClearAll:
                {
                    [self.paintingView clear];
                    self.paintingView.backgroundImage = nil;
                }
                    break;
                case setTypeSave:
                {
                    [self.paintingView saveToPhotosAlbum];
                }
                    break;
                case setTypeAlbum:
                {
                    //[weakSelf hideSettingBoard];
                    if ([self.delegate respondsToSelector:@selector(drawView:action:)]) {
                        [self.delegate drawView:self action:actionOpenAlbum];
                    }
                }
                     break;
                case setTypeCamera:
                {
                    [weakSelf hideSettingBoard];
                    if ([self.delegate respondsToSelector:@selector(drawView:action:)]) {
                        [self.delegate drawView:self action:actionOpenCamera];
                    }
                }
                    break;
                case setTypePen:
                {
                    [weakSelf setBrushType:BrushTypePencil];
                }
                     break;
                case setTypeOthers:
                {
                    [weakSelf hideSettingBoard];
                    [self showActionSheet];
                }
                     break;
                    
                default:
                    break;
            }
        }];
        
    }
    return _settingBoard;
}

- (MXRWindow *)drawWindow {
    
    if (!_drawWindow) {
        _drawWindow = [[MXRWindow alloc] initWithAnimationView:self.settingBoard];
    }
    return _drawWindow;
}

- (void)showSettingBoard {
    
    [self.drawWindow showWithAnimationTime:0.25];
}

- (void)hideSettingBoard {
    
    [self.drawWindow hideWithAnimationTime:0.25];
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SendColorAndWidthNotification object:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
