//
//  WalletViewController.m
//  LUBABA
//
//  Created by 晨曦 on 16/10/9.
//  Copyright © 2016年 晨曦. All rights reserved.
//

#import "WalletViewController.h"
#import "WalletViewCell.h"
#import "BalanceViewController.h"

@interface WalletViewController ()<
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout
>
{
    dispatch_once_t onceTokenForClip;
}

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, copy) NSArray *dataSourceArray;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *balanceViewHeightConstraint;

@end

@implementation WalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.baseViewType =  eWallet;
    [self initData];
}
- (void)initData
{
    self.dataSourceArray = [[NSMutableArray alloc] initWithArray:@[
                                                                   @{@"Title": NSLocalizedString(@"余额",nil),
                                                                     @"Image" : @"19.pic.jpg",
                                                                     @"Num": NSLocalizedString(@"￥2000",nil),
                                                                     @"Action":@"balance"},
                                                                   @{@"Title": NSLocalizedString(@"银行卡",nil),
                                                                     @"Image" : @"19.pic.jpg",
                                                                     @"Num": NSLocalizedString(@"1张",nil),
                                                                     @"Action":@"bandCard"},
                                                                   @{@"Title": NSLocalizedString(@"积分",nil),
                                                                     @"Image" : @"19.pic.jpg",
                                                                     @"Num": NSLocalizedString(@"2000",nil),
                                                                     @"Action":@"integral"}
                                                                   ]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
    return self.dataSourceArray.count;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = (DeviceWidth - 46)/self.dataSourceArray.count;
    return (CGSize){width,self.balanceViewHeightConstraint.constant};
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
   static NSString * CellIdentifier = @"WalletViewCell";
    dispatch_once(&onceTokenForClip, ^{
        //  注册UICollectionViewCell
        UINib *nib = [UINib nibWithNibName:@"WalletViewCell" bundle:nil];
        [collectionView registerNib:nib forCellWithReuseIdentifier:CellIdentifier];
    });
    
    WalletViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier
                                                                   forIndexPath:indexPath];
    
    
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(WalletViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *cellDict = self.dataSourceArray[indexPath.row];
    cell.contentLabel.text = [cellDict objectForKey:@"Title"];
    cell.contentImgView.image = [UIImage imageNamed:[cellDict objectForKey:@"Image"]];
    cell.numLabel.text = [cellDict objectForKey:@"Num"];
    cell.exclusiveTouch = YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SEL selector = NSSelectorFromString([[self.dataSourceArray objectAtIndex:[indexPath row]] objectForKey:@"Action"]);
    
    if(selector == nil) return;
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self performSelector:selector];
#pragma clang diagnostic pop
    
}


#pragma mark - cell action
//余额
- (void)balance
{
    [self performSegueWithIdentifier:@"BalanceViewController" sender:nil];
}
//银行卡
- (void)bandCard
{
    [self performSegueWithIdentifier:@"CardViewController" sender:nil];
}
//积分
- (void)integral
{
     [self performSegueWithIdentifier:@"PointsViewController" sender:nil];
}

@end
