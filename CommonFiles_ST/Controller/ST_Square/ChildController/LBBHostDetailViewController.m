//
//  LBBHostDetailViewController.m
//  ST_Travel
//
//  Created by dawei che on 2016/10/23.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBHostDetailViewController.h"
#import "ZJMHostModel.h"
#import "LBB_HostDetailTableViewCell.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "UIView+SDAutoLayout.h"
#import "PraiseModel.h"
#import "CommentModel.h"
#import "Header.h"
#import "ST_TabBarController.h"

@interface LBBHostDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UITableView     *tableView;
@property(nonatomic, strong)NSMutableArray  *dataArray;
@property(nonatomic, strong)NSMutableArray  *praiseArray;
@property(nonatomic, strong)NSMutableArray  *commentArray;
@property(nonatomic, strong)NSMutableArray  *imageArray;
@property(nonatomic, strong)NSMutableArray  *imageArray2;

@end

@implementation LBBHostDetailViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [(ST_TabBarController*)self.tabBarController setTabBarHidden:YES animated:YES];
}

- (void)loadCustomNavigationButton
{
    ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, self.view.frame.size.height - 44)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[LBB_HostDetailTableViewCell class] forCellReuseIdentifier:@"LBB_HostDetailTableViewCell"];
}

- (void)initData
{
    _imageArray = [[NSMutableArray alloc]init];
    for (int i = 0; i <= 0; i++) {
        NSString *str = @"http://c.hiphotos.baidu.com/image/pic/item/6c224f4a20a446230b10a7179a22720e0df3d7e8.jpg";
        [_imageArray addObject:str];
    }
    _imageArray2 = [[NSMutableArray alloc]init];
    for (int i = 0; i <= 0; i++) {
        NSString *str = @"http://e.hiphotos.baidu.com/image/pic/item/c83d70cf3bc79f3d7467e245b8a1cd11738b29c4.jpg";
        [_imageArray2 addObject:str];
    }
    
    _praiseArray = [[NSMutableArray alloc]init];
    for (int i = 0; i <= 10; i++) {
        PraiseModel *model = [[PraiseModel alloc]init];
        model.iconUrl = @"";
        [_praiseArray addObject:model];
    }
    
    _commentArray = [[NSMutableArray alloc]init];
    for (int i = 0; i <= 2; i++) {
        CommentModel *model = [[CommentModel alloc]init];
        model.userName = @"小大王";
        model.contentStr = @"大王叫我来巡山，抓个和尚当晚餐。看到和尚太有型，抓来当我压寨老公哇哈哈";
        [_commentArray addObject:model];
    }
    
    _dataArray = [[NSMutableArray alloc]init];
    for (int i = 0; i <= 0; i++) {
        ZJMHostModel *model = [[ZJMHostModel alloc]init];
        model.iconUrl = @"http://e.hiphotos.baidu.com/image/pic/item/c83d70cf3bc79f3d7467e245b8a1cd11738b29c4.jpg";
        model.userName = @"zjmzjmzjmzjm";
        model.timeAgo = @"15min ago";
        model.address = @"address";
        model.content = @"wdashkdfahsdfhasjkdfhasjlkhfdajshdfjkashdfjakshdjshfkjsahfksajhfsakjhfaslhfkalshfasfkajhfalskhksal";
        model.hostImageUrl = @"";
        
        if(i % 2 == 0)
        {
            model.imageArray = _imageArray;
        }else{
            model.imageArray = _imageArray2;
        }
        
        
        model.praiseModelArray = _praiseArray;
        
        model.commentModelArray = _commentArray;
        
        [_dataArray addObject:model];
    }
    
    
}

#pragma mark -- TableViewDelegate


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        LBB_HostDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LBB_HostDetailTableViewCell"];
        ////// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
        [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
        cell.model = self.dataArray[indexPath.row];
        return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"xuanzhong");
//    if(indexPath.section == 0)
//    {
//        LBBFriendViewController   *vc = [[LBBFriendViewController alloc]init];
//        [self.navigationController pushViewController:vc animated:YES];
//    }else{
//        LBBHostDetailViewController *vc = [[LBBHostDetailViewController alloc]init];
//        [self.navigationController pushViewController:vc animated:YES];
//    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // >>>>>>>>>>>>>>>>>>>>> * cell自适应 * >>>>>>>>>>>>>>>>>>>>>>>>
    id model = self.dataArray[indexPath.row];
    return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[LBB_HostDetailTableViewCell class] contentViewWidth:[self cellContentViewWith]];
    
}

- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7横屏
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}


@end
