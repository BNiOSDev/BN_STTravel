//
//  LBB_GuiderApplyViewController.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/2.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_GuiderApplyViewController.h"
#import "LBB_GuiderApplyTextField.h"
#import "SKTagView.h"
#import "LBB_GuiderApplyLabelSelectView.h"
#import "LBB_GuiderIdentityCardSelectView.h"
#import "LBB_GuiderApplyResultViewController.h"

@interface LBB_GuiderApplyViewController ()

@property (nonatomic, retain) UIScrollView *mainScrollView;

@property (nonatomic, retain) LBB_GuiderApplyTextField *nameTextField;//姓名
@property (nonatomic, retain) LBB_GuiderApplyTextField *identityIDTextField;//身份证号
@property (nonatomic, retain) LBB_GuiderApplyTextField *guiderIDTextField;//导游证号
@property (nonatomic, retain) LBB_GuiderApplyTextField *workTimeTextField;//从业时间
@property (nonatomic, retain) LBB_GuiderApplyTextField *telTextField;//联系电话
@property (nonatomic, retain) LBB_GuiderApplyTextField *shortIntroTextField;//一句话介绍
@property (nonatomic, retain) LBB_GuiderApplyTextField *detailIntroTextField;//详细介绍
@property (nonatomic, retain) LBB_GuiderApplyLabelSelectView *labelTagView; //选择标签

@property (nonatomic, retain) LBB_GuiderIdentityCardSelectView * idPositiveView; //身份证正面
@property (nonatomic, retain) LBB_GuiderIdentityCardSelectView * idNegativeView; //身份证反面

@property (nonatomic, retain) LBB_GuiderIdentityCardSelectView * guiderIDView; //导游证照片

@property (nonatomic, retain) LBB_GuiderIdentityCardSelectView * otherIDView; //其他证件照片

@property(nonatomic, retain)UILabel* noteLabel;

@end

@implementation LBB_GuiderApplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
  //  [self.mainScrollView setContentSize:CGSizeMake(0, 2000)];
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
    self.title = @"申请导游";
}

