//
//  LBBPoohCycleScrollCell.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_ScenicDetailADCell.h"
#import "SDCycleScrollView.h"
#import "GYChangeTextView.h"
#import <AutoScrollLabel/CBAutoScrollLabel.h>


@interface LBB_ScenicDetailADCell()<SDCycleScrollViewDelegate,GYChangeTextViewDelegate>{
    
    SDCycleScrollView *cycleScrollView;
    UIView* orderView;

}
@property(nonatomic, retain)CBAutoScrollLabel* orderNewMessageLabel;

@end

@implementation LBB_ScenicDetailADCell

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
        
        // 情景一：采用本地图片实现
        
        cycleScrollView = [[SDCycleScrollView alloc]init];
        cycleScrollView.placeholderImage = IMAGE(PlaceHolderImage);
        cycleScrollView.infiniteLoop = YES;
        cycleScrollView.autoScrollTimeInterval = 2;
        //  cycleScrollView.localizationImageNamesGroup = imageNames;
        
        cycleScrollView.delegate = self;
        //  cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        [self.contentView addSubview:cycleScrollView];
        [cycleScrollView mas_makeConstraints:^(MASConstraintMaker* make){
            make.center.width.height.equalTo(ws.contentView);
        }];
        
        
        //描绘左侧的订单信息
        orderView = [UIView new];
        [orderView setBackgroundColor:[UIColor colorWithRGB:0xa9a9a9]];
        CGFloat height = AutoSize(36/2);
        [self.contentView addSubview:orderView];
        [orderView mas_makeConstraints:^(MASConstraintMaker* make){
            make.top.equalTo(ws.contentView).offset(AutoSize(110/2));
            make.left.equalTo(ws.contentView).offset(AutoSize(20));
            make.height.mas_equalTo(height);
            make.width.mas_equalTo(AutoSize(100));
        }];
        orderView.layer.cornerRadius = height/2;
        orderView.layer.masksToBounds = YES;
        orderView.hidden = YES;
        //订单头像
        CGFloat margin = 3;
        self.orderPortraitImageView = [UIImageView new];
        [orderView addSubview:self.orderPortraitImageView];
        [self.orderPortraitImageView mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(orderView).offset(margin);
            make.top.equalTo(orderView).offset(margin);
            make.bottom.equalTo(orderView).offset(-margin);
            make.width.equalTo(ws.orderPortraitImageView.mas_height);
        }];
        self.orderPortraitImageView.layer.cornerRadius = (height - 2*margin)/2;
        self.orderPortraitImageView.layer.masksToBounds = YES;
        
        //订单信息
        self.orderNewMessageLabel = [CBAutoScrollLabel new];
        [self.orderNewMessageLabel setFont:Font10];
        [self.orderNewMessageLabel setTextColor:ColorWhite];
        [orderView addSubview:self.orderNewMessageLabel];
        [self.orderNewMessageLabel mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerY.equalTo(orderView);
            make.left.equalTo(ws.orderPortraitImageView.mas_right).offset(margin);
            make.right.equalTo(orderView).offset(-margin);
        }];
       
        
        
    }
    return self;
}



-(void)setCycleScrollViewHeight:(CGFloat)height{
    
    WS(ws);
    [cycleScrollView mas_remakeConstraints:^(MASConstraintMaker* make){
        make.width.equalTo(ws.contentView);
        make.height.mas_equalTo(height);
        make.bottom.top.equalTo(ws.contentView);
    }];
    
    [self.contentView layoutSubviews];
}

-(void)setCycleScrollViewUrls:(NSArray*)urlArray{
    
    cycleScrollView.imageURLStringsGroup = urlArray;
}

-(void)setAllSpotsPics:(NSMutableArray<LBB_SpotsPics *> *)allSpotsPics{
    
    _allSpotsPics = allSpotsPics;
    NSMutableArray* urls = [NSMutableArray new];
    for (LBB_SpotsPics* obj in allSpotsPics) {
        
        [urls addObject:obj.imageUrl];
    }
    NSLog(@"urls:%@",urls);
    [self setCycleScrollViewUrls:urls];//设置展示的广告图片
    
}

-(void)setPurchaseRecords:(NSMutableArray<LBB_PurchaseRecords *> *)purchaseRecords{
    
    _purchaseRecords = purchaseRecords;
    NSString* texts = @"";
    for (LBB_PurchaseRecords* obj in purchaseRecords) {
        
        texts = [[texts stringByAppendingPathComponent:obj.showContent?obj.showContent:@""] stringByAppendingPathComponent:@"   "];
    }
    
    [orderView setHidden:NO];
    [self.orderPortraitImageView sd_setImageWithURL:[NSURL URLWithString:@"http://img.blog.163.com/photo/GlXBl26Es3YNjTZLCkFXwQ==/1984961535764592168.jpg"] placeholderImage:IMAGE(PlaceHolderImage)];
    [self.orderNewMessageLabel setText:texts];
    
}



#pragma GYChangeTextView delegate

- (void)gyChangeTextView:(GYChangeTextView *)textView didTapedAtIndex:(NSInteger)index {
    // NSLog(@"%@ select: %ld",[textView class],index);
}




#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"cycleScrollView didSelectItemAtIndex:%ld",index);
    if (self.enableBlock) {
        self.click(@(index));
    }
    else{
        
        
    }
}

//显示订单信息
-(void)showOrderMessage:(NSString*)string andImageUrl:(NSString*)url{

    NSLog(@"showOrderMessage:%@",string);
    if (string.length <= 0) {
        string = @"暂时没有订单信息";
    }
    [orderView setHidden:NO];
    [self.orderPortraitImageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:IMAGE(PlaceHolderImage)];
    [self.orderNewMessageLabel setText:string];
    [self.orderNewMessageLabel refreshLabels];

}



@end
