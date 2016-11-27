//
//  PersonalCenterViewController.m
//  LUBABA
//
//  Created by 晨曦 on 16/10/13.
//  Copyright © 2016年 晨曦. All rights reserved.
//

#import "PersonalCenterViewController.h"
#import "PersonalInfoCell.h"
#import "LBB_AddressPickerView.h"
#import "ActionSheetDatePicker.h"
#import "LBB_ImagePickerViewController.h"
#import "LBB_LoginViewController.h"
#import "VerificationViewController.h"
#import "LBB_LoginManager.h"
#import "ChangePasswordViewController.h"
#import "LBB_PersonalModel.h"
#import "LBB_UserNameViewController.h"

typedef NS_ENUM(NSInteger,PersonalInfoType) {
    eUserHead = 1000,//头像
    ePhoneNum, //手机号
    eSex, //性别
    eBirthDate,//出生日期
    eCity,//所在城市
    ePassword //修改密码
};

@interface PersonalCenterViewController ()
<UITableViewDelegate,
UITableViewDataSource
>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *dataSourceArray;
@property (strong, nonatomic) LBB_AddressPickerView *addressPicker;
@property (strong, nonatomic) ActionSheetDatePicker *datePicker;
@property (strong, nonatomic) UIView *exitLoginView;
@property (nonatomic,strong) LBB_ImagePickerViewController *imagePicker;
@property (nonatomic,strong) LBB_PersonalModel *personalModel;
@end

@implementation PersonalCenterViewController

- (void)dealloc
{
    self.personalModel = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.baseViewType = ePersonalCenter;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.personalModel getPersonInfo];
}

#pragma mark - private

