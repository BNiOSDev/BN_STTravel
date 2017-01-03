//
//  LBB_GuiderIdentityCardSelectView.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/3.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_GuiderIdentityCardSelectView.h"
#import "PoohCommon.h"
#import <CTAssetsPickerController/CTAssetsPickerController.h>
#import <CTAssetsPickerController/CTAssetsPageViewController.h>
#import "UIImage+TPCategory.h"
@interface LBB_GuiderIdentityCardSelectView()<CTAssetsPickerControllerDelegate>

@property (nonatomic, strong) PHImageRequestOptions *requestOptions;
@property (nonatomic, strong) CTAssetsPickerController *picker;

@end

@implementation LBB_GuiderIdentityCardSelectView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)init{
    WS(ws);
    if (self = [super init]) {
        
        CGFloat margin = 8;
        
        UILabel* mark = [UILabel new];
        [mark setTextColor:ColorRed];
        [mark setFont:AutoFont(14)];
        [mark setText:@"*"];
        [self addSubview:mark];
        [mark mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws).offset(margin);
            make.top.equalTo(ws).offset(1.5*margin);
            make.width.mas_equalTo(AutoSize(6));
        }];
        [mark sizeToFit];
        self.mark = mark;
        
        
        UILabel* titleLable = [UILabel new];
        
        titleLable = [UILabel new];
        [titleLable setTextColor:ColorGray];
        [titleLable setFont:AutoFont(14)];
        [titleLable setText:@"身份证证件照片"];
        [self addSubview:titleLable];
        [titleLable mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerY.equalTo(mark);
            make.left.equalTo(mark.mas_right).offset(3);
        }];
        self.titleLable = titleLable;
        
        
        self.addButton = [UIButton new];
        [self.addButton setImage:IMAGE(@"导游_添加照片") forState:UIControlStateNormal];
        self.addButton.layer.borderColor = ColorLine.CGColor;
        self.addButton.layer.borderWidth = SeparateLineWidth;
        [self addSubview:self.addButton];
        [self.addButton mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerX.equalTo(ws);
            make.top.equalTo(ws.mark.mas_bottom).offset(1.5*margin);
            make.left.equalTo(ws).offset(1.5*margin);
            make.right.equalTo(ws).offset(-1.5*margin);
            make.bottom.equalTo(ws).offset(-margin);
            make.height.mas_equalTo(AutoSize(160));
        }];
        
        
        [self.addButton bk_addEventHandler:^(id sender){
        
            // init picker
            if (!ws.picker) {
                ws.picker = [[CTAssetsPickerController alloc] init];
            }
            
            // set delegate
            ws.picker.delegate = ws;
            
            // Optionally present picker as a form sheet on iPad
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                ws.picker.modalPresentationStyle = UIModalPresentationFormSheet;
            
            // present picker
            [[ws getViewController] presentViewController:ws.picker animated:YES completion:nil];
            
        } forControlEvents:UIControlEventTouchUpInside];
        
        
        self.placeHolderLabel = [UILabel new];
        [self.placeHolderLabel setText:@"身份证正面照片"];
        [self.placeHolderLabel setFont:Font13];
        [self.placeHolderLabel setTextColor:ColorLightGray];
        [self addSubview:self.placeHolderLabel];
        [self.placeHolderLabel mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerX.equalTo(ws.addButton);
            make.centerY.equalTo(ws.addButton).offset(AutoSize(25));
        }];
        
    }
    return self;
    
}

-(void)hiddenMarkView:(BOOL)hidden{

    WS(ws);
    CGFloat margin = 8;

    if (hidden) {
        self.mark.hidden = YES;
        [self.mark mas_remakeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws).offset(margin);
            make.top.equalTo(ws).offset(1.5*margin);
            make.width.mas_equalTo(AutoSize(0));
        }];
        [self.titleLable mas_remakeConstraints:^(MASConstraintMaker* make){
            make.centerY.equalTo(ws.mark);
            make.left.equalTo(ws.mark.mas_right).offset(0);
        }];
    }
    else{
        self.mark.hidden = NO;
        [self.mark mas_remakeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws).offset(margin);
            make.top.equalTo(ws).offset(1.5*margin);
            make.width.mas_equalTo(AutoSize(6));
        }];
        
        [ self.titleLable mas_remakeConstraints:^(MASConstraintMaker* make){
            make.centerY.equalTo(ws.mark);
            make.left.equalTo(ws.mark.mas_right).offset(3);
        }];
    }
    
    
}

