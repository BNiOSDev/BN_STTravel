//
//  LBB_NoticeDetailViewController.m
//  ST_Travel
//
//  Created by 晨曦 on 16/12/5.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_NoticeDetailViewController.h"

@interface LBB_NoticeDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UITextView *textView;
@end

@implementation LBB_NoticeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLabel.textColor = ColorBlack;
    self.timeLabel.textColor = ColorLightGray;
    self.textView.textColor = ColorBlack;
 
    self.titleLabel.font = Font16;
    self.timeLabel.font  = Font13;
    self.textView.font = Font13;
    self.textView.editable = NO;
    
    if (self.viewModel) {
        self.titleLabel.text = self.viewModel.title;
        self.timeLabel.text = self.viewModel.createTime;
        self.textView.text = self.viewModel.content;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
 

@end
