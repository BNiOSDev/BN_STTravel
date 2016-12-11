//
//  LBB_ShopRecoder_Controller.m
//  ST_Travel
//
//  Created by dawei che on 2016/10/28.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_ShopRecoder_Controller.h"
#import "Header.h"
#import "JHChartHeader.h"
#import "LBB_ShopRecoder_Cell.h"
#import "LBB_EditShopRecoder_Controller.h"
@interface LBB_ShopRecoder_Controller ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UITableView     *tableView;
@property(nonatomic, strong)NSArray            *dataArray;
@property(nonatomic, strong)JHRingChart     *tableHead;
@end

@implementation LBB_ShopRecoder_Controller

#pragma mark -- 调整tablecell的分割线的位置
-(void)viewDidLayoutSubviews {
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])  {
        
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    self.navigationItem.title = @"消费统计";
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, self.view.frame.size.height - 64)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[LBB_ShopRecoder_Cell class] forCellReuseIdentifier:@"LBB_ShopRecoder_Cell"];
    [self.tableView setTableHeaderView:self.tableHead];
    [self setExtraCellLineHidden:self.tableView];
}

/**
 *  隐藏多余tablecell
 *
 *  @param tableView void
 */
- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
}

- (void)initData
{
    _dataArray = @[@{@"image":@"zjmtravelhouseed",@"title":@"名宿",@"percent":@"15%",@"price":@"1080.00"},@{@"image":@"zjmtranported",@"title":@"交通",@"percent":@"22%",@"price":@"123.00"},@{@"image":@"zjmhaochideed",@"title":@"美食",@"percent":@"12%",@"price":@"234.00"},@{@"image":@"zjmmenpiaoed",@"title":@"门票",@"percent":@"12%",@"price":@"123.00"},@{@"image":@"zjmyuleed",@"title":@"娱乐",@"percent":@"23%",@"price":@"123.00"},@{@"image":@"zjmshoped",@"title":@"购物",@"percent":@"37%",@"price":@"3456.00"},@{@"image":@"zjmothered",@"title":@"其他",@"percent":@"15%",@"price":@"345.00"}] ;
}


- (JHRingChart *)tableHead
{
    if(!_tableHead)
    {
        JHRingChart *ring = [[JHRingChart alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceWidth)];
        ring.backgroundColor = WHITECOLOR;
        ring.valueDataArr = @[@"0.5",@"5",@"2",@"100",@"6"];
        ring.consumeRatios = _dataModel.consumeRatios;
        [ring showAnimation];
        return ring;
    }
    return _tableHead;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataModel.consumeRatios.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return AUTO(50);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LBB_ShopRecoder_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"LBB_ShopRecoder_Cell"];
    cell.selectionStyle = 0;
    cell.model = _dataModel.consumeRatios[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LBB_EditShopRecoder_Controller *vc = [[LBB_EditShopRecoder_Controller alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)tableView:(UITableView*)tableView willDisplayCell:(UITableViewCell*)cell forRowAtIndexPath:(NSIndexPath*)indexPat{
    
    
    if([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell  setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell  setSeparatorInset:UIEdgeInsetsZero];
    }
    
}

@end
