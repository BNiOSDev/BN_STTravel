//
//  LBBVideoPlayerViewController.h
//  ST_Travel
//
//  Created by dawei che on 2016/11/15.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "Base_BaseViewController.h"
#import "Header.h"

@interface LBBVideoPlayerViewController : Base_BaseViewController
@property(nonatomic,strong)NSURL    *videoUrl;
@property(nonatomic,copy)BlockSelectVideo  blockTransIndexPath;
@end
