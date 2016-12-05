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
        horizontalCellLayout.itemSize = CGSizeMake(AutoSize(250/2), AutoSize(260/2));
        
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
    
    if (self.spotsArray) {
        return self.spotsArray.count;
    }
    else{
        switch (self.pagerView.selectedSegmentIndex) {
            case LBBPoohSegmCtrlFoodsType:
                return self.footSpotsArray.count;
                break;
            case LBBPoohSegmCtrlHostelType:
                return self.liveSpotsArray.count;
                break;
            case LBBPoohSegmCtrlScenicType:
                return self.scenicSpotsArray.count;
                break;
                
            default:
                break;
        }
    }
    
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LBBHomeHotestTableViewCellItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LBBHomeHotestTableViewCellItem"forIndexPath:indexPath];
    
    [cell sizeToFit];
    if (!cell) {
        NSLog(@"无法创建LBBHomeHotestTableViewCellItem时打印，自定义的cell就不可能进来了。");
    }
    
    BN_HomeSpotsList* obj;
    if (self.spotsArray) {
        obj = [self.spotsArray objectAtIndex:indexPath.row];
    }
    else{
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
    [cell.mainImageView sd_setImageWithURL:[NSURL URLWithString:obj.allSpotsPicUrl] placeholderImage:IMAGE(PlaceHolderImage)];//场景图片
    [cell.titleLabel setText:obj.allSpotsName];//场景名称
    [cell.disView setTitle:[NSString stringWithFormat:@"%d",obj.commentsNum] forState:UIControlStateNormal];//评论条数
    [cell.greetView setTitle:[NSString stringWithFormat:@"%d",obj.likeNum] forState:UIControlStateNormal];//点赞次数
   // [cell.priceLabel setText:[NSString stringWithFormat:@"%@元起/人",obj.price]];//价格
    
    //单价设置
    NSString* strFormat1 = [NSString stringWithFormat:@"%@元起/人",obj.price];
    NSString* strFormat2 = @"元";
    UIColor* fontColor = ColorBtnYellow;
    NSDictionary* attrsDic = @{NSForegroundColorAttributeName:fontColor,
                               NSFontAttributeName:Font12};    //显示的字符串进行富文本转换
    NSMutableAttributedString* strAttr = [[NSMutableAttributedString alloc]initWithString:strFormat1];
    //字体设置
    NSRange rang = [strFormat1 rangeOfString:strFormat2];
    if (rang.location != NSNotFound) {
        NSLog(@"found at location = %ld, length = %ld",rang.location,rang.length);
        [strAttr addAttributes:attrsDic range:NSMakeRange(0, rang.location)];
    }else{
        NSLog(@"Not Found");
    }
    cell.priceLabel.attributedText = strAttr;
    
    
   // @weakify (self);
    [RACObserve(obj, isCollected) subscribeNext:^(NSNumber* isCollected) {
      //  @strongify(self);
        
        BOOL status = [isCollected boolValue];
        
        if (status) {
            [cell.favoriteButton setImage:IMAGE(@"ST_Home_FavoriteHL") forState:UIControlStateNormal];
        }
        else{
            [cell.favoriteButton setImage:IMAGE(@"ST_Home_Favorite") forState:UIControlStateNormal];
        }
        
    }];
    
    [RACObserve(obj, isLiked) subscribeNext:^(NSNumber* isLiked) {
      //  @strongify(self);
        BOOL status = [isLiked boolValue];
        if (status) {
            [cell.greetView setImage:IMAGE(@"ST_Home_GreatHL") forState:UIControlStateNormal];
        }
        else{
            [cell.greetView setImage:IMAGE(@"ST_Home_Great") forState:UIControlStateNormal];
        }
        
    }];
    
    [cell.greetView bk_whenTapped:^{
        
        NSLog(@"greetView touch");
        [obj like:^(NSError* error){
            NSLog(@"like error:%@",error);

        }];
    }];
    
    [cell.disView bk_whenTapped:^{
        
        NSLog(@"disView touch");
        
    }];
    [cell.favoriteButton bk_addEventHandler:^(id sender){
        
        NSLog(@"favoriteButton touch");
        [obj collecte:^(NSError* error){
            NSLog(@"collecte error:%@",error);
        }];
    } forControlEvents:UIControlEventTouchUpInside];
    

    
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.isMarket) {
        return;
    }
    
    BN_HomeSpotsList* obj;
    if (self.spotsArray) {
        obj = [self.spotsArray objectAtIndex:indexPath.row];
    }
    else{
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
            make.height.mas_equalTo(AutoSize(20));
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



-(void)setScenicSpotsArray:(NSMutableArray<BN_HomeSpotsList *> *)scenicSpotsArray{
    _scenicSpotsArray = scenicSpotsArray;
    [self.collectionView reloadData];
}

-(void)setFootSpotsArray:(NSMutableArray<BN_HomeSpotsList *> *)footSpotsArray{

    _footSpotsArray = footSpotsArray;
    [self.collectionView reloadData];
}
-(void)setLiveSpotsArray:(NSMutableArray<BN_HomeSpotsList *> *)liveSpotsArray{
    _liveSpotsArray = liveSpotsArray;
    [self.collectionView reloadData];
}
@end
