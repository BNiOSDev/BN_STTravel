//
//  LBB_DiscoveryCustomizedViewController.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/22.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_DiscoveryCustomizedViewController.h"
#import "LBB_DiscoveryCustomizedSelectView.h"
#import "PoohCommon.h"
#import "LBB_AddressAddViewController.h"
#import "UITextField+TPCategory.h"
#import "LBB_DiscoveryCustomizedPopView.h"

static CGFloat margin = 8;
static CGFloat height = 45;


@interface LBB_DiscoveryCustomizedViewController ()

@property(nonatomic, retain)LBB_DiscoveryCustomizedSelectView* startTimeSelectView;
@property(nonatomic, retain)LBB_DiscoveryCustomizedSelectView* areaSelectView;
@property(nonatomic, retain)LBB_DiscoveryCustomizedSelectView* addMoreAreaView;

@property(nonatomic, retain)UIButton* tag1;
@property(nonatomic, retain)UIButton* tag2;
@property(nonatomic, retain)UIButton* tag3;

@property(nonatomic, assign)NSInteger tagIndex;

@property(nonatomic, retain)LBB_DiscoveryCustomizedPopView* popView;

@property(nonatomic, retain)NSMutableArray* dataArray;
@property(nonatomic, retain)UIView* scenicPanel;
@property(nonatomic, retain) UIScrollView *mainScrollView;
@property(nonatomic, retain)UIButton* submitButton;

@end

@implementation LBB_DiscoveryCustomizedViewController

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
    CGFloat height = self.submitButton.frame.origin.y + self.submitButton.size.height + 30;
    if (height <= DeviceHeight) {
        height = DeviceHeight;
    }
    [self.mainScrollView setContentSize:CGSizeMake(0, height)];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

/*
 * setup navigation bar view
 */
-(void)loadCustomNavigationButton{
    self.title = @"定制路线";
}

/*
 * setup UI
 */
