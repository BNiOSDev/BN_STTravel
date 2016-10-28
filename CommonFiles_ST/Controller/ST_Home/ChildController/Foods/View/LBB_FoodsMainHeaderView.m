//
//  LBB_FoodsMainHeaderView.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/28.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_FoodsMainHeaderView.h"
#import "PoohCommon.h"
@implementation LBB_FoodsMainHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(id)init{

    WS(ws);
    if (self = [super init]) {
        
        self.cycScrollView = [[SDCycleScrollView alloc]init];
        self.cycScrollView.placeholderImage = IMAGE(PlaceHolderImage);
        self.cycScrollView.infiniteLoop = YES;
        self.cycScrollView.autoScrollTimeInterval = 2;
        //  cycleScrollView.localizationImageNamesGroup = imageNames;
        
        self.cycScrollView.delegate = self;
        //  cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        self.cycScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        self.cycScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        [self addSubview:self.cycScrollView];
        [self.cycScrollView mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerX.width.top.equalTo(ws);
            make.height.mas_equalTo(AutoSize(470/2));
        }];

        
        NSArray* titleArray = @[@"美食首页_台湾小吃", @"美食首页_厦门小吃",@"美食首页_福建小吃",@"美食首页_海鲜"];
        NSArray* iconArray = @[@"台湾小吃",@"厦门小吃",@"福建小吃",@"海鲜"];
        
        NSInteger count = [titleArray count];
        CGFloat margineLeft = 25;
        CGFloat width = (DeviceWidth - (count+1)*margineLeft)/count;
        
        UIView *sub = [UIView new];
        [self addSubview:sub];
        [sub mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.right.equalTo(ws);
            make.top.equalTo(ws.cycScrollView.mas_bottom);
            make.bottom.equalTo(ws);
        }];
        
        for (int i = 0 ; i<count; i++) {
            
            LBBPoohVerticalButton* btn = [[LBBPoohVerticalButton alloc]init];
            [btn setTag:i];
            [btn.titleLabel setText:[titleArray objectAtIndex:i]];
            [btn.titleLabel setTextColor:[UIColor blackColor]];
            [btn.titleLabel setFont:Font14];
            [btn.imageView setImage:IMAGE([iconArray objectAtIndex:i])];
            [sub addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker* make){
                make.top.equalTo(sub).offset(16);
                make.left.equalTo(sub).offset(i*(width+margineLeft)+margineLeft);
                make.width.mas_equalTo(width);
                make.bottom.equalTo(sub).offset(-16);
            }];
            [btn bk_addEventHandler:^(LBBPoohVerticalButton* sender){
                
                NSLog(@"touch button %ld",sender.tag);
                
            } forControlEvents:UIControlEventTouchUpInside];
        }
        
    }
    
    return self;
    
}

+(CGFloat)getHeaderViewHeight{

    NSArray* titleArray = @[@"美食首页_台湾小吃", @"美食首页_厦门小吃",@"美食首页_福建小吃",@"美食首页_海鲜"];
    NSArray* iconArray = @[@"台湾小吃",@"厦门小吃",@"福建小吃",@"海鲜"];
    
    NSInteger count = [titleArray count];
    CGFloat margineLeft = 25;
    CGFloat width = (DeviceWidth - (count+1)*margineLeft)/count;
    
    CGFloat height = 0;
    height = AutoSize(470/2) + 16 + 16 + 0;
    return height;
    
}


-(void)setCycleScrollViewUrls:(NSArray*)urlArray{
    
    NSArray* imagesURLStrings = @[@"http://img.blog.163.com/photo/GlXBl26Es3YNjTZLCkFXwQ==/1984961535764592168.jpg",
                                  @"http://s7.sinaimg.cn/middle/3d312b52gc448d757ad86&690",
                                  @"http://img5.poco.cn/mypoco/myphoto/20080721/19/43214503200807211940527014829584496_033_640.jpg",
                                  @"http://img2.ph.126.net/O_N-vMFrIBv-vaXfC40fcA==/1679279711155879130.jpg",
                                  @"http://upload.sanqin.com/2014/0820/1408524577544.jpg",
                                  ];
    //  imagesURLStrings = @[@"http://img.blog.163.com/photo/GlXBl26Es3YNjTZLCkFXwQ==/1984961535764592168.jpg" ];
    self.cycScrollView.imageURLStringsGroup = imagesURLStrings;
}
#pragma SDCycleScrollView Delegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"cycleScrollView didSelectItemAtIndex:%ld",index);
}



@end
