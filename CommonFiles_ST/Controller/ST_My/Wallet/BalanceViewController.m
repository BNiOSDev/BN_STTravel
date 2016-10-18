//
//  BalanceViewController.m
//  LUBABA
//
//  Created by Dianar on 16/10/9.
//  Copyright © 2016年 Dianar. All rights reserved.
//

#import "BalanceViewController.h"
#import "BalanceDetailViewController.h"

@interface BalanceViewController ()
@property (weak, nonatomic) IBOutlet UILabel *balanceNumLabel;

@end

@implementation BalanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.baseViewType =  eBalance;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark - UI Action
- (IBAction)extractBtnAction:(id)sender {
    [self performSegueWithIdentifier:@"BalanceExtractViewController" sender:nil];
}

- (IBAction)detailBtnAction:(id)sender {
     [self performSegueWithIdentifier:@"BalanceDetailViewController" sender:nil];
}

#pragma mark -  perform segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController *dstController =   segue.destinationViewController;
    if ([dstController isKindOfClass:NSClassFromString(@"BalanceExtractViewController")]) {
        LBBLOG(@"余额提现");
    }else if([dstController isKindOfClass:NSClassFromString(@"BalanceDetailViewController")]) {
         LBBLOG(@"余额明细");
        BalanceDetailViewController* vc = (BalanceDetailViewController*)dstController;
        vc.showType = BalanceDetailType;
    }
}

@end
