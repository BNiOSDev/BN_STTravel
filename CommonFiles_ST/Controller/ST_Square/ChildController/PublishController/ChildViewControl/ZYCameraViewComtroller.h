//
//  ZYCameraViewComtroller.h
//  相机封装
//
//  Created by dawei che on 16/9/6.
//  Copyright © 2016年 dawei che. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@protocol TransImageDelegate <NSObject>

- (void)transCameraImage:(UIImage *)image PHAsset:(PHAsset *)imageAsset;
- (void)transCameraVideo:(NSData *)video;

@end

@interface ZYCameraViewComtroller : UIImagePickerController
@property(nonatomic, strong)id<TransImageDelegate>  TransDelegate;
@property(nonatomic)BOOL        VideoStyle;//yes : video,no:photo
@end
