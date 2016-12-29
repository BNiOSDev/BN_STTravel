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
#import "SPKitExample.h"

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
    if (self.baseViewType == eRecentChat) {
        self.navigationItem.title = NSLocalizedString(@"最近联系人", nil);
    }
      YWConversationListViewController *conversationListController = [[SPKitExample sharedInstance].ywIMKit makeConversationListViewController];
    
    conversationListController.didSelectItemBlock = ^(YWConversation *aConversation){
        NSLog(@"选中会话");
//        YWPerson *person=[[YWPerson alloc]initWithPersonId:@"鹭爸爸888" EServiceGroupId:nil baseContext:[SPKitExample sharedInstance].ywIMKit.IMCore];
//        YWConversation *conversation=[YWP2PConversation fetchConversationByPerson:person creatIfNotExist:YES baseContext:[SPKitExample sharedInstance].ywIMKit.IMCore];
//        YWConversationViewController *conversationController=[[SPKitExample sharedInstance].ywIMKit makeConversationViewControllerWithConversationId:conversation.conversationId];
        
        YWConversationViewController *conversationController = [[SPKitExample sharedInstance].ywIMKit makeConversationViewControllerWithConversationId:aConversation.conversationId];
        Base_BaseViewController *vc = [[Base_BaseViewController alloc]init];
        [vc addChildViewController:conversationController];
        vc.view.frame = conversationController.view.frame = self.view.bounds;
        [vc.view addSubview:conversationController.view];
        vc.title = aConversation.conversationId;
        [self.navigationController pushViewController:vc animated:YES];
    };
    [self addChildViewController:conversationListController];
    
    for (int i=0; i<self.childViewControllers.count; i++) {
        UIViewController * vc = self.childViewControllers[i];
        vc.view.frame = CGRectMake(i * DeviceWidth, 0, DeviceWidth, self.view.frame.size.height);
        [self.view addSubview:vc.view];
    }
    

    
//    _mTableView = [[UITableView alloc]initWithFrame:DeviceRect style:UITableViewStyleGrouped];
//    _mTableView.height = _mTableView.height - 40 - 64;
//    if (self.baseViewType == eRecentChat) {
//        _mTableView.height = DeviceHeight - 64;
//        self.navigationItem.title = NSLocalizedString(@"最近联系人", nil);
//    }
//    _mTableView.delegate = self;
//    _mTableView.dataSource = self;
//    _mTableView.backgroundColor = ColorBackground;
//    
//    UINib *nib = [UINib nibWithNibName:@"LBB_ChatViewCell" bundle:nil];
//    [self.mTableView registerNib:nib forCellReuseIdentifier:MySquareChatTableViewCell];
//    
//    [self.view  addSubview:_mTableView];
    
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
