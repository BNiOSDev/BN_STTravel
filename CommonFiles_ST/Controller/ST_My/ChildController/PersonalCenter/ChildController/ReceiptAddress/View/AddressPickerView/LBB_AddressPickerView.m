//
//  LBB_AddressPickerView.m
//  ST_Travel
//
//  Created by 晨曦 on 16/10/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_AddressPickerView.h"
#import <ActionSheetCustomPicker.h>
#import <MJExtension.h>

@interface LBB_AddressPickerView()<ActionSheetCustomPickerDelegate>

@property (nonatomic,strong) NSMutableArray<SJR_Area*> *provinceArr; // 省
@property (nonatomic,strong) NSMutableArray<SJR_Area*> *countryArr; // 市
@property (nonatomic,strong) NSMutableArray<SJR_Area*> *districtArr; // 区
@property (nonatomic,assign) NSInteger index1; // 省下标
@property (nonatomic,assign) NSInteger index2; // 市下标
@property (nonatomic,assign) NSInteger index3; // 区下标
@property (nonatomic,strong) ActionSheetCustomPicker *picker; // 选择器
@property (weak, nonatomic) IBOutlet UILabel *detailAddress; // 具体地址
@property (weak, nonatomic) UIView *parentView;
@property (copy, nonatomic) NSString *title;
@property (assign, nonatomic) BOOL showStreet;
@property (nonatomic,strong) NSMutableArray *sectionArray;
@property (nonatomic,assign) BOOL isShowing;

@property (nonatomic,strong) SJR_Area *province;
@property (nonatomic,strong) SJR_Area *city;
@property (nonatomic,strong) SJR_Area *street;

@end

@implementation LBB_AddressPickerView

- (instancetype)initWithTitle:(NSString *)title
             showCancelButton:(BOOL)showCancelButton
                   parentView:(UIView *)parentView
                   showStreet:(BOOL)isShowStreet
{
    self = [super init];
    if (self) {
        self.isShowing = NO;
        [self calculateFirstData];
        self.parentView = parentView;
        self.title = title;
        self.showStreet = isShowStreet;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)dealloc
{
    self.picker = nil;
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
    self.isShowing = YES;
    [self.picker showActionSheetPicker];
}

// 根据传进来的下标数组计算对应的三个数组
- (void)calculateFirstData
{
    if (!self.sectionArray) {
        self.sectionArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    // 拿出省的数组
    [self loadConfigData:^{
        if (self.provinceArr.count) {
            self.province = self.provinceArr[0];
        }
        [self getCountryArrWithprovinceIndex:0 completeBlock:^{
            self.city = self.countryArr[0];
            if (self.showStreet) {
                [self getDistrictArrWithCountryIndex:0 completeBlock:^{
                    self.street = self.districtArr[0];
                    [self showPickerView];
                }];
            }else {
                [self showPickerView];
            }
        }];
    }];
}

- (void)loadConfigData:(void (^)(void))completeBlock
{
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
    
    __weak typeof (self) weakSelf = self;
    if (!self.provinceArr) {
        self.provinceArr = [[NSMutableArray alloc] init];
    }
    [self.provinceArr removeAllObjects];
    [self removeSectionKey:@"0"];
    
    SJR_AreaRequest *request = [BN_DataManagement requestAreaPID:0];
    [request dataRequestReadEvents:GL_dataRequestFirstReadLocal dataBlock:^(NSError *error, NSArray *data) {
        [weakSelf.provinceArr addObjectsFromArray:data];
        [self.sectionArray addObject:@{@"0":@"1"}];
         NSLog(@"\n === 省 = %@个",@(self.provinceArr.count));
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completeBlock) {
                completeBlock();
            }
        });
    }];
}

- (void)removeSectionKey:(NSString*)keyValue
{
    for (int i = 0; i < self.sectionArray.count; i++) {
        NSDictionary *dict = [self.sectionArray objectAtIndex:i];
        if ([dict objectForKey:keyValue]){
            [self.sectionArray removeObject:dict];
            return;
        }
    }
}

