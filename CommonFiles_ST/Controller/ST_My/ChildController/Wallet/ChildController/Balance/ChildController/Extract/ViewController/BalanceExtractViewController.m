//
//  BalanceExtractViewController.m
//  LUBABA
//
//  Created by Dianar on 16/10/9.
//  Copyright © 2016年 Dianar. All rights reserved.
//

#import "BalanceExtractViewController.h"
#import "CardDetailViewController.h"

@interface BalanceExtractViewController ()
{

}
@property (assign, nonatomic) CGFloat moneyNum;
@property (weak, nonatomic) IBOutlet UIImageView *cardImgView;
@property (weak, nonatomic) IBOutlet UILabel *cardNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cardNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UITextField *moneyTextField;

@end

@implementation BalanceExtractViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.baseViewType =  eBalanceExtract;
    [self initConstraint];
    [self initTextField];
}

- (void)buildControls
{
   
}

- (void)initTextField
{
    self.moneyTextField.keyboardType = UIKeyboardTypeDecimalPad;
    @weakify(self);
    [self.moneyTextField.rac_textSignal subscribeNext:^(id x) {
        @strongify(self);
        NSString *moneyText = self.moneyTextField.text;
        if (moneyText) {
            self.moneyNum = [moneyText floatValue];
        }
    }];
}


#pragma mark - private
- (void)initConstraint
{
    self.cardNumLabel.adjustsFontSizeToFitWidth = YES;
    self.cardNameLabel.adjustsFontSizeToFitWidth = YES;
    self.moneyLabel.adjustsFontSizeToFitWidth = YES;
}

#pragma mark -  UI Action
//银行卡详情
- (IBAction)cardDetailAction:(id)sender {
    [self performSegueWithIdentifier:@"CardDetailViewController" sender:nil];
}

//全部提现
- (IBAction)extractAllMoneyAction:(id)sender {
    
}

//提现
- (IBAction)extractMoney:(id)sender {
    
    [self performSegueWithIdentifier:@"VerificationViewController" sender:nil];
}

#pragma mark -  perform segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController *dstController =   segue.destinationViewController;
    if ([dstController isKindOfClass:NSClassFromString(@"CardDetailViewController")]) {
        NSLog(@"银行卡详情页");
    }
}

@end
