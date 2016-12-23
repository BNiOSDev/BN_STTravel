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
#import "LBB_SerCover_CollectionViewController.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "UIView+SDAutoLayout.h"
#import "LBB_TravelDetailViewCell.h"
#import "ZJMTravelModel.h"
#import "LBB_TravelCommentCell.h"
#import "LBB_TravelNote_ListViewCell.h"
#import "LBB_TravelDraftViewModel.h"
#import "LBB_SelectTip_History_ViewController.h"
#import "LBB_TagView.h"
#import "LBB_TravelSet_ViewController.h"
#import "LBB_Travel_Bill_ViewController.h"

@interface LBB_TravelNote_BaseViewController ()<UITableViewDelegate,UITableViewDataSource,TransImageDelegate>
{
    BOOL    previewSet; //no,展示地图，yes，展示预览
    BOOL    syncStaus;  //yes,进行同步,no 不进行同步
}
@property(nonatomic,strong)UIView       *whiteLine;
@property(nonatomic,weak)LBB_TraveNoteHead_View   *headView;
@property(nonatomic,weak)UITableView  *mTableView;
@property(nonatomic, strong)NSMutableArray  *dataArray;
@property(nonatomic, strong)NSMutableArray  *tipArray;
@property(nonatomic, strong)NSMutableArray  *imageArray;
@property(nonatomic, strong)LBB_TravelDraftViewModel  *dataModel;
@end

@implementation LBB_TravelNote_BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"游记";
    self.view.backgroundColor = WHITECOLOR;
    [self initData];
    [self initView];
}

