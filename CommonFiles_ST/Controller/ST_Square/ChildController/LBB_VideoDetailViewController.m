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

@interface LBB_VideoDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UITableView     *tableView;
@end

@implementation LBB_VideoDetailViewController

- (void)loadCustomNavigationButton
{
    ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, self.view.frame.size.height - 44)];
    [self initViewModel];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.clipsToBounds = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
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
                NSLog(@"发送评论=%@",obj);
                LBB_SquareUgc *model = weakSelf.viewModel;                [LBB_CommentViewModel  commentObjId:model.allSpotsId type:6 scores:0 remark:(NSString *)obj images:@[] parentId:0 block:^(NSDictionary *dic, NSError *error) {
                    NSLog(@"评论回馈= %@",dic);
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
                [model collecte:^(NSError *error) {
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
                LBB_SquareUgc  *model = weakSelf.viewModel;                NSLog(@"likeList.count = %ld",model.likeList.count);
                [model like:^(NSError *error) {
                    if(!error)
                    {
                        NSLog(@"likeList.count =  %ld",model.likeList.count);
                        NSLog(@"收藏成功，更换图片");
                        UIButton *btn = obj;
                        if(model.isLiked == 1)
                        {
                            [btn setImage:IMAGE(@"zjmzhuyedianzaned") forState:0];
                        }
                        else
                        {
                            [btn setImage:IMAGE(@"zjmzhuyedianzan") forState:0];
                            
                        }
                    }
                }];
            }
                break;
                
            default:
                break;
        }
        
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


@end
