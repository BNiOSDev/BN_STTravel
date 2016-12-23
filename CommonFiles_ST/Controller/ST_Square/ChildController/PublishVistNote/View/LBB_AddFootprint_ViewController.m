//
//  LBB_AddFootprint_ViewController.m
//  ST_Travel
//
//  Created by dawei che on 2016/11/29.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_AddFootprint_ViewController.h"
#import "Header.h"
#import "LBB_Date_SengeMent.h"
#import "LBB_AddClass_Button.h"
#import "ActionSheetDatePicker.h"
#import "UITextView+Placeholder.h"
#import "LBB_ZJMPhotoList.h"
#import "FZJPhotoModel.h"
#import "ZYCameraViewComtroller.h"
#import "LBB_SelectImages_ViewController.h"
#import "LBB_AddressAddViewController.h"
#import "LBB_SpotAddress.h"
#import "LBB_EditShopRecoder_Controller.h"
#import "LBB_SelectTip_History_ViewController.h"
#import "LBB_TagsViewModel.h"
#import "BN_SquareTravelNotesModel.h"

@interface LBB_AddFootprint_ViewController ()<TransImageDelegate>
{
    LBB_AddClass_Button  *addAddres;
    LBB_AddClass_Button  *addSale;
    BOOL  newFoot;//是否新发布
}
@property(nonatomic,strong)LBB_Date_SengeMent    *headSegment;
@property(nonatomic,strong)UITextView                       *contentText;
@property(nonatomic,strong)UIScrollView                     *imageScrollView;
@property(nonatomic,strong)LBB_SpotAddress            *addressInfo;
@property(nonatomic,copy)NSString                             *dateStr;
@property(nonatomic,copy)NSString                             *timeStr;
@property(nonatomic,strong)NSMutableArray              *tagsArray;
@property(nonatomic,strong)TravelNotesDetails          *footprintModel;
@property(nonatomic,strong)NSMutableArray<TravelNotesPics *> *imageUrlArray;
@end

@implementation LBB_AddFootprint_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WHITECOLOR;
    newFoot = YES;
    [self initNav];
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[self.navigationController.navigationBar subviews] objectAtIndex:0].alpha = 1.0;
    [self.navigationController.navigationBar setShadowImage:[UIImage createImageWithColor:[UIColor whiteColor]]];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if(_blockFeedBack)
    {
        self.blockFeedBack(self);
    }
}

- (void)initNav
{
    self.navigationItem.title = @"添加足迹";
    UIBarButtonItem  *rightBrBtn = [[UIBarButtonItem alloc]initWithImage:IMAGE(@"zjmcorfirm") style:0 target:self action:@selector(checkPulish)];
    rightBrBtn.tintColor = UIColorFromRGB(0xAC793B);
    self.navigationItem.rightBarButtonItem = rightBrBtn;
}

- (void)checkPulish
{
    NSLog(@"发布文本");
    [self publishFunc];
}

