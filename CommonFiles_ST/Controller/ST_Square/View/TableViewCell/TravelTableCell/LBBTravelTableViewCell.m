//
//  LBBTravelTableViewCell.m
//  ST_Travel
//
//  Created by dawei che on 2016/10/23.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBTravelTableViewCell.h"
#import "LBBTravelContentImage.h"
#import "Header.h"
#import "LBB_TagView.h"

@implementation LBBTravelTableViewCell
{
    LBBTravelContentImage  *contentImage;
    UILabel     *contentLabel;
    UILabel     *timeLabel;
    UILabel     *nameLabel;
    UIImageView *iconImage;
    UIButton    *zanBtn;
    UIButton    *pinBtn;
    UIButton    *heartBtn;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.userInteractionEnabled = YES;
        [self setup];
    }
    return self;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    
}
- (void)setup
{
    contentImage = [[LBBTravelContentImage alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth,AUTO(180))];
    [self addSubview:contentImage];
    
    contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, DeviceWidth - 40, AUTO(20))];
    contentLabel.textColor = [UIColor whiteColor];
    contentLabel.font = FONT(AUTO(17.0));
    [self addSubview:contentLabel];
    
    timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, contentLabel.bottom + AUTO(10), DeviceWidth - 40, AUTO(20))];
    timeLabel.textColor = [UIColor whiteColor];
    timeLabel.font = FONT(AUTO(13.0));
    [self addSubview:timeLabel];
    
    iconImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, contentImage.bottom - AUTO(10), AUTO(30), AUTO(30))];
    iconImage.clipsToBounds = YES;
    LRViewBorderRadius(iconImage, iconImage.height / 2.0, 0, [UIColor clearColor]);
    [self addSubview:iconImage];
    
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(iconImage.right + AUTO(5), contentImage.bottom + AUTO(5), 300, AUTO(15))];
    nameLabel.font = FONT(AUTO(12));
    nameLabel.textColor = [UIColor blackColor];
    [self addSubview:nameLabel];
    
    heartBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.width - 20, contentImage.bottom + AUTO(5), AUTO(20), AUTO(15))];
    heartBtn.titleLabel.font = FONT(AUTO(11.0));
    [heartBtn setTitleColor:[UIColor grayColor] forState:0];
    [heartBtn setImage:IMAGE(@"zjmlittlecollect_no") forState:0];
    [self addSubview:heartBtn];
    
    pinBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.width - 20 - heartBtn.width - AUTO(5), contentImage.bottom + AUTO(5), AUTO(20), AUTO(15))];
    pinBtn.titleLabel.font = FONT(AUTO(11.0));
    [pinBtn setTitleColor:[UIColor grayColor] forState:0];
    [pinBtn setImage:IMAGE(@"我的_评论") forState:0];
    [self addSubview:pinBtn];
    
    zanBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.width - 20 - pinBtn.width - AUTO(5), contentImage.bottom + AUTO(5), AUTO(20), AUTO(15))];
    zanBtn.titleLabel.font = FONT(AUTO(11.0));
    [zanBtn setTitleColor:[UIColor grayColor] forState:0];
    [zanBtn setImage:IMAGE(@"zjmdianzan") forState:0];
    [self addSubview:zanBtn];
    
}

