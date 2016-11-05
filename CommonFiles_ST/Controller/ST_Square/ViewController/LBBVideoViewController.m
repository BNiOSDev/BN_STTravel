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

#define VideoCell @"zjmVideoCell"

@interface LBBVideoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UITableView     *tableView;
@property(nonatomic, strong)NSMutableArray  *dataArray;
@property(nonatomic, strong)NSMutableArray  *praiseArray;
@property(nonatomic, strong)NSMutableArray  *commentArray;
@property(nonatomic, strong)NSMutableArray  *imageArray;
@property(nonatomic, strong)NSMutableArray  *imageArray2;

@end

@implementation LBBVideoViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
        [(ST_TabBarController*)self.tabBarController setTabBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, self.view.frame.size.height - 30 - 64 - 44 - 20)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[LBBVideoTableViewCell class] forCellReuseIdentifier:VideoCell];
}

- (void)initData
{
    
    _imageArray = [[NSMutableArray alloc]init];
    for (int i = 0; i <= 0; i++) {
        NSString *str = @"http://c.hiphotos.baidu.com/image/pic/item/6c224f4a20a446230b10a7179a22720e0df3d7e8.jpg";
        [_imageArray addObject:str];
    }
    
    _imageArray2 = [[NSMutableArray alloc]init];
    for (int i = 0; i <= 0; i++) {
        NSString *str = @"http://e.hiphotos.baidu.com/image/pic/item/c83d70cf3bc79f3d7467e245b8a1cd11738b29c4.jpg";
        [_imageArray2 addObject:str];
    }
    
    _praiseArray = [[NSMutableArray alloc]init];
    for (int i = 0; i <= 10; i++) {
        PraiseModel *model = [[PraiseModel alloc]init];
        model.iconUrl = @"http://c.hiphotos.baidu.com/image/pic/item/6c224f4a20a446230b10a7179a22720e0df3d7e8.jpg";
        [_praiseArray addObject:model];
    }
    
    _commentArray = [[NSMutableArray alloc]init];
    for (int i = 0; i <= 0; i++) {
        CommentModel *model = [[CommentModel alloc]init];
        model.userName = @"小大王";
        model.contentStr = @"大王叫我来巡山,大王叫我来巡山,大王叫我来巡山";
        [_commentArray addObject:model];
    }
    
    _dataArray = [[NSMutableArray alloc]init];
    for (int i = 0; i <= 10; i++) {
        ZJMHostModel *model = [[ZJMHostModel alloc]init];
        model.iconUrl = @"http://c.hiphotos.baidu.com/image/pic/item/6c224f4a20a446230b10a7179a22720e0df3d7e8.jpg";
        model.userName = @"zjmzjmzjmzjm";
        model.timeAgo = @"15min ago";
        model.address = @"address";
        model.content = @"你这是什么鬼啊你你这是什么鬼啊你你这是什么鬼啊你你这是什么鬼啊你你这是什么鬼啊你你这是什么鬼啊你你这是什么鬼啊你你这是什么鬼啊你你这是什么鬼啊你你这是什么鬼啊你你这是什么鬼啊你你这是什么鬼啊你你这是什么鬼啊你你这是什么鬼啊你你这是什么鬼啊你你这是什么鬼啊你你这是什么鬼啊你你这是什么鬼啊你你这是什么鬼啊你你这是什么鬼啊你你这是什么鬼啊你你这是什么鬼啊你你这是什么鬼啊你你这是什么鬼啊你你这是什么鬼啊你你这是什么鬼啊你你这是什么鬼啊你你这是什么鬼啊你你这是什么鬼啊你你这是什么鬼啊你你这是什么鬼啊你你这是什么鬼啊你你这是什么鬼啊你你这是什么鬼啊你你这是什么鬼啊你你这是什么鬼啊你";
        model.hostImageUrl = @"";
        
        if(i % 2 == 0)
        {
            model.imageArray = _imageArray;
        }else{
            model.imageArray = _imageArray2;
        }
        
        
        model.praiseModelArray = _praiseArray;
        
        model.commentModelArray = _commentArray;
        
        [_dataArray addObject:model];
    }
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LBBVideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:VideoCell];
    
    ////// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    
    ///////////////////////////////////////////////////////////////////////
    
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // >>>>>>>>>>>>>>>>>>>>> * cell自适应 * >>>>>>>>>>>>>>>>>>>>>>>>
    id model = self.dataArray[indexPath.row];
    
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




@end
