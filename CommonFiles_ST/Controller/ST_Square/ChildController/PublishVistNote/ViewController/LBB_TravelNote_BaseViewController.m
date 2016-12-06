//
//  LBB_TravelNote_BaseViewController.m
//  ST_Travel
//
//  Created by dawei che on 2016/11/21.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_TravelNote_BaseViewController.h"
#import "UINavigationBar+Awesome.h"
#import "LBB_TraveNoteHead_View.h"
#import "Header.h"
#import "LBB_AddTextToVistNote_Controller.h"
#import "LBB_AddFootprint_ViewController.h"
#import "ZYCameraViewComtroller.h"
#import "LBB_SelectImages_ViewController.h"
#import "FZJPhotoModel.h"

@interface LBB_TravelNote_BaseViewController ()<UITableViewDelegate,UITableViewDataSource,TransImageDelegate>
@property(nonatomic,strong)UIView       *whiteLine;
@property(nonatomic,weak)LBB_TraveNoteHead_View   *headView;
@property(nonatomic,weak)UITableView  *mTableView;
@end

@implementation LBB_TravelNote_BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"游记";
    self.view.backgroundColor = WHITECOLOR;
    [self initView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [[self.navigationController.navigationBar subviews] objectAtIndex:0].alpha = 0;
    [self.navigationController.navigationBar setShadowImage:[UIImage createImageWithColor:[UIColor whiteColor]]];
    [self initNav];
}

- (void)initView
{
    [self.view addSubview:self.mTableView];
    [_mTableView setTableHeaderView:self.headView];
//    self.headView.coverImage = IMAGE(@"zjmtakephotoing");
    self.headView.backgroundColor = ColorBtnYellow;
    self.headView.travelName = @"this is shit";
    self.headView.travelTime = @"2016-09-09";
    self.headView.btnFunction = ^(NSInteger tag)
    {
        if(tag == 0)
        {
            NSLog(@"添加标签");
        }else{
            NSLog(@"设置封面");
        }
    };
    
    UIView  *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, DeviceHeight - 44 - 64, DeviceWidth, 44)];
    bottomView.backgroundColor = WHITECOLOR;
    [self.view addSubview:bottomView];
    
    UIButton  *editText = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, bottomView.width / 2.0, bottomView.height)];
    [editText setTitle:@"文字" forState:0];
    [editText setImage:IMAGE(@"zjmedit") forState:0];
    [editText setTitleColor:BLACKCOLOR forState:0];
    editText.titleLabel.font = FONT(14.0);
    [editText setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [editText addTarget:self action:@selector(editTextFunc) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:editText];
    
    UIButton  *linerecoder = [[UIButton alloc]initWithFrame:CGRectMake(editText.right, 0, bottomView.width / 2.0, bottomView.height)];
    [linerecoder setTitle:@"线路账单" forState:0];
    [linerecoder setImage:IMAGE(@"zjmorderss") forState:0];
    [linerecoder setTitleColor:BLACKCOLOR forState:0];
    linerecoder.titleLabel.font = FONT(14.0);
    [linerecoder setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [linerecoder addTarget:self action:@selector(linerecoderFunc) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:linerecoder];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, 1.0)];
    line.backgroundColor = LINECOLOR;
    [bottomView addSubview:line];
    
    UIButton  *takePhoto = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [takePhoto setBackgroundImage:IMAGE(@"zjmtakephotoed") forState:0];
    takePhoto.centerY = bottomView.height / 2 - 10;
    takePhoto.centerX = bottomView.width / 2;
    [takePhoto addTarget:self action:@selector(takePhotoFunc) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:takePhoto];
    
}

- (void)initNav
{
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 43, DeviceWidth, 0.5)];
    line.backgroundColor = ColorWhite;
    [self.navigationController.navigationBar addSubview:line];
    
    UIBarButtonItem *backBarBtn = [[UIBarButtonItem alloc]initWithImage:IMAGE(@"back") style:0 target:self action:@selector(backToBaseControl)];
    backBarBtn.tintColor = ColorWhite;
    self.navigationItem.leftBarButtonItem = backBarBtn;
    
    UIBarButtonItem *pulishBarBtn = [[UIBarButtonItem alloc]initWithImage:IMAGE(@"zjm Sync") style:0 target:self action:@selector(upTravel)];
    pulishBarBtn.tintColor = ColorWhite;
    
    UIBarButtonItem *setBarBtn = [[UIBarButtonItem alloc]initWithImage:IMAGE(@"zjmset") style:0 target:self action:@selector(travelSet)];
    setBarBtn.tintColor = ColorWhite;
    
    self.navigationItem.rightBarButtonItems = @[setBarBtn,pulishBarBtn];
}

