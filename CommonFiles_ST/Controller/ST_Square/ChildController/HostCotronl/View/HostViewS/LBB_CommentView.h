//
//  LBB_CommentView.h
//  ForXiaMen
//
//  Created by dawei che on 2016/10/25.
//  Copyright © 2016年 jiangming zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBB_CommentView : UIView
@property(nonatomic, strong)NSArray *commentArray;
- (CGSize)sizeThatFits:(CGSize)size;
@end
