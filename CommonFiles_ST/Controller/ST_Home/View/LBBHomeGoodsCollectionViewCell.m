//
//  LBBHomeGoodsCollectionViewCell.m
//  ST_Travel
//
//  Created by 许为锴 on 2016/12/27.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBHomeGoodsCollectionViewCell.h"
#import "LBBHomeGoodsCollectionViewItem.h"

@interface LBBHomeGoodsCollectionViewCell()<UICollectionViewDelegate, UICollectionViewDataSource>

@end
@implementation LBBHomeGoodsCollectionViewCell

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
        segmentedControl.selectionIndicatorHeight = 1.0f;  // 线的高度
        segmentedControl.titleTextAttributes = @{NSFontAttributeName:Font12,
                                                 NSForegroundColorAttributeName:ColorLightGray};
        segmentedControl.selectionIndicatorColor = ColorLightGray;
        segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        [self.contentView addSubview:segmentedControl];
        [segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.centerX.equalTo(ws.contentView);
            make.height.mas_equalTo(25);
            make.width.mas_equalTo(AutoSize(300/2));
        }];
        
        self.pagerView = segmentedControl;
        
        UICollectionViewFlowLayout *horizontalCellLayout = [UICollectionViewFlowLayout new];
        horizontalCellLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        //(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
        horizontalCellLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        horizontalCellLayout.minimumInteritemSpacing = 6;
        horizontalCellLayout.minimumLineSpacing = 6;
        horizontalCellLayout.itemSize = CGSizeMake(AutoSize(186/2), AutoSize(260/2));
        
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
        
        
        [_collectionView registerClass:NSClassFromString(@"LBBHomeGoodsCollectionViewItem")
            forCellWithReuseIdentifier:@"LBBHomeGoodsCollectionViewItem"];
        
        
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
    
    
    if (self.type == LBBHomeHotestTableViewCellVipRecommendType1) {
        switch (self.pagerView.selectedSegmentIndex) {
            case LBBPoohSegmCtrlFoodsType:
                NSLog(@"达人推荐美食行数:%lu",self.footSpotsArray.count);
                return self.footSpotsArray.count;
                break;
            case LBBPoohSegmCtrlHostelType:
                NSLog(@"达人推荐民宿行数:%lu",self.liveSpotsArray.count);
                return self.liveSpotsArray.count;
                break;
            case LBBPoohSegmCtrlScenicType:
                NSLog(@"达人推荐景点行数:%lu",self.scenicSpotsArray.count);
                return self.scenicSpotsArray.count;
                break;
                
            default:
                break;
        }
    }
    else if (self.type == LBBHomeHotestTableViewCellHotType1){
        return self.spotsArray.count;
    }
    
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LBBHomeGoodsCollectionViewItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LBBHomeGoodsCollectionViewItem"forIndexPath:indexPath];
    NSLog(@"AAAAAAAA %@",cell);
    [cell sizeToFit];
    if (!cell) {
        NSLog(@"无法创建LBBHomeHotestTableViewCellItem时打印，自定义的cell就不可能进来了。");
    }
    
    BN_HomeHotGoodsObject* obj;
    if (self.type == LBBHomeHotestTableViewCellVipRecommendType1) {
        switch (self.pagerView.selectedSegmentIndex) {
            case LBBPoohSegmCtrlFoodsType:
                NSLog(@"达人推荐数据美食:%lu",indexPath.row);
                obj = [self.footSpotsArray objectAtIndex:indexPath.row];
                break;
            case LBBPoohSegmCtrlHostelType:
                NSLog(@"达人推荐数据民宿:%lu",indexPath.row);
                obj = [self.liveSpotsArray objectAtIndex:indexPath.row];
                break;
            case LBBPoohSegmCtrlScenicType:
                NSLog(@"达人推荐数据景点:%lu",indexPath.row);
                obj = [self.scenicSpotsArray objectAtIndex:indexPath.row];
                break;
        }
    }
    else if (self.type == LBBHomeHotestTableViewCellHotType1){
        obj = [self.spotsArray objectAtIndex:indexPath.row];
    }
    [cell setModel:obj];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    /*
    BN_HomeHotGoodsObject* obj;
    if (self.type == LBBHomeHotestTableViewCellVipRecommendType) {
        switch (self.pagerView.selectedSegmentIndex) {
            case LBBPoohSegmCtrlFoodsType:
                obj = [self.footSpotsArray objectAtIndex:indexPath.row];
                break;
            case LBBPoohSegmCtrlHostelType:
                obj = [self.liveSpotsArray objectAtIndex:indexPath.row];
                break;
            case LBBPoohSegmCtrlScenicType:
                obj = [self.scenicSpotsArray objectAtIndex:indexPath.row];
                break;
        }
    }
    else if (self.type == LBBHomeHotestTableViewCellHotType) {
        
        obj = [self.spotsArray objectAtIndex:indexPath.row];
    }
    
    LBB_ScenicDetailViewController* dest = [[LBB_ScenicDetailViewController alloc]init];
    LBB_SpotModel* viewModel = [[LBB_SpotModel alloc]init];
    viewModel.allSpotsId = obj.allSpotsId;
    dest.spotModel = viewModel;
    switch (obj.allSpotsType) {//	1.美食 2.民宿 3景点
        case 1://美食
            dest.homeType = LBBPoohHomeTypeFoods;
            break;
        case 2://民宿
            dest.homeType = LBBPoohHomeTypeHostel;
            break;
        case 3://景点
            dest.homeType = LBBPoohHomeTypeScenic;
            break;
    }
    if (dest) {
        [[self getViewController].navigationController pushViewController:dest animated:YES];
    }
    */
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
            make.height.mas_equalTo(AutoSize(310/2));
        }];
    }
    else{
        self.pagerView.hidden = NO;
        
        [self.pagerView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(AutoSize(20));
            make.width.mas_equalTo(AutoSize(300/2));
            make.top.centerX.equalTo(ws.contentView);
        }];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws.pagerView.mas_bottom);
            make.left.right.bottom.equalTo(ws.contentView);
            make.height.mas_equalTo(AutoSize(310/2));
        }];
    }
    [self.contentView layoutSubviews];
}


-(void)setSpotsArray:(NSMutableArray<BN_HomeHotGoodsObject *> *)spotsArray{
    
    _spotsArray = spotsArray;
    [self.collectionView reloadData];
}

-(void)setScenicSpotsArray:(NSMutableArray<BN_HomeHotGoodsObject *> *)scenicSpotsArray{
    _scenicSpotsArray = scenicSpotsArray;
    [self.collectionView reloadData];
}

-(void)setFootSpotsArray:(NSMutableArray<BN_HomeHotGoodsObject *> *)footSpotsArray{
    
    _footSpotsArray = footSpotsArray;
    [self.collectionView reloadData];
}
-(void)setLiveSpotsArray:(NSMutableArray<BN_HomeHotGoodsObject *> *)liveSpotsArray{
    _liveSpotsArray = liveSpotsArray;
    [self.collectionView reloadData];
}
@end