- (void)linerecoderFunc
{
    NSLog(@"linerecoderFunc");
}

- (void)editTextFunc
{
    NSLog(@"editTextFunc");
    LBB_AddTextToVistNote_Controller *vc = [[LBB_AddTextToVistNote_Controller alloc]init];
    if(!_mapPointArray)
    {
        _mapPointArray = [[NSMutableArray alloc]init];
    }
    vc.mapPointArray = _mapPointArray;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)backToBaseControl
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)upTravel
{
    NSLog(@"同步游记");
}

- (void)travelSet
{
    UIAlertController   *alterSheet = [UIAlertController alertControllerWithTitle: nil message: nil preferredStyle:UIAlertControllerStyleActionSheet];
    //添加Button
    [alterSheet addAction: [UIAlertAction actionWithTitle: @"预览游记" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //处理点击拍照
    }]];
    
    [alterSheet addAction: [UIAlertAction actionWithTitle: @"游记设置" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        //处理点击从相册选取
    }]];
    
    [alterSheet addAction: [UIAlertAction actionWithTitle: @"发布游记" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        //处理点击从相册选取
    }]];
    
    [alterSheet addAction: [UIAlertAction actionWithTitle: @"删除游记" style: UIAlertActionStyleDefault handler:nil]];
    [alterSheet addAction: [UIAlertAction actionWithTitle: @"取消" style: UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController: alterSheet animated: YES completion: nil];
    
}

- (void)takePhotoFunc
{
    UIAlertController   *alterSheet = [UIAlertController alertControllerWithTitle: nil message: nil preferredStyle:UIAlertControllerStyleActionSheet];
    //添加Button
    [alterSheet addAction: [UIAlertAction actionWithTitle: @"拍照" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        ZYCameraViewComtroller *Vc = [[ZYCameraViewComtroller alloc]init];
        Vc.TransDelegate = self;
        [self presentViewController:Vc animated:YES completion:nil];
    }]];
    
    __weak typeof (self) weakSelf = self;
    [alterSheet addAction: [UIAlertAction actionWithTitle: @"从相册选取" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        //处理点击从相册选取
        LBB_SelectImages_ViewController *Vc = [[LBB_SelectImages_ViewController alloc]init];
        Vc.addNum = 5;
        Vc.fatherNum = 2;
        Vc.returnBlock = ^(NSMutableArray *array){
            NSLog(@"图片数组");
            LBB_AddFootprint_ViewController  *Vc = [[LBB_AddFootprint_ViewController alloc]init];
            Vc.selectImageArray = [array copy];
            [weakSelf.navigationController pushViewController:Vc animated:YES];
        };
        Vc._blockJumpControl = ^(UIViewController *obj){
            [weakSelf.navigationController pushViewController:obj animated:YES];
        };

        [self.navigationController pushViewController:Vc animated:YES];

    }]];
    [alterSheet addAction: [UIAlertAction actionWithTitle: @"取消" style: UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController: alterSheet animated: YES completion: nil];
}

- (UITableView *)mTableView
{
    if(!_mTableView)
    {
        UITableView  *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -64, DeviceWidth, DeviceHeight - 44) style:0];
        tableView.backgroundColor = ColorWhite;
        tableView.delegate = self;
        tableView.dataSource = self;
        [self setExtraCellLineHidden:tableView];
        _mTableView = tableView;
        return  tableView;
    }
    return _mTableView;
}

- (LBB_TraveNoteHead_View *)headView
{
    if(!_headView)
    {
        LBB_TraveNoteHead_View  *tableView = [[LBB_TraveNoteHead_View alloc]initWithFrame:CGRectMake(0, -64, DeviceWidth, AUTO(175))];
        _headView = tableView;
        return  tableView;
    }
    return _headView;
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

#pragma mark -- TableViewDelegete

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _mapPointArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"TravelCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    if(_mapPointArray.count)
    {
        cell.textLabel.text = @"地点信息";
    }
    return cell;
}

#pragma mark -- TransDelegate
- (void)transCameraImage:(UIImage *)image PHAsset:(PHAsset *)imageAsset
{
    NSLog(@"拍照执行完毕");
    NSMutableArray *imageArray = [[NSMutableArray alloc]init];
    FZJPhotoModel   *model = [[FZJPhotoModel alloc]init];
    model.asset = imageAsset;
    [imageArray addObject:model];
    LBB_AddFootprint_ViewController  *Vc = [[LBB_AddFootprint_ViewController alloc]init];
    Vc.selectImageArray = [imageArray copy];
    [self.navigationController pushViewController:Vc animated:YES];
}
@end
