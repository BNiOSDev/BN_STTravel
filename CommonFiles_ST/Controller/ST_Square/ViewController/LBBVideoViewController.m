//
//  LBBVideoViewController.m
//  ST_Travel
//
//  Created by dawei che on 2016/10/22.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBVideoViewController.h"
#import "ZJMHostModel.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "UIView+SDAutoLayout.h"
#import "PraiseModel.h"
#import "CommentModel.h"
#import "LBBVideoTableViewCell.h"
#import "LBB_SquareViewModel.h"
#import "Header.h"
#define VideoCell @"zjmVideoCell"
#import "LBBVideoPlayerViewController.h"
#import "LBB_VideoDetailViewController.h"

#import "ZFPlayer.h"

@interface LBBVideoViewController ()<UITableViewDelegate,UITableViewDataSource,ZFPlayerDelegate>
@property(nonatomic, strong)UITableView     *tableView;
@property(nonatomic, strong)LBB_SquareViewModel* viewModel;
@property (nonatomic, strong) ZFPlayerView        *playerView;
@property (nonatomic, strong) ZFPlayerControlView *controlView;

@end

@implementation LBBVideoViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
        [(ST_TabBarController*)self.tabBarController setTabBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, self.view.frame.size.height - 30 - 64 - 44 - 20)];
    [self initViewModel];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[LBBVideoTableViewCell class] forCellReuseIdentifier:VideoCell];
}


-(void)initViewModel{
    
    self.viewModel = [[LBB_SquareViewModel alloc] init];
    
    /**
     3.4.4	广场-广场主页-图片/视频列表（已测）
     
     @ param type 1主页  视频为单独的2.视频
     @ param clear 清空原数据
     */
    __weak typeof(self) temp = self;

    [self.viewModel getUgcArrayType:2 ClearData:YES];
    [self.viewModel.ugcVideoArray.loadSupport setDataRefreshblock:^{
        [temp.tableView reloadData];
    }];
    
    [self.tableView setTableViewData:self.viewModel.ugcVideoArray];
    
    //3.1上拉和下拉的动作
    [self.tableView setHeaderRefreshDatablock:^{
        [temp.viewModel getUgcArrayType:2 ClearData:YES];
        
        [temp.tableView.mj_header endRefreshing];
        
    } footerRefreshDatablock:^{
        [temp.viewModel getUgcArrayType:2 ClearData:NO];
        [temp.tableView.mj_footer endRefreshing];
    }];

    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.ugcVideoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LBBVideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:VideoCell];
    
    ////// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    
    ///////////////////////////////////////////////////////////////////////
    
    cell.model = self.viewModel.ugcVideoArray[indexPath.row];
    __weak typeof (self) weakSelf = self;
//    
//    cell.sendCommentBolck = ^(id obj,UITableViewCellViewSignal signal)
//    {
//        if(signal == UITableViewCellSendMessage)
//        {
//            NSLog(@"发送评论=%@",obj);
//            LBB_SquareUgc *model = weakSelf.viewModel.ugcVideoArray[indexPath.row];
//            [LBB_CommentViewModel  commentObjId:model.allSpotsId type:6 scores:0 remark:(NSString *)obj images:@[] parentId:0 block:^(NSDictionary *dic, NSError *error) {
//                NSLog(@"评论回馈= %@",dic);
//                if(!error){
//                    LBB_SquareComments *commentsModel = [LBB_SquareComments new];
//                    NSString *commentIdStr = [NSString stringWithFormat:@"%@",dic[@"commentId"]];
//                    commentsModel.commentId = [commentIdStr longLongValue];
//                    commentsModel.remark = dic[@"remark"];
//                    commentsModel.userName = dic[@"userName"];
//                    [model.comments addObject:commentsModel];
//                    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
//                }
//            }];
//        }
//    };
    
    cell.sendCommentBolck = ^(id obj,UITableViewCellViewSignal signal)
    {
        switch (signal)
        {
            case UITableViewCellSendMessage:
            {
                NSLog(@"发送评论=%@",obj);
                LBB_SquareUgc *model = weakSelf.viewModel.ugcVideoArray[indexPath.row];
                [LBB_CommentViewModel  commentObjId:model.ugcId type:6 scores:0 remark:(NSString *)obj images:@[] parentId:0 block:^(NSDictionary *dic, NSError *error) {
                    NSLog(@"评论回馈= %@",dic);
                    if(!error){
                        LBB_SquareComments *commentsModel = [LBB_SquareComments new];
                        NSString *commentIdStr = [NSString stringWithFormat:@"%@",dic[@"commentId"]];
                        commentsModel.commentId = [commentIdStr longLongValue];
                        commentsModel.remark = dic[@"remark"];
                        commentsModel.userName = dic[@"userName"];
                        [model.comments addObject:commentsModel];
                        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                    }
                }];
            }
                break;
            case UITableViewCellCollect:
            {
                LBB_SquareUgc  *model = weakSelf.viewModel.ugcVideoArray[indexPath.row];
                [model collecte:^(NSDictionary *dic,NSError *error) {
                    if(!error)
                    {
                        NSLog(@"收藏成功，更换图片");
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
                LBB_SquareUgc  *model = weakSelf.viewModel.ugcVideoArray[indexPath.row];
                NSLog(@"likeList.count = %ld",model.likeds.count);
                [model like:^(NSDictionary *dic,NSError *error) {
                    if(!error)
                    {
                        NSLog(@"likeList.count =  %ld",model.likeds.count);
                        UIButton *btn = obj;
                        LBB_SquareLikeList * likeModel = [[LBB_SquareLikeList alloc]init];
                        likeModel.portrait = dic[@"userPicUrl"];
                        if(model.isLiked == 1)
                        {
                            [btn setImage:IMAGE(@"zjmzhuyedianzaned") forState:0];
                            [model.likeds addObject:likeModel];
                        }
                        else
                        {
                            [btn setImage:IMAGE(@"zjmzhuyedianzan") forState:0];
                            [model.likeds enumerateObjectsUsingBlock:^(LBB_SquareLikeList * obj, NSUInteger idx, BOOL * _Nonnull stop) {
                                if([obj.portrait isEqualToString:likeModel.portrait])
                                    [model.likeds removeObjectAtIndex:idx];
                            }];
                        }
                      [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                    }
                }];
            }
                break;
                
            default:
                break;
        }
        
    };
    
    __block NSIndexPath *weakIndexPath = indexPath;
    __block LBBVideoTableViewCell *weakCell     = cell;
    cell.blockBtnFunc = ^(NSInteger stuas)
    {
        LBB_SquareUgc *videoDateModel = weakSelf.viewModel.ugcVideoArray[indexPath.row];
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
        //weakSelf.playerView.hasDownload = YES;
        // 自动播放
        [weakSelf.playerView autoPlayTheVideo];

    };

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LBB_SquareUgc  *model = self.viewModel.ugcVideoArray[indexPath.row];
    NSLog(@"视频链接：%@",model.videoUrl);
    LBB_VideoDetailViewController *Vc = [[LBB_VideoDetailViewController alloc]init];
    Vc.viewModel = self.viewModel.ugcVideoArray[indexPath.row];
     [self.navigationController pushViewController:Vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // >>>>>>>>>>>>>>>>>>>>> * cell自适应 * >>>>>>>>>>>>>>>>>>>>>>>>
    id model = self.viewModel.ugcVideoArray[indexPath.row];
    
    return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[LBBVideoTableViewCell class] contentViewWidth:[self cellContentViewWith]];
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
        // _playerView.stopPlayWhileCellNotVisable = YES;
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
