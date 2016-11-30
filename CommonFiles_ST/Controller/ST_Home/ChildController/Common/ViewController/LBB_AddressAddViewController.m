//
//  LBB_AddressAddViewController.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/22.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_AddressAddViewController.h"
#import "LBB_SignInListCell.h"

@interface LBB_AddressAddViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@property(nonatomic, retain)UITableView* tableView;
@property(nonatomic, retain)UISearchBar* searchBar;

@property(nonatomic, retain)LBB_SquareAddressViewModel* viewModel;

@end


@implementation LBB_AddressAddViewController

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

-(void)initViewModel{

    self.viewModel = [[LBB_SquareAddressViewModel alloc] init];
    
    /**
     3.4.26	主页-游记添加地址（已测）
     
     @param allSpotsType 1.美食 2.民宿 3景点(可为空)
     @param name 可为空 模糊查询
     @param clear 是否清空原数据
     */
    [self.viewModel getsTravelNotesDetailAllSpotsType:1 name:@"" ClearData:YES];
    
    WS(ws);
    [self.viewModel.squareSpotsArray.loadSupport setDataRefreshblock:^{
        
        [ws.tableView reloadData];
    }];
    
    [self.tableView setTableViewData:self.viewModel.squareSpotsArray];
    
    [self.tableView setHeaderRefreshDatablock:^{
        
        [ws.viewModel getsTravelNotesDetailAllSpotsType:1 name:@"" ClearData:YES];
        [ws.tableView.mj_header endRefreshing];
    } footerRefreshDatablock:^{
        [ws.tableView.mj_footer endRefreshing];
        [ws.viewModel getsTravelNotesDetailAllSpotsType:1 name:@"" ClearData:NO];
    }];
    
    
}

-(void)loadCustomNavigationButton{
    
    WS(ws);
    UIButton *cancel = [[UIButton alloc] init];
    cancel.titleLabel.font = Font14;
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancel.frame = CGRectMake(0, 0, 45, 45);
    [cancel bk_addEventHandler:^(id sender){
        
        [ws.searchBar resignFirstResponder];

    
    }forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *signItem = [[UIBarButtonItem alloc] initWithCustomView:cancel];
    self.navigationItem.rightBarButtonItem = signItem;
    
    
    CGFloat height = IAppNavigationBarHeight - 10;
    CGFloat width = UISCREEN_WIDTH - 2*45 - 30;
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];//allocate titleView
    UISearchBar *bar = [UISearchBar new];
    bar.barStyle = UIBarStyleDefault;
    
    bar.layer.borderColor = [UIColor blackColor].CGColor;
    bar.layer.borderWidth = 0.8;
    bar.layer.cornerRadius = 5;
    bar.layer.masksToBounds = YES;
    [bar setBackgroundImage:[UIImage new]];
    bar.delegate = self;
    bar.placeholder = @"搜索地址名称";
    [bar setContentMode:UIViewContentModeLeft];
    self.searchBar = bar;
    [titleView addSubview:bar];
    [bar mas_makeConstraints:^(MASConstraintMaker* make){
        make.center.width.height.equalTo(titleView);
    }];
    
    [self.navigationItem.titleView sizeToFit];
    self.navigationItem.titleView = titleView;
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

/*
 * setup UI
 */
-(void)buildControls{
    
    WS(ws);
    
    [self.view setBackgroundColor:[UIColor whiteColor]];

    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.tableView registerClass:[LBB_SignInListCell class] forCellReuseIdentifier:@"LBB_SignInListCell"];
    [self.view addSubview:self.tableView];
    
    [self initViewModel];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.centerX.top.equalTo(ws.view);
        make.bottom.equalTo(ws.view);
    }];
    
}

#pragma tableView Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.viewModel.squareSpotsArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [tableView fd_heightForCellWithIdentifier:@"LBB_SignInListCell" cacheByIndexPath:indexPath configuration:^(LBB_SignInListCell* cell){
        
    }];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"LBB_SignInListCell";
    LBB_SignInListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    [cell showArrowImageView:YES];
    cell.portraitImageView.layer.cornerRadius = 5;
    
    LBB_SpotAddress* obj = [self.viewModel.squareSpotsArray objectAtIndex:indexPath.row];
    [cell.portraitImageView sd_setImageWithURL:[NSURL URLWithString:obj.picUrl] placeholderImage:IMAGE(PlaceHolderImage)];
    
    [cell.titleLabel setText:obj.allSpotsName];
    [cell.subTitleLabel setText:obj.address];
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    LBB_SpotAddress* obj = [self.viewModel.squareSpotsArray objectAtIndex:indexPath.row];

    self.click(self,obj);
}


@end
