//
//  LBB_MineViewDataController.m
//  ST_Travel
//
//  Created by 晨曦 on 16/10/28.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_MineViewDataController.h"
#import "LBB_MyViewCell.h"
#import "LBB_MySectionHeadViewCell.h"
#import "LBB_MySectionFooterViewCell.h"
#import "LBB_MyUserHeaderView.h"
#import "MineBaseViewController.h"


@implementation LBB_MineViewDataController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)initDataSource
{
    self.model = [[LBB_MineModel alloc] init];
    self.modelData = [self.model getData];
    self.arr = self.modelData.sectionInfo;
    
    //进行CollectionView和Cell的绑定
    UINib *nib = [UINib nibWithNibName:@"LBB_MyViewCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"LBB_MyViewCell"];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    //注册CollectionReusableView；
    UINib *nib2 = [UINib nibWithNibName:@"LBB_MySectionHeadViewCell" bundle:nil];
    [self.collectionView registerNib:nib2
          forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                 withReuseIdentifier:@"LBB_MySectionHeadViewCell"];
    
    //注册CollectionReusableView；
    UINib *nib4 = [UINib nibWithNibName:@"LBB_MyUserHeaderView" bundle:nil];
    [self.collectionView registerNib:nib4
          forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                 withReuseIdentifier:@"LBB_MyUserHeaderView"];
    
    
    UINib *nib3 = [UINib nibWithNibName:@"LBB_MySectionFooterViewCell" bundle:nil];
    [self.collectionView registerNib:nib3
          forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                 withReuseIdentifier:@"LBB_MySectionFooterViewCell"];
    
}

- (LBB_MineDetaiInfo*)getCellInfo:(NSIndexPath*)indexPath
{
    LBB_MineDetaiInfo *cellInfo = nil;
    if ((indexPath.section - 1) < self.arr.count) {
        LBB_MineSectionInfo *sectionInfo = [self.arr objectAtIndex:indexPath.section -1];
        NSArray *contentArray = sectionInfo.detailArary;
        if (contentArray && [contentArray isKindOfClass:[NSArray class]]) {
            LBB_MineDetaiInfo *detailInfo = [contentArray objectAtIndex:indexPath.row];
            cellInfo = detailInfo;
        }
        
    }
    return cellInfo;
}
#pragma mark - 共有
- (void)replaceUserHeadImage:(UIImage*)converPicture
{
    if (converPicture) {
        LBB_MineUserInfo *userInfo = self.modelData.userInfo;
        userInfo.coverPicturePath = converPicture;
        [self.collectionView reloadData];
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.arr.count + 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    LBB_MineSectionInfo *cellnfo = [self.arr objectAtIndex:section - 1];
    NSArray *contentArray = cellnfo.detailArary;
    if (contentArray && [contentArray isKindOfClass:[NSArray class]]) {
        return [contentArray count];
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"LBB_MyViewCell";
    LBB_MyViewCell *cell =  (LBB_MyViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    LBB_MineDetaiInfo *cellInfo = [self getCellInfo:indexPath];
    if (cellInfo) {
        cell.imgView.image = IMAGE(cellInfo.detailImage);
        cell.label.text = cellInfo.detailContent;
        NSString *numStr = cellInfo.newNum ? [NSString stringWithFormat:@"%@",@(cellInfo.newNum)] : nil;
        if (numStr && [numStr intValue] > 0) {
            cell.numLabel.hidden = NO;
            cell.numLabel.text = numStr;
        }else {
             cell.numLabel.hidden = YES;
        }
    }
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionReusableView *reusable = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        if (indexPath.section == 0) {
            LBB_MyUserHeaderView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LBB_MyUserHeaderView" forIndexPath:indexPath];
            view.delegate = self.userHeaderDelegate;
            reusable = view;
            LBB_MineUserInfo *userHeadInfo = self.modelData.userInfo;
            [view setUserInfo:userHeadInfo];
        }else {
            LBB_MySectionHeadViewCell *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LBB_MySectionHeadViewCell" forIndexPath:indexPath];
            if ((indexPath.section - 1) < self.arr.count) {
                LBB_MineSectionInfo *sectionInfo = [self.arr objectAtIndex:indexPath.section - 1];
                view.titleLabel.text = sectionInfo.sectionContent;
                view.userInfo = sectionInfo;
                view.viewType = sectionInfo.setcionType;
                view.delegate = self.cellDelegate;
                if (!sectionInfo.needCheckAll) {
                    view.rightBtn.hidden = YES;
                    view.arrowImgView.hidden = YES;
                }
                if ((indexPath.section == self.arr.count) || (indexPath.section == 0)) {
                    view.lineView.hidden = YES;
                }else {
                    view.lineView.hidden = NO;
                }
            }else {
                view.titleLabel.text = nil;
                [view.rightBtn setTitle:nil forState:UIControlStateNormal];
                view.arrowImgView.hidden = YES;
            }
            reusable = view;
        }
       
    }else if(kind == UICollectionElementKindSectionFooter){
        LBB_MySectionFooterViewCell *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"LBB_MySectionFooterViewCell" forIndexPath:indexPath];
        reusable = view;
    }
    return reusable;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.cellDelegate && [self.cellDelegate respondsToSelector:@selector(didClickDetailActionDelegate:)]) {
        LBB_MineDetaiInfo *cellInfo = [self getCellInfo:indexPath];
        [self.cellDelegate didClickDetailActionDelegate:cellInfo.detailType];
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((DeviceWidth - 46.f) / 4,70.f);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(1,20,1,20);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeMake(self.collectionView.frame.size.width, self.collectionView.frame.size.width * (283.f/475.f));
    }else if (section == (self.arr.count)) {
         return CGSizeMake(self.collectionView.frame.size.width, 0.001f);
    }
    return CGSizeMake(self.collectionView.frame.size.width, 40.f);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(self.collectionView.frame.size.width, 10.f);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1.f;
}


@end
