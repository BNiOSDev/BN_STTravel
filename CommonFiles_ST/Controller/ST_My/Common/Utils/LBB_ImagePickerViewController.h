//
//  LBB_ImagePickerViewController.h
//  ST_Travel
//
//  Created by 晨曦 on 16/10/31.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PickerBlock)(UIImage *resultImage);

@interface LBB_ImagePickerViewController : NSObject

- (instancetype)initPickerWithType:(UIImagePickerControllerSourceType)sourceType Parent:(UIViewController*)parentVC;

//- (void)showPicker:(void (^)(UIImage *resultImage))completeBlock;
- (void)showPicker:(PickerBlock)completeBlock;

@end
