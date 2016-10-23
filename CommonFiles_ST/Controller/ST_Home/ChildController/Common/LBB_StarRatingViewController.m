//
//  LBB_StarRatingViewController.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/22.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_StarRatingViewController.h"
#import "CWStarRateView.h"
#import <CTAssetsPickerController/CTAssetsPickerController.h>
#import <CTAssetsPickerController/CTAssetsPageViewController.h>

static const NSInteger kViewMarginLeft = 15;
static const NSInteger kPictureMaxCol = 4;
static const NSInteger kPictureInterval = 10;

@interface LBB_StarRatingViewController ()<CWStarRateViewDelegate,CTAssetsPickerControllerDelegate>

@property (nonatomic, retain) CWStarRateView *starRatingView;
@property (nonatomic, retain) UIScrollView *mainScrollView;
@property (nonatomic, retain) UITextView* textField;
@property (nonatomic, retain) UIView *picturePanel;

@property (nonatomic, retain) UIButton *submitButton;
@property (nonatomic, strong) NSMutableArray *pictures;

@property (nonatomic, strong) PHImageRequestOptions *requestOptions;
@property (nonatomic, strong) CTAssetsPickerController *picker;


@end

@implementation LBB_StarRatingViewController

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
    self.title = @"评论";
}

-(void)buildControls{

    WS(ws);
    
    self.mainScrollView = [UIScrollView new];
    [self.mainScrollView setContentSize:CGSizeMake(0, UISCREEN_HEIGTH)];
    NSLog(@"height:%f",UISCREEN_HEIGTH);
    [self.mainScrollView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.mainScrollView];
    [self.mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.view);
        make.bottom.equalTo(ws.view);
        make.width.centerX.equalTo(ws.view);
    }];

    CGFloat margin = 8;
    
    //config star view
    UIView* v1 = [UIView new];
    [self.mainScrollView addSubview:v1];
    [v1 mas_makeConstraints:^(MASConstraintMaker* make){
        make.centerX.width.equalTo(ws.mainScrollView);
        make.top.equalTo(ws.mainScrollView).offset(2*margin);
    }];
    
    UILabel* l1 = [UILabel new];
    [l1 setText:@"评论得分: "];
    [l1 setFont:Font3];
    [v1 addSubview:l1];
    [l1 mas_makeConstraints:^(MASConstraintMaker* make){
        make.centerY.equalTo(v1);
        make.left.equalTo(v1).offset(margin);
        make.width.equalTo(@70);
    }];
    
    CGFloat starWidth = UISCREEN_WIDTH  - 70 - margin - 2*margin;
    CGFloat starHeigth = 30;
    self.starRatingView = [[CWStarRateView alloc] initWithFrame:CGRectMake(0, 0, starWidth, starHeigth)
                                                     numberOfStars:5];
    self.starRatingView.scorePercent = 0.9;
    self.starRatingView.allowIncompleteStar = YES;
    self.starRatingView.hasAnimation = YES;
    self.starRatingView.delegate = self;
    [v1 addSubview:self.starRatingView];
    [self.starRatingView mas_makeConstraints:^(MASConstraintMaker* make){
        make.centerY.equalTo(v1);
        make.left.equalTo(l1.mas_right).offset(margin*0);
        make.right.equalTo(v1).offset(-2*margin);
        make.height.mas_equalTo(starHeigth);
        make.top.bottom.equalTo(v1);
    }];
    
    //评论描述
    UILabel* l2 = [UILabel new];
    [l2 setText:@"评论描述: "];
    [l2 setFont:Font3];
    [self.mainScrollView addSubview:l2];
    [l2 mas_makeConstraints:^(MASConstraintMaker* make){
        
        make.top.equalTo(v1.mas_bottom).offset(margin);
        make.left.equalTo(v1).offset(margin);
    }];
    
    self.textField = [UITextView new];
    self.textField.placeholder = @"请输入您的评论内容";
    [self.textField setFont:Font5];
    self.textField.layer.borderColor = [UIConstants getSeperatorLineColor].CGColor;
    self.textField.layer.borderWidth = SeparateLineWidth;
    [self.mainScrollView addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker* make){
        
        make.top.equalTo(l2.mas_bottom).offset(margin);
        make.width.equalTo(ws.mainScrollView).offset(-4*margin);
        make.centerX.equalTo(ws.mainScrollView);
        make.height.equalTo(@150);
    }];
    
    //图片
    self.picturePanel = [UIView new];
    [self.mainScrollView addSubview:self.picturePanel];
    [self.picturePanel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.textField.mas_bottom).offset(margin);
        make.width.centerX.equalTo(ws.mainScrollView);
    }];
    
    
    //submit
    self.submitButton = [UIButton new];
    [self.submitButton setTitle:@"提交评论" forState:UIControlStateNormal];
    [self.submitButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.submitButton.titleLabel setFont:Font2];
    self.submitButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.submitButton.layer.borderWidth = SeparateLineWidth;
    [self.mainScrollView addSubview:self.submitButton];
    [self.submitButton mas_makeConstraints:^(MASConstraintMaker* make){
        
        make.top.equalTo(ws.picturePanel.mas_bottom).offset(margin);
        make.centerX.equalTo(ws.mainScrollView);
        make.height.equalTo(@40);
        make.width.equalTo(@120);
    }];
    [self.submitButton bk_addEventHandler:^(id sender){
        
        [ws showHudPrompt:@"提交啦"];
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self refreshPicturePanel];
}



