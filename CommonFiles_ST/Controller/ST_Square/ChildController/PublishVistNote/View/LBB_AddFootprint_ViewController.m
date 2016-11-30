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

@interface LBB_AddFootprint_ViewController ()<TransImageDelegate>
@property(nonatomic,strong)LBB_Date_SengeMent    *headSegment;
@property(nonatomic,strong)UITextView                       *contentText;
@property(nonatomic,strong)UIScrollView                     *imageScrollView;
@end

@implementation LBB_AddFootprint_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WHITECOLOR;
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

- (void)checkPulish
{
    NSLog(@"发布文本");
}

- (void)initView
{
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
    
    _contentText = [[UITextView alloc]initWithFrame:CGRectMake(0, _imageScrollView.bottom, DeviceWidth, AUTO(100))];
    _contentText.placeholder = @"添加文字";
    [self.view addSubview:_contentText];
    
    LBB_AddClass_Button  *addAddres = [[LBB_AddClass_Button alloc]initWithFrame:CGRectMake(0, _contentText.bottom, DeviceWidth, AUTO(35))];
    addAddres.titleStr = @"点击添加地点信息";
    [addAddres addTarget:self action:@selector(addAddressFunc) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addAddres];
    
    UIView  *mapView = [[UIView alloc]initWithFrame:CGRectMake(0, addAddres.bottom + 5, DeviceWidth, AUTO(100))];
    mapView.backgroundColor = [UIColor redColor];
    [self.view addSubview:mapView];
    
    LBB_AddClass_Button  *addSale = [[LBB_AddClass_Button alloc]initWithFrame:CGRectMake(0, mapView.bottom + 5, DeviceWidth, AUTO(35))];
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
}

- (void)addAddressFunc
{
    NSLog(@"nicai");
}

- (void)addSaleFunc
{
    NSLog(@"asdfasf");
}

- (void)publishFunc
{
    NSLog(@"publishFunc");
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

}

@end