- (void)initView
{
    _footprintModel = [[TravelNotesDetails alloc]init];
    __weak typeof (self) weakSelf = self;
    _headSegment = [[LBB_Date_SengeMent alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, AUTO(32))];
    _headSegment.dateStr = [self stringFromDate:[NSDate date]];
    _headSegment.timeStr = [self stringFromTime:[NSDate date]];
    _headSegment.blockDatepick = ^(NSInteger tag)
    {
        if(tag == 0)
        {
            NSLog(@"addTime");
            [weakSelf setTime:nil];
        }else{
            NSLog(@"addDate");
            [weakSelf setDate:nil];
        }
    };
    [self.view addSubview:_headSegment];
    
    _imageScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, _headSegment.bottom, DeviceWidth, AUTO(100))];
    _imageScrollView.backgroundColor = WHITECOLOR;
    [self.view addSubview:_imageScrollView];
    
    UIButton  *addImage = [[UIButton alloc]initWithFrame:CGRectMake(AUTO(5), AUTO(5), AUTO(90), AUTO(90))];
    LRViewBorderRadius(addImage, 0, 0.5, LINECOLOR);
    [addImage setImage:IMAGE(@"zjmadd") forState:0];
    [addImage addTarget:self action:@selector(addimageFunc) forControlEvents:UIControlEventTouchUpInside];
    [_imageScrollView addSubview:addImage];
    
    // 修改足迹做的处理
    if(_model)
    {
        NSMutableArray *imageArray = [[NSMutableArray alloc] init];
        for(TravelNotesPics *url in _model.pics)
        {
            UIImage *image = [self getImageFromURL:url.imageUrl];
            [imageArray addObject:image];
        }
        _selectImageArray = imageArray.copy;
    }
    
    for(int i = 0;i < _selectImageArray.count;i++)
    {
        UIImageView  *image = [[UIImageView alloc]initWithFrame:CGRectMake(AUTO(5) + (AUTO(5) + AUTO(90)) * (i), AUTO(5), AUTO(90), AUTO(90))];
        
        CGSize size = image.size;
        size.width *= [UIScreen mainScreen].scale;
        size.height *= [UIScreen mainScreen].scale;
        id obj = self.selectImageArray[i];
        if([obj isKindOfClass:[UIImage class]])
        {
            image.image = obj;//修改足迹
        }else{
            FZJPhotoModel  *model = self.selectImageArray[i];
            [[FZJPhotoTool defaultFZJPhotoTool] getImageByAsset:model.asset makeSize:size makeResizeMode:           PHImageRequestOptionsResizeModeExact completion:^(UIImage *    AssetImage) {
             image.image = AssetImage;
            }];
        }
       
        [_imageScrollView addSubview:image];
        
        addImage.left = image.right + AUTO(5);
        _imageScrollView.contentSize = CGSizeMake(addImage.right + AUTO(5), AUTO(100));
    }
    
    _contentText = [[UITextView alloc]initWithFrame:CGRectMake(0, _imageScrollView.bottom, DeviceWidth, AUTO(100))];
    _contentText.placeholder = @"添加文字";
    [self.view addSubview:_contentText];
    
    addAddres = [[LBB_AddClass_Button alloc]initWithFrame:CGRectMake(0, _contentText.bottom, DeviceWidth, AUTO(35))];
    addAddres.titleStr = @"点击添加地点信息";
    [addAddres addTarget:self action:@selector(addAddressFunc) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addAddres];
    
    addSale = [[LBB_AddClass_Button alloc]initWithFrame:CGRectMake(0, addAddres.bottom + 5, DeviceWidth, AUTO(35))];
    addSale.titleStr = @"添加消费记录";
    [addSale addTarget:self action:@selector(addSaleFunc) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addSale];
    
    UIButton  *publishBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, DeviceHeight - 44 - 64, DeviceWidth, 44)];
    publishBtn.backgroundColor = ColorBtnYellow;
    [publishBtn setTitle:@"发    布" forState:0];
    [publishBtn setTitleColor:WHITECOLOR forState:0];
    publishBtn.titleLabel.font = FONT(AUTO(14.0));
    [publishBtn addTarget:self action:@selector(publishFunc) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:publishBtn];
    
    if(_model)
    {
        _headSegment.dateStr = _model.releaseDate;
        _headSegment.timeStr = _model.releaseTime;
        _contentText.text = _model.picRemark;
        BN_MapView  *mapView = [[BN_MapView alloc]init];
        [mapView setFrame:CGRectMake(0, addAddres.bottom + 5, DeviceWidth, AUTO(100))];
        [mapView andAnnotationLatitude:[_model.dimensionality longLongValue]longitude:[_model.longitude longLongValue]];
        [self.view addSubview:mapView];
        addSale.top = mapView.bottom + 5;
        addSale.titleStr = @"修改消费记录";
        addAddres.titleStr = @"修改地址信息";
        self.navigationItem.title = @"修改足迹";
        
        _footprintModel = _model;
    }

}

- (void)addAddressFunc
{
    NSLog(@"nicai");
    __weak typeof (self) weakSelf = self;
    LBB_AddressAddViewController* dest = [[LBB_AddressAddViewController alloc]init];
    dest.click = ^(LBB_AddressAddViewController* add,LBB_SpotAddress* address){
        _addressInfo = address;
        NSLog(@"详细地址：%@",_addressInfo.address);
        //页面变化代码块
        {
            //地图显示，修改布局
            BN_MapView  *mapView = [[BN_MapView alloc]init];
            [mapView setFrame:CGRectMake(0, addAddres.bottom + 5, DeviceWidth, AUTO(100))];
            [mapView andAnnotationLatitude:[_addressInfo.dimensionality longLongValue]longitude:[_addressInfo.longitude longLongValue]];
            [self.view addSubview:mapView];
             addSale.top = mapView.bottom + 5;
        }
        
        [add.navigationController popViewControllerAnimated:YES];
    };
    [weakSelf.navigationController pushViewController:dest animated:YES];
}

- (void)addSaleFunc
{
    NSLog(@"asdfasf");
    if(_model)
    {
        _footprintModel.billAmount = _model.billAmount;
        _footprintModel.consumptionType = _model.consumptionType;
        _footprintModel.consumptionDesc = _model.consumptionDesc;
    }
    LBB_EditShopRecoder_Controller  *vc = [[LBB_EditShopRecoder_Controller alloc]init];
    vc.footPointNote = _footprintModel;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)publishFunc
{
    if(_model)
    {
        newFoot = NO;
        _footprintModel.travelNotesDetailId = _model.travelNotesDetailId;
        _addressInfo = [[LBB_SpotAddress alloc]init];
        _addressInfo.longy = _model.longitude;
        _addressInfo.dimx = _model.dimensionality;
        _addressInfo.allSpotsId = _model.objId;
    }
    
    if(!_addressInfo)
    {
        [self showHudPrompt:@"请添加地点信息"];
        return;
    }
    [self getImageUrl];
}