- (void)getCountryArrWithprovinceIndex:(NSInteger)index completeBlock:(void (^)(void))completeBlock
{
    if (self.provinceArr.count > index) {
        SJR_Area *obj = [self.provinceArr objectAtIndex:index];
        if (!self.countryArr) {
            self.countryArr = [[NSMutableArray alloc] init];
        }
        [self.countryArr removeAllObjects];
        [self.sectionArray removeObject:@"1"];
        __weak typeof (self) weakSelf = self;
        [obj getNextLevelArrayBlock:^(NSError *error, NSArray *data){
            NSLog(@"\n === 市 = %@个",@(weakSelf.countryArr.count));
            [weakSelf.countryArr addObjectsFromArray:data];
            [self.sectionArray addObject:@{@"1":@"1"}];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (completeBlock) {
                    completeBlock();
                }
            });
        }];
    }
}

- (void)getDistrictArrWithCountryIndex:(NSInteger)index completeBlock:(void (^)(void))completeBlock
{
    if (self.countryArr.count > index) {
        SJR_Area *obj = [self.countryArr objectAtIndex:index];
        if (!self.districtArr) {
            self.districtArr = [[NSMutableArray alloc] init];
        }
        [self.districtArr removeAllObjects];
        [self.sectionArray removeObject:@"2"];
        __weak typeof (self) weakSelf = self;
        [obj getNextLevelArrayBlock:^(NSError *error, NSArray *data){
            NSLog(@"\n === 市 = %@个",@(weakSelf.districtArr.count));
            [weakSelf.districtArr addObjectsFromArray:data];
            [self.sectionArray addObject:@{@"2":@"1"}];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (completeBlock) {
                    completeBlock();
                }
            });
        }];
    }
}

#pragma mark - UIPickerViewDataSource Implementation
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.sectionArray.count;
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

- (NSString *)rowAreaTitle:(SJR_Area*)area
{
    if (area) {
       return area.NAME;
    }
    return @"";
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (component)
    {
        case 0:
        {
            if (row < self.provinceArr.count) {
                return [self rowAreaTitle:self.provinceArr[row]];
            }
        } break;
            
        case 1:
        {
            if (row < self.countryArr.count) {
               return  [self rowAreaTitle:self.countryArr[row]];
            }
        } break;
            
        case 2:
        {
            if (row < self.districtArr.count) {
                return  [self rowAreaTitle:self.districtArr[row]];
            }
        }
          
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
        case 0:
        {
            if (row < self.provinceArr.count) {
                title = [self rowAreaTitle:self.provinceArr[row]];
            }
        } break;
            
        case 1:
        {
            if (row < self.countryArr.count) {
                title =  [self rowAreaTitle:self.countryArr[row]];
            }
        } break;
            
        case 2:
        {
            if (row < self.districtArr.count) {
                title =  [self rowAreaTitle:self.districtArr[row]];
            }
        }
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
            self.province = self.provinceArr[row];
             // 滚动的时候都要进行一次数组的刷新
            [self getCountryArrWithprovinceIndex:row completeBlock:^{
                [pickerView reloadComponent:1];
                [pickerView selectRow:0 inComponent:1 animated:YES];
                if (self.countryArr.count > 0) {
                    self.city = self.countryArr[0];
                }
                if(self.showStreet) {
                    [self getDistrictArrWithCountryIndex:0 completeBlock:^{
                        [pickerView reloadComponent:2];
                        [pickerView selectRow:0 inComponent:2 animated:YES];
                        if (self.districtArr.count > 0) {
                            self.street = self.districtArr[0];
                        }
                    }];
                }
            }];
        }
            break;
            
        case 1:
        {
            self.index2 = row;
            self.index3 = 0;
            self.city = self.countryArr[row];
            if(self.showStreet) {
                [self getDistrictArrWithCountryIndex:row completeBlock:^{
                    [pickerView reloadComponent:2];
                    [pickerView selectRow:0 inComponent:2 animated:YES];
                    self.street = self.districtArr[0];
                }];
            }
        }
            break;
        case 2:
            self.index3 = row;
            self.street = self.districtArr[0];
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
    if(self.myBlock) {
      self.myBlock(self.province,self.city,self.street);
    }
}


@end
