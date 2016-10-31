//
//  LLBB_ScenicDetailVipMPaiCell.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/26.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_ScenicDetailVipMPaiCell.h"
@interface LBB_ScenicDetailVipMPaiCell()<UICollectionViewDelegate, UICollectionViewDataSource>

@end
@implementation LBB_ScenicDetailVipMPaiCell

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
 
        UICollectionViewFlowLayout *horizontalCellLayout = [UICollectionViewFlowLayout new];
        horizontalCellLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        //(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
        horizontalCellLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        horizontalCellLayout.minimumInteritemSpacing = 10;
        horizontalCellLayout.minimumLineSpacing = 10;
        horizontalCellLayout.itemSize = CGSizeMake(DeviceWidth * 530/640, LBB_ScenicDetailVipMPaiCellItemHeight);

        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:horizontalCellLayout];
        
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        
        self.collectionView.alwaysBounceHorizontal = YES;
        [_collectionView registerClass:NSClassFromString(@"LBB_ScenicDetailVipMPaiCellItem")
            forCellWithReuseIdentifier:@"LBB_ScenicDetailVipMPaiCellItem"];
        _collectionView.scrollEnabled = YES;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [self.contentView addSubview:_collectionView];
        
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws.contentView.mas_top);
            make.left.right.equalTo(ws.contentView);
            make.bottom.equalTo(ws.contentView);
            make.height.mas_equalTo(LBB_ScenicDetailVipMPaiCellItemHeight);
        }];
        
        
        NSLog(@"LBB_ScenicDetailVipMPaiCellItemHeight:%f",LBB_ScenicDetailVipMPaiCellItemHeight);
        

        
    /*
        UIView* sep = [UIView new];
        [sep setBackgroundColor:ColorLine];
        [self.contentView addSubview:sep];
        [sep mas_makeConstraints:^(MASConstraintMaker* make){
            make.top.equalTo(_collectionView.mas_bottom);
            make.left.right.equalTo(ws.contentView);
            make.height.equalTo(@1.5);
            make.bottom.equalTo(ws.contentView);
        }];*/
        [self.contentView layoutSubviews];
    }
    return self;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LBB_ScenicDetailVipMPaiCellItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LBB_ScenicDetailVipMPaiCellItem"forIndexPath:indexPath];
    
    [cell sizeToFit];
    if (!cell) {
        NSLog(@"无法创建LBB_ScenicDetailVipMPaiCellItem时打印，自定义的cell就不可能进来了。");
    }
    
    [cell.mainImageView sd_setImageWithURL:[NSURL URLWithString:@"http://s7.sinaimg.cn/middle/3d312b52gc448d757ad86&690"] placeholderImage:IMAGE(PlaceHolderImage)];
    [cell.portraitImageView sd_setImageWithURL:[NSURL URLWithString:@"http://s7.sinaimg.cn/middle/3d312b52gc448d757ad86&690"] placeholderImage:IMAGE(PlaceHolderImage)];

    NSLog(@"LBB_ScenicDetailVipMPaiCellItem cellForItemAtIndexPath:%ld",indexPath.row);
    
    return cell;
}


@end
