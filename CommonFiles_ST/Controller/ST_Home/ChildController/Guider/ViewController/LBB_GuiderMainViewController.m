//
//  LBB_GuiderMainViewController.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/2.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_GuiderMainViewController.h"
#import "LBB_GuiderMainCell.h"
#import "LBB_GuiderApplyViewController.h"
#import "LBB_GuiderUserViewController.h"

@interface LBB_GuiderMainViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, retain) UISearchBar *searchBar;
@property (nonatomic, retain) UITableView* tableView;

@end

@implementation LBB_GuiderMainViewController

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

-(void)loadCustomNavigationButton{
  
    CGFloat height = IAppNavigationBarHeight - 10;
    CGFloat width = DeviceWidth - 2*45 - 30;
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];//allocate titleView
    UISearchBar *bar = [UISearchBar new];
    bar.barStyle = UIBarStyleDefault;
    
    bar.layer.borderColor = [UIColor blackColor].CGColor;
    bar.layer.borderWidth = 0.8;
    bar.layer.cornerRadius = height/2;
    bar.layer.masksToBounds = YES;
    [bar setBackgroundImage:[UIImage new]];
    bar.delegate = self;
    bar.placeholder = @"请搜索用户";
    [bar setContentMode:UIViewContentModeLeft];
    self.searchBar = bar;
    [titleView addSubview:bar];
    [bar mas_makeConstraints:^(MASConstraintMaker* make){
        make.center.width.height.equalTo(titleView);
    }];
    
    [self.navigationItem.titleView sizeToFit];
    self.navigationItem.titleView = titleView;
    
}


/*
 *  setup UI
 */
-(void)buildControls{

    
    WS(ws);
    self.automaticallyAdjustsScrollViewInsets = NO;//对策scroll View自动向下移动20像素问题
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.tableView registerClass:[LBB_GuiderMainCell class] forCellReuseIdentifier:@"LBB_GuiderMainCell"];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.left.right.equalTo(ws.view);
        make.top.equalTo(ws.view.mas_top);
        make.bottom.equalTo(ws.view);
    }];
    
    
    
}

#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    NSLog(@"searchBarSearchButtonClicked");
    
}

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    [self.searchBar becomeFirstResponder];
    return YES;
}


#pragma tableView Delegate


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return AutoSize(40);
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    WS(ws);
    CGFloat height = [self tableView:tableView heightForHeaderInSection:section];
    
    UIView* v = [UIView new];
    [v setBackgroundColor:ColorWhite];
    [v setFrame:CGRectMake(0, 0, DeviceWidth, height)];
    
    UIButton* b1 = [UIButton new];
    [b1 setTitle:@"申请导游证 >" forState:UIControlStateNormal];
    [b1 setTitleColor:ColorBlack forState:UIControlStateNormal];
    [b1.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    b1.layer.borderColor = ColorLine.CGColor;
    b1.layer.borderWidth = SeparateLineWidth;
    b1.layer.masksToBounds = YES;
    [v addSubview:b1];
    [b1 mas_makeConstraints:^(MASConstraintMaker* make){
        make.center.equalTo(v);
        make.width.mas_equalTo(AutoSize(250/2));
        make.height.mas_equalTo(AutoSize(40/2));

    }];
    
    [b1 bk_addEventHandler:^(id sender){
    
        LBB_GuiderApplyViewController* dest = [[LBB_GuiderApplyViewController alloc]init];
        dest.showLabelTag = YES;
        [ws.navigationController pushViewController:dest animated:YES];
    } forControlEvents:UIControlEventTouchUpInside];

    
    //设置
    NSString* strFormat1 = @"申请导游证 >";
    NSString* strFormat2 = @">";
    UIColor* fontColor = ColorLine;
    NSDictionary* attrsDic = @{NSForegroundColorAttributeName:fontColor,
                               NSFontAttributeName:Font14};    //显示的字符串进行富文本转换
    NSMutableAttributedString* strAttr = [[NSMutableAttributedString alloc]initWithString:strFormat1];
    //字体设置
    NSRange rang = [strFormat1 rangeOfString:strFormat2];
    if (rang.location != NSNotFound) {
        NSLog(@"found at location = %ld, length = %ld",rang.location,rang.length);
        [strAttr addAttributes:attrsDic range:NSMakeRange(rang.location, rang.length)];
    }else{
        NSLog(@"Not Found");
    }
    b1.titleLabel.attributedText = strAttr;
   
    
    UIView* sep = [UIView new];
    [sep setBackgroundColor:ColorLine];
    [v addSubview:sep];
    [sep mas_makeConstraints:^(MASConstraintMaker* make){
        make.centerX.width.bottom.equalTo(v);
        make.height.mas_equalTo(SeparateLineWidth);
    }];
    
    UIButton* b2 = [UIButton new];
    [b2 setTitle:@"筛选" forState:UIControlStateNormal];
    [b2 setTitleColor:ColorLightGray forState:UIControlStateNormal];
    [b2.titleLabel setFont:Font14];
    [v addSubview:b2];
    [b2 mas_makeConstraints:^(MASConstraintMaker* make){
        make.centerY.equalTo(v);
        make.right.equalTo(v).offset(-16);
    }];
    
    return v;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"LBB_GuiderMainCell";
    LBB_GuiderMainCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[LBB_GuiderMainCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        NSLog(@"LBB_GuiderMainCell nil");
    }
    [cell setModel:nil];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [tableView fd_heightForCellWithIdentifier:@"LBB_GuiderMainCell" cacheByIndexPath:indexPath configuration:^(LBB_GuiderMainCell *cell) {
        
    }];
}

@end
