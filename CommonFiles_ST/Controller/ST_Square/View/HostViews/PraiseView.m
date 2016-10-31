//
//  PraiseView.m
//  GSD_WeiXin(wechat)
//
//  Created by dawei che on 2016/10/19.
//  Copyright © 2016年 GSD. All rights reserved.
//

#import "PraiseView.h"
#import "UIView+SDAutoLayout.h"
#import "Header.h"
#import <UIImageView+WebCache.h>
#import "PraiseModel.h"

@implementation PraiseView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self == [super initWithFrame:frame])
    {
        
    }
    return self;
}

- (void)setPraiseArray:(NSArray *)praiseArray
{
        for(UIView *view in self.subviews)
        {
            [view removeFromSuperview];
        }
    
        UIButton    *praiseBtn = [UIButton new];
        praiseBtn.backgroundColor = UIColorFromRGB(0xE0E1E2);
        [praiseBtn setImage:IMAGE(@"praiseComment") forState:0];
        [praiseBtn setTitle:@"赞" forState:0];
        [praiseBtn setTitleColor:UIColorFromRGB(0x888888) forState:0];
        praiseBtn.titleLabel.font = FONT(11.0);
        [praiseBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
        [self addSubview:praiseBtn];
    
       praiseBtn.sd_layout
       .topSpaceToView(self,0)
       .leftSpaceToView(self,0)
       .heightIs(18)
        .widthIs(36);
    
        UIView      *lastView = praiseBtn;
        CGFloat     margin = 5.0;
    
      __block UIView *weakSelf = lastView;
    
        if(praiseArray.count <= 4)
        {
            [praiseArray enumerateObjectsUsingBlock:^(PraiseModel  * obj, NSUInteger idx, BOOL * _Nonnull stop) {
                UIImageView *imageView = [[UIImageView alloc]init];
                [imageView sd_setImageWithURL:[NSURL URLWithString:obj.iconUrl] placeholderImage:DEFAULTIMAGE];
                [self addSubview:imageView];
                imageView.sd_layout
                .topSpaceToView(self,0)
                .leftSpaceToView(weakSelf, margin)
                .heightIs(18)
                .widthIs(18);
                
                [imageView setSd_cornerRadius:@(2.0)];
                weakSelf = imageView;
            }];
        }else{
            for(int i = 0;i < 4;i++)
            {
                UIImageView *imageView = [[UIImageView alloc]init];
                imageView.backgroundColor = [UIColor redColor];
                PraiseModel *model = praiseArray[i];
                [imageView sd_setImageWithURL:[NSURL URLWithString:model.iconUrl] placeholderImage:DEFAULTIMAGE];
                [self addSubview:imageView];
                imageView.sd_layout
                .topSpaceToView(self,0)
                .leftSpaceToView(weakSelf, margin)
                .heightIs(18)
                .widthIs(18);
                [imageView setSd_cornerRadius:@(2.0)];
                weakSelf = imageView;
                
                if (i == 3 ) {
                    UILabel   *praiseNumLabel = [UILabel new];
                    praiseNumLabel.font = [UIFont systemFontOfSize:12.0];
                    praiseNumLabel.textColor = UIColorFromRGB(0x888888);
                    praiseNumLabel.backgroundColor = LINECOLOR;
                    praiseNumLabel.text = @"99";
                    praiseNumLabel.textAlignment = NSTextAlignmentCenter;
                    [self addSubview:praiseNumLabel];
                    
                    praiseNumLabel.sd_layout
                    .topSpaceToView(self,0)
                    .leftSpaceToView(weakSelf, margin)
                    .heightIs(18)
                    .widthIs(18);
                    [praiseNumLabel setSd_cornerRadius:@(2.0)];
                }
            }
        }
    
     [self setupAutoHeightWithBottomView:lastView bottomMargin:0];
}

@end
