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
                
        //标签
        self.labelButton1 = [UIButton new];
        [self.labelButton1 setBackgroundImage:IMAGE(@"labelDetailBg") forState:UIControlStateNormal];
        [self.labelButton1 setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        [self.labelButton1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.labelButton1.titleLabel setFont:Font12];
        [self.labelButton1 setTitle:@"厦门" forState:UIControlStateNormal];
        [self addSubview:self.labelButton1];
        [self.labelButton1 mas_makeConstraints:^(MASConstraintMaker* make){
            make.bottom.equalTo(ws).offset(-AutoSize(18));
            make.right.equalTo(ws).offset(-AutoSize(8));
        }];
        
        self.labelButton2 = [UIButton new];
        [self.labelButton2 setBackgroundImage:IMAGE(@"labelDetailBg") forState:UIControlStateNormal];
        [self.labelButton2 setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        [self.labelButton2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.labelButton2.titleLabel setFont:Font12];
        [self.labelButton2 setTitle:@"胶卷摄影" forState:UIControlStateNormal];
        [self addSubview:self.labelButton2];
        [self.labelButton2 mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.height.equalTo(ws.labelButton1);
            make.bottom.equalTo(ws.labelButton1.mas_top).offset(-10);
        }];
        
        self.labelButton3 = [UIButton new];
        [self.labelButton3 setBackgroundImage:IMAGE(@"labelDetailBg") forState:UIControlStateNormal];
        [self.labelButton3 setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        [self.labelButton3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.labelButton3.titleLabel setFont:Font12];
        [self.labelButton3 setTitle:@"胶卷摄影" forState:UIControlStateNormal];
        [self addSubview:self.labelButton3];
        [self.labelButton3 mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.height.equalTo(ws.labelButton1);
            make.bottom.equalTo(ws.labelButton2.mas_top).offset(-10);
        }];
        
        self.labelButton4 = [UIButton new];
        [self.labelButton4 setBackgroundImage:IMAGE(@"labelDetailBg") forState:UIControlStateNormal];
        [self.labelButton4 setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        [self.labelButton4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.labelButton4.titleLabel setFont:Font12];
        [self.labelButton4 setTitle:@"胶卷摄影" forState:UIControlStateNormal];
        [self addSubview:self.labelButton4];
        [self.labelButton4 mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.height.equalTo(ws.labelButton1);
            make.bottom.equalTo(ws.labelButton3.mas_top).offset(-10);
        }];
        
        self.labelButton5 = [UIButton new];
        [self.labelButton5 setBackgroundImage:IMAGE(@"labelDetailBg") forState:UIControlStateNormal];
        [self.labelButton5 setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        [self.labelButton5 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.labelButton5.titleLabel setFont:Font12];
        [self.labelButton5 setTitle:@"胶卷摄影" forState:UIControlStateNormal];
        [self addSubview:self.labelButton5];
        [self.labelButton5 mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.height.equalTo(ws.labelButton1);
            make.bottom.equalTo(ws.labelButton4.mas_top).offset(-10);
        }];
        
        self.labelButton6 = [UIButton new];
        [self.labelButton6 setBackgroundImage:IMAGE(@"labelDetailBg") forState:UIControlStateNormal];
        [self.labelButton6 setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        [self.labelButton6 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.labelButton6.titleLabel setFont:Font12];
        [self.labelButton6 setTitle:@"胶卷摄影" forState:UIControlStateNormal];
        [self addSubview:self.labelButton6];
        [self.labelButton6 mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.height.equalTo(ws.labelButton1);
            make.bottom.equalTo(ws.labelButton5.mas_top).offset(-10);
        }];
        
        self.labelButton1.hidden = YES;
        self.labelButton2.hidden = YES;
        self.labelButton3.hidden = YES;
        self.labelButton4.hidden = YES;
        self.labelButton5.hidden = YES;
        self.labelButton6.hidden = YES;
        
    }
    return self;
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
        
        //item1 的标签动作
        [self.item1.labelButton1 bk_whenTapped:^{
            NSLog(@"labelButton1 touch");
            LBB_LabelDetailViewController* dest = [[LBB_LabelDetailViewController alloc]init];
            LBB_SquareTags* viewModel = [[LBB_SquareTags alloc] init];
            LBB_SquareTags* tag = [ws.model1.tags objectAtIndex:0];
            viewModel.tagId = tag.tagId;
            dest.viewModel = viewModel;
            [[ws getViewController].navigationController pushViewController:dest animated:YES];
        }];
        [self.item1.labelButton2 bk_whenTapped:^{
            NSLog(@"labelButton2 touch");
            LBB_LabelDetailViewController* dest = [[LBB_LabelDetailViewController alloc]init];
            LBB_SquareTags* viewModel = [[LBB_SquareTags alloc] init];
            LBB_SquareTags* tag = [ws.model1.tags objectAtIndex:1];
            viewModel.tagId = tag.tagId;
            dest.viewModel = viewModel;
            [[ws getViewController].navigationController pushViewController:dest animated:YES];
            
        }];
        [self.item1.labelButton3 bk_whenTapped:^{
            NSLog(@"labelButton3 touch");
            LBB_LabelDetailViewController* dest = [[LBB_LabelDetailViewController alloc]init];
            LBB_SquareTags* viewModel = [[LBB_SquareTags alloc] init];
            LBB_SquareTags* tag = [ws.model1.tags objectAtIndex:2];
            viewModel.tagId = tag.tagId;
            dest.viewModel = viewModel;
            [[ws getViewController].navigationController pushViewController:dest animated:YES];
            
        }];
        [self.item1.labelButton4 bk_whenTapped:^{
            NSLog(@"labelButton4 touch");
            LBB_LabelDetailViewController* dest = [[LBB_LabelDetailViewController alloc]init];
            LBB_SquareTags* viewModel = [[LBB_SquareTags alloc] init];
            LBB_SquareTags* tag = [ws.model1.tags objectAtIndex:3];
            viewModel.tagId = tag.tagId;
            dest.viewModel = viewModel;
            [[ws getViewController].navigationController pushViewController:dest animated:YES];
            
        }];
        [self.item1.labelButton5 bk_whenTapped:^{
            NSLog(@"labelButton5 touch");
            LBB_LabelDetailViewController* dest = [[LBB_LabelDetailViewController alloc]init];
            LBB_SquareTags* viewModel = [[LBB_SquareTags alloc] init];
            LBB_SquareTags* tag = [ws.model1.tags objectAtIndex:4];
            viewModel.tagId = tag.tagId;
            dest.viewModel = viewModel;
            [[ws getViewController].navigationController pushViewController:dest animated:YES];
            
        }];
        
        [self.item1.labelButton6 bk_whenTapped:^{
            NSLog(@"labelButton6 touch");
            LBB_LabelDetailViewController* dest = [[LBB_LabelDetailViewController alloc]init];
            LBB_SquareTags* viewModel = [[LBB_SquareTags alloc] init];
            LBB_SquareTags* tag = [ws.model1.tags objectAtIndex:5];
            viewModel.tagId = tag.tagId;
            dest.viewModel = viewModel;
            [[ws getViewController].navigationController pushViewController:dest animated:YES];
            
        }];
        
        
        //item2 的标签动作
        [self.item2.labelButton1 bk_whenTapped:^{
            NSLog(@"labelButton1 touch");
            LBB_LabelDetailViewController* dest = [[LBB_LabelDetailViewController alloc]init];
            LBB_SquareTags* viewModel = [[LBB_SquareTags alloc] init];
            LBB_SquareTags* tag = [ws.model2.tags objectAtIndex:0];
            viewModel.tagId = tag.tagId;
            dest.viewModel = viewModel;
            [[ws getViewController].navigationController pushViewController:dest animated:YES];
        }];
        [self.item2.labelButton2 bk_whenTapped:^{
            NSLog(@"labelButton2 touch");
            LBB_LabelDetailViewController* dest = [[LBB_LabelDetailViewController alloc]init];
            LBB_SquareTags* viewModel = [[LBB_SquareTags alloc] init];
            LBB_SquareTags* tag = [ws.model2.tags objectAtIndex:1];
            viewModel.tagId = tag.tagId;
            dest.viewModel = viewModel;
            [[ws getViewController].navigationController pushViewController:dest animated:YES];
            
        }];
        [self.item2.labelButton3 bk_whenTapped:^{
            NSLog(@"labelButton3 touch");
            LBB_LabelDetailViewController* dest = [[LBB_LabelDetailViewController alloc]init];
            LBB_SquareTags* viewModel = [[LBB_SquareTags alloc] init];
            LBB_SquareTags* tag = [ws.model2.tags objectAtIndex:2];
            viewModel.tagId = tag.tagId;
            dest.viewModel = viewModel;
            [[ws getViewController].navigationController pushViewController:dest animated:YES];
            
        }];
        [self.item2.labelButton4 bk_whenTapped:^{
            NSLog(@"labelButton4 touch");
            LBB_LabelDetailViewController* dest = [[LBB_LabelDetailViewController alloc]init];
            LBB_SquareTags* viewModel = [[LBB_SquareTags alloc] init];
            LBB_SquareTags* tag = [ws.model2.tags objectAtIndex:3];
            viewModel.tagId = tag.tagId;
            dest.viewModel = viewModel;
            [[ws getViewController].navigationController pushViewController:dest animated:YES];
            
        }];
        [self.item2.labelButton5 bk_whenTapped:^{
            NSLog(@"labelButton5 touch");
            LBB_LabelDetailViewController* dest = [[LBB_LabelDetailViewController alloc]init];
            LBB_SquareTags* viewModel = [[LBB_SquareTags alloc] init];
            LBB_SquareTags* tag = [ws.model2.tags objectAtIndex:4];
            viewModel.tagId = tag.tagId;
            dest.viewModel = viewModel;
            [[ws getViewController].navigationController pushViewController:dest animated:YES];
            
        }];
        
        [self.item2.labelButton6 bk_whenTapped:^{
            NSLog(@"labelButton6 touch");
            LBB_LabelDetailViewController* dest = [[LBB_LabelDetailViewController alloc]init];
            LBB_SquareTags* viewModel = [[LBB_SquareTags alloc] init];
            LBB_SquareTags* tag = [ws.model2.tags objectAtIndex:5];
            viewModel.tagId = tag.tagId;
            dest.viewModel = viewModel;
            [[ws getViewController].navigationController pushViewController:dest animated:YES];
            
        }];
    }
    return self;
}

