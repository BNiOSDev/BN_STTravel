//
//  LBBPoohCycleScrollCell.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBPoohCycleScrollCell.h"
#import "SDCycleScrollView.h"

@interface LBBPoohCycleScrollCell()<SDCycleScrollViewDelegate>{

    SDCycleScrollView *cycleScrollView;
    UIView* orderView;
}

@end

@implementation LBBPoohCycleScrollCell

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
        self.orderNewMessageLabel = [UILabel new];
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

    NSArray* imagesURLStrings = @[@"http://img.blog.163.com/photo/GlXBl26Es3YNjTZLCkFXwQ==/1984961535764592168.jpg",
                                  @"http://s7.sinaimg.cn/middle/3d312b52gc448d757ad86&690",
                                  @"http://img5.poco.cn/mypoco/myphoto/20080721/19/43214503200807211940527014829584496_033_640.jpg",
                                  @"http://img2.ph.126.net/O_N-vMFrIBv-vaXfC40fcA==/1679279711155879130.jpg",
                                  @"http://upload.sanqin.com/2014/0820/1408524577544.jpg",
                                  ];
  //  imagesURLStrings = @[@"http://img.blog.163.com/photo/GlXBl26Es3YNjTZLCkFXwQ==/1984961535764592168.jpg" ];
    cycleScrollView.imageURLStringsGroup = urlArray;

}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"cycleScrollView didSelectItemAtIndex:%ld",index);
    if (self.enableBlock) {
        self.click(@(index));
    }
}

//显示订单信息
-(void)showOrderMessage{

    [orderView setHidden:NO];
    [self.orderPortraitImageView sd_setImageWithURL:[NSURL URLWithString:@"http://img.blog.163.com/photo/GlXBl26Es3YNjTZLCkFXwQ==/1984961535764592168.jpg"] placeholderImage:IMAGE(PlaceHolderImage)];
    [self.orderNewMessageLabel setText:@"最新订单来自杭州的百小小. 3秒前"];
}



@end
