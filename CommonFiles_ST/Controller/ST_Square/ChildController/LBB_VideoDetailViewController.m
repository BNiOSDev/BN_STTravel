//
//  LBB_VideoDetailViewController.m
//  ST_Travel
//
//  Created by dawei che on 2016/12/7.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_VideoDetailViewController.h"
#import "ZJMHostModel.h"
#import "LBB_VideoDetailTableViewCell.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "UIView+SDAutoLayout.h"
#import "PraiseModel.h"
#import "CommentModel.h"
#import "Header.h"
#import "ST_TabBarController.h"

#import "ZFPlayer.h"


@interface LBB_VideoDetailViewController ()<UITableViewDelegate,UITableViewDataSource,ZFPlayerDelegate>

@property(nonatomic, strong)UITableView     *tableView;
@property (nonatomic, strong) ZFPlayerView        *playerView;
@property (nonatomic, strong) ZFPlayerControlView *controlView;
@property (nonatomic, strong) NSURL          *currentVideoUrl;
@end

@implementation LBB_VideoDetailViewController

- (void)loadCustomNavigationButton
{
    [super loadCustomNavigationButton];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.playerView resetPlayer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"视频详情";
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, self.view.frame.size.height - 44)];
    [self initViewModel];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.clipsToBounds = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    [[self.navigationController.navigationBar subviews] objectAtIndex:0].alpha = 1.0;
//    [self.tableView registerClass:[LBB_VideoDetailTableViewCell class] forCellReuseIdentifier:@"LBB_VideoDetailTableViewCell"];
}


-(void)initViewModel{
    
    __weak typeof(self) temp = self;
    
    [self.viewModel getSquareDetailViewModelData];
    [self.viewModel.squareDetailViewModel.loadSupport setDataRefreshblock:^{
        [temp.tableView reloadData];
    }];
    
    [self.tableView setHeaderRefreshDatablock:^{
        [temp.tableView.mj_header endRefreshing];
        [temp.viewModel getSquareDetailViewModelData];

    } footerRefreshDatablock:^{
        
    }];
    
    
}