-(void)buildControls{
    
    WS(ws);
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.dataArray = [NSMutableArray new];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.mainScrollView = [UIScrollView new];
    [self.mainScrollView setBackgroundColor:[UIColor whiteColor]];
    [self.mainScrollView setContentSize:CGSizeMake(0, UISCREEN_HEIGTH)];
    [self.mainScrollView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.mainScrollView];
    [self.mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.view);
        make.width.height.centerX.equalTo(ws.view);
    }];
    
    self.startTimeSelectView = [[LBB_DiscoveryCustomizedSelectView alloc]init];
    [self.startTimeSelectView.titleLabel setText:@"行程时间"];
    [self.mainScrollView addSubview:self.startTimeSelectView];
    [self.startTimeSelectView mas_makeConstraints:^(MASConstraintMaker* make){
        make.top.equalTo(ws.mainScrollView).offset(2*margin);
        make.centerX.width.equalTo(ws.mainScrollView);
        make.height.mas_equalTo(height);

        
    }];

    
    self.areaSelectView = [[LBB_DiscoveryCustomizedSelectView alloc]init];
    [self.areaSelectView.titleLabel setText:@"选择景点"];
    [self.mainScrollView addSubview:self.areaSelectView];
    [self.areaSelectView mas_makeConstraints:^(MASConstraintMaker* make){
        make.top.equalTo(ws.startTimeSelectView.mas_bottom).offset(2*margin);
        make.centerX.width.equalTo(ws.startTimeSelectView);
        make.height.equalTo(ws.startTimeSelectView);
    }];
  
    
    self.scenicPanel = [UIView new];
    [self.mainScrollView addSubview:self.scenicPanel];
    [self.scenicPanel mas_makeConstraints:^(MASConstraintMaker* make){
        make.top.equalTo(ws.areaSelectView.mas_bottom).offset(2*margin);
        make.centerX.width.equalTo(ws.startTimeSelectView);
    }];
    
    self.addMoreAreaView = [[LBB_DiscoveryCustomizedSelectView alloc]init];
    [self.addMoreAreaView.titleLabel setText:@""];
    [self.addMoreAreaView.bgCtrlView setPlaceholder:@""];
    [self.addMoreAreaView showAddMoreView:YES];
    [self.mainScrollView addSubview:self.addMoreAreaView];
    [self.addMoreAreaView mas_makeConstraints:^(MASConstraintMaker* make){
        make.top.equalTo(ws.scenicPanel.mas_bottom);
        make.centerX.width.equalTo(ws.startTimeSelectView);
        make.height.equalTo(ws.startTimeSelectView);
    }];
    
    //config tag
    UIView* tagView = [UIView new];
    [self.mainScrollView addSubview:tagView];
    [tagView mas_makeConstraints:^(MASConstraintMaker* make){
        
        make.top.equalTo(ws.addMoreAreaView.mas_bottom).offset(2*margin);
        make.centerX.width.height.equalTo(ws.startTimeSelectView);
    }];
    UILabel* l = [UILabel new];
    [l setText:@"个性标签"];
    [l setFont:Font14];
    [l setTextAlignment:NSTextAlignmentCenter];
    [tagView addSubview:l];
    [l mas_makeConstraints:^(MASConstraintMaker* make){
        make.left.centerY.equalTo(tagView);
        make.width.equalTo(@100);
    }];
    
    self.tag1 = [[UIButton alloc]init];
    [self.tag1.titleLabel setFont:Font13];
    [self.tag1 setImage:IMAGE(@"ST_Discovery_Select") forState:UIControlStateNormal];
    [self.tag1 setTitle:@"我是吃货" forState:UIControlStateNormal];
    [self.tag1 setTitleColor:ColorBlack forState:UIControlStateNormal];
    [self.tag1 setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, -5)];
    [tagView addSubview:self.tag1];
    
    self.tag2 = [[UIButton alloc]init];
    [self.tag2.titleLabel setFont:Font13];
    [self.tag2 setImage:IMAGE(@"ST_Discovery_DeSelect") forState:UIControlStateNormal];
    [self.tag2 setTitle:@"潮男潮女" forState:UIControlStateNormal];
    [self.tag2 setTitleColor:ColorBlack forState:UIControlStateNormal];
    [self.tag2 setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, -5)];
    [tagView addSubview:self.tag2];
    
    self.tag3 = [[UIButton alloc]init];

    [self.tag3.titleLabel setFont:Font13];
    [self.tag3 setImage:IMAGE(@"ST_Discovery_DeSelect") forState:UIControlStateNormal];
    [self.tag3 setTitle:@"运动达人" forState:UIControlStateNormal];
    [self.tag3 setTitleColor:ColorBlack forState:UIControlStateNormal];
    [self.tag3 setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, -5)];
    [tagView addSubview:self.tag3];
    
    
    [self.tag1 mas_makeConstraints:^(MASConstraintMaker* make){
        make.centerY.top.bottom.equalTo(tagView);
        make.left.equalTo(l.mas_right);
       // make.height.equalTo(@18);
        
    }];
    [self.tag2 mas_makeConstraints:^(MASConstraintMaker* make){
        make.centerY.equalTo(tagView);
        make.left.equalTo(self.tag1.mas_right);
        make.height.width.equalTo(self.tag1);
    }];
    [self.tag3 mas_makeConstraints:^(MASConstraintMaker* make){
        make.centerY.equalTo(tagView);
        make.left.equalTo(self.tag2.mas_right);
        make.height.width.equalTo(self.tag1);
        make.right.equalTo(tagView).offset(-2*margin);
    }];
    
    UIView* sep = [UIView new];
    [sep setBackgroundColor:ColorLine];
    [self.mainScrollView addSubview:sep];
    [sep mas_makeConstraints:^(MASConstraintMaker* make){
        make.centerX.equalTo(ws.view);
        make.height.mas_equalTo(SeparateLineWidth);
        make.left.equalTo(ws.view).offset(2*margin);
        make.right.equalTo(ws.view).offset(-2*margin);
        make.top.equalTo(tagView.mas_bottom).offset(2*margin);

    }];
    sep.hidden = YES;
    
    UIButton* submit = [UIButton new];
    [submit setTitle:@"立即提交" forState:UIControlStateNormal];
    [submit.titleLabel setFont:Font15];
    [submit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submit setBackgroundColor:ColorBtnYellow];
    [self.mainScrollView addSubview:submit];
    [submit mas_makeConstraints:^(MASConstraintMaker* make){
        make.centerX.equalTo(ws.view);
        make.top.equalTo(sep.mas_bottom).offset(margin);
    //    make.left.right.equalTo(sep);
        make.height.mas_equalTo(AutoSize(77/2));
        make.width.mas_equalTo(AutoSize(400/2));
    }];
    self.submitButton = submit;
    
