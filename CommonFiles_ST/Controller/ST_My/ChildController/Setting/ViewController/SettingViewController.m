//
//  SettingViewController.m
//  LUBABA
//
//  Created by 晨曦 on 16/10/10.
//  Copyright © 2016年 晨曦. All rights reserved.
//

#import "SettingViewController.h"
#import "Base_Utils.h"
#import "CommonFunc.h"
#import "LBB_WebViewController.h"

typedef NS_ENUM(NSInteger,SettingViewType) {
    ePushNotification = 0,//推送通知
    ePrivace, //隐私
    eVideoAutoPlay, //视频自动播放
    eTravelSync, //游记自动同步
    eDownloadSetting, //下载设置
    eInviteFriends,//邀请好友
    eStarComment,//去评分
    eClearCache ,// 清理缓存
    eAboutUS //关于我们
};

@interface SettingViewController ()
<UITableViewDelegate,
UITableViewDataSource
>
{
    CGFloat     _cacheSize;
    CGFloat     _isFinishCacuteCacheSize;
    dispatch_queue_t _folderSizeQueue;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *dataSourceArray;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     _folderSizeQueue = dispatch_queue_create("FolderSize", nil);
    // Do any additional setup after loading the view.
    self.baseViewType = eSetting;
    [self initData];
    [self cacheSize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private
- (void)initData
{
    self.dataSourceArray = [[NSMutableArray alloc] initWithArray:@[
                                                                   @{@"Title": NSLocalizedString(@"推送通知",nil),
                                                                     @"Image" : @"19.pic.jpg",
                                                                     @"Action":@"push:",
                                                                     @"ActionSender" : [NSNumber numberWithInt:ePushNotification]},
//                                                                   @{@"Title": NSLocalizedString(@"隐私",nil),
//                                                                     @"Image" : @"19.pic.jpg",
//                                                                     @"Action":@"privace:",
//                                                                     @"ActionSender" : [NSNumber numberWithInt:ePrivace]},
                                                                   @{@"Title": NSLocalizedString(@"视频自动播放",nil),
                                                                     @"Image" : @"19.pic.jpg",
                                                                     @"Action":@"showPickerMenu:",
                                                                     @"ActionSender" : [NSNumber numberWithInt:eVideoAutoPlay]},
                                                                   @{@"Title": NSLocalizedString(@"游记自动同步",nil),
                                                                     @"Image" : @"19.pic.jpg",
                                                                     @"Action":@"showPickerMenu:",
                                                                     @"ActionSender" : [NSNumber numberWithInt:eTravelSync]},
                                                                   @{@"Title": NSLocalizedString(@"下载设置",nil),
                                                                     @"Image" : @"19.pic.jpg",
                                                                     @"Action":@"showPickerMenu:",
//                                                                     @"ActionSender" : [NSNumber numberWithInt:eDownloadSetting]},
//                                                                   @{@"Title": NSLocalizedString(@"邀请好友",nil),
                                                                     @"Image" : @"19.pic.jpg",
                                                                     @"Action":@"inviteFriends:",
                                                                     @"ActionSender" : [NSNumber numberWithInt:eInviteFriends]},
                                                                   @{@"Title": NSLocalizedString(@"去评分",nil),
                                                                     @"Image" : @"19.pic.jpg",
                                                                     @"Action":@"starComment:",
                                                                     @"ActionSender" : [NSNumber numberWithInt:eStarComment]},
                                                                   @{@"Title": NSLocalizedString(@"清理缓存",nil),
                                                                     @"Image" : @"19.pic.jpg",
                                                                     @"Action":@"clearCache:",
                                                                     @"ActionSender" : [NSNumber numberWithInt:eClearCache]},
                                                                   @{@"Title": NSLocalizedString(@"关于我们",nil),
                                                                     @"Image" : @"19.pic.jpg",
                                                                     @"Action":@"aboutUS:",
                                                                     @"ActionSender" : [NSNumber numberWithInt:eAboutUS]}
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
    static NSString *CellIdentifier = @"SettingCell";
    UITableViewCell *cell = nil;
    
    NSDictionary *cellDict = [self.dataSourceArray objectAtIndex:[indexPath row]];
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectedBackgroundView.backgroundColor = RGB(240, 240, 240);
    cell.textLabel.font = Font16;
    cell.textLabel.textColor = ColorBlack;
    cell.textLabel.text = [cellDict objectForKey:@"Title"];
    cell.accessoryView =  nil;
    if ([cell.textLabel.text isEqualToString:NSLocalizedString(@"清除缓存",nil)]) {
        [self setupCacheCell:cell];
    }
    return cell;
}

- (void)setupCacheCell:(UITableViewCell*)cell
{
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.font = Font16;
    label.textColor = ColorBlack;
    label.textAlignment = NSTextAlignmentRight;
    if (!_isFinishCacuteCacheSize) { //还没计算完成显示0KB
        label.text = [NSString stringWithFormat:@"0KB"];
    }else if ((_cacheSize/(1024 * 1024)) > 1.0f) {
        label.text = [NSString stringWithFormat:@"%.1fM", _cacheSize/(1024 * 1024)];
    }else {
        label.text = [NSString stringWithFormat:@"%.1fKB",_cacheSize/1024];
        if (_cacheSize == 0.f) {
            label.text = [NSString stringWithFormat:@"%.0fKB",_cacheSize/1024];
        }
    }
    
    cell.accessoryView = label;
    [label sizeToFit];
    CGRect frame = label.frame;
    frame.size.width += 5.f;
    label.frame = frame;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SEL selector = NSSelectorFromString([[self.dataSourceArray objectAtIndex:[indexPath row]] objectForKey:@"Action"]);
    NSNumber* actionSender = (NSNumber*)[[self.dataSourceArray objectAtIndex:[indexPath row]] objectForKey:@"ActionSender"];
    if(selector == nil) return;
  
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    if ([self canPerformAction:selector withSender:actionSender]) {
        [self performSelector:selector withObject:actionSender];
    }
#pragma clang diagnostic pop
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)push:(id)sender
{
    [self performSegueWithIdentifier:@"SettingPushViewController" sender:nil];
}

- (void)privace:(id)sender
{
    [self performSegueWithIdentifier:@"SettingPrivaceViewController" sender:nil];
}

- (void)showPickerMenu:(id)sender {
    NSNumber *actionSender = (NSNumber*)sender;
    SettingViewType setType = [actionSender intValue];
    NSLog(@"\n 选中类型:%@",@(setType));
    
    NSString *title = NSLocalizedString(@"请选择", nil);
    NSString *cancelButtonTitle = NSLocalizedString(@"取消", nil);
    NSString *mobileNetwork = NSLocalizedString(@"3G/4G", nil);
    NSString *wifiNetwork  = NSLocalizedString(@"WIFI", nil);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    // Create the actions.
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
       
    }];
    
    UIAlertAction *mobileAction = [UIAlertAction actionWithTitle:mobileNetwork style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    }];
    
    UIAlertAction *wifiAction = [UIAlertAction actionWithTitle:wifiNetwork style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
       
    }];
    
    // Add the actions.
    [alertController addAction:cancelAction];
    [alertController addAction:mobileAction];
    [alertController addAction:wifiAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

//邀请好友
- (void)inviteFriends:(id)sender
{
   [self performSegueWithIdentifier:@"LBB_InviteFriendsViewController" sender:nil];
}

//关于我们
- (void)aboutUS:(id)sender
{
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"MineStoryboard" bundle:nil];
    LBB_WebViewController* vc = [main instantiateViewControllerWithIdentifier:@"LBB_WebViewController"];
    vc.baseViewType = eSettongAboutUS;
    vc.webViewURL = @"http://www.baidu.com/";
    [self.navigationController pushViewController:vc animated:YES];
}
//去评分
- (void)starComment:(id)sender
{
//    UIStoryboard *main = [UIStoryboard storyboardWithName:@"MineStoryboard" bundle:nil];
//    LBB_WebViewController* vc = [main instantiateViewControllerWithIdentifier:@"LBB_WebViewController"];
//    vc.baseViewType = eSettongAboutUS;
//    vc.webViewURL = @"http://www.baidu.com/";
//    [self.navigationController pushViewController:vc animated:YES];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/us/app/id%d", 1101627686]]];
}

#pragma mark - 计算缓存大小
- (void)cacheSize
{
    dispatch_async(_folderSizeQueue, ^{
        _cacheSize = 0.f;
        //sdwebimage 网络图片模块
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *webImagePath = [paths[0] stringByAppendingPathComponent:@"default"];
        webImagePath  = [webImagePath stringByAppendingPathComponent:@"com.hackemist.SDWebImageCache.default"];
        _cacheSize += folderSizeAtPath(webImagePath);
        
        _isFinishCacuteCacheSize = YES;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:[self.dataSourceArray count]-2 inSection:0]]
                                    withRowAnimation:UITableViewRowAnimationNone];
            
        });
    });
}

@end
