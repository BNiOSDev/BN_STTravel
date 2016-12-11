//
//  ZJMCommentView.m
//  GSD_WeiXin(wechat)
//
//  Created by dawei che on 2016/10/19.
//  Copyright © 2016年 GSD. All rights reserved.
//

#import "LBB_PoohCommentView.h"
#import "UIView+SDAutoLayout.h"
#import "CommentModel.h"
#import "Header.h"
#import "PoohCommon.h"
@implementation LBB_PoohCommentView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self == [super initWithFrame:frame])
    {
    }
    return self;
}

- (void)setCommentArray:(NSArray *)commentArray
{
    WS(ws);
    for(UIView *view in self.subviews)
    {
        [view removeFromSuperview];
    }
    UIView  *lastTopView;
    for (int i = 0; i < commentArray.count; i++) {
        CommentModel *model = commentArray[i];
        UILabel *label = [[UILabel alloc]init];
        label.font = [UIFont systemFontOfSize:14.0];
        label.textColor = ColorGray;
        label.numberOfLines = 0;
        label.lineBreakMode = NSLineBreakByTruncatingTail;
        NSString *text = [NSString stringWithFormat:@"%@: %@",model.userName,model.contentStr];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc ]initWithString:text];
        NSRange range = NSMakeRange(0,[text rangeOfString:@":"].location+1);
        [str addAttributes:@{NSForegroundColorAttributeName:BLACKCOLOR} range:range];
        [label setAttributedText:str];
        [self addSubview:label];
        
        UILabel  *heightLabel = [[UILabel alloc]init];
        [heightLabel autoFit:label.text size:label.font maxSize:CGSizeMake(DeviceWidth - 75, DeviceHeight)];
        if(_maxWidth > 0)
        {
            [heightLabel autoFit:label.text size:label.font maxSize:CGSizeMake(_maxWidth, DeviceHeight)];
        }
        if(lastTopView)
        {
            
            [label mas_makeConstraints:^(MASConstraintMaker* make){
            
                make.top.equalTo(lastTopView.mas_bottom);
                make.left.right.equalTo(ws);
                make.height.mas_equalTo(heightLabel.size.height);
                if (i == commentArray.count - 1) {
                    make.bottom.equalTo(ws);
                }
            }];
          /*
            label.sd_layout
            .topSpaceToView(lastTopView,0)
            .leftSpaceToView(self,0)
            .rightEqualToView(self)
            .heightIs(heightLabel.size.height);*/
        }else
        {
            [label mas_makeConstraints:^(MASConstraintMaker* make){
                
                make.top.equalTo(ws);
                make.left.right.equalTo(ws);
                make.height.mas_equalTo(heightLabel.size.height);
                
            }];
        /*    label.sd_layout
            .topEqualToView(self)
            .leftSpaceToView(self,0)
            .rightEqualToView(self)
            .heightIs(heightLabel.size.height);
         */
        }
        lastTopView = label;
        if (commentArray.count <= 1) {
            [lastTopView mas_updateConstraints:^(MASConstraintMaker* make){
                make.bottom.equalTo(ws);
            }];
        }

       // [self setupAutoHeightWithBottomView:lastTopView bottomMargin:0];
    }
    
    if (commentArray.count <= 0) {
        UILabel  *heightLabel = [[UILabel alloc]init];
        [self addSubview:heightLabel];
        
        [heightLabel autoFit:@"" size:[UIFont systemFontOfSize:14.0] maxSize:CGSizeMake(DeviceWidth - 75, DeviceHeight)];
        
        
        [heightLabel mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.top.equalTo(ws);
            make.left.right.equalTo(ws);
            make.height.mas_equalTo(0);
            make.bottom.equalTo(ws);
        }];
      /*  heightLabel.sd_layout
        .topSpaceToView(self,0)
        .leftSpaceToView(self,0)
        .rightEqualToView(self)
        .heightIs(0);
        [self setupAutoHeightWithBottomView:heightLabel bottomMargin:0];*/
    }
    NSLog(@"height");
}

@end
