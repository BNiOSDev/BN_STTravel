//
//  LBB_UserNameViewController.m
//  ST_Travel
//
//  Created by 晨曦 on 16/10/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_UserNameViewController.h"

@interface LBB_UserNameViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tipLabelHeightConstraint;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewTopConstraint;

@end

@implementation LBB_UserNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.baseViewType = eEditUserName;
    [self initConstraint];
}

- (void)initConstraint
{
    if (self.baseViewType == eEditUserName) {
        self.textView.placeholder = NSLocalizedString(@"请输用户名名", nil);
        self.textViewHeightConstraint.constant = 60.f;
    }else {
        self.tipLabel.text = nil;
        self.tipLabel.hidden = YES;
        self.tipLabelHeightConstraint.constant = 0.f;
        self.lineView.hidden = YES;
        self.textView.placeholder = NSLocalizedString(@"请输个性签名", nil);
        self.textViewTopConstraint.constant = 0.f;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveBtnClickAction:(id)sender {
    NSLog(@"点击保存按钮");
}

@end