- (void)setModel:(BN_SquareTravelList *)model
{
    _model = model;
    /*
     @property(nonatomic, assign)long travelNotesId;//	Long	游记主键
     @property(nonatomic, strong)NSString* travelNotesName; //	String	游记名称
     @property(nonatomic, strong)NSString* travelNotesPicUrl;//	String	游记封面
     @property(nonatomic, strong)NSString* lastReleaseTime;//	String	发布日期
     @property(nonatomic, assign)int dayCount;//	Int	天数
     @property(nonatomic, assign)long totalPageViews;//	Long	浏览总数
     @property(nonatomic, assign)long userId;//	Long	用户ID
     @property(nonatomic, strong)NSString* userName;//	String	用户名称
     @property(nonatomic, strong)NSString* userPicUrl;//	String	用户头像
     @property(nonatomic, strong)NSArray<LBB_SquareTags*>* tags;//	List	标签集合
     @property(nonatomic, assign)int isLiked;//	int	是否点赞
     @property(nonatomic, assign)int likeNum;//	Int	点赞数
     @property(nonatomic, assign)int commentsNum;//	Int	评论数
     @property(nonatomic, assign)int isCollected;//	int	是否收藏
     @property(nonatomic, assign)int totalCollected;//	Int	收藏数
     */
    
    contentImage.imageUrl = model.travelNotesPicUrl;//	String	游记封面
    contentLabel.text  = model.travelNotesName;//	String	游记名称
    timeLabel.text = model.lastReleaseTime;//	String	发布日期
    //[NSString stringWithFormat:@"%@  %@   %@",model.timeStr,model.daysStr,model.vistNum];
    [iconImage sd_setImageWithURL:[NSURL URLWithString:model.userPicUrl] placeholderImage:DEFAULTIMAGE];//	String	用户头像
    nameLabel.text = model.userName;//	String	用户名称
    
    [heartBtn setTitle:[NSString stringWithFormat:@"%d",model.totalCollected] forState:0];
    heartBtn.width = [self getWidthWithContent:[NSString stringWithFormat:@"%d",model.totalCollected] height:AUTO(15) font:AUTO(11.0)] + AUTO(20);
    heartBtn.left = DeviceWidth - 10 - heartBtn.width;
    [heartBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [heartBtn addTarget:self action:@selector(btnFunc:) forControlEvents:UIControlEventTouchUpInside];
    
    [pinBtn setTitle:[NSString stringWithFormat:@"%d",model.commentsNum] forState:0];
    pinBtn.width = [self getWidthWithContent:[NSString stringWithFormat:@"%d",model.commentsNum] height:AUTO(15) font:AUTO(11.0)] + AUTO(20);
     pinBtn.left = DeviceWidth - heartBtn.width - pinBtn.width  - 10;
    [pinBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [pinBtn addTarget:self action:@selector(btnFunc:) forControlEvents:UIControlEventTouchUpInside];
    
    [zanBtn setTitle:[NSString stringWithFormat:@"%d",model.likeNum] forState:0];
    zanBtn.width = [self getWidthWithContent:[NSString stringWithFormat:@"%d",model.likeNum] height:AUTO(15) font:AUTO(11.0)] + AUTO(20);
    zanBtn.left = DeviceWidth - pinBtn.width - heartBtn.width - zanBtn.width  - 10;
    [zanBtn addTarget:self action:@selector(btnFunc:) forControlEvents:UIControlEventTouchUpInside];
    [zanBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    
    if(model.isLiked == 1)
    {
        [zanBtn setImage:IMAGE(@"我的_点赞_点击后") forState:0];
    }else{
        [zanBtn setImage:IMAGE(@"我的_点赞") forState:0];
    }
    
    if(model.isCollected == 1)
    {
        [heartBtn setImage:IMAGE(@"我的_小收藏-点击后") forState:0];
    }else{
        [heartBtn setImage:IMAGE(@"我的_小收藏") forState:0];
    }
    
    [self setTagViews];
}


- (void)btnFunc:(UIButton *)btn
{
    if (btn == heartBtn) {
        self.cellBlock(btn,UITableViewCellCollect);
    }else if(btn == pinBtn)
    {
        self.cellBlock(btn,UITableViewCellConment);
    }else{
        self.cellBlock(btn,UITableViewCellPraise);
    }
}

- (CGFloat)getWidthWithContent:(NSString *)content height:(CGFloat)height font:(CGFloat)font{
    
    CGRect rect = [content boundingRectWithSize:CGSizeMake(999, height)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}
                                        context:nil];
    return rect.size.width;
}

- (void)setTagViews
{
    for(UIView *view in [self subviews])
    {
        if([view isKindOfClass:[LBB_TagView class]])
        {
            [view removeFromSuperview];
        }
    }
    for(int i = 0;i < _model.tags.count;i++)
    {
        LBB_SquareTags  *tagsModel = [_model.tags objectAtIndex:i];
        LBB_TagView   *tagView = [[LBB_TagView alloc]initWithFrame:CGRectMake(0, contentImage.height - AUTO(25) - (AUTO(25) * i), AUTO(80), AUTO(20))];
        tagView.tagModel = tagsModel;
        __weak typeof(tagView) weakTagView = tagView;
        tagView.blockTagFunc = ^(LBB_TagView *view)
        {
            weakTagView.left = contentImage.width - view.width - 5;
        };
        tagView.tagTitleStr = tagsModel.tagName;
        
        [self addSubview:tagView];
        
    }
}


@end
