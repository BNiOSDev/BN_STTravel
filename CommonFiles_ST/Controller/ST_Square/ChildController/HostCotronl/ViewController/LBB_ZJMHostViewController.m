//
//  ZJMHostViewController.m
//  GSD_WeiXin(wechat)
//
//  Created by dawei che on 2016/10/19.
//  Copyright © 2016年 GSD. All rights reserved.
//

#import "LBB_ZJMHostViewController.h"
#import "ZJMHostTableViewCell.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "UIView+SDAutoLayout.h"
#import "PraiseModel.h"
#import "CommentModel.h"
#import "LBBFriendTableViewCell.h"
#import "Header.h"
#import "LBBFriendModel.h"
#import "LBBFriendViewController.h"
#import "LBBHostDetailViewController.h"
#import "LBB_SquareViewModel.h"


@interface LBB_ZJMHostViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UITableView     *tableView;



@property(nonatomic, strong)LBB_SquareViewModel* viewModel;

@end

@implementation LBB_ZJMHostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, self.view.frame.size.height - 64 - AUTO(44))];
    [self initViewModel];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[ZJMHostTableViewCell class] forCellReuseIdentifier:@"zjmhost"];
    [self.tableView registerClass:[LBBFriendTableViewCell class] forCellReuseIdentifier:@"LBBFriendTableViewCell"];
}


-(void)initViewModel{

    self.viewModel = [[LBB_SquareViewModel alloc] init];
    
    /**
     3.4.1	广场-广场主页-好友推荐（已测）
     */
    __weak typeof(self) temp = self;
    [self.viewModel getSquareRecommendData];
    [self.viewModel.squareRecommend.loadSupport setDataRefreshblock:^{
        [temp.tableView reloadData];
    }];
   
    /**
     3.4.4	广场-广场主页-图片/视频列表（已测）
     
     @param type 1主页  视频为单独的2.视频
     @param clear 清空原数据
     */
    [self.viewModel getUgcArrayType:1 ClearData:YES];
    [self.viewModel.ugcImageArray.loadSupport setDataRefreshblock:^{
        [temp.tableView reloadData];
    }];
    
    [self.tableView setTableViewData:self.viewModel.ugcImageArray];
    
    //3.1上拉和下拉的动作
    [self.tableView setHeaderRefreshDatablock:^{
        [temp.viewModel getFriendArrayClearData:YES];
        [temp.viewModel getSquareRecommendData];
        [temp.viewModel getUgcArrayType:1 ClearData:YES];
        
        [temp.tableView.mj_header endRefreshing];
        
    } footerRefreshDatablock:^{
        [temp.viewModel getUgcArrayType:1 ClearData:NO];
        [temp.tableView.mj_footer endRefreshing];
    }];

    /**
     3.4.2	广场-广场主页-好友推荐列表（已测）
     
     @param clear 清空原数据
     */
    [self.viewModel getFriendArrayClearData:YES];
    
}

#pragma mark -- TableViewDelegate
-  (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 1;
    }
    return self.viewModel.ugcImageArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return AUTO(25);
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if(section == 0)
    {
        UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, AUTO(25))];
        footView.backgroundColor = BACKVIEWCOLOR;
        
        UIButton *moreBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth,AUTO(20))];
        LRViewBorderRadius(moreBtn, 0, 0.5, LINECOLOR);
        moreBtn.backgroundColor = WHITECOLOR;
        [moreBtn setTitle:@"查看更多" forState:0];
        [moreBtn setImage:IMAGE(@"morearrow") forState:0];
        moreBtn.titleLabel.font = Font10;
        [moreBtn setTitleColor:ColorGray forState:0];
        [moreBtn setImageEdgeInsets:UIEdgeInsetsMake(0, AUTO(100), 0, 0)];
        [footView addSubview:moreBtn];
        return footView;
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        LBBFriendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LBBFriendTableViewCell"];

        cell.model = self.viewModel.squareRecommend;
        return cell;
    }else{
        ZJMHostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"zjmhost"];
        ////// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
        __weak typeof(self) weakSelf = self;
        cell.btnBlock = ^(id obj,UITableViewCellViewSignal signal)
        {
            switch (signal)
            {
                case UITableViewCellSendMessage:
                {
                    NSLog(@"发送评论=%@",obj);
                    LBB_SquareUgc *model = weakSelf.viewModel.ugcImageArray[indexPath.row];
                    [LBB_CommentViewModel  commentObjId:model.allSpotsId type:5 scores:0 remark:(NSString *)obj images:@[] parentId:0 block:^(NSDictionary *dic, NSError *error) {
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
                    LBB_SquareUgc  *model = self.viewModel.ugcImageArray[indexPath.row];
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
                    LBB_SquareUgc  *model = self.viewModel.ugcImageArray[indexPath.row];
                    NSLog(@"likeList.count = %ld",model.likeList.count);
                    [model like:^(NSDictionary *dic,NSError *error) {
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
        [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
        cell.model = self.viewModel.ugcImageArray[indexPath.row];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.section == 0)
    {
        LBBFriendViewController   *vc = [[LBBFriendViewController alloc]init];
        vc.viewModel = self.viewModel;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        LBBHostDetailViewController *vc = [[LBBHostDetailViewController alloc]init];
        vc.viewModel = self.viewModel.ugcImageArray[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        return AUTO(60);
    }else{
        // >>>>>>>>>>>>>>>>>>>>> * cell自适应 * >>>>>>>>>>>>>>>>>>>>>>>>
        id model = self.viewModel.ugcImageArray[indexPath.row];

        return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[ZJMHostTableViewCell class] contentViewWidth:[self cellContentViewWith]];
    }
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
