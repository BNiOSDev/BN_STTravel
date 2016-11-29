//
//  LBB_SelectTip_History_ViewController.m
//  ST_Travel
//
//  Created by dawei che on 2016/11/20.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_SelectTip_History_ViewController.h"
#import "LBB_HistoryTipView.h"
#import "Header.h"
#import "LBB_HotTipCell.h"

@interface LBB_SelectTip_History_ViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property(nonatomic,strong)UITableView      *mTableView;
@property(nonatomic,strong)UITableView      *SearchTableView;
@property(nonatomic,weak)LBB_HistoryTipView *tableHead;
@end

@implementation LBB_SelectTip_History_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WHITECOLOR;
    [self initNav];
    [self initView];
}

- (void)initView
{
    LBB_HistoryTipView  *tableHeadVeiw = [[LBB_HistoryTipView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, AUTO(207))];
    tableHeadVeiw.backgroundColor = WHITECOLOR;
    _tableHead = tableHeadVeiw;
    [self.view addSubview:self.mTableView];
    _tableHead.historySearch = @[@"三朵金花",@"三朵金花",@"三朵金花",@"三朵金花"];
    [self.mTableView setTableHeaderView:_tableHead];
}

- (void)initNav
{
    UITextField  *inputTip = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, AUTO(240), 25)];
    inputTip.leftViewMode = UITextFieldViewModeAlways;
    inputTip.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 15, 25)];
    inputTip.delegate = self;
    inputTip.font = FONT(11.0);
    LRViewBorderRadius(inputTip, 4.5, 0.5, BLACKCOLOR);
    inputTip.placeholder = @"输入标签";
    
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.titleView = inputTip;
    
    UIBarButtonItem *cancelBarBtn =  [[UIBarButtonItem alloc]initWithTitle:@"取消" style:0 target:self action:@selector(cancelFunc)];
    cancelBarBtn.tintColor = BLACKCOLOR;
    self.navigationItem.rightBarButtonItem = cancelBarBtn;
}

- (void)cancelFunc
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UITableView *)mTableView
{
    if(!_mTableView)
    {
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight - 64) style:0];
        tableView.backgroundColor = WHITECOLOR;
        tableView.delegate = self;
        tableView.dataSource = self;
        _mTableView = tableView;
    }
    return _mTableView;
}

- (UITableView *)SearchTableView
{
    if(!_SearchTableView)
    {
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight - 64) style:0];
        tableView.backgroundColor = WHITECOLOR;
        tableView.delegate = self;
        tableView.dataSource = self;
        _SearchTableView = tableView;
    }
    return _SearchTableView;
}

#pragma mark TableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return AUTO(40);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"photoCell";
    LBB_HotTipCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[LBB_HotTipCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.tipTitle = @"你喜欢我吗？";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark uitextFielddelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSLog(@"%@",textField.text);
    [self.view addSubview:self.SearchTableView];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    _SearchTableView = nil;
    return YES;
}

@end