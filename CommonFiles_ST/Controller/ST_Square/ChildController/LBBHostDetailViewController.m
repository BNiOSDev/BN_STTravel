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


@end

@implementation LBBHostDetailViewController

- (void)loadCustomNavigationButton
{
    [super loadCustomNavigationButton];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"游记详情";
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, self.view.frame.size.height - 44)];
    [self initViewModel];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[LBB_HostDetailTableViewCell class] forCellReuseIdentifier:@"LBB_HostDetailTableViewCell"];
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
        LBB_HostDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LBB_HostDetailTableViewCell"];
        ////// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
        [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
        cell.model = self.viewModel.squareDetailViewModel;
    __weak typeof (self) weakSelf = self;
    cell.cellBtnBlock = ^(id obj,UITableViewCellViewSignal signal)
    {
        switch (signal)
        {
            case UITableViewCellSendMessage:
            {
                NSLog(@"发送评论=%@",obj);
                LBB_SquareUgc *model = weakSelf.viewModel;                [LBB_CommentViewModel  commentObjId:model.ugcId type:5 scores:0 remark:(NSString *)obj images:@[] parentId:0 block:^(NSDictionary *dic, NSError *error) {
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
                LBB_SquareUgc  *model = self.viewModel;
                [model collecte:^(NSDictionary *dic,NSError *error) {
                    if(!error)
                    {
                        NSLog(@"收藏成功，更换图片");
                        UIButton *btn = obj;
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
                LBB_SquareUgc  *model = self.viewModel;                NSLog(@"likeList.count = %ld",model.likeList.count);
                [model like:^(NSDictionary *dic,NSError *error) {
                    if(!error)
                    {
                        NSLog(@"likeList.count =  %ld",model.likeList.count);
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

//    cell.cellBtnBlock = ^(id obj,UITableViewCellViewSignal signal)
//    {
//        if(signal == UITableViewCellSendMessage)
//        {
//            NSLog(@"发送评论=%@",obj);
//            LBB_SquareUgc *model = weakSelf.viewModel;
//            [LBB_CommentViewModel  commentObjId:model.allSpotsId type:5 scores:0 remark:(NSString *)obj images:@[] parentId:0 block:^(NSDictionary *dic, NSError *error) {
//                NSLog(@"评论回馈= %@",dic);
//                if(!error){
//                    LBB_SquareComments *commentsModel = [LBB_SquareComments new];
//                    NSString *commentIdStr = [NSString stringWithFormat:@"%@",dic[@"commentId"]];
//                    commentsModel.commentId = [commentIdStr longLongValue];
//                    commentsModel.remark = dic[@"remark"];
//                    commentsModel.userName = dic[@"userName"];
//                    [weakSelf.viewModel.squareDetailViewModel.comments addObject:commentsModel];
//                    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
//                    [tableView reloadData];
//                }
//            }];
//        }
//    };
    
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
