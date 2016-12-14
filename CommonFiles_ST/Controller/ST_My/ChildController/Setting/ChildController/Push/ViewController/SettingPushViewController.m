//
//  SettingPushViewController.m
//  LUBABA
//
//  Created by 晨曦 on 16/10/10.
//  Copyright © 2016年 晨曦. All rights reserved.
//

#import "SettingPushViewController.h"
#import "LBB_SetPushViewModel.h"

@interface SettingPushViewController ()
@property(nonatomic,strong) LBB_SetPushViewModel *viewModel;
@property(nonatomic,assign) BOOL  isUpdateSetting;
@property(nonatomic,assign) NSInteger updateSwithType;
@property(nonatomic,assign) int  updateSwithValue;
@end

@implementation SettingPushViewController


- (void)dealloc
{
    self.viewModel = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.baseViewType = eSettingPush;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buildControls
{
    _isUpdateSetting = NO;
    
    if (!self.viewModel) {
        self.viewModel = [[LBB_SetPushViewModel alloc] init];
    }
    __weak typeof (self) weakSelf = self;
    
    [self.viewModel.loadSupport setDataRefreshblock:^{
        if (weakSelf.isUpdateSetting) {
            [weakSelf updateSettingValue:weakSelf.updateSwithType settintValue:weakSelf.updateSwithValue];
        }
        [weakSelf updateData];
    }];
    
    [self.viewModel.loadSupport setDataRefreshFailBlock:^(NetLoadEvent code ,NSString* remark){
        if (remark && [remark length]) {
            [weakSelf showHudPrompt:remark];
        }
        if (weakSelf.isUpdateSetting) {
            weakSelf.isUpdateSetting = NO;
            [weakSelf.viewModel getSettingData];
        }
    }];
    [self.viewModel getSettingData];
    
    [weakSelf updateData];
}

- (void)updateSettingValue:(NSInteger)swithType settintValue:(int)setValue
{
    switch (swithType) {
        case  eRemoteShakeWarn://推送消息震动提醒
            
            break;
        case  eRemoteVoiceWarn://聊天提醒
            
            break;
        case  eHighqualityWarn://精品内容推荐提醒
            
            break;
        case  eFollowWarn://关注提醒
        {
            self.viewModel.isFollowWarn = setValue;
        }
            break;
            
        case  eChatWarn://聊天提醒
        {
            self.viewModel.isChatWarn =  setValue;
        }
            break;
            
        case  eLikeWarn://点赞提醒
        {
            self.viewModel.isLikeWarn = setValue;
        }
            break;
            
        case  eCollectWarn://收藏提醒
        {
            self.viewModel.isCollectWarn = setValue;
        }
            break;
            
        case  eCommentWarn://评论提醒
        {
           self.viewModel.isCommentWarn = setValue;
        }
            break;
            
        case  eNightUnwarn://夜间提醒
        {
           self.viewModel.isNightUnwarn = setValue;
        }
            
            break;
        default:
            break;
    }
}

- (void)updateData
{
    self.dataSourceArray = [[NSMutableArray alloc] initWithArray:@[
                                                                   @{@"Title": NSLocalizedString(@"推送消息震动提醒",nil),
                                                                     @"SwitchOn" : [NSNumber numberWithInt:self.viewModel.isShakeWarn],
                                                                     @"SwitchType":[NSNumber numberWithInt:self.viewModel.isVoiceWarn]},
                                                                    @{@"Title": NSLocalizedString(@"推送消息声音提醒",nil),
                                                                      @"SwitchOn" : [NSNumber numberWithInt:NO],
                                                                      @"SwitchType":[NSNumber numberWithInteger:eRemoteVoiceWarn]},
//                                                                    @{@"Title": NSLocalizedString(@"精品内容推荐提醒提",nil),
//                                                                      @"SwitchOn" : [NSNumber numberWithInt:YES],
//                                                                      @"SwitchType":[NSNumber numberWithInteger:eHighqualityWarn]},
                                                                    @{@"Title": NSLocalizedString(@"关注提醒",nil),
                                                                      @"SwitchOn" : [NSNumber numberWithInt:self.viewModel.isFollowWarn],
                                                                      @"SwitchType":[NSNumber numberWithInteger:eFollowWarn]},
                                                                    @{@"Title": NSLocalizedString(@"私聊提醒",nil),
                                                                      @"SwitchOn" : [NSNumber numberWithInt:self.viewModel.isChatWarn],
                                                                      @"SwitchType":[NSNumber numberWithInteger:eChatWarn]},
                                                                    @{@"Title": NSLocalizedString(@"点赞提醒",nil),
                                                                      @"SwitchOn" : [NSNumber numberWithInt:self.viewModel.isLikeWarn],
                                                                      @"SwitchType":[NSNumber numberWithInteger:eLikeWarn]},
                                                                    @{@"Title": NSLocalizedString(@"收藏提醒",nil),
                                                                      @"SwitchOn" : [NSNumber numberWithInt:self.viewModel.isCollectWarn],
                                                                      @"SwitchType":[NSNumber numberWithInteger:eCollectWarn]},
                                                                    @{@"Title": NSLocalizedString(@"评论提醒",nil),
                                                                      @"SwitchOn" : [NSNumber numberWithInt:self.viewModel.isCommentWarn],
                                                                      @"SwitchType":[NSNumber numberWithInteger:eCommentWarn]},
                                                                    @{@"Title": NSLocalizedString(@"夜间防骚扰提醒",nil),
                                                                      @"SwitchOn" : [NSNumber numberWithInt:self.viewModel.isNightUnwarn],
                                                                      @"ShowDesc" : [NSNumber numberWithInt:YES],
                                                                      @"SwitchType":[NSNumber numberWithInteger:eNightUnwarn]}
                                                                   
                                                                   ]];
    [self.tableView reloadData];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSMutableDictionary *tmpDict = [NSMutableDictionary dictionaryWithDictionary:self.dataSourceArray[indexPath.row]];
    NSNumber *switchType = [tmpDict objectForKey:@"SwitchType"];
    NSString *settingName = nil;
    int settingValue = [[tmpDict objectForKey:@"SwitchOn"] intValue];
    self.updateSwithType = switchType.integerValue;
    switch (switchType.integerValue) {
        case  eRemoteShakeWarn://推送消息震动提醒
            settingName = @"isShakeWarn";
            settingValue = !self.viewModel.isShakeWarn;
            break;
        case  eRemoteVoiceWarn://声音提醒
            settingName = @"isVoiceWarn";
            settingValue = !self.viewModel.isVoiceWarn;
            break;
        case  eHighqualityWarn://精品内容推荐提醒
            
            break;
        case  eFollowWarn://关注提醒
        {
            settingName = @"isFollowWarn";
            settingValue = !self.viewModel.isFollowWarn;
        }
            break;
            
        case  eChatWarn://聊天提醒
        {
            settingName = @"isChatWarn";
            settingValue = !self.viewModel.isChatWarn;
        }
            break;
            
        case  eLikeWarn://点赞提醒
        {
            settingName = @"isLikeWarn";
            settingValue = !self.viewModel.isLikeWarn;
        }
            break;
            
        case  eCollectWarn://收藏提醒
        {
            settingName = @"isLikeWarn";
            settingValue = !self.viewModel.isCollectWarn;
        }
            break;
            
        case  eCommentWarn://评论提醒
        {
            settingName = @"eCommentWarn";
            settingValue = !self.viewModel.isCommentWarn;
        }
            break;
            
        case  eNightUnwarn://夜间提醒
        {
            settingName = @"eCommentWarn";
            settingValue = !self.viewModel.isNightUnwarn;
        }
            
            break;
        default:
            break;
    }
    if (!settingName || [settingName length] == 0) {
        return;
    }
    
    self.isUpdateSetting = YES;
    self.updateSwithValue = settingValue;
    [self.viewModel updateSettingData:settingName settingValue:settingValue];
}

@end
