//
//  CardDetailViewController.m
//  LUBABA
//
//  Created by Dianar on 16/10/9.
//  Copyright © 2016年 Dianar. All rights reserved.
//

#import "CardDetailViewController.h"

@interface CardDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *cardImgView;
@property (weak, nonatomic) IBOutlet UILabel *cardNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cardNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *cardUserNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cardUserIdentifierLabel;

@end

@implementation CardDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.baseViewType =  eCardDetail;
    [self initConstraint];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - private
- (void)initConstraint
{
    self.cardNumLabel.adjustsFontSizeToFitWidth = YES;
    self.cardNameLabel.adjustsFontSizeToFitWidth = YES;
    self.cardUserIdentifierLabel.adjustsFontSizeToFitWidth = YES;
}

#pragma mark - UI Aciton
//解除绑定
- (IBAction)RemoveBindAction:(id)sender {
}

@end
