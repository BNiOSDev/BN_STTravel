//
//  LBB_AddressPickerView.m
//  ST_Travel
//
//  Created by dhxiang on 16/10/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_AddressPickerView.h"
#import <ActionSheetCustomPicker.h>
#import <MJExtension.h>

@interface LBB_AddressPickerView()<ActionSheetCustomPickerDelegate>
@property (nonatomic,strong) NSArray *addressArr; // 解析出来的最外层数组
@property (nonatomic,strong) NSArray *provinceArr; // 省
@property (nonatomic,strong) NSArray *countryArr; // 市
@property (nonatomic,strong) NSArray *districtArr; // 区
@property (nonatomic,assign) NSInteger index1; // 省下标
@property (nonatomic,assign) NSInteger index2; // 市下标
@property (nonatomic,assign) NSInteger index3; // 区下标
@property (nonatomic,strong) ActionSheetCustomPicker *picker; // 选择器
@property (weak, nonatomic) IBOutlet UILabel *detailAddress; // 具体地址
@property (weak, nonatomic) UIView *parentView;
@property (copy, nonatomic) NSString *title;
@property (assign, nonatomic) BOOL showStreet;
@end

@implementation LBB_AddressPickerView

- (instancetype)initWithTitle:(NSString *)title
             showCancelButton:(BOOL)showCancelButton
                   parentView:(UIView *)parentView
                   showStreet:(BOOL)isShowStreet
{
    self = [super init];
    if (self) {
        [self calculateFirstData];
        self.parentView = parentView;
        self.title = title;
        self.showStreet = isShowStreet;
    }
    return self;
}

- (void)loadConfigData
{
    self.backgroundColor = [UIColor clearColor];
    if (self.pushAddress) {
        self.detailAddress.text = self.pushAddress;
    }
    if (!self.selections) {
        self.selections = [[NSArray alloc] init];
    }
    if (self.selections.count) {
        self.index1 = [self.selections[0] integerValue];
        self.index2 = [self.selections[1] integerValue];
        self.index3 = [self.selections[2] integerValue];
    }

    // 注意JSON后缀的东西和Plist不同，Plist可以直接通过contentOfFile抓取，Json要先打成字符串，然后用工具转换
    NSString *path = [[NSBundle mainBundle] pathForResource:@"address" ofType:@"json"];
    NSLog(@"%@",path);
    NSString *jsonStr = [NSString stringWithContentsOfFile:path usedEncoding:nil error:nil];
    self.addressArr = [jsonStr mj_JSONObject];
    
    NSMutableArray *firstName = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in self.addressArr)
    {
        NSString *name = dict.allKeys.firstObject;
        [firstName addObject:name];
    }
    // 第一层是省份 分解出整个省份数组
    self.provinceArr = firstName;
}

- (void)showPickerView
{
    // 点击的时候传三个index进去
    if (self.showStreet) {
        self.picker = [[ActionSheetCustomPicker alloc] initWithTitle:self.title
                                                            delegate:self
                                                    showCancelButton:YES
                                                              origin:self.parentView
                                                   initialSelections:@[@(self.index1),@(self.index2),@(self.index2)]];

    }else {
        self.picker = [[ActionSheetCustomPicker alloc] initWithTitle:self.title
                                                            delegate:self
                                                    showCancelButton:YES
                                                              origin:self.parentView
                                                   initialSelections:@[@(self.index1),@(self.index2)]];

    }
    self.picker.tapDismissAction  = TapActionSuccess;
    [self.picker showActionSheetPicker];
}

// 根据传进来的下标数组计算对应的三个数组
- (void)calculateFirstData
{
    // 拿出省的数组
    [self loadConfigData];
    
    NSMutableArray *cityNameArr = [[NSMutableArray alloc] init];
    // 根据省的index1，默认是0，拿出对应省下面的市
    for (NSDictionary *cityName in [self.addressArr[self.index1] allValues].firstObject) {
        
        NSString *name1 = cityName.allKeys.firstObject;
        [cityNameArr addObject:name1];
    }
    // 组装对应省下面的市
    self.countryArr = cityNameArr;
    //   index1对应省的字典  市的数组 index2市的字典   对应市的数组
    // 这里的allValue是取出来的大数组，取第0个就是需要的内容
    self.districtArr = [[self.addressArr[self.index1] allValues][0][self.index2] allValues][0];
}