-(void)hiddenTitleView:(BOOL)hidden{
    WS(ws);
    CGFloat margin = 8;
    if (hidden) {
        self.mark.hidden = YES;
        self.titleLable.hidden = YES;
        [self.mark setText:@""];
        [self.titleLable setText:@""];
        [self.mark mas_remakeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws).offset(margin);
            make.top.equalTo(ws);
            make.width.mas_equalTo(AutoSize(0));
        }];
        [self.titleLable mas_remakeConstraints:^(MASConstraintMaker* make){
            make.centerY.equalTo(ws.mark);
            make.left.equalTo(ws.mark.mas_right).offset(0);
        }];
        [self.addButton mas_remakeConstraints:^(MASConstraintMaker* make){
            make.centerX.equalTo(ws);
            make.top.equalTo(ws.mark.mas_bottom);
            make.left.equalTo(ws).offset(1.5*margin);
            make.right.equalTo(ws).offset(-1.5*margin);
            make.bottom.equalTo(ws).offset(-margin);
            make.height.mas_equalTo(AutoSize(160));
        }];
    }
    else{
        self.mark.hidden = NO;
        self.titleLable.hidden = NO;
        [self.mark mas_remakeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws).offset(margin);
            make.top.equalTo(ws).offset(1.5*margin);
            make.width.mas_equalTo(AutoSize(6));
        }];
        
        [ self.titleLable mas_remakeConstraints:^(MASConstraintMaker* make){
            make.centerY.equalTo(ws.mark);
            make.left.equalTo(ws.mark.mas_right).offset(3);
        }];
        
        [self.addButton mas_remakeConstraints:^(MASConstraintMaker* make){
            make.centerX.equalTo(ws);
            make.top.equalTo(ws.mark.mas_bottom).offset(1.5*margin);
            make.left.equalTo(ws).offset(1.5*margin);
            make.right.equalTo(ws).offset(-1.5*margin);
            make.bottom.equalTo(ws).offset(-margin);
            make.height.mas_equalTo(AutoSize(160));
        }];
    }
    
}


-(void)configImageView:(BOOL)show{
    
    if (show) {
        [self.addButton setBackgroundImage:self.selectImageView.image forState:UIControlStateNormal];
        self.placeHolderLabel.hidden = YES;
        [self.addButton setImage:nil forState:UIControlStateNormal];
    }
    else{
        [self.addButton setImage:IMAGE(@"导游_添加照片") forState:UIControlStateNormal];
        self.placeHolderLabel.hidden = NO;
        [self.addButton setBackgroundImage:nil forState:UIControlStateNormal];
    }
}

-(void)setAddButtonBgImage:(UIImage*)image{
    
    if (!image) {
        [self.addButton setBackgroundImage:image forState:UIControlStateNormal];
        self.placeHolderLabel.hidden = YES;
        [self.addButton setImage:nil forState:UIControlStateNormal];
    }
}

#pragma CTAssetsPickerController delegate

- (void)assetsPickerController:(CTAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
    // assets contains PHAsset objects.
    NSLog(@"CTAssetsPickerController didFinishPickingAssets:%@",assets);
    [picker dismissViewControllerAnimated:YES completion:nil];

    if (!self.requestOptions) {
        self.requestOptions = [[PHImageRequestOptions alloc] init];
        self.requestOptions.resizeMode   = PHImageRequestOptionsResizeModeExact;
        self.requestOptions.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    }
    
    WS(ws);
    for (PHAsset *asset in assets) {
        PHImageManager *manager = [PHImageManager defaultManager];
        [manager requestImageForAsset:asset targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeDefault options:self.requestOptions resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            
            if (!ws.selectImageView) {
                ws.selectImageView = [UIImageView new];
            }
            ws.selectImageView.image = [result scaleToSize:CGSizeMake(DeviceWidth, AutoSize(160))];
            [ws configImageView:YES];
        }];
    }
    
}
- (BOOL)assetsPickerController:(CTAssetsPickerController *)picker shouldSelectAsset:(PHAsset *)asset
{
    NSInteger max = 1;
    
    // show alert gracefully
    // show alert gracefully
    if (picker.selectedAssets.count >= max)
    {
        UIAlertController *alert =
        [UIAlertController alertControllerWithTitle:@"提示"
                                            message:[NSString stringWithFormat:@"最多只能选择 %ld 张照片", (long)max]
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action =
        [UIAlertAction actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                               handler:nil];
        
        [alert addAction:action];
        
        [picker presentViewController:alert animated:YES completion:nil];
    }
    
    // limit selection to max
    return (picker.selectedAssets.count < max);
}

@end
