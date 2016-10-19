//
//  VerificationViewController.m
//  ST_Travel
//
//  Created by Diana on 16/10/19.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "VerificationViewController.h"

@interface VerificationViewController ()<
UITextFieldDelegate
>

@property (weak, nonatomic) IBOutlet UILabel *phoneNumLabel;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation VerificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.baseViewType = eExtractVerification;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UI Action
- (IBAction)getVerificationNum:(id)sender {
}

- (IBAction)startVerificatiteAction:(id)sender {
    [self performSegueWithIdentifier:@"ExtractDetailViewController" sender:nil];
}

#pragma mark - UITextFiled Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return YES;
}
@end
