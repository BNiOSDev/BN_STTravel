//
//  LBBVideoCollectionViewCell.h
//  ST_Travel
//
//  Created by dawei che on 2016/11/15.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^videoSecletBlock)(NSInteger object,BOOL  select);
@interface LBBVideoCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong)UIImageView    *pauseImage;
@property(nonatomic,strong)UIImageView    *contentImage;
@property(nonatomic,strong)UIButton           *selectBtn;
@property(nonatomic)BOOL                            beSelect;
@property(nonatomic,strong)videoSecletBlock  _blockVideo;
@end
