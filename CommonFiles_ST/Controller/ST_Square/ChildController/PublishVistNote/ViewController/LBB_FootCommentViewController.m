//
//  LBB_FootCommentViewController.m
//  ST_Travel
//
//  Created by dawei che on 2016/12/25.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_FootCommentViewController.h"
#import "ST_TabBarController.h"
#import "ZJMHostModel.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "UIView+SDAutoLayout.h"
#import "PraiseModel.h"
#import "Header.h"
#import "CommentModel.h"
#import "LBB_TravelCommentCell.h"
#import "LBB_SquareViewModel.h"
#import "LBB_FootCommentCell.h"

@interface LBB_FootCommentViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UITableView     *tableView;
@property(nonatomic, strong)NSMutableArray  *dataArray;
@property(nonatomic, strong)NSMutableArray  *praiseArray;
@property(nonatomic, strong)NSMutableArray  *commentArray;
@property(nonatomic, strong)NSMutableArray  *imageArray;
@property(nonatomic, strong)NSMutableArray  *imageArray2;


@end

@implementation LBB_FootCommentViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [(ST_TabBarController*)self.tabBarController setTabBarHidden:YES animated:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    self.navigationItem.title = @"视频评论";
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, self.view.frame.size.height)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = 0;
    [self.tableView registerClass:[LBB_FootCommentCell class] forCellReuseIdentifier:@"LBB_FootCommentCell"];
}

- (void)initData
{
    __weak typeof(self) weakSelf = self;
    [_dataModel getTravelNotesDetailsCommentsModel];
    [_dataModel.travelNotesDetailsComments.loadSupport setDataRefreshblock:^{
        NSLog(@"获取数据成功！！！");
        [weakSelf.tableView reloadData];
    }];
    
}

#pragma mark -- TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self) weakSelf = self;
    LBB_FootCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LBB_FootCommentCell"];
    cell.commentBlock = ^(id obj, UITableViewCellViewSignal signal)
    {
        switch (signal) {
            case UITableViewCellSendMessage:
            {
                NSLog(@"pinglun");
                [LBB_CommentViewModel  commentObjId:_dataModel.travelNotesDetailId type:9 scores:0 remark:(NSString *)obj images:@[] parentId:0 block:^(NSDictionary *dic, NSError *error) {
                    NSLog(@"评论回馈= %@",dic);
                    if(!error){
                        LBB_SquareComments *commentsModel = [LBB_SquareComments new];
                        NSString *commentIdStr = [NSString stringWithFormat:@"%@",dic[@"commentId"]];
                        commentsModel.commentId = [commentIdStr longLongValue];
                        commentsModel.remark = dic[@"remark"];
                        commentsModel.userName = dic[@"userName"];
                        
                        [weakSelf.dataModel getTravelNotesDetailsCommentsModel];
                    }
                }];
                
            };
                break;
            case UITableViewCellPraise:
            {
                BN_SquareTravelList *model = self.viewModel;
                [_dataModel like:^(NSDictionary *dic, NSError *error) {
                    if(!error)
                    {
                        NSLog(@"点赞成功");
                        if(model.isLiked == 1)
                        {
                            [(UIButton *)obj setImage:IMAGE(@"zjmzhuyedianzaned") forState:0];
                            
                        }else{
                            [(UIButton *)obj setImage:IMAGE(@"zjmzhuyedianzan") forState:0];
                            
                        }
                    }
                }];
                
            }
                break;
                
            default:
                break;
        }
    };
    
    ////// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    cell.model = self.dataModel.travelNotesDetailsComments;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"xuanzhong");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // >>>>>>>>>>>>>>>>>>>>> * cell自适应 * >>>>>>>>>>>>>>>>>>>>>>>>
    id model = self.dataModel.travelNotesDetailsComments;
    
    return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[LBB_FootCommentCell class] contentViewWidth:[self cellContentViewWith]];
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
