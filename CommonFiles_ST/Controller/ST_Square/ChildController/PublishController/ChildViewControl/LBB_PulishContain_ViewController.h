//
//  LBB_PulishContain_ViewController.h
//  ST_Travel
//
//  Created by dawei che on 2016/11/18.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "Base_BaseViewController.h"

@interface LBB_PulishContain_ViewController : Base_BaseViewController
@property(nonatomic,strong)NSArray  *selectImageArray;
- (void)transTagsWithViewTag:(NSArray *)tagList viewTag:(NSInteger )tag;
@end