#pragma mark -- TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.viewModel.squareDetailViewModel) {
        return 1;
    }
    else{
        return 0;
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    LBB_VideoDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LBB_HostDetailTableViewCell"];
    static NSString *ID = @"LBB_HostDetailTableViewCell";
    LBB_VideoDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
         cell = [[LBB_VideoDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    ////// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    cell.model = self.viewModel.squareDetailViewModel;
    
    __weak typeof(self) weakSelf = self;
    cell.sendCommentBlock = ^(id obj,UITableViewCellViewSignal signal)
    {
        switch (signal)
        {
            case UITableViewCellSendMessage:
            {
                LBB_SquareUgc *model = weakSelf.viewModel;                [LBB_CommentViewModel  commentObjId:model.ugcId type:6 scores:0 remark:(NSString *)obj images:@[] parentId:0 block:^(NSDictionary *dic, NSError *error) {
                    if(!error){
                        LBB_SquareComments *commentsModel = [LBB_SquareComments new];
                        NSString *commentIdStr = [NSString stringWithFormat:@"%@",dic[@"commentId"]];
                        commentsModel.commentId = [commentIdStr longLongValue];
                        commentsModel.remark = dic[@"remark"];
                        commentsModel.userName = dic[@"userName"];
                        [weakSelf.viewModel.squareDetailViewModel.comments addObject:commentsModel];
                        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                    }
                }];
            }
                break;
            case UITableViewCellCollect:
            {
                LBB_SquareUgc  *model = weakSelf.viewModel;

                [model collecte:^(NSDictionary *dic,NSError *error) {
                    if(!error)
                    {
                        UIButton *btn = obj;
                        [btn setImage:IMAGE(@"zjmshoucanged") forState:0];
                        if(model.isCollected == 1)
                        {
                            [btn setImage:IMAGE(@"景区列表_收藏HL") forState:0];
                        }
                        else
                        {
                            [btn setImage:IMAGE(@"景区列表_收藏") forState:0];
                        }
                        
                    }
                }];
            }
                break;
            case UITableViewCellPraise:
            {
                LBB_SquareUgc  *model = weakSelf.viewModel;                NSLog(@"likeList.count = %ld",model.likeds.count);
                [model like:^(NSDictionary *dic,NSError *error) {
                    if(!error)
                    {
                        UIButton *btn = obj;
                        LBB_SquareLikeList * likeModel = [[LBB_SquareLikeList alloc]init];
                        likeModel.portrait = dic[@"userPicUrl"];
                        if(model.isLiked == 1)
                        {
                            [btn setImage:IMAGE(@"zjmzhuyedianzaned") forState:0];
                            [weakSelf.viewModel.squareDetailViewModel.likeds addObject:likeModel];
                        }
                        else
                        {
                            [btn setImage:IMAGE(@"zjmzhuyedianzan") forState:0];
                            [weakSelf.viewModel.squareDetailViewModel.likeds enumerateObjectsUsingBlock:^(LBB_SquareLikeList * obj, NSUInteger idx, BOOL * _Nonnull stop) {
                                if([obj.portrait isEqualToString:likeModel.portrait])
                                    [weakSelf.viewModel.squareDetailViewModel.likeds removeObjectAtIndex:idx];
                            }];
                        }
                        [self.tableView reloadData];
                    }
                }];
            }
                break;
                
            default:
                break;
        }
        
    };
    
    __block NSIndexPath *weakIndexPath = indexPath;
    __block LBB_VideoDetailTableViewCell *weakCell     = cell;
    _currentVideoUrl = [NSURL URLWithString:_viewModel.videoUrl];
    // 点击播放的回调
    cell.playBlock = ^(UIButton *btn){
        LBB_SquareUgc *videoDateModel = weakSelf.viewModel;
        ZFPlayerModel *playerModel = [[ZFPlayerModel alloc] init];
        playerModel.title            = @"     ";
        playerModel.videoURL         = [NSURL URLWithString:videoDateModel.videoUrl];
        playerModel.placeholderImageURLString = videoDateModel.coverImageUrl;
        playerModel.tableView        = weakSelf.tableView;
        playerModel.indexPath        = weakIndexPath;
        // 赋值分辨率字典
        playerModel.resolutionDic    = nil;
        // player的父视图
        weakCell.contentImage.userInteractionEnabled = YES;
        playerModel.fatherView       = weakCell.contentImage;
        
        // 设置播放控制层和model
        [weakSelf.playerView playerControlView:weakSelf.controlView playerModel:playerModel];
        // 下载功能
        //        weakSelf.playerView.hasDownload = YES;
        // 自动播放
        [weakSelf.playerView autoPlayTheVideo];
        
        //视频的宁外的播放方式
        
//        _player = [[XLVideoPlayer alloc] init];
//        _player.videoUrl = weakSelf.viewModel.squareDetailViewModel.videoUrl;
//        [_player playerBindTableView:self.tableView currentIndexPath:indexPath];
//        _player.frame = weakCell.contentImage.bounds;
//        
//        [weakCell.contentImage addSubview:_player];
//        
//        _player.completedPlayingBlock = ^(XLVideoPlayer *player) {
//            [player destroyPlayer];
//            _player = nil;
//        };
    
    };


    
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
    id model = self.viewModel.squareDetailViewModel;
    return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[LBB_VideoDetailTableViewCell class] contentViewWidth:[self cellContentViewWith]];
    
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

- (ZFPlayerView *)playerView
{
    if (!_playerView) {
        _playerView = [ZFPlayerView sharedPlayerView];
        _playerView.delegate = self;
        // 当cell播放视频由全屏变为小屏时候，不回到中间位置
        _playerView.cellPlayerOnCenter = NO;
        
        // 当cell划出屏幕的时候停止播放
         _playerView.stopPlayWhileCellNotVisable = YES;
        //（可选设置）可以设置视频的填充模式，默认为（等比例填充，直到一个维度到达区域边界）
        _playerView.playerLayerGravity = ZFPlayerLayerGravityResizeAspectFill;
        // 静音
        // _playerView.mute = YES;
    }
    return _playerView;
}

- (ZFPlayerControlView *)controlView
{
    if (!_controlView) {
        _controlView = [[ZFPlayerControlView alloc] init];
    }
    return _controlView;
}


@end
