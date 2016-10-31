//
//  ExtractDetailViewController.m
//  ST_Travel
//
//  Created by Diana on 16/10/19.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "ExtractDetailViewController.h"

@interface ExtractDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *moneyNumLabel;

@property (weak, nonatomic) IBOutlet UILabel *cardLabel;

@end

@implementation ExtractDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI Action

- (IBAction)doneAction:(id)sender {
    NSArray *vcArray = self.navigationController.viewControllers;
    if ( vcArray.count >= 4) {
        UIViewController *dstVC = [vcArray objectAtIndex:(vcArray.count - 4)];
        [self.navigationController popToViewController:dstVC animated:YES];
    }else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
