//
//  LBB_CommentView.m
//  ForXiaMen
//
//  Created by dawei che on 2016/10/25.
//  Copyright © 2016年 jiangming zheng. All rights reserved.
//

#import "LBB_CommentView.h"
#import "Header.h"
#define Ymargin  5.0

@implementation LBB_CommentView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self == [super initWithFrame:frame])
    {
        
    }
    return self;
}

- (void)setCommentArray:(NSArray *)commentArray
{
    for(UIView *view in self.subviews)
    {
        [view removeFromSuperview];
    }
    _commentArray = commentArray;
    __weak typeof(self) weakSelf = self;
    UIView  *lastTopView = self;
    __block typeof(lastTopView) weaklastTopView = lastTopView;
    
    for(int i = 0;i < _commentArray.count;i++)
    {
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:14.0];
        label.textColor = UIColorFromRGB(0x626262);
        label.numberOfLines = 0;
        label.lineBreakMode = NSLineBreakByTruncatingTail;
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc ]initWithString:_commentArray[i]];
        NSRange range = NSMakeRange(0,[_commentArray[i] rangeOfString:@":"].location);
        [str addAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(0x000000)} range:range];
        
        [label setAttributedText:str];
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            if(i == 0)
            {
                make.top.equalTo(weaklastTopView.mas_top).offset(Ymargin);
            }else{
                make.top.equalTo(weaklastTopView.mas_bottom).offset(Ymargin);
            }
                make.left.equalTo(weakSelf.mas_left);
                make.right.equalTo(weakSelf.mas_right);
            if(i == (_commentArray.count - 1))
            {
                make.bottom.equalTo(weakSelf.mas_bottom).offset(-Ymargin);
            }
            weaklastTopView = label;
        }];
    }

}

- (CGSize)sizeThatFits:(CGSize)size
{
    CGFloat totalHeight = 0;
    for(UIView *view in self.subviews)
    {
        if([view isKindOfClass:[UILabel class]])
        {
              totalHeight += [view sizeThatFits:size].height;
        }
    }
    totalHeight += 20; // margins
    return CGSizeMake(size.width, totalHeight);
}

@end
