//
//  LBBHomeHotestTableViewCell.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBHomeHotestTableViewCell.h"
#import "LBBHomeHotestTableViewCellItem.h"
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
        segmentedControl.titleTextAttributes = @{NSFontAttributeName:Font6,
                                                 NSForegroundColorAttributeName:ColorLightGray};
        segmentedControl.selectionIndicatorColor = ColorLightGray;
        segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        [self.contentView addSubview:segmentedControl];
        [segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.centerX.equalTo(ws.contentView);
            make.height.mas_equalTo(TopSegmmentControlHeight);
            make.width.equalTo(@200);
        }];

        self.pagerView = segmentedControl;
        segmentedControl.indexChangeBlock = ^(NSInteger index){
            NSLog(@"segmentedControl select:%ld",index);
        };
        
        UICollectionViewFlowLayout *horizontalCellLayout = [UICollectionViewFlowLayout new];
        horizontalCellLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        //(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
        horizontalCellLayout.sectionInset = UIEdgeInsetsMake(15, 8, 15, 8);
        horizontalCellLayout.minimumInteritemSpacing = 10;
        horizontalCellLayout.minimumLineSpacing = 10;
        horizontalCellLayout.itemSize = CGSizeMake(DeviceWidth * 2/3, DeviceWidth * 2/3-30);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:horizontalCellLayout];

        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        
        self.collectionView.alwaysBounceHorizontal = YES;
        
        _collectionView.scrollEnabled = YES;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [self addSubview:_collectionView];
        
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws.pagerView.mas_bottom).offset(3);
            make.left.right.width.equalTo(ws.contentView);
        }];

        
        [_collectionView registerClass:NSClassFromString(@"LBBHomeHotestTableViewCellItem")
            forCellWithReuseIdentifier:@"LBBHomeHotestTableViewCellItem"];
        
        
        UIView* sep = [UIView new];
        [sep setBackgroundColor:ColorLine];
        [self.contentView addSubview:sep];
        [sep mas_makeConstraints:^(MASConstraintMaker* make){
            make.top.equalTo(_collectionView.mas_bottom);
            make.left.right.equalTo(ws.contentView);
            make.height.equalTo(@1.5);
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

//- (CGSize)horizontalCellContentsView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    CGSize itemSize = CGSizeMake(200, 80);
//    return itemSize;
//}

+(CGFloat)getCellHeight{
    
    CGFloat height = 0;
    height = DeviceWidth * 2/3;

    return height;
}
+(CGFloat)getCellHeight2{
    
    CGFloat height = 0;
    height = DeviceWidth * 2/3 + TopSegmmentControlHeight;
    
    return height;
}

-(void)setPagerViewHidden:(BOOL)isHidden{
    WS(ws);
    if (isHidden) {
        
        self.pagerView.hidden = YES;
        
        [self.pagerView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
            make.width.equalTo(@200);
            make.top.centerX.equalTo(ws.contentView);
        }];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws.pagerView.mas_bottom);
            make.left.right.width.equalTo(ws.contentView);
        }];
    }
    else{
        self.pagerView.hidden = NO;
        
        [self.pagerView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@35);
            make.width.equalTo(@200);
            make.top.centerX.equalTo(ws.contentView);
        }];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws.pagerView.mas_bottom).offset(3);
            make.left.right.width.equalTo(ws.contentView);
        }];
    }
    
    [self.contentView layoutSubviews];
}

-(void)setreload{
    
  //  NSLog(@"setreload");
    
    [self.collectionView reloadData];
}



@end
