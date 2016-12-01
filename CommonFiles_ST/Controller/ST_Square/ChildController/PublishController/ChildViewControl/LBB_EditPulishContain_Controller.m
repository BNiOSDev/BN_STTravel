//
//  LBB_EditPulishContain_Controller.m
//  ST_Travel
//
//  Created by dawei che on 2016/11/20.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_EditPulishContain_Controller.h"
#import "UITextView+Placeholder.h"
#import "LBB_AddressAddViewController.h"
#import "LBB_SpotAddress.h"
#import "LBB_ZJMPhotoList.h"
#import "FZJPhotoModel.h"

@interface LBB_EditPulishContain_Controller ()
@property(nonatomic,strong)UIScrollView   *backView;
@property(nonatomic,strong)UITextView     *vistHead;
@property(nonatomic,strong)UIButton         *pulishBtn;
@property(nonatomic,strong)NSMutableArray   *mapViewArray;
@property(nonatomic,strong)LBB_SpotAddress *addressInfo;
@end

@implementation LBB_EditPulishContain_Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"发布内容";
    self.view.backgroundColor = WHITECOLOR;
    [self initView];
}

- (void)initView
{
    [self.view addSubview:self.backView];
    
    _mapViewArray = [[NSMutableArray alloc]init];
    _imageContainView = [[LBB_Pulish_ImageContain_View alloc]initWithFrame:CGRectMake(AUTO(5), 5, DeviceWidth - AUTO(10), DeviceWidth - AUTO(20))];
    _imageContainView.imageArray = _imageArray;
    [self.view addSubview:_imageContainView];
    
    [self.backView addSubview:_imageContainView];
   
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, _imageContainView.bottom + 5, DeviceWidth, 1.0)];
    line.backgroundColor = LINECOLOR;
    [self.backView addSubview:line];
    
    _vistHead = [[UITextView alloc]initWithFrame:CGRectMake(0, line.bottom, DeviceWidth, AUTO(90))];
    _vistHead.placeholder = @"添加文字";
    _vistHead.placeholderColor = MORELESSBLACKCOLOR;
    [self.backView addSubview:_vistHead];
    
    UILabel *line1 = [[UILabel alloc]initWithFrame:CGRectMake(0, _vistHead.bottom, DeviceWidth, 1.0)];
    line1.backgroundColor = LINECOLOR;
    [self.backView addSubview:line1];
    
    UIButton *addAddress = [[UIButton alloc]initWithFrame:CGRectMake(0, line1.bottom, DeviceWidth, AUTO(30))];
    [addAddress setTitle:@"点击添加地点信息" forState:0];
    [addAddress setImage:IMAGE(@"zjmadd") forState:0];
    [addAddress setTitleColor:BLACKCOLOR forState:0];
    addAddress.titleLabel.font = FONT(AUTO(12.0));
    [addAddress addTarget:self action:@selector(addMap:) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:addAddress];
    
    UILabel *line2 = [[UILabel alloc]initWithFrame:CGRectMake(0, addAddress.bottom, DeviceWidth, 1.0)];
    line2.backgroundColor = LINECOLOR;
    [self.backView addSubview:line2];

    _pulishBtn = [[UIButton alloc]initWithFrame:CGRectMake(AUTO(25), line2.bottom + AUTO(50), DeviceWidth - AUTO(50), AUTO(40))];
    [_pulishBtn setTitle:@"发        布" forState:0];
    [_pulishBtn setTitleColor:WHITECOLOR forState:0];
    _pulishBtn.titleLabel.font = FONT(AUTO(13.0));
    _pulishBtn.backgroundColor = ColorBtnYellow;
    [_pulishBtn addTarget:self action:@selector(publishFunc) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:_pulishBtn];
}

- (UIScrollView *)backView
{
    if(!_backView)
    {
        UIScrollView *backView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight - 64)];
        backView.contentSize = CGSizeMake(DeviceWidth, DeviceHeight);
        _backView = backView;
    }
    return _backView;
}

- (void)addMap:(UIView *)btn
{
    __weak typeof (self) weakSelf = self;
    LBB_AddressAddViewController* dest = [[LBB_AddressAddViewController alloc]init];
    dest.click = ^(LBB_AddressAddViewController* add,LBB_SpotAddress* address){
        //   [text setText:[NSString stringWithFormat:@"%ld",[index integerValue]]];
        // [ws.dataArray addObject:index];//回调回来数据
        _addressInfo = address;
        NSLog(@"详细地址：%@",_addressInfo.address);
        
        //页面变化代码块
        {
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, btn.bottom + AUTO(5), DeviceWidth, AUTO(100))];
            view.backgroundColor = ColorRed;
            [_mapViewArray addObject:view];
            [self.backView addSubview:view];
            
            _pulishBtn.bottom = view.bottom + AUTO(50);
            self.backView.contentSize = CGSizeMake(DeviceWidth, _pulishBtn.bottom+ 25);
        }
        
        
        [add.navigationController popViewControllerAnimated:YES];
    };
    [weakSelf.navigationController pushViewController:dest animated:YES];

}

- (void)publishFunc
{
   __block NSArray *imageUrlArray;
    NSMutableArray *imageArray = [[NSMutableArray alloc] init];
    for (FZJPhotoModel *model in _imageArray) {
        [[FZJPhotoTool defaultFZJPhotoTool] getImageByAsset:model.asset makeSize:PHImageManagerMaximumSize makeResizeMode:           PHImageRequestOptionsResizeModeExact completion:^(UIImage *    AssetImage) {
            [imageArray addObject:AssetImage];
        }];

    }
    BC_ToolRequest  *request = [BC_ToolRequest sharedManager];
    [request uploadfile:imageArray block:^(NSArray *files, NSError *error) {
        imageUrlArray = files;
        NSLog(@"获取的url个数：%ld",imageUrlArray.count);
    }];
}

@end
