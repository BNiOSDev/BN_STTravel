//
//  LBB_LabelDetailHotCell.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/1.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_LabelDetailHotCell.h"
#import "LBB_TravelCommentController.h"
#import "LBB_LabelDetailViewController.h"
@implementation LBB_LabelDetailHotCellItem

-(id)init{
    WS(ws);
    if (self = [super init]) {
        
        self.bgImageView = [UIImageView new];
        [self addSubview:self.bgImageView];
        [self.bgImageView mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.center.width.height.equalTo(ws);
        }];
    }
    return self;
}


-(void)setModel:(LBB_TagShowViewData *)model{
    
    _model = model;
    [self setTagViews];
}


- (void)setTagViews
{
    WS(ws);
    NSInteger baseTagNum = 432;
    for(UIView *view in [self subviews])
    {
        if([view isKindOfClass:[UIButton class]])
        {
            if (view.tag >= baseTagNum) {
                [view removeFromSuperview];
            }
        }
    }
    CGFloat interval = 8;
    
    UIView* lastView = nil;
    for(int i = 0;i < _model.tags.count;i++)
    {
        
        LBB_SquareTags* homeTags = [_model.tags objectAtIndex:i];
        NSString *content = [NSString stringWithFormat:@"   %@",homeTags.tagName];
        UIFont *font = AutoFont(11);
        CGSize size = CGSizeMake(MAXFLOAT, AutoSize(18));
        CGSize buttonSize = [content boundingRectWithSize:size
                                                  options:NSStringDrawingTruncatesLastVisibleLine  | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                               attributes:@{ NSFontAttributeName:font}
                                                  context:nil].size;
        
        NSLog(@"AutoSize(18):%f",AutoSize(18));
        NSLog(@"buttonSize.height:%f",buttonSize.height);
        NSLog(@"buttonSize.width:%f",buttonSize.width);
        
        UIButton* tagButton = [UIButton new];
        [tagButton setBackgroundImage:IMAGE(@"labelDetailBg") forState:UIControlStateNormal];
        [tagButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [tagButton.titleLabel setFont:font];
        [tagButton setTitle:content forState:UIControlStateNormal];
        [self addSubview:tagButton];
        [tagButton mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.right.equalTo(ws).offset(-AutoSize(8));
            if (lastView) {
                make.bottom.equalTo(lastView.mas_top).offset(-interval);
            }
            else{
                make.bottom.equalTo(ws).offset(-AutoSize(18));
            }
            make.height.mas_equalTo(buttonSize.height + 5);
            make.width.mas_equalTo(buttonSize.width + 35);
            
        }];
        tagButton.tag = baseTagNum + i;
        lastView = tagButton;
        
        [tagButton bk_whenTapped:^{
            LBB_LabelDetailViewController* dest = [[LBB_LabelDetailViewController alloc]init];
            dest.viewModel = homeTags;
            [[ws getViewController].navigationController pushViewController:dest animated:YES];
        }];
        
    }
}


@end

@implementation LBB_LabelDetailHotCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    WS(ws);
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.item1 = [[LBB_LabelDetailHotCellItem alloc]init];
        self.item2 = [[LBB_LabelDetailHotCellItem alloc]init];
        
        
        [self.contentView addSubview:self.item1];
        [self.contentView addSubview:self.item2];
        
        
        CGFloat interval = 8;
        [self.item1 mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(ws.contentView).offset(interval);
            make.top.equalTo(ws.contentView).offset(interval);
            make.bottom.equalTo(ws.contentView);
           // make.height.mas_equalTo(AutoSize(380/2));
            make.height.equalTo(ws.item1.mas_width);
        }];
        
        [self.item2 mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(ws.item1.mas_right).offset(interval);
            make.top.equalTo(ws.item1);
            make.right.equalTo(ws.contentView).offset(-interval);
            make.width.height.equalTo(ws.item1);
        }];
        
        [self.item1 bk_whenTapped:^{
            NSLog(@"item1 tap");
            LBB_TravelCommentController* dest = [[LBB_TravelCommentController alloc]init];
            [[ws getViewController].navigationController pushViewController:dest animated:YES];
            
        }];
        [self.item2 bk_whenTapped:^{
            NSLog(@"item2 tap");
            LBB_TravelCommentController* dest = [[LBB_TravelCommentController alloc]init];
            [[ws getViewController].navigationController pushViewController:dest animated:YES];
            
        }];
        
    }
    return self;
}

-(void)setModel1:(LBB_TagShowViewData *)model1{
    
    _model1 = model1;
    [self.item1.bgImageView sd_setImageWithURL:[NSURL URLWithString:model1.picUrl] placeholderImage:IMAGE(PlaceHolderImage)];

    [self.item1 setModel:model1];
}

-(void)setModel2:(LBB_TagShowViewData *)model2{
    _model2 = model2;
    [self.item2.bgImageView sd_setImageWithURL:[NSURL URLWithString:model2.picUrl] placeholderImage:IMAGE(PlaceHolderImage)];
    [self.item2 setModel:model2];
}

@end
