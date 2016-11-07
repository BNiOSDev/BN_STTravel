//
//  LBB_GuiderApplyResultViewController.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/3.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_GuiderApplyResultViewController.h"

@interface LBB_GuiderApplyResultViewController ()

@property(nonatomic, retain)UIButton* applyResultButton;
@property(nonatomic, retain)UIButton* finishButton;
@property(nonatomic, retain)UILabel* reasonLabel;


@end

@implementation LBB_GuiderApplyResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
-(void)loadCustomNavigationButton{
    
    if (self.isSuccess) {
        self.title = @"审核成功";
    }
    else{
        self.title = @"审核失败";
    }
}

-(void)buildControls{
    
    WS(ws);
    
    CGFloat margin = 8;
    
    [self.view setBackgroundColor:ColorWhite];
    
    self.applyResultButton = [UIButton new];
    [self.applyResultButton setTitleColor:ColorGray forState:UIControlStateNormal];
    [self.applyResultButton.titleLabel setFont:Font16];
    [self.applyResultButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, -10)];
    [self.applyResultButton setBackgroundColor:[UIColor colorWithRGB:0xf2f2f2]];
    [self.view addSubview:self.applyResultButton];
    [self.applyResultButton mas_makeConstraints:^(MASConstraintMaker* make){
        make.centerX.top.width.equalTo(ws.view);
        make.height.mas_equalTo(AutoSize(60));
    }];

    UIView* sep = [UIView new];
    [sep setBackgroundColor:ColorLine];
    [self.view addSubview:sep];
    [sep mas_makeConstraints:^(MASConstraintMaker* make){
        make.centerX.width.equalTo(ws.view);
        make.top.equalTo(ws.applyResultButton.mas_bottom);
        make.height.mas_equalTo(SeparateLineWidth);
    }];
 
    self.reasonLabel = [UILabel new];
    [self.reasonLabel setFont:Font15];
    [self.reasonLabel setNumberOfLines:0];
    [self.reasonLabel setTextColor:ColorGray];
    [self.view addSubview:self.reasonLabel];
    [self.reasonLabel mas_makeConstraints:^(MASConstraintMaker* make){
        make.top.equalTo(sep.mas_bottom).offset(25);
        make.centerX.equalTo(ws.view);
        make.left.equalTo(ws.view).offset(22);
        make.right.equalTo(ws.view).offset(-22);
    }];
    
    self.finishButton = [UIButton new];
    [self.finishButton setTitleColor:ColorWhite forState:UIControlStateNormal];
    [self.finishButton.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [self.finishButton setBackgroundColor:ColorBtnYellow];
    [self.view addSubview:self.finishButton];
    [self.finishButton mas_makeConstraints:^(MASConstraintMaker* make){
        make.centerX.equalTo(ws.view);
        make.height.mas_equalTo(AutoSize(90/2));
        make.width.mas_equalTo(AutoSize(480/2));
        make.top.equalTo(ws.reasonLabel.mas_bottom).offset(45);
    }];
    
    
    @weakify (self);
    
    [RACObserve(self, isSuccess) subscribeNext:^(NSNumber* index) {
        @strongify(self);
        
        if (self.isSuccess) {

            [self.applyResultButton setImage:IMAGE(@"导游_完成") forState:UIControlStateNormal];
            [self.applyResultButton setTitle:@"您已提交认证审核" forState:UIControlStateNormal];
            [self.finishButton setTitle:@"完成" forState:UIControlStateNormal];
            
            [self.reasonLabel setText:@"您的导游申请已提交成功，工作人员将在三个工作日内进行审核，请耐心等待，谢谢!"];
        }
        else{
            [self.applyResultButton setImage:IMAGE(@"导游_失败") forState:UIControlStateNormal];
            [self.applyResultButton setTitle:@"您提交导游审核认证失败" forState:UIControlStateNormal];
            [self.finishButton setTitle:@"重新申请导游认证" forState:UIControlStateNormal];
            
            [self.reasonLabel setText:@"您的导游申请未通过审核，不通过理由为：您的导游证错误，你的姓名与身份证不匹配你的照片不清晰，请重新填写提交审核"];
        }
        [self.reasonLabel setLineSpace:10];
        
        
    }];
}

@end
