//
//  LBB_SelectTip_History_ViewController.m
//  ST_Travel
//
//  Created by dawei che on 2016/11/20.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_SelectTip_History_ViewController.h"
#import "LBB_HistoryTipView.h"
#import "Header.h"
#import "LBB_HotTipCell.h"
#import "CoreData+MagicalRecord.h"
#import "LBB_TagsViewModel.h"
#import "TipHistory+CoreDataClass.h"

@interface LBB_SelectTip_History_ViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UITextField  *inputTip;
}
@property(nonatomic,strong)UITableView      *mTableView;
@property(nonatomic,strong)UITableView      *SearchTableView;
@property(nonatomic,weak)LBB_HistoryTipView *tableHead;
@property(nonatomic,strong)NSArray            *tagArray;
@end

@implementation LBB_SelectTip_History_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WHITECOLOR;
    
    //注册键盘消失的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWillBeHidden:)
     
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    [self initNav];
    [self initView];
    [self getData];
}

- (void)getData
{
//    LBB_TagsViewModel  *model = [[LBB_TagsViewModel alloc]init];
    [LBB_SquareTags getConditionTagsClass: 1 type: 1 block:^(NSArray<LBB_SquareTags *> *files, NSError *error) {
         NSLog(@"files:%@",files);
        _tagArray = files;
        [_mTableView reloadData];
    }];
}

- (void)initView
{
    LBB_HistoryTipView  *tableHeadVeiw = [[LBB_HistoryTipView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, AUTO(207))];
    tableHeadVeiw.backgroundColor = WHITECOLOR;
    tableHeadVeiw.clearBlock = ^(NSInteger tag){
        [self.view removeAllSubviews];
        [self initView];
    };
    _tableHead = tableHeadVeiw;
    [self.view addSubview:self.mTableView];
//    _tableHead.historySearch = @[@"三朵金花",@"三朵金花",@"三朵金花",@"三朵金花"];
    NSArray *array = [TipHistory  MR_findAll];
    NSMutableArray *dataArray = [[NSMutableArray alloc]init];
    for(int i = 0;i  < array.count;i++)
    {
        TipHistory *model = array[i];
        [dataArray addObject:model.searchKey];
    }
    _tableHead.historySearch = dataArray;
    [self.mTableView setTableHeaderView:_tableHead];
}

- (void)initNav
{
    inputTip = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, AUTO(240), 25)];
    inputTip.leftViewMode = UITextFieldViewModeAlways;
    inputTip.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 15, 25)];
    inputTip.delegate = self;
    inputTip.font = FONT(11.0);
    
    LRViewBorderRadius(inputTip, 4.5, 0.5, BLACKCOLOR);
    inputTip.placeholder = @"输入标签";
    
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.titleView = inputTip;
    
    UIBarButtonItem *cancelBarBtn =  [[UIBarButtonItem alloc]initWithTitle:@"取消" style:0 target:self action:@selector(cancelFunc)];
    cancelBarBtn.tintColor = BLACKCOLOR;
    self.navigationItem.rightBarButtonItem = cancelBarBtn;
}

- (void)cancelFunc
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UITableView *)mTableView
{
    if(!_mTableView)
    {
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight - 64) style:0];
        tableView.backgroundColor = WHITECOLOR;
        tableView.delegate = self;
        tableView.dataSource = self;
        _mTableView = tableView;
        [self setExtraCellLineHidden:_mTableView];
    }
    return _mTableView;
}

- (UITableView *)SearchTableView
{
    if(!_SearchTableView)
    {
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight - 64) style:0];
        tableView.backgroundColor = WHITECOLOR;
        tableView.delegate = self;
        tableView.dataSource = self;
        _SearchTableView = tableView;
          [self setExtraCellLineHidden:_SearchTableView];
    }
    return _SearchTableView;
}

/**
 *  隐藏多余tablecell
 *
 *  @param tableView void
 */
- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
}

#pragma mark TableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tagArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return AUTO(40);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"photoCell";
    LBB_HotTipCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[LBB_HotTipCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    LBB_SquareTags *tagModel = [_tagArray objectAtIndex:indexPath.row];
    cell.tipTitle = tagModel.tagName;;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LBB_SquareTags  * tagModel = [_tagArray objectAtIndex:indexPath.row];
    self.transTags(tagModel);
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark uitextFielddelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSLog(@"%@",textField.text);
    [self.view addSubview:self.SearchTableView];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    _SearchTableView = nil;
    [textField endEditing:YES];
    return YES;
}

-(void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    if(inputTip.text.length <= 0)
    {
        return;
    }
    TipHistory  *historyModel = [TipHistory MR_createEntity];
    historyModel.searchKey = inputTip.text;
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    
    NSArray *array = [TipHistory  MR_findAll];
    NSMutableArray *dataArray = [[NSMutableArray alloc]init];
    for(int i = 0;i  < array.count;i++)
    {
        TipHistory *model = array[i];
        [dataArray addObject:model.searchKey];
    }
    _tableHead.historySearch = dataArray;
}

@end