- (void)refreshPicturePanel{
    WS(ws);
    [self.picturePanel removeAllSubviews];
    
    
    CGFloat width = ([UIScreen mainScreen].bounds.size.width - 2 * kViewMarginLeft - (kPictureMaxCol-1)*kPictureInterval)/kPictureMaxCol;
    UIView *sep = [UIView new];
    [sep setHidden:YES];
    [self.picturePanel addSubview:sep];
    [sep mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.top.centerX.equalTo(self.picturePanel);
        make.height.equalTo(@1);
    }];
    sep.backgroundColor = [UIConstants getSeperatorLineColor];
    UIView *lastView = sep;
    
    NSInteger count = self.pictures.count + 1;
    
    for (int i = 0; i < count; i++) {
        UIImageView *v = [UIImageView new];
        [v setTag:i];
        [self.picturePanel addSubview:v];
        
        int col = i % kPictureMaxCol;
        int row = i / kPictureMaxCol;
        
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(width);
            make.left.equalTo(self.picturePanel).offset(col*(width+kPictureInterval)+kViewMarginLeft);
            make.top.equalTo(self.picturePanel).offset(row*(width+kPictureInterval) + kViewMarginLeft);
        }];
        v.contentMode = UIViewContentModeScaleAspectFill;
        v.clipsToBounds = YES;
        
        lastView = v;
        
        if (i == self.pictures.count) {
            v.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [UITapGestureRecognizer bk_recognizerWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
                
                [ws.textField resignFirstResponder];

                // init picker
                if (!ws.picker) {
                    ws.picker = [[CTAssetsPickerController alloc] init];
                }

                // set delegate
                ws.picker.delegate = ws;
                
                // Optionally present picker as a form sheet on iPad
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                    ws.picker.modalPresentationStyle = UIModalPresentationFormSheet;
                
                // present picker
                [ws presentViewController:ws.picker animated:YES completion:nil];

            }];
            [v addGestureRecognizer:tap];
            
            v.image = [UIImage imageNamed:PlaceHolderImage];
        }else{
            
            if ([self.pictures[i] isKindOfClass:[UIImage class]]) {
                v.image = self.pictures[i];
            }else{
                [v sd_setImageWithURL:self.pictures[i]];
            }
            
            
            v.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [UITapGestureRecognizer bk_recognizerWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
            
                CTAssetsPageViewController *vc = [[CTAssetsPageViewController alloc] initWithAssets:ws.picker.selectedAssets];
                vc.pageIndex = v.tag;
                [ws.navigationController pushViewController:vc animated:YES];

            
            }];
            [v addGestureRecognizer:tap];
        }
    }
    
    [self.picturePanel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lastView.mas_bottom).offset(kViewMarginLeft);
    }];
}


#pragma CWStarRateView delegate
- (void)starRateView:(CWStarRateView *)starRateView scroePercentDidChange:(CGFloat)newScorePercent{
    
    NSLog(@"newScorePercent:%f",newScorePercent);
    [starRateView setScorePercent:newScorePercent];
}

#pragma CTAssetsPickerController delegate

- (void)assetsPickerController:(CTAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
    // assets contains PHAsset objects.
    NSLog(@"CTAssetsPickerController didFinishPickingAssets:%@",assets);
    [picker dismissViewControllerAnimated:YES completion:nil];

    if (!self.pictures) {
        self.pictures = [NSMutableArray new];
    }
    [self.pictures removeAllObjects];
    if (!self.requestOptions) {
        self.requestOptions = [[PHImageRequestOptions alloc] init];
        self.requestOptions.resizeMode   = PHImageRequestOptionsResizeModeExact;
        self.requestOptions.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    }

    WS(ws);
    for (PHAsset *asset in assets) {
        PHImageManager *manager = [PHImageManager defaultManager];
        [manager requestImageForAsset:asset targetSize:CGSizeMake(200, 100) contentMode:PHImageContentModeAspectFill options:self.requestOptions resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            
            [ws.pictures addObject:result];
            [ws refreshPicturePanel];

        }];
    }

}
- (BOOL)assetsPickerController:(CTAssetsPickerController *)picker shouldSelectAsset:(PHAsset *)asset
{
    NSInteger max = 9;
    
    // show alert gracefully
    // show alert gracefully
    if (picker.selectedAssets.count >= max)
    {
        UIAlertController *alert =
        [UIAlertController alertControllerWithTitle:@"提示"
                                            message:[NSString stringWithFormat:@"最多只能选择 %ld 张照片", (long)max]
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action =
        [UIAlertAction actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                               handler:nil];
        
        [alert addAction:action];
        
        [picker presentViewController:alert animated:YES completion:nil];
    }
    
    // limit selection to max
    return (picker.selectedAssets.count < max);
}

@end