//
//  LBB_ImagePickerViewController.m
//  ST_Travel
//
//  Created by 晨曦 on 16/10/31.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_ImagePickerViewController.h"


@interface LBB_ImagePickerViewController ()<
UINavigationControllerDelegate,
UIImagePickerControllerDelegate
>

@property (nonatomic,strong) UIImagePickerController *picker;
@property (nonatomic,weak) UIViewController *parentVC;
@property (nonatomic,copy) PickerBlock completeBlock;

@end

@implementation LBB_ImagePickerViewController

- (void)dealloc
{
    self.completeBlock = nil;
    self.picker = nil;
}

- (instancetype)initPickerWithType:(UIImagePickerControllerSourceType)sourceType Parent:(UIViewController*)parentVC
{
    self = [super init];
    if (self) {
        self.picker = [[UIImagePickerController alloc]init];
         self.picker.view.backgroundColor = [UIColor orangeColor];
         UIImagePickerControllerSourceType sourcheType = sourceType;
         self.picker.sourceType = sourcheType;
         self.picker.delegate = self;
         self.picker.allowsEditing = YES;
         self.parentVC = parentVC;

    }
    return self;
}

- (void)showPicker:(PickerBlock)completeBlock
{
    self.completeBlock = completeBlock;
    if (self.parentVC) {
        [self.parentVC presentViewController:self.picker animated:YES completion:nil];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [self.picker dismissViewControllerAnimated:YES completion:nil];
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    //    NSLog(@"%@",mediaType);
    if ([mediaType isEqualToString:( NSString *)kUTTypeImage]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
        if (image == nil)
            image = [info objectForKey:UIImagePickerControllerOriginalImage];
        if (self.completeBlock) {
            self.completeBlock(image);
        }
    }
    self.completeBlock = nil;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.picker dismissViewControllerAnimated:YES completion:nil];
    if (self.completeBlock) {
        self.completeBlock(nil);
    }
     self.completeBlock = nil;
}

@end