#pragma mark - UIPickerViewDataSource Implementation
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (self.showStreet) {
        return 3;
    }
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    // Returns
    switch (component)
    {
        case 0: return self.provinceArr.count;
        case 1: return self.countryArr.count;
        case 2:return self.districtArr.count;
        default:break;
    }
    return 0;
}
#pragma mark UIPickerViewDelegate Implementation


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (component)
    {
        case 0: return self.provinceArr[row];break;
        case 1: return self.countryArr[row];break;
        case 2:return self.districtArr[row];break;
        default:break;
    }
    return nil;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel* label = (UILabel*)view;
    if (!label)
    {
        label = [[UILabel alloc] init];
        [label setFont:[UIFont systemFontOfSize:14]];
    }
    
    NSString * title = @"";
    switch (component)
    {
        case 0: title =   self.provinceArr[row];break;
        case 1: title =   self.countryArr[row];break;
        case 2: title =   self.districtArr[row];break;
        default:break;
    }
    label.textAlignment = NSTextAlignmentCenter;
    label.text=title;
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (component)
    {
        case 0:
        {
            self.index1 = row;
            self.index2 = 0;
            self.index3 = 0;
            
            // 滚动的时候都要进行一次数组的刷新
            [self calculateFirstData];
            [pickerView reloadComponent:1];
            [pickerView selectRow:0 inComponent:1 animated:YES];
            if(self.showStreet) {
                [pickerView reloadComponent:2];
                [pickerView selectRow:0 inComponent:2 animated:YES];
            }
            
        }
            break;
            
        case 1:
        {
            self.index2 = row;
            self.index3 = 0;
            [self calculateFirstData];
            if(self.showStreet) {
                [pickerView selectRow:0 inComponent:2 animated:YES];
                [pickerView reloadComponent:2];
            }
        }
            break;
        case 2:
            self.index3 = row;
            break;
        default:break;
    }
}

- (void)configurePickerView:(UIPickerView *)pickerView
{
    pickerView.showsSelectionIndicator = NO;
}

// 点击done的时候回调
- (void)actionSheetPickerDidSucceed:(ActionSheetCustomPicker *)actionSheetPicker origin:(id)origin
{
    NSMutableString *detailAddress = [[NSMutableString alloc] init];
    if (self.index1 < self.provinceArr.count) {
        NSString *firstAddress = self.provinceArr[self.index1];
        [detailAddress appendString:firstAddress];
    }
    if (self.index2 < self.countryArr.count) {
        NSString *secondAddress = self.countryArr[self.index2];
        [detailAddress appendString:secondAddress];
    }
    if (self.showStreet) {
        if (self.index3 < self.districtArr.count) {
            NSString *thirfAddress = self.districtArr[self.index3];
            [detailAddress appendString:thirfAddress];
        }
    }
    // 此界面显示
    self.detailAddress.text = detailAddress;
    // 回调到上一个界面
    if(self.myBlock) {
      self.myBlock(detailAddress,@[@(self.index1),@(self.index2),@(self.index3)]);
    }
}


- (NSArray *)provinceArr
{
    if (_provinceArr == nil) {
        _provinceArr = [[NSArray alloc] init];
    }
    return _provinceArr;
}

-(NSArray *)countryArr
{
    if(_countryArr == nil)
    {
        _countryArr = [[NSArray alloc] init];
    }
    return _countryArr;
}

- (NSArray *)districtArr
{
    if (_districtArr == nil) {
        _districtArr = [[NSArray alloc] init];
    }
    return _districtArr;
}

-(NSArray *)addressArr
{
    if (_addressArr == nil) {
        _addressArr = [[NSArray alloc] init];
    }
    return _addressArr;
}


@end