-(void)setModel1:(LBB_TagShowViewData *)model1{
    
    _model1 = model1;
    
    /*
     @property (nonatomic, assign)int actionType ;// 5 ugc图片 6 ugc视频 7 游记 11 广告
     @property (nonatomic, assign)long objId ;// 对象主键
     @property (nonatomic, strong)NSString *picUrl ;// 图片地址
     @property (nonatomic, strong)NSMutableArray<LBB_SquareTags*> *tags ;// 标签
     @property (nonatomic, assign)int adClasses ;// 1 外部连接 2 列表 3 详情
     @property (nonatomic, assign)int adType ;// 1.美食 2.民宿  3.景点 4伴手礼
     @property (nonatomic, strong)NSString *adPicDestUrl ;// 外部链接地址
     */
    [self.item1.bgImageView sd_setImageWithURL:[NSURL URLWithString:model1.picUrl] placeholderImage:IMAGE(PlaceHolderImage)];

    //标签
    self.item1.labelButton1.hidden = YES;
    self.item1.labelButton2.hidden = YES;
    self.item1.labelButton3.hidden = YES;
    self.item1.labelButton4.hidden = YES;
    self.item1.labelButton5.hidden = YES;
    self.item1.labelButton6.hidden = YES;
    
    NSInteger count = model1.tags.count;
    if (count > 0) {
        self.item1.labelButton1.hidden = NO;
        LBB_SquareTags* tag = [model1.tags objectAtIndex:0];
        [self.item1.labelButton1 setTitle:tag.tagName forState:UIControlStateNormal];
    }
    if (count > 1){
        self.item1.labelButton2.hidden = NO;
        LBB_SquareTags* tag = [model1.tags objectAtIndex:1];
        [self.item1.labelButton2 setTitle:tag.tagName forState:UIControlStateNormal];
    }
    if (count > 2){
        self.item1.labelButton3.hidden = NO;
        LBB_SquareTags* tag = [model1.tags objectAtIndex:2];
        [self.item1.labelButton3 setTitle:tag.tagName forState:UIControlStateNormal];
    }
    if (count > 3){
        self.item1.labelButton4.hidden = NO;
        LBB_SquareTags* tag = [model1.tags objectAtIndex:3];
        [self.item1.labelButton4 setTitle:tag.tagName forState:UIControlStateNormal];
    }
    if (count > 4){
        self.item1.labelButton5.hidden = NO;
        LBB_SquareTags* tag = [model1.tags objectAtIndex:4];
        [self.item1.labelButton5 setTitle:tag.tagName forState:UIControlStateNormal];
    }
    if (count > 5){
        self.item1.labelButton6.hidden = NO;
        LBB_SquareTags* tag = [model1.tags objectAtIndex:5];
        [self.item1.labelButton6 setTitle:tag.tagName forState:UIControlStateNormal];
    }
    
}

