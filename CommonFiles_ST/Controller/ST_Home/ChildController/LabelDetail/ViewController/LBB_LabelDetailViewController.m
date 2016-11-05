//
//  LBB_LabelDetailViewController.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/1.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_LabelDetailViewController.h"
#import "LBB_LabelDetailHeaderView.h"

#import "LBB_LabelDetailHotDataSource.h"
#import "LBB_LabelDetailUserDataSource.h"

typedef NS_ENUM(NSInteger, LBB_LabelDetailType) {
    LBB_LabelDetailHot = 0,//热门
    LBB_LabelDetailTime,//时间
    LBB_LabelDetailUser,//用户
};

@interface LBB_LabelDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, retain)UITableView* tableView;
@property(nonatomic, retain)LBB_LabelDetailHeaderView* headerView;

@property(nonatomic, assign)LBB_LabelDetailType selectType;

@property(nonatomic, retain)LBB_LabelDetailHotDataSource* hotDataSource;
@property(nonatomic, retain)LBB_LabelDetailHotDataSource* timeDataSource;
@property(nonatomic, retain)LBB_LabelDetailUserDataSource* userDataSource;

@end

@implementation LBB_LabelDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
/*
 * setup navigation bar view
 */
-(void)loadCustomNavigationButton{
    
    WS(ws);
    UIButton *cancel = [[UIButton alloc] init];
    cancel.titleLabel.font = Font14;
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancel.frame = CGRectMake(0, 0, 45, 45);
    [cancel bk_addEventHandler:^(id sender){
        
        
        
    }forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *signItem = [[UIBarButtonItem alloc] initWithCustomView:cancel];
    self.navigationItem.rightBarButtonItem = signItem;
    
}

/*
 * setup UI
 */
-(void)buildControls{
    
    WS(ws);
    

    self.headerView = [[LBB_LabelDetailHeaderView alloc]init];
    [self.headerView setFrame:CGRectMake(0, 0, DeviceWidth, [LBB_LabelDetailHeaderView getHeight])];
    [self.headerView setModel:nil];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.hotDataSource = [[LBB_LabelDetailHotDataSource alloc] initWithTableView:self.tableView];
    self.timeDataSource = [[LBB_LabelDetailHotDataSource alloc] initWithTableView:self.tableView];
    self.userDataSource = [[LBB_LabelDetailUserDataSource alloc] initWithTableView:self.tableView];
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.centerX.top.equalTo(ws.view);
        make.bottom.equalTo(ws.view);
    }];
    
}

#pragma tableView Delegate

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (self.selectType == LBB_LabelDetailUser) {
        return AutoSize(72/2)+SeparateLineWidth + AutoSize(54/2);

    }
    return AutoSize(72/2)+SeparateLineWidth;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    WS(ws);
    CGFloat height = [self tableView:tableView heightForHeaderInSection:section];
    
    UIView* v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, height)];
    [v setBackgroundColor:ColorLine];
    NSArray* titleArray = @[@"热门",@"时间",@"用户"];
    NSArray* iconArray = @[@"标签详情_热门",@"标签详情_时间",@"标签详情_用户"];
    NSArray* iconHLArray = @[@"标签详情_热门HL",@"标签详情_时间HL",@"标签详情_用户HL"];
    CGFloat labelHeight = AutoSize(54/2);
    CGFloat width = (DeviceWidth - 2*SeparateLineWidth)/3;
    for (int i = 0; i<titleArray.count; i++) {
        
        UIButton* b = [UIButton new];
        [b setBackgroundColor:ColorWhite];
        [b setTitle:[titleArray objectAtIndex:i] forState:UIControlStateNormal];
        [b.titleLabel setFont:Font13];
        if (self.selectType == i) {
            [b setImage:IMAGE(iconHLArray[i]) forState:UIControlStateNormal];
            [b setTitleColor:ColorBtnYellow forState:UIControlStateNormal];
        }
        else{
            [b setImage:IMAGE(iconArray[i]) forState:UIControlStateNormal];
            [b setTitleColor:ColorGray forState:UIControlStateNormal];
        }
        [v addSubview:b];
        [b mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(v).offset(i*(width+SeparateLineWidth));
            make.top.equalTo(v);
            make.width.mas_equalTo(width);
            if (self.selectType == LBB_LabelDetailUser) {
                make.bottom.equalTo(v).offset(-SeparateLineWidth - labelHeight);
            }
            else{
                make.bottom.equalTo(v).offset(-SeparateLineWidth);
            }
        }];
        [b bk_addEventHandler:^(id sender){
        
            ws.selectType = i;
            [ws.tableView reloadData];
        } forControlEvents:UIControlEventTouchUpInside];
    }

    if (self.selectType == LBB_LabelDetailUser) {
        UILabel* l = [UILabel new];
        [l setBackgroundColor:ColorLine];
        [l setTextColor:ColorLightGray];
        [l setFont:Font12];
        [l setText:@"  共有179位达人"];
        [v addSubview:l];
        [l mas_makeConstraints:^(MASConstraintMaker* make){
            make.bottom.width.equalTo(v);
            make.height.mas_equalTo(labelHeight);
        }];
    }


    return v;
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    switch (self.selectType) {
        case LBB_LabelDetailHot:
            return [self.hotDataSource tableView:self.tableView numberOfRowsInSection:section];
            break;
        case LBB_LabelDetailTime:
            return [self.timeDataSource tableView:self.tableView numberOfRowsInSection:section];
            break;
        case LBB_LabelDetailUser:
            return [self.userDataSource tableView:self.tableView numberOfRowsInSection:section];
            break;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (self.selectType) {
        case LBB_LabelDetailHot:
            return [self.hotDataSource tableView:self.tableView cellForRowAtIndexPath:indexPath];
            break;
        case LBB_LabelDetailTime:
            return [self.timeDataSource tableView:self.tableView cellForRowAtIndexPath:indexPath];
            break;
        case LBB_LabelDetailUser:
            return [self.userDataSource tableView:self.tableView cellForRowAtIndexPath:indexPath];
            break;
    }
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (self.selectType) {
        case LBB_LabelDetailHot:
            return [self.hotDataSource tableView:self.tableView heightForRowAtIndexPath:indexPath];
            break;
        case LBB_LabelDetailTime:
            return [self.timeDataSource tableView:self.tableView heightForRowAtIndexPath:indexPath];
            break;
        case LBB_LabelDetailUser:
            return [self.userDataSource tableView:self.tableView heightForRowAtIndexPath:indexPath];
            break;
    }
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (self.selectType) {
        case LBB_LabelDetailHot:
            return [self.hotDataSource tableView:self.tableView didSelectRowAtIndexPath:indexPath];
            break;
        case LBB_LabelDetailTime:
            return [self.timeDataSource tableView:self.tableView didSelectRowAtIndexPath:indexPath];
            break;
        case LBB_LabelDetailUser:
            return [self.userDataSource tableView:self.tableView didSelectRowAtIndexPath:indexPath];
            break;
    }
}

@end
