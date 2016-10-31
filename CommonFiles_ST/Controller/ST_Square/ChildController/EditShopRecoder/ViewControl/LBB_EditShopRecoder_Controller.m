//
//  LBB_EditShopRecoder_Controller.m
//  ST_Travel
//
//  Created by dawei che on 2016/10/29.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_EditShopRecoder_Controller.h"
#import "Header.h"
#import "LBB_ShopCatgory_View.h"
#import "LBB_AddressTipView.h"

@interface LBB_EditShopRecoder_Controller ()
{
    UIView *cateGoryView;
}
@property(nonatomic,weak)UITextField    *shopText;
@property(nonatomic,weak)UITextField    *shopMoney;
@property(nonatomic,strong)NSArray       *cateArray;
@end

@implementation LBB_EditShopRecoder_Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _cateArray = @[@{@"image":@"zjmtravelhouseed",@"title":@"名宿",@"selectImage":@"zjmtravelhouse"},@{@"image":@"zjmtranported",@"title":@"交通",@"selectImage":@"zjmtranpord"},@{@"image":@"zjmhaochideed",@"title":@"美食",@"selectImage":@"zjmhaochide"},@{@"image":@"zjmmenpiaoed",@"title":@"门票",@"selectImage":@"zjmmenpiao"},@{@"image":@"zjmyuleed",@"title":@"娱乐",@"selectImage":@"zjmyule"},@{@"image":@"zjmshoped",@"title":@"购物",@"selectImage":@"zjmshoping"},@{@"image":@"zjmothered",@"title":@"其他",@"selectImage":@"zjmother"}] ;
    self.view.backgroundColor = WHITECOLOR;
    [self initView];
}

- (void)initView
{
    UIView *choseCategory = [self getLable:@"选择消费类型"];
    [self.view addSubview:choseCategory];
    
    cateGoryView = [self getCateGroyView];
    cateGoryView.top = choseCategory.bottom;
    [self.view addSubview:cateGoryView];
    
    UIView *shopDetail = [self getLable:@"消费明细"];
    shopDetail.top = cateGoryView.bottom;
    [self.view addSubview:shopDetail];
    
    [self.view addSubview:self.shopText];
     self.shopText.top = shopDetail.bottom;
    
    UIView *shopMoney = [self getLable:@"消费金额"];
    shopMoney.top = self.shopText.bottom;
    [self.view addSubview:shopMoney];
    
    [self.view addSubview:self.shopMoney];
     self.shopMoney.top = shopMoney.bottom;
    
    UIButton    *sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, self.shopMoney.bottom + AUTO(50), DeviceWidth - 40, AUTO(50))];
    sureBtn.backgroundColor = ColorBtnYellow;
    sureBtn.titleLabel.font = FONT(AUTO(14.0));
    [sureBtn setTitle:@"确定" forState:0];
    [sureBtn setTitleColor:WHITECOLOR forState:0];
    [self.view addSubview:sureBtn];
}
- (UITextField *)shopText
{
    if(!_shopText)
    {
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth,AUTO(45))];
        textField.font = FONT(AUTO(13.0));
        textField.textColor = MORELESSBLACKCOLOR;
        textField.leftViewMode = UITextFieldViewModeAlways;
        textField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 15, AUTO(45))];
        textField.placeholder = @"请输入消费明细";
         LRViewBorderRadius(textField, 0, 1, LINECOLOR);
        _shopText = textField;
        return textField;
    }
    return _shopText;
}

- (UITextField *)shopMoney
{
    if(!_shopMoney)
    {
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth,AUTO(45))];
        textField.font = FONT(AUTO(13.0));
        textField.textColor = MORELESSBLACKCOLOR;
        textField.leftViewMode = UITextFieldViewModeAlways;
        textField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 15, AUTO(45))];
        textField.placeholder = @"请输入消费金额";
         LRViewBorderRadius(textField, 0, 1, LINECOLOR);
        _shopMoney = textField;
        return textField;
    }
    return _shopMoney;
}

- (UIView *)getLable:(NSString *)title
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, AUTO(35))];
    view.backgroundColor = WHITECOLOR;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, DeviceWidth, view.height)];
    label.textColor = BLACKCOLOR;
    label.font = FONT(AUTO(13.0));
    label.text = title;
    [view addSubview:label];
    return view;
}

- (UIView *)getCateGroyView
{
    UIView  *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, AUTO(75))];
    view.layer.borderWidth = 1.0;
    view.layer.borderColor = LINECOLOR.CGColor;
    CGFloat  marginX = 10;
    CGFloat marginY = 8;
    CGFloat  width = (DeviceWidth - AUTO(50) - 30) / 4.0;
    CGFloat  height = AUTO(20);
    for(int i = 0;i < 7;i++)
    {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(AUTO(25) + (marginX + width)*(i % 4), marginY + (marginY + height) * (i / 4), width, height)];
        LRViewBorderRadius(btn, 5, 1, [UIColor clearColor]);
        btn.backgroundColor = LINECOLOR;
        btn.titleLabel.font = FONT(AUTO(11.0));
        [btn setTitle:_cateArray[i][@"title"] forState:0];
        [btn setImage:IMAGE(_cateArray[i][@"selectImage"]) forState:0];
        [btn setTitleColor:MORELESSBLACKCOLOR forState:0];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, -AUTO(7.5), 0, 0)];
        btn.tag = i;
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, AUTO(7.5), 0, 0)];
        [view addSubview:btn];
        view.height = btn.bottom + marginY;
        [btn addTarget:self action:@selector(btnFunc:) forControlEvents:UIControlEventTouchUpInside];
    }
    return view;
}

- (void)btnFunc:(UIButton *)btn
{
    [btn setImage:IMAGE(_cateArray[btn.tag][@"image"]) forState:0];
    [btn setTitleColor:ColorBtnYellow forState:0];
    btn.backgroundColor = UIColorFromRGB(0xFBF8F1);
    btn.layer.borderColor = ColorBtnYellow.CGColor;
    for(UIButton *view in cateGoryView.subviews)
    {
        if(view != btn)
        {
            [view setImage:IMAGE(_cateArray[view.tag][@"selectImage"]) forState:0];
            [view setTitleColor:MORELESSBLACKCOLOR forState:0];
            view.backgroundColor = LINECOLOR;
            view.layer.borderColor = [UIColor clearColor].CGColor;
        }
    }
}

@end
