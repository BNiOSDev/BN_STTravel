//
//  LBBHomeHotestTableViewCell.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBHomeHotestTableViewCell.h"
#import "LBBHomeHotestTableViewCellItem.h"
#import "LBB_ScenicDetailViewController.h"
@interface LBBHomeHotestTableViewCell()<UICollectionViewDelegate, UICollectionViewDataSource>


@end

@implementation LBBHomeHotestTableViewCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    WS(ws);
    if (self) {
        
        [self setBackgroundColor:[UIColor whiteColor]];

        NSArray* segmentArray = @[@"景点",@"美食",@"民宿"];
    
        HMSegmentedControl *segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:segmentArray];
        segmentedControl.selectionIndicatorHeight = 2.0f;  // 线的高度
        segmentedControl.titleTextAttributes = @{NSFontAttributeName:Font15,
                                                 NSForegroundColorAttributeName:ColorLightGray};
        segmentedControl.selectionIndicatorColor = ColorLightGray;
        segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        segmentedControl.selectedSegmentIndex = self.selectType;
        [self.contentView addSubview:segmentedControl];
        [segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.centerX.equalTo(ws.contentView);
            make.height.mas_equalTo(TopSegmmentControlHeight);
            make.width.mas_equalTo(AutoSize(300/2));
        }];

        self.pagerView = segmentedControl;
        
        segmentedControl.indexChangeBlock = ^(NSInteger index){
            NSLog(@"segmentedControl select:%ld",index);
        };
        
        UICollectionViewFlowLayout *horizontalCellLayout = [UICollectionViewFlowLayout new];
        horizontalCellLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        //(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
        horizontalCellLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        horizontalCellLayout.minimumInteritemSpacing = 6;
        horizontalCellLayout.minimumLineSpacing = 6;
        horizontalCellLayout.itemSize = CGSizeMake(AutoSize(250/2), AutoSize(250/2));
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:horizontalCellLayout];

        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        
        self.collectionView.alwaysBounceHorizontal = YES;
        
        _collectionView.scrollEnabled = YES;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [self.contentView addSubview:_collectionView];
        
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws.pagerView.mas_bottom);
            make.left.right.bottom.equalTo(ws.contentView);
            make.height.mas_equalTo(AutoSize(300/2));
        }];

        
        [_collectionView registerClass:NSClassFromString(@"LBBHomeHotestTableViewCellItem")
            forCellWithReuseIdentifier:@"LBBHomeHotestTableViewCellItem"];
        
        
        UIView* sep = [UIView new];
        [sep setBackgroundColor:ColorLine];
        [self.contentView addSubview:sep];
        [sep mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.right.equalTo(ws.contentView);
            make.height.mas_equalTo(SeparateLineWidth);
            make.bottom.equalTo(ws.contentView);
        }];
    }
    return self;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LBBHomeHotestTableViewCellItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LBBHomeHotestTableViewCellItem"forIndexPath:indexPath];
    
    [cell sizeToFit];
    if (!cell) {
        NSLog(@"无法创建LBBHomeHotestTableViewCellItem时打印，自定义的cell就不可能进来了。");
    }
    
    [cell.mainImageView sd_setImageWithURL:[NSURL URLWithString:@"http://s7.sinaimg.cn/middle/3d312b52gc448d757ad86&690"] placeholderImage:IMAGE(@"poohtest")];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.isMarket) {
        return;
    }
    
    LBB_ScenicDetailViewController* dest = [[LBB_ScenicDetailViewController alloc]init];
    switch (self.selectType) {
        case LBBPoohSegmCtrlScenicType://景点
            dest.homeType = LBBPoohHomeTypeScenic;
            break;
        case LBBPoohSegmCtrlFoodsType://美食
            dest.homeType = LBBPoohHomeTypeFoods;
            break;
        case LBBPoohSegmCtrlHostelType://民宿
            dest.homeType = LBBPoohHomeTypeHostel;
            break;
    }
    if (dest) {
        [[self getViewController].navigationController pushViewController:dest animated:YES];
    }
    
}


//- (CGSize)horizontalCellContentsView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    CGSize itemSize = CGSizeMake(200, 80);
//    return itemSize;
//}

-(void)setPagerViewHidden:(BOOL)isHidden{
    WS(ws);
    if (isHidden) {
        
        self.pagerView.hidden = YES;
        
        [self.pagerView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
            make.width.mas_equalTo(AutoSize(300/2));
            make.top.centerX.equalTo(ws.contentView);
        }];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws.pagerView.mas_bottom);
            make.left.right.bottom.equalTo(ws.contentView);
            make.height.mas_equalTo(AutoSize(300/2));
        }];
    }
    else{
        self.pagerView.hidden = NO;
        
        [self.pagerView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(TopSegmmentControlHeight);
            make.width.mas_equalTo(AutoSize(300/2));
            make.top.centerX.equalTo(ws.contentView);
        }];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws.pagerView.mas_bottom);
            make.left.right.bottom.equalTo(ws.contentView);
            make.height.mas_equalTo(AutoSize(300/2));
        }];
    }
    [self.contentView layoutSubviews];
}





@end
