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
@property (weak, nonatomic) IBOutlet UILabel *phoneTipLabel;
@property (weak, nonatomic) IBOutlet UILabel *checkTipLabel;

@property (weak, nonatomic) IBOutlet UILabel *phoneNumLabel;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *getCheckNumBtn;

@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet UIView *line1;
@property (weak, nonatomic) IBOutlet UIView *line2;


@property (copy,nonatomic) NSString *checkNum;

@end

@implementation VerificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //找回密码验证
    if (self.baseViewType == eFindPassword) {
        [self.nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    }
}

- (void)buildControls
{
    self.phoneNumLabel.textColor = ColorBlack;
    self.phoneTipLabel.textColor = ColorBlack;
    self.checkTipLabel.textColor = ColorBlack;
    self.textField.textColor = ColorBlack;
    self.phoneNumLabel.font = Font16;
    self.phoneTipLabel.font = Font16;
    self.checkTipLabel.font = Font16;
    self.textField.font = Font16;
    self.line1.backgroundColor = ColorLine;
    self.line2.backgroundColor = ColorLine;
    self.nextBtn.backgroundColor = ColorBtnYellow;
//    [self.nextBtn setBackgroundImage:[UIImage createImageWithColor:ColorBtnYellow] forState:UIControlStateNormal];
//    [self.nextBtn setBackgroundImage:nil forState:UIControlStateHighlighted];
    [self.nextBtn setTitleColor:ColorWhite forState:UIControlStateNormal];
    
    @weakify(self)
    [self.textField.rac_textSignal subscribeNext:^(id x) {
        @strongify(self)
        self.checkNum = self.textField.text;
    }];
    
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
