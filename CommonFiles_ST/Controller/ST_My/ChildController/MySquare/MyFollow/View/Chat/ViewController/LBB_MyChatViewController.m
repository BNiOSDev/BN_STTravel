//
//  LBB_MyChatViewController.m
//  ST_Travel
//
//  Created by 晨曦 on 16/11/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_MyChatViewController.h"
#import "LBB_ChatModel.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "Header.h"
#import "LBB_ChatViewCell.h"
#import "UIImageView+WebCache.h"

#define MySquareChatTableViewCell @"LBB_ChatViewCell"

@interface LBB_MyChatViewController ()
<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic, strong)UITableView    *mTableView;
@property(nonatomic, strong)NSMutableArray  *dataSourceArray;

@end

@implementation LBB_MyChatViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataSourceArray = [[NSMutableArray alloc]init];
    for (int i = 0; i <= 9; i++) {
        LBB_ChatModel  *model = [[LBB_ChatModel alloc]init];
        model.imageURL = @"http://e.hiphotos.baidu.com/image/pic/item/c83d70cf3bc79f3d7467e245b8a1cd11738b29c4.jpg";
        model.name = @"钟爱SD的男人钟";
        model.content = @"开启说走就走的旅行吧开启说走就走的旅行吧开启说走就走的";
        model.dateStr = @"2016-08-09";
        [self.dataSourceArray addObject:model];
    }
    [self createTable];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)createTable
{
    _mTableView = [[UITableView alloc]initWithFrame:DeviceRect style:UITableViewStyleGrouped];
    _mTableView.height = _mTableView.height - 40 - 64;
    _mTableView.delegate = self;
    _mTableView.dataSource = self;
    _mTableView.backgroundColor = ColorBackground;
    
    UINib *nib = [UINib nibWithNibName:@"LBB_ChatViewCell" bundle:nil];
    [self.mTableView registerNib:nib forCellReuseIdentifier:MySquareChatTableViewCell];
    
    [self.view  addSubview:_mTableView];
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = [tableView fd_heightForCellWithIdentifier:@"LBB_ChatViewCell"
                                                 configuration:^(LBB_ChatViewCell *cell) {
                                                    LBB_ChatModel *cellModel = [self.dataSourceArray objectAtIndex:[indexPath row]];
                                                     [cell setModel:cellModel];
                                                 }];
    return height;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = MySquareChatTableViewCell;
    LBB_ChatViewCell *cell = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[LBB_ChatViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.accessoryView =  nil;
    [cell setModel:[self.dataSourceArray objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}



@end
