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

@interface ReceiptAddressViewController ()<
ReceiptAddressViewCellDelegate
>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *dataSourceArray;

@end

@implementation ReceiptAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.baseViewType = eAddress;
    [self initData];
    [self loadRightBarItem];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
- (void)loadRightBarItem {
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ST_TabImage1"]
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:self
                                                                      action:@selector(addAddressAction:)];
    
    
    rightBarButton.tintColor = [UIColor colorWithRed:0.0 green:0.1176 blue:0.4549 alpha:1.0];
    
    self.navigationItem.rightBarButtonItem = rightBarButton;
}
#pragma mark - private
- (void)initData
{
    UINib *nib = [UINib nibWithNibName:@"ReceiptAddressViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"ReceiptAddressViewCell"];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.dataSourceArray = [[NSMutableArray alloc] initWithArray:@[
                                                                   @{@"ID" : @"1",
                                                                     @"UserName": NSLocalizedString(@"王大锤",nil),
                                                                     @"PhoneNum" : @"186****9876",
                                                                     @"Address" : @"福建省 厦门市 思明区",
                                                                     @"Street" : @"软件园望海路59号楼1号楼鑫海科技"},
                                                                   @{
                                                                    @"ID" : @"2",
                                                                    @"UserName": NSLocalizedString(@"董美丽名字很长的很长的很长的很长的很长的",nil),
                                                                     @"PhoneNum" : @"186****9876",
                                                                     @"Address" : @"福建省 厦门市 思明区",
                                                                     @"Street" : @"软件园望海路59号楼1号楼鑫海科技",
                                                                     @"DefautAdress":@"1"},
                                                                   @{@"ID" : @"3",
                                                                    @"UserName": NSLocalizedString(@"王大锤",nil),
                                                                     @"PhoneNum" : @"186****9876",
                                                                     @"Address" : @"福建省 厦门市 思明区 福建省 厦门市 思明区 福建省 厦门市 思明区",
                                                                     @"Street" : @"软件园望海路59号楼1号楼鑫海科技"},
                                                                   @{@"ID" : @"4",
                                                                     @"UserName": NSLocalizedString(@"马云",nil),
                                                                     @"PhoneNum" : @"186****9876",
                                                                     @"Address" : @"福建省 厦门市 思明区 福建省 厦门市 思明区 福建省 厦门市 思明区",
                                                                     @"Street" : @"软件园望海路59号楼1号楼鑫海科技软件园望海路59号楼1号楼鑫海科技软件园望海路59号楼1号楼鑫海科技软件园望海路59号楼1号楼鑫海科技软件园望海路59号楼1号楼鑫海科技软件园望海路59号楼1号楼鑫海科技"},
                                                                   @{@"ID" : @"5",
                                                                     @"UserName": NSLocalizedString(@"王健林",nil),
                                                                     @"PhoneNum" : @"186****9876",
                                                                     @"Address" : @"福建省 厦门市 思明区",
                                                                     @"Street" : @"软件园望海路59号楼1号楼鑫海科技是在软件园哪个角落"},
                                                                   ]];
    
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
                                                     NSDictionary *cellDict = [self.dataSourceArray objectAtIndex:[indexPath row]];
                                                     [cell setCellInfo:cellDict];
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
    
    NSDictionary *cellDict = [self.dataSourceArray objectAtIndex:[indexPath row]];
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[ReceiptAddressViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.accessoryView =  nil;
    cell.selectedBackgroundView.backgroundColor = RGB(240, 240, 240);
    cell.delegate = self;
    [cell setCellInfo:cellDict];
    
    return cell;
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
    NSDictionary *cellDict = (NSDictionary*)cellInfo;
    
    for (NSInteger i = 0; i < self.dataSourceArray.count; i++) {
        NSDictionary *tmpDict = (NSDictionary*)[self.dataSourceArray objectAtIndex:i];
        NSMutableDictionary *newDict = [NSMutableDictionary dictionaryWithObjects:[tmpDict allValues]
                                                                          forKeys:[tmpDict allKeys]];
        if ([[tmpDict objectForKey:@"ID"] isEqualToString:[cellDict objectForKey:@"ID"]]) {
            [newDict setObject:@"1" forKey:@"DefautAdress"];
        }else{
            [newDict setObject:@"0" forKey:@"DefautAdress"];
        }
        [self.dataSourceArray replaceObjectAtIndex:i  withObject:newDict];
    }
    
    [self.tableView reloadData];
}

@end
