//
//  LBB_AboutUsViewController.m
//  ST_Travel
//
//  Created by 美少男 on 16/12/24.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_AboutUsViewController.h"

@interface LBB_AboutUsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *contentlabel;

@end

@implementation LBB_AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.contentlabel.adjustsFontSizeToFitWidth = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
