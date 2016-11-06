//
//  ConvertiblePointsViewController.m
//  LUBABA
//  可兑换积分
//  Created by 晨曦 on 16/10/10.
//  Copyright © 2016年 晨曦. All rights reserved.
//

#import "ConvertiblePointsViewController.h"

@interface ConvertiblePointsViewController ()<
UITextFieldDelegate
>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *moneyNumLabel;
@property (weak, nonatomic) IBOutlet UIButton *convertBtn;
@property (weak, nonatomic) IBOutlet UIButton *allConvertBtn;

@end

@implementation ConvertiblePointsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.baseViewType =  ePointConvert;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  - textField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark - UI Action
- (IBAction)allConvertAction:(id)sender {
}
- (IBAction)convertAction:(id)sender {
}

@end
