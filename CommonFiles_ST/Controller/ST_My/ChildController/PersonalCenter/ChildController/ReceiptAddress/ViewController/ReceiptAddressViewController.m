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
@property (strong, nonatomic) UIView *addNewAddressView;

@property (strong,nonatomic) LBB_AddressViewModel *viewModel;

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
    self.viewModel = [[LBB_AddressViewModel alloc] init];
    
    __weak typeof(self) temp = self;
    
    [self.tableView setHeaderRefreshDatablock:^{
        [temp.viewModel getAddressList:0 PageNum:10 IsClear:YES];
    } footerRefreshDatablock:^{
        [temp.viewModel getAddressList:0 PageNum:10  IsClear:YES];
    }];
    
    //设置绑定数组
    [self.tableView setTableViewData:self.viewModel.addressArray];
    
    //刷新数据
    [self.viewModel getAddressList:0 PageNum:10  IsClear:YES];
    
    [self.viewModel.addressArray.loadSupport setDataRefreshblock:^{
        NSLog(@"数据刷新了");
    }];
    
    [self.tableView loadData:self.viewModel.addressArray];
    
//    __weak typeof (self) weakSelf = self;
//    [self.viewModel.loadSupport setDataRefreshblock:^{
//        [weakSelf.tableView reloadData];
//    }];
//    
//    [self.viewModel.loadSupport setDataRefreshFailBlock:^(NetLoadEvent code ,NSString* remark){
//        [weakSelf showHudPrompt:remark];
//    }];
}

#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.addressArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat height = [tableView fd_heightForCellWithIdentifier:@"ReceiptAddressViewCell"
                                                 configuration:^(ReceiptAddressViewCell *cell) {
                                                     if (indexPath.row < self.viewModel.addressArray.count) {
                                                         LBB_AddressModel *cellModel = [self.viewModel.addressArray objectAtIndex:[indexPath row]];
                                                         [cell setCellInfo:cellModel];
                                                     }
                                                   
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
    
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[ReceiptAddressViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.accessoryView =  nil;
    cell.selectedBackgroundView.backgroundColor = RGB(240, 240, 240);
    cell.delegate = self;
    if (indexPath.row < self.viewModel.addressArray.count) {
        LBB_AddressModel *cellModel = [self.viewModel.addressArray objectAtIndex:[indexPath row]];
        
        [cell setCellInfo:cellModel];
    }
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
    [cellModel setDefaultAddress];
    
    __weak typeof (self) weakSelf = self;
    __weak typeof (LBB_AddressModel*) weakModel = cellModel;
    
    [cellModel.loadSupport setDataRefreshblock:^{
        [weakSelf updateDefaultModel:weakModel];
    }];
    
    [cellModel.loadSupport setDataRefreshFailBlock:^(NetLoadEvent code ,NSString* remark){
        [weakSelf showHudPrompt:remark];
    }];
}

- (void)updateDefaultModel:(LBB_AddressModel*)model
{
    if(!model){
        return;
    }
    
    model.isDefault = YES;
    for (int i = 0; i < self.viewModel.addressArray.count; i++) {
        if (model.addressId != model.addressId) {
            model.isDefault = NO;
        }
    }
    [self.tableView reloadData];
}
@end
