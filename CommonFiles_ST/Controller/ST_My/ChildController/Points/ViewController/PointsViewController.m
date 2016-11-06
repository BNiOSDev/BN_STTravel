//
//  PointsViewController.m
//  LUBABA
//  我的积分
//  Created by 晨曦 on 16/10/9.
//  Copyright © 2016年 晨曦. All rights reserved.
//

#import "PointsViewController.h"
#import "WalletViewCell.h"
#import "BalanceDetailViewController.h"

@interface PointsViewController ()<
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
@property (weak, nonatomic) IBOutlet UIButton *pointsRedeemedBtn;
@property (weak, nonatomic) IBOutlet UIButton *pointsDetailBtn;

@end

@implementation PointsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.baseViewType =  ePoints;
    [self initData];
}
    
- (void)initData
{
    self.dataSourceArray = [[NSMutableArray alloc] initWithArray:@[
                                                                   @{@"Title": NSLocalizedString(@"可兑换积分",nil),
                                                                     @"Image" : @"19.pic.jpg",
                                                                     @"Num": NSLocalizedString(@"2000",nil),
                                                                     @"Action":@"balance"},
                                                                   @{@"Title": NSLocalizedString(@"已兑换积分",nil),
                                                                     @"Image" : @"19.pic.jpg",
                                                                     @"Num": NSLocalizedString(@"2000",nil),
                                                                     @"Action":@"bandCard"},
                                                                   @{@"Title": NSLocalizedString(@"累计总积分",nil),
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

#pragma mark - UI Action
- (IBAction)pointsRedeemedAction:(id)sender {
    [self performSegueWithIdentifier:@"ConvertiblePointsViewController" sender:nil];
}

- (IBAction)pointsDetailAction:(id)sender {
    [self performSegueWithIdentifier:@"Points_DetailViewController" sender:nil];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     UIViewController *dstController =   segue.destinationViewController;
    if ([dstController isKindOfClass:NSClassFromString(@"BalanceDetailViewController")]) {
        BalanceDetailViewController *balanceDetailVC = (BalanceDetailViewController*)dstController;
        balanceDetailVC.showType = PointsDetailType;
    }else if(([dstController isKindOfClass:NSClassFromString(@"ConvertiblePointsViewController")])) {
        
    }
}


@end