- (void)setDate:(NSString *)dateStr
{
    __weak typeof (self) weakSelf = self;
    [ActionSheetDatePicker showPickerWithTitle:NSLocalizedString(@"选择日期", nil)
                                datePickerMode:UIDatePickerModeDate
                                  selectedDate:[NSDate date]
                                     doneBlock:^(ActionSheetDatePicker *picker, id selectedDate, id origin){
                                         NSLog(@"selectedDate =  %@",selectedDate);
                                         weakSelf.headSegment.dateStr = [weakSelf stringFromDate:selectedDate];
                                         _footprintModel.releaseDate = [weakSelf stringFromDate:selectedDate];
                                     }
                                   cancelBlock:^(ActionSheetDatePicker *picker){
                                       
                                   }  origin:self.view];
}

- (void)setTime:(NSString *)dateStr
{
    __weak typeof (self) weakSelf = self;
    [ActionSheetDatePicker showPickerWithTitle:NSLocalizedString(@"选择日期", nil)
                                datePickerMode:UIDatePickerModeTime
                                  selectedDate:[NSDate date]
                                     doneBlock:^(ActionSheetDatePicker *picker, id selectedDate, id origin){
                                         NSLog(@"selectedDate =  %@",selectedDate);
                                         weakSelf.headSegment.timeStr = [weakSelf stringFromTime:selectedDate];
                                         _footprintModel.releaseTime = [weakSelf stringFromTime:selectedDate];
                                     }
                                   cancelBlock:^(ActionSheetDatePicker *picker){
                                       
                                   }  origin:self.view];
}


- (NSString *)stringFromDate:(NSDate *)date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息.
    //[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

- (NSString *)stringFromTime:(NSDate *)date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息.
    //[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

- (void)addimageFunc
{
    [self takePhotoFunc];
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
        
        UIAlertController   *alterView = [UIAlertController alertControllerWithTitle: @"重选照片" message: nil preferredStyle:UIAlertControllerStyleAlert];
        //添加Button
        [alterView addAction: [UIAlertAction actionWithTitle: @"取消" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                return ;
        }]];
        [alterView addAction: [UIAlertAction actionWithTitle: @"确定" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            //处理点击从相册选取
            LBB_SelectImages_ViewController *Vc = [[LBB_SelectImages_ViewController alloc]init];
            Vc.addNum = 5;
            Vc.fatherNum = 2;
            Vc.returnBlock = ^(NSMutableArray *array){
                NSLog(@"图片数组");
                _selectImageArray = array;
                [_imageScrollView removeAllSubviews];
                UIButton  *addImage = [[UIButton alloc]initWithFrame:CGRectMake(AUTO(5), AUTO(5), AUTO(90), AUTO(90))];
                LRViewBorderRadius(addImage, 0, 0.5, LINECOLOR);
                [addImage setImage:IMAGE(@"zjmadd") forState:0];
                [addImage addTarget:self action:@selector(addimageFunc) forControlEvents:UIControlEventTouchUpInside];
                [_imageScrollView addSubview:addImage];
                for(int i = 0;i < _selectImageArray.count;i++)
                {
                    UIImageView  *image = [[UIImageView alloc]initWithFrame:CGRectMake(AUTO(5) + (AUTO(5) + AUTO(90)) * (i), AUTO(5), AUTO(90), AUTO(90))];
                    
                    CGSize size = image.size;
                    size.width *= [UIScreen mainScreen].scale;
                    size.height *= [UIScreen mainScreen].scale;
                    FZJPhotoModel  *model = self.selectImageArray[i];
                    [[FZJPhotoTool defaultFZJPhotoTool] getImageByAsset:model.asset makeSize:size makeResizeMode:           PHImageRequestOptionsResizeModeExact completion:^(UIImage *    AssetImage) {
                        image.image = AssetImage;
                    }];
                    
                    [_imageScrollView addSubview:image];
                    
                    addImage.left = image.right + AUTO(5);
                    _imageScrollView.contentSize = CGSizeMake(addImage.right + AUTO(5), AUTO(100));
                }
                
            };
            Vc._blockJumpControl = ^(UIViewController *obj){
                [weakSelf.navigationController pushViewController:obj animated:YES];
            };
            
            [self.navigationController pushViewController:Vc animated:YES];
        }]];
        [self presentViewController: alterView animated: YES completion: nil];
  
    }]];
    [alterSheet addAction: [UIAlertAction actionWithTitle: @"取消" style: UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController: alterSheet animated: YES completion: nil];
}

