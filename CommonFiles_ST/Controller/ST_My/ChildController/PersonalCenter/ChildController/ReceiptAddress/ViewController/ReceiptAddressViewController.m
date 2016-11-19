//
//  ReceiptAddressViewController.m
//  ST_Travel
//
//  Created by 晨曦 on 16/10/19.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "ReceiptAddressViewController.h"
#import "ReceiptAddressViewCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "LBB_AddressModel.h"

@interface ReceiptAddressViewController ()<
ReceiptAddressViewCellDelegate
>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *dataSourceArray;
@property (strong,nonatomic) LBB_AddressDataModel *dataModel;
@property (strong, nonatomic) UIView *addNewAddressView;
@end

@implementation ReceiptAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.baseViewType = eAddress;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

#pragma mark - private
- (void)buildControls
{
    UINib *nib = [UINib nibWithNibName:@"ReceiptAddressViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"ReceiptAddressViewCell"];
    if (!self.dataModel) {
        self.dataModel = [[LBB_AddressDataModel alloc] init];
    }
    self.dataSourceArray = [self.dataModel getData];
}


#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourceArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat height = [tableView fd_heightForCellWithIdentifier:@"ReceiptAddressViewCell"
                                                 configuration:^(ReceiptAddressViewCell *cell) {
                                                    LBB_AddressModel *cellModel = [self.dataSourceArray objectAtIndex:[indexPath row]];
                                                     [cell setCellInfo:cellModel];
                                                 }];
    
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ReceiptAddressViewCell";
    ReceiptAddressViewCell *cell = nil;
    
    LBB_AddressModel *cellModel = [self.dataSourceArray objectAtIndex:[indexPath row]];
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[ReceiptAddressViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.accessoryView =  nil;
    cell.selectedBackgroundView.backgroundColor = RGB(240, 240, 240);
    cell.delegate = self;
    [cell setCellInfo:cellModel];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 100.f;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (!self.addNewAddressView) {
        self.addNewAddressView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 100)];
        UIButton *exitBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, 30, DeviceWidth - 60, 50)];
        [exitBtn setTitle:NSLocalizedString(@"新建收货地址", nil) forState:UIControlStateNormal];
        [exitBtn setTitleColor:ColorWhite forState:UIControlStateNormal];
        [exitBtn setBackgroundImage:[UIImage createImageWithColor:ColorBtnYellow] forState:UIControlStateNormal];
        [exitBtn.titleLabel setFont:Font15];
        [exitBtn addTarget:self
                    action:@selector(addAddressAction:)
          forControlEvents:UIControlEventTouchUpInside];
        [self.addNewAddressView addSubview:exitBtn];
        
    }
    return self.addNewAddressView;
}

#pragma mark - add Adress
- (void)addAddressAction:(id)sender
{
    [self performSegueWithIdentifier:@"AddAddressViewController" sender:nil];
}

#pragma mark - cell delegate
- (void)didDeleteCellAddress:(id)cellInfo
{
    
}

- (void)didEditCellAddress:(id)cellInfo
{
    [self performSegueWithIdentifier:@"AddAddressViewController" sender:cellInfo];
}

- (void)setDefautlCellAdress:(id)cellInfo
{
    LBB_AddressModel *cellModel = (LBB_AddressModel*)cellInfo;
    
    for (NSInteger i = 0; i < self.dataSourceArray.count; i++) {
        LBB_AddressModel *tmpModel = (LBB_AddressModel*)[self.dataSourceArray objectAtIndex:i];
        if ([tmpModel.addressId isEqualToString:cellModel.addressId]) {
            tmpModel.isDefault = YES;
        }else{
            tmpModel.isDefault = NO;
        }
    }
    
    [self.tableView reloadData];
}

@end