- (void)initData
{
    _tipArray = [[NSMutableArray alloc]init];
    _imageArray = [[NSMutableArray alloc]init];
    _dataModel = [[LBB_TravelDraftViewModel alloc]init];
    [_dataModel getTravelDraftData];
    __weak typeof(self) weakSelf = self;
   
    [_dataModel.travelDraftModel.loadSupport setDataRefreshblock:^{
        NSLog(@"%@",weakSelf.dataModel.travelDraftModel.travelNotesDetails);
        [weakSelf.mTableView reloadData];
        [weakSelf.imageArray removeAllObjects];
        for (TravelNotesDetails *footModel in weakSelf.dataModel.travelDraftModel.travelNotesDetails) {
            for(TravelNotesPics *imageModel in footModel.pics)
            {
                [weakSelf.imageArray addObject:imageModel];
            }
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [[self.navigationController.navigationBar subviews] objectAtIndex:0].alpha = 0;
    [self.navigationController.navigationBar setShadowImage:[UIImage createImageWithColor:[UIColor whiteColor]]];
    [self initNav];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[self.navigationController.navigationBar subviews] objectAtIndex:0].alpha = 1.0;
    [self.navigationController.navigationBar setShadowImage:[UIImage createImageWithColor:[UIColor grayColor]]];
}

- (void)initView
{
    __weak typeof (self) weakSelf = self;
    [self.view addSubview:self.mTableView];
    [_mTableView registerClass:[LBB_TravelNote_ListViewCell class] forCellReuseIdentifier:@"LBB_TravelNote_ListViewCell"];
    [_mTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCellAddress"];
    [_mTableView setTableHeaderView:self.headView];
//    self.headView.coverImage = IMAGE(@"zjmtakephotoing");
//    self.headView.travelName = @"this is shit";
//    self.headView.travelTime = @"2016-09-09";
    self.headView.btnFunction = ^(NSInteger tag)
    {
        if(tag == 0)
        {
            NSLog(@"添加标签");
            if(_tipArray.count >= 3)
            {
                [self showHudPrompt:@"最多只能有三个标签"];
                return ;
            }
            
            LBB_SelectTip_History_ViewController *vc = [[LBB_SelectTip_History_ViewController alloc]init];
            vc.transTags = ^(id obj){
                if(![self containsObject:(LBB_SquareTags *)obj])
                {
                    [_tipArray addObject:obj];
                    [weakSelf setTagViews];
                }
            };
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            NSLog(@"设置封面");
            LBB_SerCover_CollectionViewController *Vc = [[LBB_SerCover_CollectionViewController alloc]init];
            Vc.view.backgroundColor = WHITECOLOR;
            Vc.imageArray = _imageArray;
            Vc.setCoverBlock = ^(TravelNotesPics *model){
                _dataModel.travelDraftModel.picUrl = model.imageUrl;
                weakSelf.headView.coverImage = weakSelf.dataModel.travelDraftModel.picUrl;
            };
            [self.navigationController pushViewController:Vc animated:YES];
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
    LBB_Travel_Bill_ViewController *vc = [[LBB_Travel_Bill_ViewController alloc]init];
    vc.edit = YES;
    vc.travelNotesId = _dataModel.travelDraftModel.travelNotesId;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)editTextFunc
{
    NSLog(@"editTextFunc");
    LBB_AddTextToVistNote_Controller *vc = [[LBB_AddTextToVistNote_Controller alloc]init];
    vc.dataModel = self.dataModel;
    if(!_mapPointArray)
    {
        _mapPointArray = [[NSMutableArray alloc]init];
    }
    vc.mapPointArray = _mapPointArray;
    vc.blockFeedBack = ^(UIViewController *vc)
    {
        previewSet = NO;
        [self.dataModel getTravelDraftData];
    };
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
    if(_headView.travelName.length == 0)
    {
        _headView.travelName = @"";
    }
    self.dataModel.travelDraftModel.name = _headView.travelName;
    self.dataModel.travelDraftModel.tags = _tipArray.copy;
    self.dataModel.travelDraftModel.picRemark = @"";
    [self.dataModel saveTravelDraftData:^(NSError *error) {
        
    }];
}


- (void)setTagViews
{
    for(UIView *view in [_headView subviews])
    {
        if([view isKindOfClass:[LBB_TagView class]])
        {
            [view removeFromSuperview];
        }
    }
    for(int i = 0;i < _tipArray.count;i++)
    {
        LBB_SquareTags  *tagsModel = [_tipArray objectAtIndex:i];
        LBB_TagView   *tagView = [[LBB_TagView alloc]initWithFrame:CGRectMake(0, _headView.height - AUTO(25) - (AUTO(25) * i), AUTO(80), AUTO(20))];
        tagView.tagModel = tagsModel;
        __weak typeof(tagView) weakTagView = tagView;
        tagView.blockTagFunc = ^(LBB_TagView *view)
        {
            weakTagView.left = _headView.width - view.width - 5;
        };
        tagView.tagTitleStr = tagsModel.tagName;
        //        [tagView addTarget:self action:@selector(tagsDetailFunc:) forControlEvents:UIControlEventTouchUpInside];
        [_headView addSubview:tagView];
        
    }
}


- (BOOL)containsObject:(LBB_SquareTags *)tag
{
    for(int i = 0; i < self.tipArray.count; i++)
    {
        LBB_SquareTags *chareTag = [self.tipArray objectAtIndex:i];
        if([chareTag.tagName isEqualToString:tag.tagName])
        {
            return YES;
        }
    }
    return NO;
}

- (void)travelSet
{
    __weak  typeof (self) weakSelf = self;
    UIAlertController   *alterSheet = [UIAlertController alertControllerWithTitle: nil message: nil preferredStyle:UIAlertControllerStyleActionSheet];
    //添加Button
    [alterSheet addAction: [UIAlertAction actionWithTitle: @"预览游记" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //处理点击拍照
        if(!weakSelf.dataModel.travelDraftModel.travelNotesDetails.count)
        {
            [weakSelf showHudPrompt:@"没有数据不能预览"];
            return ;
        }
        previewSet = YES;
        [_mTableView reloadData];
    }]];
    
    [alterSheet addAction: [UIAlertAction actionWithTitle: @"游记设置" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        LBB_TravelSet_ViewController *vc = [[LBB_TravelSet_ViewController alloc]init];
        vc.blockBtnFunc = ^(NSInteger tag){
            weakSelf.dataModel.travelDraftModel.displayState = (int)tag;
        };
        vc.blockFeedBack = ^(UIViewController *VC)
        {
            syncStaus = ((LBB_TravelSet_ViewController *)VC).autoSync;
        };
        [self.navigationController pushViewController:vc animated:YES];
    }]];
    
    [alterSheet addAction: [UIAlertAction actionWithTitle: @"发布游记" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
            UIAlertController   *alterPublish = [UIAlertController alertControllerWithTitle: @"提示" message: @"确定发布游记？" preferredStyle:UIAlertControllerStyleAlert];
            [alterPublish addAction: [UIAlertAction actionWithTitle: @"取消" style: UIAlertActionStyleCancel handler:^(UIAlertAction *action){
            }]];
            [alterPublish addAction: [UIAlertAction actionWithTitle: @"确定" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                NSLog(@"发布游记");
                if(_headView.travelName.length == 0)
                {
                    _headView.travelName = @"";
                }
                weakSelf.dataModel.travelDraftModel.name = _headView.travelName;
                weakSelf.dataModel.travelDraftModel.picUrl = _headView.coverImage;
                [weakSelf.dataModel publicTravelDraftData:^(NSError *error) {
                    if(!error)
                    {
                        [weakSelf showHudPrompt:@"发布失败"];
                    }
                }];
            }]];
         [self presentViewController: alterPublish animated: YES completion: nil];
    }]];
    
    [alterSheet addAction: [UIAlertAction actionWithTitle: @"删除游记" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
        UIAlertController   *alterPublish = [UIAlertController alertControllerWithTitle: @"提示" message: @"确定删除游记？" preferredStyle:UIAlertControllerStyleAlert];
        [alterPublish addAction: [UIAlertAction actionWithTitle: @"取消" style: UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        }]];
        [alterPublish addAction: [UIAlertAction actionWithTitle: @"确定" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            NSLog(@"删除游记");
            [weakSelf.dataModel deleteTravelDraftData:^(NSError *error) {
                if(!error)
                {
                    [weakSelf showHudPrompt:@"删除失败"];
                }
            }];
        }]];
        [self presentViewController: alterPublish animated: YES completion: nil];
    }]];
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
            Vc.dataModel = _dataModel;
            Vc.selectImageArray = [array copy];
            Vc.blockFeedBack = ^(UIViewController *vc){
                previewSet = NO;
                [self.dataModel getTravelDraftData];
            };
            
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
        tableView.separatorStyle = UITableViewCellSelectionStyleNone;
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(!previewSet)
    {
        return _dataModel.travelDraftModel.travelNotesDetails.count;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(!previewSet)
    {
        return 1;
    }
    return _dataModel.travelDraftModel.travelNotesDetails.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(!previewSet)
    {
        return 10;
    }
    return AUTO(35);
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
        UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, AUTO(35))];
        headView.backgroundColor = WHITECOLOR;
        
        UIView *ballView = [[UIView alloc]initWithFrame:CGRectMake(14, 10, AUTO(12.0), AUTO(12.0))];
        LRViewBorderRadius(ballView, ballView.height / 2.0, 0, [UIColor clearColor]);
        ballView.backgroundColor = BLACKCOLOR;
        [headView addSubview:ballView];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(20, ballView.bottom, 1.0, AUTO(13.0))];
        line.backgroundColor = BLACKCOLOR;
        [headView addSubview:line];
        
        ballView.centerX = line.centerX;
        
        UILabel *sectionLabel = [[UILabel alloc]initWithFrame:CGRectMake(ballView.right + 5, 10, DeviceWidth - (ballView.right + 5), AUTO(15))];
        sectionLabel.font = FONT(AUTO(13.0));
        sectionLabel.text = @"第一天 2016-09-10";
        sectionLabel.centerY = ballView.centerY;
        [headView addSubview:sectionLabel];
        if(self.dataModel.travelDraftModel.travelNotesDetails.count == 0 || !previewSet)
        {
            return nil;
        }
        return headView;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(!previewSet)
    {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellAddress"];
            TravelNotesDetails *model = [_dataModel.travelDraftModel.travelNotesDetails objectAtIndex:indexPath.row];
            BN_MapView  *mapView = [[BN_MapView alloc]init];
            [mapView setFrame:CGRectMake(0, 0, cell.size.width , cell.size.height)];
            [mapView andAnnotationLatitude:[model.dimensionality longLongValue]longitude:[model.longitude longLongValue]];
            cell.backgroundView = mapView;
            return cell;
    }else{
    
        LBB_TravelNote_ListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LBB_TravelNote_ListViewCell"];
        cell.accessoryType = 0;
        TravelNotesDetails *model = [_dataModel.travelDraftModel.travelNotesDetails objectAtIndex:indexPath.row];
        NSLog(@"%@",model);
        cell.model = model;
        cell.selectionStyle = 0;
    ////// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
        [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    
        return cell;
    }
 
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // >>>>>>>>>>>>>>>>>>>>> * cell自适应 * >>>>>>>>>>>>>>>>>>>>>>>>
//    id model = self.dataArray[indexPath.row];
    if(!previewSet)
    {
        return 100;
    }
    id model = self.dataModel.travelDraftModel.travelNotesDetails[indexPath.row];
    return [_mTableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[LBB_TravelNote_ListViewCell class] contentViewWidth:[self cellContentViewWith]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(!previewSet)
    {
        TravelNotesDetails *model = [_dataModel.travelDraftModel.travelNotesDetails objectAtIndex:indexPath.section];
        if(model.pics.count > 0)
        {
            LBB_AddFootprint_ViewController   *vc = [[LBB_AddFootprint_ViewController alloc]init];
            vc.dataModel = self.dataModel;
            vc.model = model;
            vc.blockFeedBack = ^(UIViewController *vc)
            {
                previewSet = NO;
                [self.dataModel getTravelDraftData];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            LBB_AddTextToVistNote_Controller   *vc = [[LBB_AddTextToVistNote_Controller alloc]init];
             vc.dataModel = self.dataModel;
            vc.model = model;
            vc.blockFeedBack = ^(UIViewController *vc)
            {
                previewSet = NO;
                [self.dataModel getTravelDraftData];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
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
    Vc.blockFeedBack = ^(UIViewController *vc){
        previewSet = NO;
        [self.dataModel getTravelDraftData];
    };
    [self.navigationController pushViewController:Vc animated:YES];
}
@end
