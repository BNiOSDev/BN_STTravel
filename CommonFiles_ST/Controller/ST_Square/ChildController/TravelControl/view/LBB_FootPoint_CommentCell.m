//
//  LBB_FootPoint_CommentCell.m
//  ST_Travel
//
//  Created by dawei che on 2016/12/26.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_FootPoint_CommentCell.h"
#import "PraiseView.h"
#import "CommentBoxView.h"
#import "ZJMCommentView.h"
#import "Header.h"
#import "LBB_TravelDetailContentView.h"


@implementation LBB_FootPoint_CommentCell
{
    PraiseView                  *praiseView;         //
    ZJMCommentView      *commetView;      //
    CommentBoxView       *boxView;             //
    
    LBB_TravelDetailContentView   *cellView;
    UIView      *line;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setUp];
    }
    return self;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
}
- (void)setUp
{

    __weak typeof (self) weakSelf = self;
    cellView = [LBB_TravelDetailContentView new];
    praiseView  = [PraiseView new];
    
    praiseView.praiseBlock = ^(UIButton *btn,UITableViewCellViewSignal signal)
    {
        if(weakSelf.commentBlock)
        {
            weakSelf.commentBlock(btn,signal);
        }
    };
    
    commetView = [ZJMCommentView new];
    commetView.maxWidth = DeviceWidth - 20;
    
    boxView = [CommentBoxView new];
    
    boxView.sendBlock = ^(NSString *str,UITableViewCellViewSignal signal)
    {
        if(weakSelf.commentBlock)
        {
            weakSelf.commentBlock(str,signal);
        }
    };
    
    NSArray *views = @[cellView,praiseView,commetView,boxView];
    [self.contentView sd_addSubviews:views];
    
    cellView.sd_layout
    .leftSpaceToView(self.contentView,10)
    .rightSpaceToView(self.contentView,10)
    .topEqualToView(self.contentView);
    
    praiseView.sd_layout
    .leftSpaceToView(self.contentView,10)
    .topSpaceToView(cellView,10.0)
    .widthIs(DeviceWidth - 20);
    
    commetView.sd_layout
    .leftEqualToView(praiseView)
    .topSpaceToView(praiseView,10.0)
    .rightEqualToView(praiseView);
    
    boxView.sd_layout
    .leftEqualToView(commetView)
    .topSpaceToView(commetView,10.0)
    .rightEqualToView(commetView)
    .heightIs(AUTO(30));
    
}

- (void)setModel:(BN_TravelNotesDetailsComments *)model
{
    _model = model;
    
    cellView.noteModel = model;
    
    praiseView.praiseArray = model.likeList;
    if(model.isLiked == 1)
    {
        [praiseView setBtnImage:IMAGE(@"zjmzhuyedianzaned")];
    }
    else
    {
        [praiseView setBtnImage:IMAGE(@"zjmzhuyedianzan")];
    }
    
    //评论内容
    NSMutableArray *commentModelArray = (NSMutableArray *)[model.comments map:^id(LBB_SquareComments *element) {
        
        CommentModel *model = [[CommentModel alloc]init];
        model.userName = element.userName;// 用户名称
        model.contentStr = element.remark;// 评论内容
        model.userID = [NSString stringWithFormat:@"%ld",element.commentId];// 评论ID
        return model;
    }];
    commetView.commentArray = commentModelArray;
    
    [self setupAutoHeightWithBottomView:boxView bottomMargin:10];
}

@end
