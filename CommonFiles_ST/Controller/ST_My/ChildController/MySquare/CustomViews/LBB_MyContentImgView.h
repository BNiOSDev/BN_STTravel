//
//  LBB_MyContentImgView.h
//  ST_Travel
//
//  Created by 晨曦 on 16/12/2.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBB_MyContentImgView : UIImageView

@property(nonatomic,strong) NSArray *tagList; //标签列表
@property(nonatomic,copy) NSString *imageURL; //图片地址

- (void)prepareForReuse;

@end
