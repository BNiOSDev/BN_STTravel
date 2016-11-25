//
//  ZYCameraViewComtroller.m
//  相机封装
//
//  Created by dawei che on 16/9/6.
//  Copyright © 2016年 dawei che. All rights reserved.
//

#import "ZYCameraViewComtroller.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface ZYCameraViewComtroller ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@end

@implementation ZYCameraViewComtroller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    [self initcameraSet];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    NSLog(@"%f",self.cameraViewTransform.tx);
//    NSLog(@"%f",self.cameraViewTransform.ty);
//    NSLog(@"%f",self.cameraViewTransform.a);
//    NSLog(@"%f",self.cameraViewTransform.b);
//    NSLog(@"%f",self.cameraViewTransform.c);
//    NSLog(@"%f",self.cameraViewTransform.d);

}

- (void)initcameraSet
{
    /*
     UIImagePickerControllerSourceTypePhotoLibrary  -->default
     UIImagePickerControllerSourceTypeCamera    -->Camera
     UIImagePickerControllerSourceTypeSavedPhotosAlbum  -->Album
     */
    self.sourceType = 1;
//    self.allowsEditing = YES;
//    self.showsCameraControls = NO;
    /*
     设置媒体类型录像、拍照
     */
//    self.mediaTypes = @[(NSString *) kUTTypeMovie,(NSString *) kUTTypeImage];
    if(_VideoStyle)
    {
         self.mediaTypes = @[(NSString *) kUTTypeMovie];
    }else{
         self.mediaTypes = @[(NSString *) kUTTypeImage];
    }
   
    
//    self.cameraViewTransform = CGAffineTransformMake(1,0,0,0.8,0,0);

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    [self takePicture];
}

#pragma mark UIImagePickerControllerDelegate
//该代理方法仅适用于只选取图片时
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo {
    NSLog(@"选择完毕----image:%@-----info:%@",image,editingInfo);
}

//适用获取所有媒体资源，只需判断资源类型
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
    //判断资源类型
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]){
        //如果是图片
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        //压缩图片
//        NSData *fileData = UIImageJPEGRepresentation(image, 1.0);
        //保存图片至相册
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
        //上传图片
        [self.TransDelegate transCameraImage:image];
        
         NSLog(@"这是一张照片");
        
    }else{
        //如果是视频
        NSURL *url = info[UIImagePickerControllerMediaURL];
        //播放视频
//        _moviePlayer.contentURL = url;
//        [_moviePlayer play];
        //保存视频至相册（异步线程）
        NSString *urlStr = [url path];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(urlStr)) {
                
                UISaveVideoAtPathToSavedPhotosAlbum(urlStr, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);
            }
        });
        NSData *videoData = [NSData dataWithContentsOfURL:url];
        //视频上传
//        [self uploadVideoWithData:videoData];
         NSLog(@"这是一段视频");
        [self.TransDelegate transCameraVideo:videoData];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"取消");
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark 图片保存完毕的回调
- (void) image: (UIImage *) image didFinishSavingWithError:(NSError *) error contextInfo: (void *)contextInf{
    NSLog(@"图片保存完毕");
}

#pragma mark 视频保存完毕的回调
- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInf{
    if (error) {
        NSLog(@"保存视频过程中发生错误，错误信息:%@",error.localizedDescription);
    }else {
        NSLog(@"视频保存成功");
    }
}

@end