#pragma action
    
    @weakify(self);
    [RACObserve(self, tagIndex) subscribeNext:^(NSNumber* index) {
        @strongify(self);
        [self.tag1 setImage:IMAGE(@"ST_Discovery_DeSelect") forState:UIControlStateNormal];
        [self.tag2 setImage:IMAGE(@"ST_Discovery_DeSelect") forState:UIControlStateNormal];
        [self.tag3 setImage:IMAGE(@"ST_Discovery_DeSelect") forState:UIControlStateNormal];
        switch ([index integerValue]) {
            case 0:
                [self.tag1 setImage:IMAGE(@"ST_Discovery_Select") forState:UIControlStateNormal];
                break;
            case 1:
                [self.tag2 setImage:IMAGE(@"ST_Discovery_Select") forState:UIControlStateNormal];
                break;
            case 2:
                [self.tag3 setImage:IMAGE(@"ST_Discovery_Select") forState:UIControlStateNormal];
                break;
            default:
                break;
        }
    }];
    
    [self.tag1 bk_whenTapped:^{
        ws.tagIndex = 0;
    }];
    [self.tag2 bk_whenTapped:^{
        ws.tagIndex = 1;
    }];
    [self.tag3 bk_whenTapped:^{
        ws.tagIndex = 2;
    }];
    

    self.startTimeSelectView.bgCtrlView.bk_shouldBeginEditingBlock = ^(UITextField* text){
        
        UIAlertController *c = [UIAlertController alertControllerWithTitle:@"请选择行程时间" message:nil preferredStyle:UIAlertControllerStyleActionSheet];

        UIAlertAction *oneDayAction = [UIAlertAction actionWithTitle:@"1天" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
            [text setText:@"1天"];
        }];
        UIAlertAction *twoDayAction = [UIAlertAction actionWithTitle:@"2天" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [text setText:@"2天"];

        }];
        UIAlertAction *threeDayAction = [UIAlertAction actionWithTitle:@"3天" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [text setText:@"3天"];

        }];
        UIAlertAction *fourDayAction = [UIAlertAction actionWithTitle:@"4天" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [text setText:@"4天"];

        }];
        UIAlertAction *manyDayAction = [UIAlertAction actionWithTitle:@"5-7天" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [text setText:@"5-7天"];

        }];
        
        UIAlertAction *oneWeekAction = [UIAlertAction actionWithTitle:@"一周" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [text setText:@"一周"];

        }];
        [c addAction:oneDayAction];
        [c addAction:twoDayAction];
        [c addAction:threeDayAction];
        [c addAction:fourDayAction];
        [c addAction:manyDayAction];
        [c addAction:oneWeekAction];
        [ws presentViewController:c animated:YES completion:nil];

        return NO;
    };
    self.areaSelectView.bgCtrlView.bk_shouldBeginEditingBlock = ^(UITextField* text){
    
        
        [text resignFirstResponder];
        LBB_AddressAddViewController* dest = [[LBB_AddressAddViewController alloc]init];
        dest.click = ^(LBB_AddressAddViewController* add,NSNumber* index){
            NSLog(@"回调地址:%ld",[index integerValue]);
            [ws.dataArray addObject:index];//回调回来数据
            [ws refreshScenicPanel];
            [add.navigationController popViewControllerAnimated:YES];
        };
        [ws.navigationController pushViewController:dest animated:YES];
        return NO;
    };
    
    self.addMoreAreaView.bgCtrlView.bk_shouldBeginEditingBlock = ^(UITextField* text){
        
        [text resignFirstResponder];
        LBB_AddressAddViewController* dest = [[LBB_AddressAddViewController alloc]init];
        dest.click = ^(LBB_AddressAddViewController* add,LBB_SpotAddress* address){
         //   [text setText:[NSString stringWithFormat:@"%ld",[index integerValue]]];
           // [ws.dataArray addObject:index];//回调回来数据
            [ws refreshScenicPanel];
            [add.navigationController popViewControllerAnimated:YES];
        };
        [ws.navigationController pushViewController:dest animated:YES];
        return NO;
    };
    
    [submit bk_addEventHandler:^(id sender){
        
        NSLog(@"sign touch");
        if (!ws.popView) {
            ws.popView = [[LBB_DiscoveryCustomizedPopView alloc]init];
        }
        [ws.popView showPopView];
        [ws.popView.confirmButton bk_addEventHandler:^(id sender){
            NSLog(@"ws.popView.confirmButton touch");
            
            ws.popView.hidden = YES;
            [ws.popView resignKeyWindow];
            ws.popView = nil;
            [ws.navigationController popViewControllerAnimated:YES];
        } forControlEvents:UIControlEventTouchUpInside];
        
    } forControlEvents:UIControlEventTouchUpInside];
    
}

//刷新选择的景点的数据
-(void)refreshScenicPanel{

    WS(ws);
    [self.scenicPanel removeAllSubviews];
    
    NSInteger count = self.dataArray.count;
    for (int i = 0; i < count; i++) {
        
        NSNumber* num = [self.dataArray objectAtIndex:i];
        LBB_DiscoveryCustomizedSelectView* scenic = [[LBB_DiscoveryCustomizedSelectView alloc]init];
        [scenic showDeleteImageView:YES];
        [scenic.bgCtrlView setText:[NSString stringWithFormat:@"%ld",[num integerValue]]];
        [scenic.bgCtrlView setPlaceholder:@""];
        [scenic setTag:i];
        [self.scenicPanel addSubview:scenic];
        [scenic mas_makeConstraints:^(MASConstraintMaker* make){
            make.top.equalTo(ws.scenicPanel).offset(i*(height+margin));
            make.centerX.width.equalTo(ws.scenicPanel);
            make.height.mas_equalTo(height);
            if (i == count - 1) {
                make.bottom.equalTo(ws.scenicPanel);
            }
        }];
        [scenic.rightButton bk_addEventHandler:^(id sender){
            NSLog(@"arrowImageView tab");
            [ws.dataArray removeObjectAtIndex:i];
            [ws refreshScenicPanel];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    

    
    [self.addMoreAreaView mas_remakeConstraints:^(MASConstraintMaker* make){
        if (count > 0) {
            make.top.equalTo(ws.scenicPanel.mas_bottom).offset(2*margin);
        }
        else{
            make.top.equalTo(ws.scenicPanel.mas_bottom);
        }
        make.centerX.width.equalTo(ws.startTimeSelectView);
        make.height.equalTo(ws.startTimeSelectView);
    }];
    
    [self.mainScrollView layoutSubviews];
    
}

@end
