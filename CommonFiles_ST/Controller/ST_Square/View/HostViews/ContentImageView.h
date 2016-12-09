//
//  ContentImageView.h
//  GSD_WeiXin(wechat)
//
//  Created by dawei che on 2016/10/20.
//  Copyright © 2016年 GSD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBB_SquareDetailViewModel.h"
@interface ContentImageView : UIView
@property(nonatomic,strong)NSArray          *imageArray;
@property(nonatomic,strong)NSArray          *picArray;
@property(nonatomic,strong)NSMutableArray *tagsArray;
- (void)prepareForReuse;
@end
