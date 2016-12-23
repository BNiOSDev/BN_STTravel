//
//  LBB_AddTextToVistNote_Controller.m
//  ST_Travel
//
//  Created by dawei che on 2016/11/29.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_AddTextToVistNote_Controller.h"
#import "Header.h"
#import "LBB_Date_SengeMent.h"
#import "LBB_AddClass_Button.h"
#import "ActionSheetDatePicker.h"
#import "UITextView+Placeholder.h"
#import "LBB_AddressAddViewController.h"
#import "LBB_SpotAddress.h"
#import "LBB_EditShopRecoder_Controller.h"
#import "LBB_SelectTip_History_ViewController.h"
#import "LBB_TagsViewModel.h"
#import "BN_SquareTravelNotesModel.h"

@interface LBB_AddTextToVistNote_Controller ()
{
    LBB_AddClass_Button  *addAddres;
    LBB_AddClass_Button  *addSale;
}
@property(nonatomic,strong)LBB_Date_SengeMent    *headSegment;
@property(nonatomic,strong)UITextView                       *contentText;
@property(nonatomic,strong)LBB_SpotAddress            *addressInfo;
@property(nonatomic,copy)NSString                             *dateStr;
@property(nonatomic,copy)NSString                             *timeStr;
@property(nonatomic,strong)NSMutableArray              *tagsArray;
@property(nonatomic,strong)TravelNotesDetails          *footprintModel;
@end

@implementation LBB_AddTextToVistNote_Controller

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = WHITECOLOR;
    
    _footprintModel = [[TravelNotesDetails alloc]init];
    
    [self initNav];
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[self.navigationController.navigationBar subviews] objectAtIndex:0].alpha = 1.0;
    [self.navigationController.navigationBar setShadowImage:[UIImage createImageWithColor:[UIColor whiteColor]]];

}

- (void)initNav
{
    self.navigationItem.title = @"添加足迹";
    UIBarButtonItem  *rightBrBtn = [[UIBarButtonItem alloc]initWithImage:IMAGE(@"zjmcorfirm") style:0 target:self action:@selector(checkPulish)];
    rightBrBtn.tintColor = UIColorFromRGB(0xAC793B);
    self.navigationItem.rightBarButtonItem = rightBrBtn;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if(_blockFeedBack)
    {
        self.blockFeedBack(self);
    }
}

- (void)leftButtonClick
{
    if(_blockFeedBack)
    {
        self.blockFeedBack(self);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)checkPulish
{
    NSLog(@"发布文本");
}

- (void)initView
{
//    LBB_AddClass_Button  *addTags = [[LBB_AddClass_Button alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, AUTO(35))];
//    addTags.titleStr = @"添加标签";
//    [addTags addTarget:self action:@selector(addTagsFunc) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:addTags];
    
    __weak typeof (self) weakSelf = self;
    _headSegment = [[LBB_Date_SengeMent alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, AUTO(32))];
    _headSegment.dateStr = [self stringFromDate:[NSDate date]];
    _headSegment.timeStr = [self stringFromTime:[NSDate date]];
    _footprintModel.releaseTime = _headSegment.timeStr;
    _footprintModel.releaseDate = _headSegment.dateStr;
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
    
    _contentText = [[UITextView alloc]initWithFrame:CGRectMake(0, _headSegment.bottom, DeviceWidth, AUTO(100))];
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
    }
}

- (void)addTagsFunc
{
    NSLog(@"nicai");
    if(_tagsArray.count >= 3)
    {
        [self showHudPrompt:@"最多添加三个标签"];
        return;
    }
    LBB_SelectTip_History_ViewController  *vc = [[LBB_SelectTip_History_ViewController alloc]init];
    vc.transTags = ^(id object){
        if(!_tagsArray)
        {
            _tagsArray = [[NSMutableArray alloc]init];
        }
        [_tagsArray addObject:object];
    };
    [self.navigationController pushViewController:vc animated:YES];
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
    NSLog(@"publishFunc");
    BOOL  newFoot = YES;//是否新发布
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
    _footprintModel.picRemark = _contentText.text;
    _footprintModel.name = @"";
    _footprintModel.picUrl = @"";
    if(_footprintModel.consumptionDesc.length == 0)
        _footprintModel.consumptionDesc = @"";
    _footprintModel.pics = @[];

    [_footprintModel saveTravelTrackData:newFoot travelNoteId:_dataModel.travelDraftModel.travelNotesId  address:_addressInfo block:^(NSError *error) {
        if(!error)
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
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

@end
