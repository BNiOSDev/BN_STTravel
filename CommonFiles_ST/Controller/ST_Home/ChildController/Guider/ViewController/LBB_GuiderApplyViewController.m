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
#import "UITextField+TPCategory.h"
#import <NSString+TPCategory.h>
@interface LBB_GuiderApplyViewController ()

@property (nonatomic, retain) UIScrollView *mainScrollView;

@property (nonatomic, retain) LBB_GuiderApplyTextField *nameTextField;//姓名
@property (nonatomic, retain) LBB_GuiderApplyTextField *identityIDTextField;//身份证号
@property (nonatomic, retain) LBB_GuiderApplyTextField *genderTextField;//性别

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

-(id)init{
    
    if (self = [super init]) {
      //  self.auditTags = [[NSMutableArray alloc] initFromNet];
    }
    return self;
}

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
    [super loadCustomNavigationButton];
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
        
        [ws saveTour];
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
    
    self.genderTextField = [[LBB_GuiderApplyTextField alloc]init];
    [self.genderTextField.titleLable setText:@"性别"];
    [self.mainScrollView addSubview:self.genderTextField];
    [self.genderTextField mas_makeConstraints:^(MASConstraintMaker* make){
        make.centerX.width.equalTo(noteLabel);
        make.top.equalTo(ws.identityIDTextField.mas_bottom);
    }];
    
    self.genderTextField.rightTextField.bk_shouldBeginEditingBlock = ^(UITextField* text){
        
        UIAlertController *c = [UIAlertController alertControllerWithTitle:@"请选择性别" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        for (LBB_GuiderGenderConditionOption* tag in ws.gender) {
            UIAlertAction *action = [UIAlertAction actionWithTitle:tag.gender style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
                [text setText:tag.gender];
                ws.viewModel.applyObject.genderKey = tag.key;
            }];
            [c addAction:action];
        }
        [ws presentViewController:c animated:YES completion:nil];
        
        return NO;
    };
    
    self.guiderIDTextField = [[LBB_GuiderApplyTextField alloc]init];
    [self.guiderIDTextField.titleLable setText:@"导游证号"];
    [self.mainScrollView addSubview:self.guiderIDTextField];
    [self.guiderIDTextField mas_makeConstraints:^(MASConstraintMaker* make){
        make.centerX.width.equalTo(noteLabel);
        make.top.equalTo(ws.genderTextField.mas_bottom);
    }];
    
    self.workTimeTextField = [[LBB_GuiderApplyTextField alloc]init];
    [self.workTimeTextField.rightTextField setText:[PoohAppHelper getStringFromDate:[NSDate new] withFormat:DateFormatFullDate]];
    [self.workTimeTextField.rightTextField useDateKeyboard:@"yyyy-MM-dd"];
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
    if (self.viewModel.applyObject.auditTags.count > 0) {
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
        array = [self.viewModel.applyObject.auditTags map:^id(LBB_GuiderApplyTagsObject* tag){
        
            NSString* str = tag.tagName;
            return str;
        }];
        
        [self.labelTagView configContentView:array];
    }
    
   
    //身份证正面
    self.idPositiveView = [[LBB_GuiderIdentityCardSelectView alloc]init];
    [self.idPositiveView.placeHolderLabel setText:@"身份证正面照片"];
    [self.idPositiveView.titleLable setText:@"身份证证件照片"];
    [self.mainScrollView addSubview:self.idPositiveView];
    [self.idPositiveView mas_makeConstraints:^(MASConstraintMaker* make){
        if (ws.viewModel.applyObject.auditTags.count > 0) {
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
    
    self.nameTextField.rightTextField.text = self.viewModel.applyObject.realName;
    self.identityIDTextField.rightTextField.text = self.viewModel.applyObject.idCard;
    self.guiderIDTextField.rightTextField.text = self.viewModel.applyObject.tourIdCard;
    self.workTimeTextField.rightTextField.text = self.viewModel.applyObject.tourStartTime;
    self.telTextField.rightTextField.text = self.viewModel.applyObject.phoneNum;
    self.shortIntroTextField.rightTextField.text = self.viewModel.applyObject.tourAWords;
    self.detailIntroTextField.bottomTextField.text = self.viewModel.applyObject.tourDetails;
    if (self.viewModel.applyObject.tourStartTime.length <= 0) {
        [self.workTimeTextField.rightTextField setText:[PoohAppHelper getStringFromDate:[NSDate new] withFormat:DateFormatFullDate]];
    }
    
    
    [self.idPositiveView.selectImageView sd_setImageWithURL:[NSURL URLWithString:self.viewModel.applyObject.idCardFrontUrl] completed:^(UIImage* image, NSError* error , SDImageCacheType cacheType, NSURL* imageUrl){
        [ws.idPositiveView.addButton setImage:image forState:UIControlStateNormal];
    }];
    [self.idNegativeView.selectImageView sd_setImageWithURL:[NSURL URLWithString:self.viewModel.applyObject.idCardBackUrl] completed:^(UIImage* image, NSError* error , SDImageCacheType cacheType, NSURL* imageUrl){
        [ws.idNegativeView.addButton setImage:image forState:UIControlStateNormal];

    }];
    [self.guiderIDView.selectImageView sd_setImageWithURL:[NSURL URLWithString:self.viewModel.applyObject.tourPicUrl] completed:^(UIImage* image, NSError* error , SDImageCacheType cacheType, NSURL* imageUrl){
        [ws.guiderIDView.addButton setImage:image forState:UIControlStateNormal];

    }];
    [self.otherIDView.selectImageView sd_setImageWithURL:[NSURL URLWithString:self.viewModel.applyObject.otherCertificateUrl] completed:^(UIImage* image, NSError* error , SDImageCacheType cacheType, NSURL* imageUrl){
        [ws.otherIDView.addButton setImage:image forState:UIControlStateNormal];

    }];

}


/**
 申请导游
 */
-(void)saveTour{

    if (!self.viewModel) {
        self.viewModel = [[LBB_GuiderApplyViewModel alloc] init];
    }
    
    if (self.nameTextField.rightTextField.text.length <= 0) {
        [self showHudPrompt:@"请输入姓名!"];
        return;
    }
    
    if (self.identityIDTextField.rightTextField.text.length <= 0 ) {
        [self showHudPrompt:@"请输入身份证号码!"];
        return;
    }
    else if([self.identityIDTextField.rightTextField.text validateIdentityCard] == NO){
        [self showHudPrompt:@"输入的身份证号码格式错误!"];
        return;
    }
    
    if (self.guiderIDTextField.rightTextField.text.length <= 0) {
        [self showHudPrompt:@"请输入导游证号!"];
        return;
    }
    
    if (self.workTimeTextField.rightTextField.text.length <= 0) {
        [self showHudPrompt:@"请输入从业时间!"];
        return;
    }
    
    if (self.telTextField.rightTextField.text.length <= 0 ) {
        [self showHudPrompt:@"请输入联系电话!"];
        return;
    }
    else if([self.telTextField.rightTextField.text validatePhone] == NO){
        [self showHudPrompt:@"输入的电话号码格式错误!"];
        return;
    }
    
    if (self.shortIntroTextField.rightTextField.text.length <= 0) {
        [self showHudPrompt:@"请输入一句话介绍!"];
        return;
    }
    
    if (self.detailIntroTextField.bottomTextField.text.length <= 0) {
        [self showHudPrompt:@"请输入详细介绍!"];
        return;
    }
    if (self.idPositiveView.selectImageView.image == nil) {
        [self showHudPrompt:@"身份证正面照不能为空!"];
        return;
    }
    if (self.idNegativeView.selectImageView.image == nil) {
        [self showHudPrompt:@"身份证反面照不能为空!"];
        return;
    }
    if (self.guiderIDView.selectImageView.image == nil) {
        [self showHudPrompt:@"导游证照片不能为空!"];
        return;
    }
    
    self.viewModel.applyObject.realName = self.nameTextField.rightTextField.text;
    self.viewModel.applyObject.idCard = self.identityIDTextField.rightTextField.text;
    self.viewModel.applyObject.tourIdCard = self.guiderIDTextField.rightTextField.text;
    self.viewModel.applyObject.tourStartTime = self.workTimeTextField.rightTextField.text;
    self.viewModel.applyObject.phoneNum = self.telTextField.rightTextField.text;
    self.viewModel.applyObject.tourAWords = self.shortIntroTextField.rightTextField.text;
    self.viewModel.applyObject.tourDetails = self.detailIntroTextField.bottomTextField.text;
    
    [self.viewModel.applyObject.auditTags removeAllObjects];
    for (int i = 0; i < self.viewModel.applyObject.auditTags.count; i++) {
        
        NSNumber* num = self.labelTagView.flagArray[i];
        BOOL status = [num boolValue];
        if (status) {
            LBB_GuiderApplyTagsObject* obj = [[LBB_GuiderApplyTagsObject alloc] init];
            LBB_GuiderApplyTagsObject* option = self.viewModel.applyObject.auditTags[i];
            obj.tagId = option.tagId;
            [self.viewModel.applyObject.auditTags addObject:obj];
        }
    }
    
    WS(ws);
    NSLog(@"self.viewModel:%@",self.viewModel);
    [self.viewModel saveTour:self.idPositiveView.selectImageView.image
             idCardBackImage:self.idNegativeView.selectImageView.image
                tourPicImage:self.guiderIDView.selectImageView.image
       otherCertificateImage:self.otherIDView.selectImageView.image
                        succ:^(LBB_GuiderApplyObject* applyObjcet){
                            LBB_GuiderApplyResultViewController* dest = [[LBB_GuiderApplyResultViewController alloc]init];
                            dest.isRemote = YES;
                            [ws.navigationController pushViewController:dest animated:YES];
                        }
                       faile:^(LBB_GuiderAuditResultObject* resultObject){
                           LBB_GuiderApplyResultViewController* dest = [[LBB_GuiderApplyResultViewController alloc]init];
                           dest.isRemote = NO;
                           dest.viewModel.applyResult = resultObject;
                           [ws.navigationController pushViewController:dest animated:YES];
                       }
                       error:^(NSError* error){
                       
                       }];
}

@end
