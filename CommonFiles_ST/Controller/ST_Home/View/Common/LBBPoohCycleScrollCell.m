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
        
        //        NSMutableArray *rightUtilityButtons = [NSMutableArray new];
        //        [rightUtilityButtons sw_addUtilityButtonWithColor:[UIColor colorWithRGB:0xfb0d1b]
        //                                                    title:@"删除"];
        //        [rightUtilityButtons sw_addUtilityButtonWithColor:[UIColor colorWithRGB:0x058cc0]
        //                                                    title:@"修改"];
        //
        //        self.rightUtilityButtons = rightUtilityButtons;
        
        

        // 情景一：采用本地图片实现

        cycleScrollView = [[SDCycleScrollView alloc]init];
        cycleScrollView.placeholderImage = IMAGE(@"poohBack");
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
    }
    return self;
}


-(void)setCycleScrollViewUrls:(NSArray*)urlArray{

    NSArray* imagesURLStrings = @[@"http://img.blog.163.com/photo/GlXBl26Es3YNjTZLCkFXwQ==/1984961535764592168.jpg",
                                  @"http://s7.sinaimg.cn/middle/3d312b52gc448d757ad86&690",
                                  @"http://img5.poco.cn/mypoco/myphoto/20080721/19/43214503200807211940527014829584496_033_640.jpg",
                                  @"http://img2.ph.126.net/O_N-vMFrIBv-vaXfC40fcA==/1679279711155879130.jpg",
                                  @"http://upload.sanqin.com/2014/0820/1408524577544.jpg",
                                  ];
    cycleScrollView.imageURLStringsGroup = imagesURLStrings;

}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"cycleScrollView didSelectItemAtIndex:%ld",index);
}


-(CGFloat)getCellHeight{

    CGFloat height = 0;
    height = UISCREEN_WIDTH * 3/5;
    NSLog(@"getCellHeight:%f",height);
    return height;
}

@end