#pragma mark -- transCameraImage
- (void)transCameraImage:(UIImage *)image PHAsset:(PHAsset *)imageAsset
{
    NSMutableArray  *imageArray = [[NSMutableArray alloc]initWithArray:_selectImageArray];
    FZJPhotoModel *model = [[FZJPhotoModel alloc]init];
    model.asset = imageAsset;
    [imageArray addObject:model];
    _selectImageArray = [imageArray copy];
    [_imageScrollView removeAllSubviews];
    UIButton  *addImage = [[UIButton alloc]initWithFrame:CGRectMake(AUTO(5), AUTO(5), AUTO(90), AUTO(90))];
    LRViewBorderRadius(addImage, 0, 0.5, LINECOLOR);
    [addImage setImage:IMAGE(@"zjmadd") forState:0];
    [addImage addTarget:self action:@selector(addimageFunc) forControlEvents:UIControlEventTouchUpInside];
    [_imageScrollView addSubview:addImage];
    for(int i = 0;i < _selectImageArray.count;i++)
    {
        UIImageView  *image = [[UIImageView alloc]initWithFrame:CGRectMake(AUTO(5) + (AUTO(5) + AUTO(90)) * (i), AUTO(5), AUTO(90), AUTO(90))];
        
        CGSize size = image.size;
        size.width *= [UIScreen mainScreen].scale;
        size.height *= [UIScreen mainScreen].scale;
        FZJPhotoModel  *model = self.selectImageArray[i];
        [[FZJPhotoTool defaultFZJPhotoTool] getImageByAsset:model.asset makeSize:size makeResizeMode:           PHImageRequestOptionsResizeModeExact completion:^(UIImage *    AssetImage) {
            image.image = AssetImage;
        }];
        
        [_imageScrollView addSubview:image];
        
        addImage.left = image.right + AUTO(5);
        _imageScrollView.contentSize = CGSizeMake(addImage.right + AUTO(5), AUTO(100));
    }
    //满五张之后，隐藏添加图片按钮
    if(_selectImageArray.count >= 5)
    {
        addImage.hidden = YES;
    }

}

- (void)getImageUrl
{
    NSMutableArray *imageArray = [[NSMutableArray alloc] init];
    for (id model in _selectImageArray) {
        if([model isKindOfClass:[UIImage class]])
        {
            [imageArray addObject:model];
        }else{
            [[FZJPhotoTool defaultFZJPhotoTool] getImageByAsset:((FZJPhotoModel *)model).asset makeSize:       PHImageManagerMaximumSize makeResizeMode:               PHImageRequestOptionsResizeModeExact completion:^(UIImage *     AssetImage) {
                [imageArray addObject:AssetImage];
            }];
        }
        
    }
    
    BC_ToolRequest  *request = [BC_ToolRequest sharedManager];
    [request uploadfile:imageArray block:^(NSArray *files, NSError *error) {
        NSLog(@"%@",files);
        if(!_imageUrlArray)
        {
            _imageUrlArray = [[NSMutableArray alloc]init];
        }
        __weak typeof (_imageUrlArray) weakImageUrlArray = _imageUrlArray;
        [files enumerateObjectsUsingBlock:^(NSString  * obj, NSUInteger idx, BOOL * _Nonnull stop) {
            TravelNotesPics *model = [[TravelNotesPics  alloc]init];
            model.imageUrl = obj;
            model.picId = obj.longLongValue;
            [weakImageUrlArray addObject:model];
            
            _footprintModel.picRemark = _contentText.text;
            _footprintModel.releaseTime = _headSegment.timeStr;
            _footprintModel.releaseDate = _headSegment.dateStr;
            _footprintModel.name = @"";
            _footprintModel.picUrl = @"";
            if(_footprintModel.consumptionDesc .length == 0)
                _footprintModel.consumptionDesc = @"";
            _footprintModel.pics = _imageUrlArray;
            
            [_footprintModel saveTravelTrackData:newFoot travelNoteId:_dataModel.travelDraftModel.travelNotesId  address:_addressInfo block:^(NSError *error) {
                if(!error)
                {
                    [self.navigationController popViewControllerAnimated:YES];
                }
                NSLog(@"error=%@",error);
            }];
            
        }];
    }];

}

#pragma maek -- 下载图片
-(UIImage *) getImageFromURL:(NSString *)fileURL {
    
    NSLog(@"执行图片下载函数");
    UIImage * result;
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];

    return result;
    
}

@end
