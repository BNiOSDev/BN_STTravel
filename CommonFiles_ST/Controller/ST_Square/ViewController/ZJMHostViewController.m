//
//  ZJMHostViewController.m
//  GSD_WeiXin(wechat)
//
//  Created by dawei che on 2016/10/19.
//  Copyright © 2016年 GSD. All rights reserved.
//

#import "ZJMHostViewController.h"
#import "LBB_HostTableViewCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "HostModel.h"


@interface ZJMHostViewController ()<UIActionSheetDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView  *tableView;
@property (nonatomic, assign) BOOL cellHeightCacheEnabled;
@property (nonatomic, strong) NSMutableArray *feedEntitySections;
@property (nonatomic, strong) NSMutableArray *commentArray;
@end

@implementation ZJMHostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initModel];
    [self createTable];
}

- (void)initModel
{
    
    NSMutableArray    *_imageArray = [[NSMutableArray alloc]init];
    for (int i = 0; i <= 8; i++) {
        NSString *str = @"http://c.hiphotos.baidu.com/image/pic/item/6c224f4a20a446230b10a7179a22720e0df3d7e8.jpg";
        [_imageArray addObject:str];
    }
    
    _commentArray = [[NSMutableArray alloc]init];
    for (int i = 0; i <= 2; i++) {
        NSString  *contentStr = @"老郑最帅: 大王叫我来巡山，抓个和尚当晚餐。看到和尚太有型，抓来当我压寨老公哇哈哈";
        [_commentArray addObject:contentStr];
    }
    
    _feedEntitySections = [[NSMutableArray alloc]init];
    for(int i = 0; i < 10;i++)
    {
        HostModel *model = [[HostModel alloc]init];
        model.content = @"妹妹你坐船头啊，哥哥我岸上走，狠狠哈哈牵手荡悠悠。哥哥呀，妹妹我单身呀，晚上一起赏月饮酒呀，可好呀";
        model.imageArray = _imageArray;
        model.commentArray = _commentArray;
        [_feedEntitySections addObject:model];
    }
}

- (void)createTable
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 568) style:UITableViewStylePlain];
    
    //去掉系统自带分割线
    //    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    
    
    [self.tableView registerClass:[LBB_HostTableViewCell class] forCellReuseIdentifier:@"LBB_HostTableViewCell"];
    
    self.tableView.estimatedRowHeight = 250;
    self.tableView.fd_debugLogEnabled = YES;
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.feedEntitySections count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LBB_HostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LBB_HostTableViewCell" forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(LBB_HostTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    //  cell.fd_enforceFrameLayout = YES; // Enable to use "-sizeThatFits:"
    cell.entity = self.feedEntitySections[indexPath.row];
    cell.clipsToBounds = YES;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView fd_heightForCellWithIdentifier:@"LBB_HostTableViewCell" cacheByIndexPath:indexPath configuration:^(LBB_HostTableViewCell *cell) {
        [self configureCell:cell atIndexPath:indexPath];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString  *contentStr = @"老郑最帅: 大王叫我来巡山，抓个和尚当晚餐。看到和尚太有型，抓来当我压寨老公哇哈哈";
    [_commentArray addObject:contentStr];
    
    HostModel *model = _feedEntitySections[indexPath.row];
    model.commentArray = _commentArray;
    
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
}


@end