- (void)buildControls
{
    UINib *nib = [UINib nibWithNibName:@"PersonalInfoCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"PersonalInfoCell"];
    
    self.personalModel = [[LBB_PersonalModel alloc] init];
    
    __weak typeof (self) weakSelf = self;
    [self.personalModel.loadSupport setDataRefreshblock:^{
        [weakSelf updateData];
    }];
    
    [self.personalModel.loadSupport setDataRefreshFailBlock:^(NetLoadEvent code ,NSString* remark){
//        [weakSelf showHudPrompt:remark];
    }];
    
    [self updateData];
}

- (void)updateData
{
    self.dataSourceArray = [[NSMutableArray alloc] initWithArray:@[
                                                                       @{@"Title":@"",
                                                                         @"Image" :[self anyValue:self.personalModel.userPicUrl],
                                                                         @"Action":@"showHeadImagePickerMenu:",
                                                                         @"ActionSender" : [NSNumber numberWithInt:eUserHead]},
                                                                       @{@"Title": NSLocalizedString(@"用户名",nil),
                                                                         @"Desc" : [self anyValue:self.personalModel.userName],
                                                                         @"Action":@"showTextFieldView:",
                                                                         @"ActionSender" : [NSNumber numberWithInt:eEditUserName]},
                                                                       @{@"Title": NSLocalizedString(@"个人签名",nil),
                                                                         @"Desc" : [self anyValue:self.personalModel.signature],
                                                                         @"Action":@"showTextFieldView:",
                                                                         @"ActionSender" : [NSNumber numberWithInt:eEditUserSignature]},
                                                                       @{@"Title": NSLocalizedString(@"手机号",nil),
                                                                         @"Desc" : [self anyValue:self.personalModel.phoneNum],
                                                                         @"Action":@"showChangePhoneNum:",
                                                                         @"ActionSender" : [NSNumber numberWithInt:ePhoneNum]},
                                                                       @{@"Title": NSLocalizedString(@"性别",nil),
                                                                         @"Desc" : [self sexStr:self.personalModel.gender],
                                                                         @"Action":@"showSexPickerMenu:",
                                                                         @"ActionSender" : [NSNumber numberWithInt:eSex]},
                                                                       @{@"Title": NSLocalizedString(@"出生日期",nil),
                                                                         @"Desc" : [self anyValue:self.personalModel.birthDate],
                                                                         @"Action":@"birthDatePickerMenu:",
                                                                         @"ActionSender" : [NSNumber numberWithInt:eBirthDate]},
                                                                       @{@"Title": NSLocalizedString(@"所在城市",nil),
                                                                         @"Desc" : [self anyValue:self.personalModel.area],
                                                                         @"Action":@"showAddressPickerMenu:",
                                                                         @"ActionSender" : [NSNumber numberWithInt:eCity]},
                                                                       @{@"Title": NSLocalizedString(@"收货地址",nil),
                                                                         @"Desc" :[self anyValue:self.personalModel.address],
                                                                         @"Action":@"showReceiptAddress:",
                                                                         @"ActionSender" : [NSNumber numberWithInt:eAddress]},
                                                                       @{@"Title": NSLocalizedString(@"修改密码",nil),
                                                                         @"Desc" : [self passwordTips:self.personalModel.isUpdatePasswd],
                                                                         @"Action":@"changePassword:",
                                                                         @"ActionSender" : [NSNumber numberWithInt:ePassword]}
                                                                       ]];
    [self.tableView reloadData];

}

- (NSString *)sexStr:(int)gender
{
    if(gender == 0) {
        return @"女";
    }else if(gender == 1){
        return @"男";
    }
    return @"保密";
}
- (NSString*)passwordTips:(int)isUpdatePasswd
{
    return (isUpdatePasswd == 0) ? @"不可修改" : @"可修改";
}

- (NSString *)anyValue:(NSString*)orignValue
{
    if (!orignValue) {
        return @"";
    }
    return orignValue;
}

- (void)reloadTableView:(NSInteger)type content:(NSString*)contentStr
{
    for (NSInteger i = 0; i < self.dataSourceArray.count; i++)  {
        NSDictionary *tmpDict = (NSDictionary*)[self.dataSourceArray objectAtIndex:i];
        if ([[tmpDict objectForKey:@"ActionSender"] intValue] == type) {
            NSMutableDictionary *newDict = [NSMutableDictionary dictionaryWithObjects:[tmpDict allValues]
                                                                              forKeys:[tmpDict allKeys]];
            [newDict setObject:contentStr forKey:@"Desc"];
            [self.dataSourceArray replaceObjectAtIndex:i  withObject:newDict];
            [self.tableView reloadData];
            break;
        }
    }
}

#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourceArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 110.f;
    }
    return 60.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectZero];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 100.f;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (!self.exitLoginView) {
        self.exitLoginView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 100)];
        UIButton *exitBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, 30, DeviceWidth - 60, 50)];
        [exitBtn setTitle:NSLocalizedString(@"退 出 登 录", nil) forState:UIControlStateNormal];
        [exitBtn setTitleColor:ColorWhite forState:UIControlStateNormal];
        [exitBtn setBackgroundImage:[UIImage createImageWithColor:ColorBtnYellow] forState:UIControlStateNormal];
        [exitBtn.titleLabel setFont:Font15];
        [exitBtn addTarget:self
                    action:@selector(exitLogin:)
          forControlEvents:UIControlEventTouchUpInside];
        [self.exitLoginView addSubview:exitBtn];
        
    }
    return self.exitLoginView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PersonalInfoCell";
    
    PersonalInfoCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[PersonalInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    cell.selectedBackgroundView.backgroundColor = RGB(240, 240, 240);
    NSDictionary *cellDict = [self.dataSourceArray objectAtIndex:[indexPath row]];
    cell.leftLabal.text = [cellDict objectForKey:@"Title"];
    cell.accessoryView =  nil;
    if (indexPath.row == 0) {
//        IMAGE(@"我的_未登录_头像.png")
       cell.backgroundColor = RGBAHEX(0xEBEBF1, 1.0);
        NSString *url = [cellDict objectForKey:@"Image"];
        if (url && [url length]) {
             [cell.rightImgView  sd_setImageWithURL:[NSURL URLWithString:[cellDict objectForKey:@"Image"]] placeholderImage:UnLoginDefaultImage];
        }else{
            cell.rightImgView.image = UnLoginDefaultImage;
        }
     
        cell.rightLabel.text = @"";
    }else{
        cell.backgroundColor = RGBAHEX(0xFFFFFF, 1.0);
        cell.rightLabel.text = [cellDict objectForKey:@"Desc"];
        cell.rightImgView.image = nil;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SEL selector = NSSelectorFromString([[self.dataSourceArray objectAtIndex:[indexPath row]] objectForKey:@"Action"]);
    NSNumber* actionSender = (NSNumber*)[[self.dataSourceArray objectAtIndex:[indexPath row]] objectForKey:@"ActionSender"];
    if(selector == nil) return;
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    if ([self canPerformAction:selector withSender:actionSender]) {
        [self performSelector:selector withObject:actionSender];
    }
#pragma clang diagnostic pop
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)showHeadImagePickerMenu:(id)sender
{
    NSString *cameraStr = NSLocalizedString(@"相机", nil);
    NSString *albumStr = NSLocalizedString(@"相册", nil);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"更换头像" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    // Create the actions.
    UIAlertAction *camraAction = [UIAlertAction actionWithTitle:cameraStr style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self showImagePickerView:UIImagePickerControllerSourceTypeCamera];
    }];
    
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:albumStr style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self showImagePickerView:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    }]; 
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
       
    }];
    
    // Add the actions.
    [alertController addAction:camraAction];
    [alertController addAction:albumAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)showImagePickerView:(UIImagePickerControllerSourceType)sourceType
{
    self.imagePicker = nil;

    self.imagePicker = [[LBB_ImagePickerViewController alloc] initPickerWithType:sourceType Parent:self];
    
    __weak typeof (self) weakSelf = self;
    [self.imagePicker showPicker:^(UIImage *resultImage){
        NSLog(@"%d",resultImage == nil);
        [weakSelf reSetDataSource:resultImage];
    }];
}

