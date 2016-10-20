//
//  PersonalCenterViewController.m
//  LUBABA
//
//  Created by Diana on 16/10/13.
//  Copyright © 2016年 Diana. All rights reserved.
//

#import "PersonalCenterViewController.h"
#import "PersonalInfoCell.h"
#import "LBB_AddressPickerView.h"
#import "ActionSheetDatePicker.h"
#import "ChangePhoneNumViewController.h"

typedef NS_ENUM(NSInteger,PersonalInfoType) {
    eUserHead = 0,//头像
    eUserName, //用户名
    eUserSignature, //个人签名
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

@end

@implementation PersonalCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.baseViewType = ePersonalCenter;
    [self initData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private
- (void)initData
{
    UINib *nib = [UINib nibWithNibName:@"PersonalInfoCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"PersonalInfoCell"];
//    [self.tableView registerNib:nib forCellReuseIdentifier:@"PersonalUserHeadCell"];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.dataSourceArray = [[NSMutableArray alloc] initWithArray:@[
                                                                   @{@"Title": NSLocalizedString(@"头像",nil),
                                                                     @"Image" : @"19.pic.jpg",
                                                                     @"Action":@"showHeadImagePickerMenu:",
                                                                     @"ActionSender" : [NSNumber numberWithInt:eUserHead]},
                                                                   @{@"Title": NSLocalizedString(@"用户名",nil),
                                                                     @"Desc" : @"王滨滨",
                                                                     @"Action":@"showTextFieldView:",
                                                                     @"ActionSender" : [NSNumber numberWithInt:eEditUserName]},
                                                                   @{@"Title": NSLocalizedString(@"个人签名",nil),
                                                                     @"Desc" : @"请填写",
                                                                     @"Action":@"showTextFieldView:",
                                                                     @"ActionSender" : [NSNumber numberWithInt:eEditUserSignature]},
                                                                   @{@"Title": NSLocalizedString(@"手机号",nil),
                                                                     @"Desc" : @"1234**901",
                                                                     @"Action":@"showChangePhoneNum:",
                                                                     @"ActionSender" : [NSNumber numberWithInt:ePhoneNum]},
                                                                   @{@"Title": NSLocalizedString(@"性别",nil),
                                                                     @"Desc" : @"美女",
                                                                     @"Action":@"showSexPickerMenu:",
                                                                     @"ActionSender" : [NSNumber numberWithInt:eSex]},
                                                                   @{@"Title": NSLocalizedString(@"出生日期",nil),
                                                                     @"Desc" : @"可设置出生日期",
                                                                     @"Action":@"birthDatePickerMenu:",
                                                                     @"ActionSender" : [NSNumber numberWithInt:eBirthDate]},
                                                                   @{@"Title": NSLocalizedString(@"所在城市",nil),
                                                                     @"Desc" : @"福建 厦门",
                                                                     @"Action":@"showAddressPickerMenu:",
                                                                     @"ActionSender" : [NSNumber numberWithInt:eCity]},
                                                                   @{@"Title": NSLocalizedString(@"收货地址",nil),
                                                                     @"Desc" : @"厦门市思明区莲前街道软件园二期望海路59号",
                                                                     @"Action":@"showReceiptAddress:",
                                                                     @"ActionSender" : [NSNumber numberWithInt:eAddress]},
                                                                   @{@"Title": NSLocalizedString(@"修改密码",nil),
                                                                     @"Desc" : @"可修改密码",
                                                                     @"Action":@"changePassword:",
                                                                     @"ActionSender" : [NSNumber numberWithInt:ePassword]}
                                                                   ]];
    
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
       cell.backgroundColor = RGBAHEX(0xEBEBF1, 1.0);
       [cell.rightImgView setImage:[UIImage imageNamed:[cellDict objectForKey:@"Image"]]];
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
    
}

- (void)showTextFieldView:(id)sender
{
    [self performSegueWithIdentifier:@"LBB_UserNameViewController" sender:sender];
}

- (void)showChangePhoneNum:(id)sender
{
    [self performSegueWithIdentifier:@"ChangePhoneNumViewController" sender:nil];
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
}

- (void)showReceiptAddress:(id)sender
{
    [self performSegueWithIdentifier:@"ReceiptAddressViewController" sender:sender];
}

- (void)showSexPickerMenu:(id)sender {
    NSString *title = NSLocalizedString(@"请选择", nil);
    NSString *cancelButtonTitle = NSLocalizedString(@"保密", nil);
    NSString *otherButtonTitle = NSLocalizedString(@"帅哥", nil);
    NSString *otherButtonTitle1 = NSLocalizedString(@"美女", nil);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];
    
    // Create the actions.
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction *action) {
        NSLog(@"The \"Okay/Cancel\" alert's cancel action occured.");
    }];
    
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction *action) {
        NSLog(@"The \"Okay/Cancel\" alert's other action occured.");
    }];
    
    UIAlertAction *otherAction1 = [UIAlertAction actionWithTitle:otherButtonTitle1
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action) {
        NSLog(@"The \"Okay/Cancel\" alert's other action occured.");
    }];
    
    
    // Add the actions.
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    [alertController addAction:otherAction1];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)birthDatePickerMenu:(id)sender
{
    [ActionSheetDatePicker showPickerWithTitle:NSLocalizedString(@"选择日期", nil)
                                datePickerMode:UIDatePickerModeDate
                                  selectedDate:[NSDate date]
                                     doneBlock:^(ActionSheetDatePicker *picker, id selectedDate, id origin){
                                         NSLog(@"selectedDate =  %@",selectedDate);
                                     }
                                   cancelBlock:^(ActionSheetDatePicker *picker){
                                       
                                   }  origin:self.view];

}

- (void)changePassword:(id)sender
{
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController *dstController =   segue.destinationViewController;
    if ([dstController isKindOfClass:NSClassFromString(@"LBB_UserNameViewController")]){
        MineBaseViewController *baseVC = (MineBaseViewController*)dstController;
        if (sender && [sender isKindOfClass:[NSNumber class]]) {
            baseVC.baseViewType = [(NSNumber *)sender intValue];
        }
    }else if([dstController isKindOfClass:NSClassFromString(@"ReceiptAddressViewController")]){
        
    }else if([dstController isKindOfClass:NSClassFromString(@"ChangePhoneNumViewController")]){
        ChangePhoneNumViewController *phoneVC = (ChangePhoneNumViewController*)dstController;
        phoneVC.baseViewType = eChangePhoneNum;
    }
}

@end
