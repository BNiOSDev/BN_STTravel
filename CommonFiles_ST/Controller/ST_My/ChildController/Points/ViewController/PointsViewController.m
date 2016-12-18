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
#import "LBB_PointViewModel.h"
#import "LBB_WebViewController.h"

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
@property (weak, nonatomic) IBOutlet UIImageView *myPointsImgView;
@property (weak, nonatomic) IBOutlet UILabel *pointsLabel;
@property (weak, nonatomic) IBOutlet UILabel *pointsTipLabel;
@property (weak, nonatomic) IBOutlet UIView *middleBgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *middleBgViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIButton *detailDescBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *detailDescBtnBottomContraint;

@property (strong,nonatomic) LBB_PointViewModel *viewModel;

@end

@implementation PointsViewController

- (void)dealloc
{
    self.viewModel = nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.baseViewType =  ePoints;
    [self initUI];
}

- (void)buildControls
{
    if (!self.viewModel) {
        self.viewModel = [[LBB_PointViewModel alloc] init];
    }
    [self initData];
    
    __weak typeof (self) weakSelf = self;
    [self.viewModel.loadSupport setDataRefreshblock:^{
        [weakSelf initData];
    }];
    [self.viewModel getPointData];
}

- (void)initUI
{
    self.middleBgView.backgroundColor = ColorBackground;
    [self.detailDescBtn setTitleColor:ColorLightGray forState:UIControlStateNormal];
    self.pointsLabel.font = [UIFont systemFontOfSize:24];
    self.pointsLabel.textColor = ColorBlack;
    self.pointsTipLabel.font = Font14;
    self.pointsTipLabel.textColor = ColorBlack;
    self.detailDescBtnBottomContraint.constant = -TabHeight + 30.f;
    self.pointsDetailBtn.backgroundColor = ColorBtnYellow;
    self.pointsRedeemedBtn.backgroundColor = ColorGray;
    self.pointsRedeemedBtn.hidden = YES;
}

- (void)initData
{
    self.pointsLabel.text = [NSString stringWithFormat:@"%@",@(self.viewModel.unused)];
    
    self.dataSourceArray = [[NSMutableArray alloc] initWithArray:@[
                                       @{@"Title": NSLocalizedString(@"可兑换积分",nil),
                                         @"Image" : @"我的_积分2",
                                         @"Num": [NSString stringWithFormat:@"%@",@(self.viewModel.unused)]},
                                       @{@"Title": NSLocalizedString(@"已兑换积分",nil),
                                         @"Image" : @"我的_积分3",
                                         @"Num":[NSString stringWithFormat:@"%@",@(self.viewModel.used)]},
                                       @{@"Title": NSLocalizedString(@"累计总积分",nil),
                                         @"Image" : @"我的_积分4",
                                         @"Num": [NSString stringWithFormat:@"%@",@(self.viewModel.total)]}
                                    ]];
    [self.collectionView reloadData];

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
    if (indexPath.row < self.dataSourceArray.count) {
        NSDictionary *cellDict = self.dataSourceArray[indexPath.row];
        cell.contentLabel.text = [cellDict objectForKey:@"Title"];
        cell.contentImgView.image = [UIImage imageNamed:[cellDict objectForKey:@"Image"]];
        cell.numLabel.text = [cellDict objectForKey:@"Num"];
        cell.exclusiveTouch = YES;
    }
}

#pragma mark - UI Action
- (IBAction)pointsRedeemedAction:(id)sender {
    [self performSegueWithIdentifier:@"ConvertiblePointsViewController" sender:nil];
}

- (IBAction)pointsDetailAction:(id)sender {
    [self performSegueWithIdentifier:@"Points_DetailViewController" sender:nil];
}

//积分兑换说明
- (IBAction)detailDescBtnClickAction:(id)sender {
    
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"MineStoryboard" bundle:nil];
    LBB_WebViewController* vc = [main instantiateViewControllerWithIdentifier:@"LBB_WebViewController"];
    vc.baseViewType = ePointConvertDesc;
    vc.webViewURL = self.viewModel.integralExplain;
    [self.navigationController pushViewController:vc animated:YES];
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