- (void)reSetDataSource:(UIImage*)userImage
{
    if (userImage) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:[self.dataSourceArray objectAtIndex:0]];
        [dict setObject:userImage forKey:@"Image"];
        [self.dataSourceArray replaceObjectAtIndex:0 withObject:dict];
        [self.tableView reloadData];
    }
}

- (void)showTextFieldView:(id)sender
{
    [self performSegueWithIdentifier:@"LBB_UserNameViewController" sender:sender];
}

- (void)showChangePhoneNum:(id)sender
{
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"MineStoryboard" bundle:nil];
    VerificationViewController* vc = [main instantiateViewControllerWithIdentifier:@"VerificationViewController"];
    vc.baseViewType = eChangePhoneNum;
    vc.mainPersonModel = self.personalModel;
    vc.userToken = [LBB_LoginManager shareInstance].userToken;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)showAddressPickerMenu:(id)sender
{
    if (!self.addressPicker) {
        self.addressPicker = [[LBB_AddressPickerView alloc] initWithTitle:NSLocalizedString(@"选择地址", nil)
                                                         showCancelButton:YES
                                                               parentView:self.view
                                                        showStreet:NO];
    }
  
    [self.addressPicker showPickerView];
    __weak typeof (self) weakSelf = self;
    self.addressPicker.myBlock = ^(NSString *address,NSArray *selections){
        if (address && [address length]) {
            [weakSelf.personalModel updateArea:1000 CityId:1];
        }
    };
}

- (void)showReceiptAddress:(id)sender
{
    [self performSegueWithIdentifier:@"ReceiptAddressViewController" sender:sender];
}

- (void)showSexPickerMenu:(id)sender {
    NSString *title = NSLocalizedString(@"请选择", nil);
    NSString *cancelButtonTitle = NSLocalizedString(@"保密", nil);
    NSString *otherButtonTitle = NSLocalizedString(@"男", nil);
    NSString *otherButtonTitle1 = NSLocalizedString(@"女", nil);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];
    
    // Create the actions.
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction *action) {
    }];
    
    UIAlertAction *baomiAction = [UIAlertAction actionWithTitle:cancelButtonTitle
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action) {
                                                             [self.personalModel updateGender:2];
                                                         }];
    
    
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction *action) {
        [self.personalModel updateGender:1];
    }];
    
    UIAlertAction *otherAction1 = [UIAlertAction actionWithTitle:otherButtonTitle1
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action) {
        [self.personalModel updateGender:0];
    }];
    
    
    // Add the actions.
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    [alertController addAction:otherAction1];
    [alertController addAction:baomiAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)changePassword:(id)sender
{ 
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"MineStoryboard" bundle:nil];
    ChangePasswordViewController  *vc  = [main instantiateViewControllerWithIdentifier:@"ChangePasswordViewController"];
    vc.baseViewType = eChangePassword;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)birthDatePickerMenu:(id)sender
{
    __weak typeof (self) weakSelf = self;
    [ActionSheetDatePicker showPickerWithTitle:NSLocalizedString(@"选择日期", nil)
                                datePickerMode:UIDatePickerModeDate
                                  selectedDate:[NSDate date]
                                     doneBlock:^(ActionSheetDatePicker *picker, id selectedDate, id origin){
                                         NSLog(@"selectedDate =  %@",selectedDate);
                                         [weakSelf.personalModel updateBirthDate:[weakSelf stringFromDate:selectedDate] ];
//                                         
//                                         [weakSelf reloadTableView:eBirthDate content:[weakSelf stringFromDate:selectedDate]];
                                     }
                                   cancelBlock:^(ActionSheetDatePicker *picker){
                                       
                                   }  origin:self.view];

}


- (NSString *)stringFromDate:(NSDate *)date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    //[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController *dstController =   segue.destinationViewController;
    if ([dstController isKindOfClass:NSClassFromString(@"MineBaseViewController")]){
        MineBaseViewController *baseVC = (MineBaseViewController*)dstController;
        if (sender && [sender isKindOfClass:[NSNumber class]]) {
            baseVC.baseViewType = [(NSNumber *)sender intValue];
        }
    }
    if ([dstController isKindOfClass:NSClassFromString(@"LBB_UserNameViewController")]){
        LBB_UserNameViewController *baseVC = (LBB_UserNameViewController*)dstController;
        baseVC.personModel = self.personalModel;
        baseVC.userToken = [LBB_LoginManager shareInstance].userToken;
        
    }else if([dstController isKindOfClass:NSClassFromString(@"ReceiptAddressViewController")]){
        
    }
}

#pragma mark - 退出登录
- (void)exitLogin:(id)sender
{
    __weak typeof (self) weakSelf = self;
    LBB_LoginManager *loginManager = [LBB_LoginManager shareInstance];
    [loginManager logout:^(NSString *userToken,BOOL result){
        [weakSelf performSegueWithIdentifier:@"LBB_LoginViewController" sender:nil];
    }];
    NSLog(@"\n 退出登录");
}

@end
