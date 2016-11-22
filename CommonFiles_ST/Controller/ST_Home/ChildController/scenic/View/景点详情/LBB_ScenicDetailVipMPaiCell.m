//
//  LLBB_ScenicDetailVipMPaiCell.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/26.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_ScenicDetailVipMPaiCell.h"
#import "LBB_TravelCommentController.h"
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
    return self.ugc.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LBB_ScenicDetailVipMPaiCellItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LBB_ScenicDetailVipMPaiCellItem"forIndexPath:indexPath];
    
    [cell sizeToFit];
    if (!cell) {
        NSLog(@"无法创建LBB_ScenicDetailVipMPaiCellItem时打印，自定义的cell就不可能进来了。");
    }
    
    LBB_SpotsUgc* obj = [self.ugc objectAtIndex:indexPath.row];
    
    /*
     @property(nonatomic, assign)int likeNum ;// 点赞次数
     @property(nonatomic, assign)int commentsNum ;// 评论条数
     @property(nonatomic, strong)NSString *userName ;// 发布者用户名称
     
     @property(nonatomic, strong)NSString *userPicUrl ;// 发布者头像URL
     
     

     */
    
    [cell.mainImageView sd_setImageWithURL:[NSURL URLWithString:obj.ugcPicUrl] placeholderImage:IMAGE(PlaceHolderImage)];
    [cell.nickNameLabel setText:obj.userName];// 发布者用户名称
    [cell.portraitImageView sd_setImageWithURL:[NSURL URLWithString:obj.userPicUrl] placeholderImage:IMAGE(PlaceHolderImage)];

    if (obj.ugcType == 1) {//照片
        cell.playButton.hidden = YES;
    }
    else{//视频
        cell.playButton.hidden = NO;
        [cell.playButton bk_addEventHandler:^(id sender){
            
            //ugcVideoUrl ;// 视频地址
            NSLog(@"playButton touch");
            
        } forControlEvents:UIControlEventTouchUpInside];
    }
    
    @weakify(self);
    // 点赞次数
    [RACObserve(obj, likeNum) subscribeNext:^(NSNumber* num) {
        int likenum = [num intValue];
        [cell.greatButton setTitle:[NSString stringWithFormat:@"%d",likenum] forState:UIControlStateNormal];
    }];
    
    // 评论条数
    [RACObserve(obj, commentsNum) subscribeNext:^(NSNumber* num) {
        int likenum = [num intValue];
        [cell.commentsButton setTitle:[NSString stringWithFormat:@"%d",likenum] forState:UIControlStateNormal];
    }];
 
 
    // 是否收藏 0否 1是
    [RACObserve(obj, isCollected) subscribeNext:^(NSNumber* num) {
        BOOL status = [num boolValue];
     //   [cell.commentsButton setTitle:[NSString stringWithFormat:@"%d",likenum] forState:UIControlStateNormal];
    }];
    
    // 是否点赞 0否 1是
    [RACObserve(obj, isLiked) subscribeNext:^(NSNumber* num) {
        BOOL status = [num boolValue];
        if (status) {
            [cell.greatButton setImage:IMAGE(@"景区列表_点赞HL")forState:UIControlStateNormal];
        }
        else{
            [cell.greatButton setImage:IMAGE(@"景区列表_点赞")forState:UIControlStateNormal];
        }
    }];
    
    [cell.commentsButton bk_whenTapped:^{
        
        NSLog(@"disView touch");
        
    }];
    [cell.greatButton bk_whenTapped:^{
        
        NSLog(@"greetView touch");
        
    }];
    
    
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LBB_TravelCommentController* dest = [[LBB_TravelCommentController alloc]init];
    [[self getViewController].navigationController pushViewController:dest animated:YES];
        
}

-(void)setUgc:(NSMutableArray<LBB_SpotsUgc *> *)ugc{
    
    _ugc = ugc;
    [self.collectionView reloadData];
}

@end
