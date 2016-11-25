//
//  LBB_PublishVideo_Contain_ViewController.h
//  ST_Travel
//
//  Created by dawei che on 2016/11/21.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "Base_BaseViewController.h"
#import <Photos/Photos.h>

@interface LBB_PublishVideo_Contain_ViewController : Base_BaseViewController
@property(nonatomic,strong)NSURL     *videoUrl;
@property(nonatomic,copy) PHAsset     *videoAsset;
@end
