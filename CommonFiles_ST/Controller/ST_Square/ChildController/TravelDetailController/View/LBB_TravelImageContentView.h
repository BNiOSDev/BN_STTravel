//
//  LBB_TravelImageContentView.h
//  ST_Travel
//
//  Created by dawei che on 2016/12/11.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBB_TravelImageContentView : UIView
@property(nonatomic,strong)NSArray          *imageArray;
@property(nonatomic,strong)NSArray          *picArray;
@property(nonatomic,strong)NSMutableArray *tagsArray;
- (void)prepareForReuse;
@end