-(void)setModel2:(LBB_TagShowViewData *)model2{
    _model2 = model2;
    [self.item2.bgImageView sd_setImageWithURL:[NSURL URLWithString:model2.picUrl] placeholderImage:IMAGE(PlaceHolderImage)];
    //标签
    self.item2.labelButton1.hidden = YES;
    self.item2.labelButton2.hidden = YES;
    self.item2.labelButton3.hidden = YES;
    self.item2.labelButton4.hidden = YES;
    self.item2.labelButton5.hidden = YES;
    self.item2.labelButton6.hidden = YES;
    
    NSInteger count = model2.tags.count;
    if (count > 0) {
        self.item2.labelButton1.hidden = NO;
        LBB_SquareTags* tag = [model2.tags objectAtIndex:0];
        [self.item2.labelButton1 setTitle:tag.tagName forState:UIControlStateNormal];
    }
    if (count > 1){
        self.item2.labelButton2.hidden = NO;
        LBB_SquareTags* tag = [model2.tags objectAtIndex:1];
        [self.item2.labelButton2 setTitle:tag.tagName forState:UIControlStateNormal];
    }
    if (count > 2){
        self.item2.labelButton3.hidden = NO;
        LBB_SquareTags* tag = [model2.tags objectAtIndex:2];
        [self.item2.labelButton3 setTitle:tag.tagName forState:UIControlStateNormal];
    }
    if (count > 3){
        self.item2.labelButton4.hidden = NO;
        LBB_SquareTags* tag = [model2.tags objectAtIndex:3];
        [self.item2.labelButton4 setTitle:tag.tagName forState:UIControlStateNormal];
    }
    if (count > 4){
        self.item2.labelButton5.hidden = NO;
        LBB_SquareTags* tag = [model2.tags objectAtIndex:4];
        [self.item2.labelButton5 setTitle:tag.tagName forState:UIControlStateNormal];
    }
    if (count > 5){
        self.item2.labelButton6.hidden = NO;
        LBB_SquareTags* tag = [model2.tags objectAtIndex:5];
        [self.item2.labelButton6 setTitle:tag.tagName forState:UIControlStateNormal];
    }
}

@end
