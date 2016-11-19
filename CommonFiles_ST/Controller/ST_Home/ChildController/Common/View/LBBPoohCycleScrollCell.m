//
//  LBBPoohCycleScrollCell.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBPoohCycleScrollCell.h"
#import "SDCycleScrollView.h"
#import "LBB_ScenicMainViewController.h"
#import "LBB_HostelMainViewController.h"
#import "LBB_FoodsMainViewController.h"

#import "LBB_ScenicDetailViewController.h"

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

-(void)setAdModelArray:(NSMutableArray<BN_HomeAdvertisement *> *)adModelArray{
    
    _adModelArray = adModelArray;
    NSMutableArray* urls = [NSMutableArray new];
    for (BN_HomeAdvertisement* obj in adModelArray) {
        
        [urls addObject:obj.picUrl];
    }
    NSLog(@"urls:%@",urls);
    [self setCycleScrollViewUrls:urls];//设置展示的广告图片

}


#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"cycleScrollView didSelectItemAtIndex:%ld",index);
    if (self.enableBlock) {
        self.click(@(index));
    }
    else{
    
        /*
         @interface BN_HomeAdvertisement : NSObject
         @property (nonatomic, assign)int classes;//广告类型1 外部连接 2 列表 3 详情
         @property (nonatomic, assign)int type;//1.美食 2.民宿  3.景点 4伴手礼
         @property (nonatomic, strong)NSString *hrefUrl;//跳转地址（当是外部链接的时候有值）
         @property (nonatomic, assign)long objId;//跳转主键（当是跳转到原生的时候有值）
         
         @end
         */
        BN_HomeAdvertisement* model = [self.adModelArray objectAtIndex:index];
        NSLog(@"cycleScrollView didSelect :%@",model);

        switch (model.classes) {
            case 1://外部链接
            {
                TOWebViewController *webViewController = [[TOWebViewController alloc]init];
                webViewController.url = [NSURL URLWithString:model.hrefUrl];
                [[self getViewController].navigationController pushViewController:webViewController animated:YES];
            }
                break;
            case 2://列表
            {
                UIViewController* dest;
                switch (model.type) {
                    case 1://美食
                        dest = [[LBB_FoodsMainViewController alloc] init];
                        break;
                    case 2://民宿
                        dest = [[LBB_HostelMainViewController alloc] init];
                        break;
                    case 3://景点
                        dest = [[LBB_ScenicMainViewController alloc] init];
                        break;
                    case 4://伴手礼
                        break;
                    default:
                        break;
                }
                if (dest) {
                    [[self getViewController].navigationController pushViewController:dest animated:YES];
                }

            }
                break;
            case 3://详情
            {
                LBB_ScenicDetailViewController* dest = [[LBB_ScenicDetailViewController alloc] init];
                switch (model.type) {
                    case 1://美食
                        dest.homeType = LBBPoohHomeTypeFoods;
                        break;
                    case 2://民宿
                        dest.homeType = LBBPoohHomeTypeHostel;
                        break;
                    case 3://景点
                        dest.homeType = LBBPoohHomeTypeScenic;
                        break;
                    case 4://伴手礼
                        break;
                    default:
                        break;
                }
                if (dest) {
                    [[self getViewController].navigationController pushViewController:dest animated:YES];
                }
            }
                break;
                
            default:
                break;
        }
    }
}

//显示订单信息
-(void)showOrderMessage{

    [orderView setHidden:NO];
    [self.orderPortraitImageView sd_setImageWithURL:[NSURL URLWithString:@"http://img.blog.163.com/photo/GlXBl26Es3YNjTZLCkFXwQ==/1984961535764592168.jpg"] placeholderImage:IMAGE(PlaceHolderImage)];
    [self.orderNewMessageLabel setText:@"最新订单来自杭州的百小小. 3秒前"];
}



@end
