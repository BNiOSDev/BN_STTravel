//
//  LBB_UserNameViewController.m
//  ST_Travel
//
//  Created by 晨曦 on 16/10/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_UserNameViewController.h"

@interface LBB_UserNameViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewTopConstraint;
@property(nonatomic,weak) IBOutlet UIView *line1;
@property(nonatomic,weak) IBOutlet UIView *line2;
@property(nonatomic,weak) IBOutlet UIView *tipBgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tipLabelHeightConstraint;

@property(nonatomic,copy) NSString *textContent;

@end

@implementation LBB_UserNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initConstraint];
}

- (void)buildControls
{
    @weakify(self);
    [self.textView.rac_textSignal subscribeNext:^(id x) {
        @strongify(self);
        self.textContent = self.textView.text;
    }];
}

- (void)initConstraint
{
    self.view.backgroundColor = ColorWhite;
    if (self.baseViewType == eEditUserName) {
        self.textView.placeholder = NSLocalizedString(@"请输用户名名", nil);
        self.textViewHeightConstraint.constant = 60.f;
        self.tipBgView.backgroundColor = ColorBackground;
        self.tipLabel.textColor = ColorBlack;
        self.tipLabel.font = Font14;
    }else {
        self.tipBgView.hidden = YES;
        self.tipLabelHeightConstraint.constant = 0.f;
        self.line1.hidden = YES;
        self.textView.placeholder = NSLocalizedString(@"请输个性签名", nil);
        self.textViewTopConstraint.constant = 0.f;
    }
    self.textView.font = Font16;
    self.textView.textColor = ColorBlack;
    
    self.line1.backgroundColor = ColorLine;
    self.line2.backgroundColor = ColorLine;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveBtnClickAction:(id)sender {
    NSLog(@"点击保存按钮");
    
    self.textContent = [self.textContent Trim];
    
    switch (self.baseViewType) {
        case eEditUserName: //用户名
        {
            
        }
            break;
        case eEditUserSignature://用户签名
        {
            
        }
            break;
            
        default:
            break;
    }
}

@end
