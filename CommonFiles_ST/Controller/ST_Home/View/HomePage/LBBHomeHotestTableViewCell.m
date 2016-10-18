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
        
        [self setBackgroundColor:[UIColor grayColor]];

        
        UICollectionViewFlowLayout *horizontalCellLayout = [UICollectionViewFlowLayout new];
        horizontalCellLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        //(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
        horizontalCellLayout.sectionInset = UIEdgeInsetsMake(15, 8, 15, 8);
        horizontalCellLayout.minimumInteritemSpacing = 10;
        horizontalCellLayout.minimumLineSpacing = 10;
        horizontalCellLayout.itemSize = CGSizeMake(UISCREEN_WIDTH * 2/3, UISCREEN_WIDTH * 2/3-30);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:horizontalCellLayout];

        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        
        self.collectionView.alwaysBounceHorizontal = YES;
      //    self.collectionView.alwaysBounceVertical = YES;

        _collectionView.scrollEnabled = YES;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [self.contentView addSubview:_collectionView];

        
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws.contentView);
            make.left.right.bottom.equalTo(ws.contentView);
         //   make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width);
        }];

        [_collectionView registerClass:NSClassFromString(@"LBBHomeHotestTableViewCellItem")
            forCellWithReuseIdentifier:@"LBBHomeHotestTableViewCellItem"];
        
        
        UIView* sep = [UIView new];
        [sep setBackgroundColor:[UIConstants getSeperatorLineColor]];
        [self.contentView addSubview:sep];
        [sep mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.right.bottom.equalTo(ws.contentView);
            make.height.equalTo(@1.5);
        }];
        
        [self layoutSubviews];//it must to be done to layouts subviews

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

-(CGFloat)getCellHeight{
    
    CGFloat height = 0;
    height = UISCREEN_WIDTH * 2/3;
    NSLog(@"getCellHeight:%f",height);
    return height;
}

-(void)setreload{
    
    NSLog(@"setreload");
    
    [self layoutSubviews];
    [self.collectionView reloadData];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    NSLog(@"content size width: %f,height:%f",_collectionView.contentSize.width,_collectionView.contentSize.height);
}

@end