-(void)buildControls{
    
    WS(ws);
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.mainScrollView = [UIScrollView new];
    [self.mainScrollView setBackgroundColor:[UIColor whiteColor]];
    [self.mainScrollView setContentSize:CGSizeMake(0, UISCREEN_HEIGTH)];
    [self.mainScrollView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.mainScrollView];
    [self.mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.view);
       // make.bottom.equalTo(ws.view);
        make.width.centerX.equalTo(ws.view);
    }];
    
    //提交申请按钮
    UIButton* applyButton = [UIButton new];
    [applyButton setBackgroundColor:ColorBtnYellow];
    [applyButton setTitle:@"立即申请" forState:UIControlStateNormal];
    [applyButton setTitleColor:ColorWhite forState:UIControlStateNormal];
    [applyButton.titleLabel setFont:Font15];
    [self.view addSubview:applyButton];
    [applyButton mas_makeConstraints:^(MASConstraintMaker* make){
        make.centerX.width.bottom.equalTo(ws.view);
        make.height.mas_equalTo(AutoSize(40));
        make.top.equalTo(ws.mainScrollView.mas_bottom);
    }];
    [applyButton bk_addEventHandler:^(id sender){
    
        LBB_GuiderApplyResultViewController* dest = [[LBB_GuiderApplyResultViewController alloc]init];
        dest.isSuccess = YES;
        [ws.navigationController pushViewController:dest animated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    
    
    
    CGFloat margin = 8;
    
    UILabel* noteLabel = [UILabel new];
    [noteLabel setTextColor:ColorGray];
    [noteLabel setBackgroundColor:[UIColor colorWithRGB:0xe9e9e9]];
    [noteLabel setFont:Font15];
    [noteLabel setText:@"  请填写相关申请信息"];
    [self.mainScrollView addSubview:noteLabel];
    [noteLabel mas_makeConstraints:^(MASConstraintMaker* make){
        
        make.centerX.top.width.equalTo(ws.mainScrollView);
        make.height.mas_equalTo(AutoSize(80/2));
    }];
    
    self.nameTextField = [[LBB_GuiderApplyTextField alloc]init];
    [self.nameTextField.titleLable setText:@"姓名"];
    [self.mainScrollView addSubview:self.nameTextField];
    [self.nameTextField mas_makeConstraints:^(MASConstraintMaker* make){
        make.centerX.width.equalTo(noteLabel);
        make.top.equalTo(noteLabel.mas_bottom);
    }];
    
    self.identityIDTextField = [[LBB_GuiderApplyTextField alloc]init];
    [self.identityIDTextField.titleLable setText:@"身份证号"];
    [self.mainScrollView addSubview:self.identityIDTextField];
    [self.identityIDTextField mas_makeConstraints:^(MASConstraintMaker* make){
        make.centerX.width.equalTo(noteLabel);
        make.top.equalTo(ws.nameTextField.mas_bottom);
    }];
    
    self.guiderIDTextField = [[LBB_GuiderApplyTextField alloc]init];
    [self.guiderIDTextField.titleLable setText:@"导游证号"];
    [self.mainScrollView addSubview:self.guiderIDTextField];
    [self.guiderIDTextField mas_makeConstraints:^(MASConstraintMaker* make){
        make.centerX.width.equalTo(noteLabel);
        make.top.equalTo(ws.identityIDTextField.mas_bottom);
    }];
    
    self.workTimeTextField = [[LBB_GuiderApplyTextField alloc]init];
    [self.workTimeTextField.titleLable setText:@"从业时间"];
    [self.mainScrollView addSubview:self.workTimeTextField];
    [self.workTimeTextField mas_makeConstraints:^(MASConstraintMaker* make){
        make.centerX.width.equalTo(noteLabel);
        make.top.equalTo(ws.guiderIDTextField.mas_bottom);
    }];
    
    self.telTextField = [[LBB_GuiderApplyTextField alloc]init];
    [self.telTextField.titleLable setText:@"联系电话"];
    [self.mainScrollView addSubview:self.telTextField];
    [self.telTextField mas_makeConstraints:^(MASConstraintMaker* make){
        make.centerX.width.equalTo(noteLabel);
        make.top.equalTo(ws.workTimeTextField.mas_bottom);
    }];
    
    self.shortIntroTextField = [[LBB_GuiderApplyTextField alloc]init];
    [self.shortIntroTextField.titleLable setText:@"一句话介绍"];
    [self.shortIntroTextField.rightTextField setPlaceholder:@"15字以内"];
    [self.mainScrollView addSubview:self.shortIntroTextField];
    [self.shortIntroTextField mas_makeConstraints:^(MASConstraintMaker* make){
        make.centerX.width.equalTo(noteLabel);
        make.top.equalTo(ws.telTextField.mas_bottom);
    }];
    [self.shortIntroTextField.rightTextField bk_addEventHandler:^(UITextField* textField){
    
        if (textField.text.length > 15) {
            textField.text = [textField.text substringToIndex:15];
        }
        
    } forControlEvents:UIControlEventEditingChanged];
    
    
    
    self.detailIntroTextField = [[LBB_GuiderApplyTextField alloc]init];
    [self.detailIntroTextField.titleLable setText:@"详细介绍"];
    [self.detailIntroTextField showBottomTextField:YES];
    [self.mainScrollView addSubview:self.detailIntroTextField];
    [self.detailIntroTextField mas_makeConstraints:^(MASConstraintMaker* make){
        make.centerX.width.equalTo(noteLabel);
        make.top.equalTo(ws.shortIntroTextField.mas_bottom);
    }];
    
    //选择标签
    if (self.showLabelTag) {
        self.labelTagView = [[LBB_GuiderApplyLabelSelectView alloc] init];
        self.labelTagView.borderWidth = SeparateLineWidth;
        self.labelTagView.buttonFont = Font13;
        self.labelTagView.titleColor = ColorGray;
        self.labelTagView.borderColor = ColorLine;
        self.labelTagView.buttonBgColor = ColorWhite;
        
        self.labelTagView.selectTitleColor = ColorBtnYellow;
        self.labelTagView.selectBorderColor = ColorBtnYellow;
        self.labelTagView.selectButtonBgColor = [UIColor colorWithRGB:0xfbf8f3];
        
        [self.mainScrollView addSubview:self.labelTagView];
        [self.labelTagView mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.top.equalTo(ws.detailIntroTextField.mas_bottom);
            make.centerX.width.equalTo(noteLabel);
        }];
        NSArray* array = @[@"余罪",@"恐怖游轮",@"放牛班的春天",@"当幸福来敲门",@"哈利波特",@"死亡密码",@"源代码",@"盗梦空间",@"疯狂动物城",@"X战警",@"西游降魔篇",@"这个男人来自地球",@"致命ID致命ID致命ID致命ID",@"搏击俱乐部",@"冰雪世界"];
        [self.labelTagView configContentView:array];
    }
    
   
    //身份证正面
    self.idPositiveView = [[LBB_GuiderIdentityCardSelectView alloc]init];
    [self.idPositiveView.placeHolderLabel setText:@"身份证正面照片"];
    [self.idPositiveView.titleLable setText:@"身份证证件照片"];
    [self.mainScrollView addSubview:self.idPositiveView];
    [self.idPositiveView mas_makeConstraints:^(MASConstraintMaker* make){
        if (ws.showLabelTag) {
            make.top.equalTo(ws.labelTagView.mas_bottom);
        }
        else{
            make.top.equalTo(ws.detailIntroTextField.mas_bottom);
        }
        make.centerX.width.equalTo(noteLabel);
    }];
    
    //身份证反面
    self.idNegativeView = [[LBB_GuiderIdentityCardSelectView alloc]init];
    [self.idNegativeView.placeHolderLabel setText:@"身份证反面照片"];
    [self.idNegativeView hiddenTitleView:YES];
    [self.mainScrollView addSubview:self.idNegativeView];
    [self.idNegativeView mas_makeConstraints:^(MASConstraintMaker* make){

        make.top.equalTo(ws.idPositiveView.mas_bottom);
        make.centerX.width.equalTo(noteLabel);
    }];
    
    //导游证照片
    UIView* sep = [UIView new];
    [sep setBackgroundColor:ColorLine];
    [self.mainScrollView addSubview:sep];
    [sep mas_makeConstraints:^(MASConstraintMaker* make){
        make.top.equalTo(ws.idNegativeView.mas_bottom);
        make.centerX.width.equalTo(noteLabel);
        make.height.mas_equalTo(SeparateLineWidth);
    }];
    
    self.guiderIDView = [[LBB_GuiderIdentityCardSelectView alloc]init];
    [self.guiderIDView.titleLable setText:@"导游证照片"];
    [self.guiderIDView.placeHolderLabel setText:@"导游证照片"];
    [self.guiderIDView hiddenMarkView:YES];
    [self.mainScrollView addSubview:self.guiderIDView];
    [self.guiderIDView mas_makeConstraints:^(MASConstraintMaker* make){
        
        make.top.equalTo(sep.mas_bottom);
        make.centerX.width.equalTo(noteLabel);
    }];
    
    //其他证件照片
    
    UIView* sep1 = [UIView new];
    [sep1 setBackgroundColor:ColorLine];
    [self.mainScrollView addSubview:sep1];
    [sep1 mas_makeConstraints:^(MASConstraintMaker* make){
        make.top.equalTo(ws.guiderIDView.mas_bottom);
        make.centerX.width.equalTo(noteLabel);
        make.height.mas_equalTo(SeparateLineWidth);
    }];
    
    self.otherIDView = [[LBB_GuiderIdentityCardSelectView alloc]init];
    [self.otherIDView.titleLable setText:@"其他证件照片"];
    [self.otherIDView.placeHolderLabel setText:@"其他证件照片"];
    [self.otherIDView hiddenMarkView:YES];
    [self.mainScrollView addSubview:self.otherIDView];
    [self.otherIDView mas_makeConstraints:^(MASConstraintMaker* make){
        
        make.top.equalTo(sep1.mas_bottom);
        make.centerX.width.equalTo(noteLabel);
    }];
   
    //底部的提示信息
    self.noteLabel = [UILabel new];
    [self.noteLabel setNumberOfLines:0];
    [self.noteLabel setFont:Font10];
    [self.noteLabel setTextColor:ColorLightGray];
    [self.noteLabel setText:@"上传照片大小不超过2M，请确保照片可以\n清晰看清图片上的图片和文字 "];
    [self.noteLabel setLineSpace:5];
    [self.noteLabel setTextAlignment:NSTextAlignmentCenter];
    [self.mainScrollView addSubview:self.noteLabel];
    [self.noteLabel mas_makeConstraints:^(MASConstraintMaker* make){
        make.top.equalTo(ws.otherIDView.mas_bottom).offset(margin);
        make.centerX.width.equalTo(noteLabel);
        make.bottom.equalTo(ws.mainScrollView).offset(-3*margin);
    }];
    

    
}

@end
