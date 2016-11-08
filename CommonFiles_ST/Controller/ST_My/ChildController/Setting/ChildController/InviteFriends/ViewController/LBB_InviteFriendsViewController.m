//
//  LBB_InviteFriendsViewController.m
//  ST_Travel
//
//  Created by 晨曦 on 16/11/4.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_InviteFriendsViewController.h"
#import "LBB_InviteViewCell.h"

@interface LBB_InviteFriendsViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *dataSourceArray;

@end

@implementation LBB_InviteFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private
- (void)buildControls
{
    UINib *nib = [UINib nibWithNibName:@"LBB_InviteViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"LBB_InviteViewCell"];
    
    self.dataSourceArray = [[NSMutableArray alloc] initWithArray:@[
                                                                   @{@"Title": NSLocalizedString(@"微信邀请好友",nil),
                                                                     @"Image" : @"我的_设置_微信.png",
                                                                     @"ActionType":[NSNumber numberWithInt:eWeChatInvite]},
                                                                   @{@"Title": NSLocalizedString(@"QQ邀请好友",nil),
                                                                     @"Image" : @"我的_设置_QQ.png",
                                                                     @"ActionType":[NSNumber numberWithInt:eQQInvite]},
                                                                   @{@"Title": NSLocalizedString(@"微博邀请好友",nil),
                                                                     @"Image" : @"我的_设置_微博.png",
                                                                     @"ActionType":[NSNumber numberWithInt:eWeiboInvite]}                                                                   
                                                                   ]];
    
}

#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourceArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.f;
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
    static NSString *CellIdentifier = @"LBB_InviteViewCell";
    LBB_InviteViewCell *cell = nil;
    
    NSDictionary *cellDict = [self.dataSourceArray objectAtIndex:[indexPath row]];
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[LBB_InviteViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectedBackgroundView.backgroundColor = RGB(240, 240, 240);
    cell.accessoryView =  nil;
    cell.iconImgView.image = IMAGE([cellDict objectForKey:@"Image"]);
    cell.contentLabel.text = [cellDict objectForKey:@"Title"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *cellInfo = [self.dataSourceArray objectAtIndex:indexPath.row];
    InviteFriendsType type = [[cellInfo objectForKey:@"ActionType"] integerValue];
    switch (type) {
        case eWeChatInvite://微信邀请
            
            break;
        case eQQInvite://QQ邀请
             
            break;
        case eWeiboInvite://微博邀请
            
            break;
            
        default:
            break;
    }
    
 
}

@end
