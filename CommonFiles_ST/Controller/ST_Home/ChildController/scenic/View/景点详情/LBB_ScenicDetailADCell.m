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


@interface LBB_ScenicDetailADCell()<SDCycleScrollViewDelegate,GYChangeTextViewDelegate>{
    
    SDCycleScrollView *cycleScrollView;
    UIView* orderView;
    GYChangeTextView *tView;

}

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
     /*   self.orderNewMessageLabel = [UILabel new];
        [self.orderNewMessageLabel setFont:Font10];
        [self.orderNewMessageLabel setTextColor:ColorWhite];
        [orderView addSubview:self.orderNewMessageLabel];
        [self.orderNewMessageLabel mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerY.equalTo(orderView);
            make.left.equalTo(ws.orderPortraitImageView.mas_right).offset(margin);
            make.right.equalTo(orderView).offset(-margin);
        }];*/
       
        CGFloat height1 = AutoSize(36/2);
        CGFloat x = 3 + height1 + 3;
        CGFloat width1 = DeviceWidth-AutoSize(20) - x - 3;

        tView = [[GYChangeTextView alloc] initWithFrame:CGRectMake(x, 0, width1, height1)];
        tView.delegate = self;
        [orderView addSubview:tView];
        [tView mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.centerY.equalTo(orderView);
            make.left.equalTo(ws.orderPortraitImageView.mas_right).offset(margin);
            make.right.equalTo(orderView).offset(-margin);
        }];
        NSArray* array = @[@"IMCCP",@"a iOS developer",@"GitHub:https://github.com/IMCCP"];
        
        [tView animationWithTexts:array/*[NSArray arrayWithObjects:@"这是第1条",@"这是第2条",@"这是第3条", nil]*/];
        
        
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
    NSMutableArray* texts = [NSMutableArray new];
    for (LBB_PurchaseRecords* obj in purchaseRecords) {
        
        [texts addObject:obj.showContent?obj.showContent:@""];
    }
    [self setScrollTextArray:texts];
}


-(void)setScrollTextArray:(NSArray*)array{
    
    WS(ws);
    NSLog(@"setScrollTextArray:%@",array);
    
    if (tView) {
        [tView removeFromSuperview];
        tView = nil;
    }
    CGFloat margin = 3;

    CGFloat height1 = AutoSize(36/2);
    CGFloat x = 3 + height1 + 3;
    CGFloat width1 = DeviceWidth-AutoSize(20) - x - 3;
    
    tView = [[GYChangeTextView alloc] initWithFrame:CGRectMake(x, 0, width1, height1)];
    tView.delegate = self;
    [orderView addSubview:tView];
    [tView mas_makeConstraints:^(MASConstraintMaker* make){
        
        make.centerY.equalTo(orderView);
        make.left.equalTo(ws.orderPortraitImageView.mas_right).offset(margin);
        make.right.equalTo(orderView).offset(-margin);
    }];
    
    if (array.count <= 0) {
        [tView animationWithTexts:@[@"adadadadasdas"]];
    }
    else{
        [tView animationWithTexts:array];
    }
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
-(void)showOrderMessage{
    
    [orderView setHidden:NO];
    [self.orderPortraitImageView sd_setImageWithURL:[NSURL URLWithString:@"http://img.blog.163.com/photo/GlXBl26Es3YNjTZLCkFXwQ==/1984961535764592168.jpg"] placeholderImage:IMAGE(PlaceHolderImage)];
    [self.orderNewMessageLabel setText:@"最新订单来自杭州的百小小. 3秒前"];
}



@end
