//
//  LBB_DiscoveryCustomizedViewController.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/22.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_DiscoveryCustomizedViewController.h"
#import "LBB_DiscoveryCustomizedSelectView.h"
#import "LBB_AddressAddViewController.h"
#import "UITextField+TPCategory.h"
#import "LBB_DiscoveryCustomizedPopView.h"
#import "LBB_TagsViewModel.h"
#import "LBB_DiscoveryCustomizedLabelView.h"

static CGFloat margin = 8;
static CGFloat height = 45;


@interface LBB_DiscoveryCustomizedViewController ()

@property(nonatomic, retain)LBB_DiscoveryCustomizedSelectView* startTimeSelectView;
@property(nonatomic, retain)LBB_DiscoveryCustomizedSelectView* areaSelectView;
@property(nonatomic, retain)LBB_DiscoveryCustomizedSelectView* addMoreAreaView;

@property(nonatomic, retain)LBB_DiscoveryCustomizedLabelView* tagView;

@property(nonatomic, retain)LBB_DiscoveryCustomizedPopView* popView;

@property(nonatomic, retain)UIView* scenicPanel;
@property(nonatomic, retain)UIScrollView *mainScrollView;
@property(nonatomic, retain)UIButton* submitButton;


@property(nonatomic, retain)NSArray<LBB_SquareTags*>* selectTimeArray;//行程时间数组
@property(nonatomic, retain)NSMutableArray<LBB_SquareTags*>* tagsArray;//标签数组
@property(nonatomic, retain)NSMutableArray<LBB_SpotAddress*>* scenicArray; //景区列表数据
@property(nonatomic, retain)LBB_SquareTags* timeLine;

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

-(void)initViewModel{

    /**
     3.1.13	筛选标签列表(已测)
     
     @param classes 1美食 2 民宿 3 景点 4 伴手礼  10 线路攻略11 美食专题 12民宿专题 13景点专题 14伴手礼专题 15  用户/导游
     @param type 1.热门推荐 2标签 3价格 4类别 5、设施 6、退票及预约提示 7、品牌 8、适合人群 9、个性标签 10、行程时长 11  导游类型  12  从业时间
     @param dataBlock 返回标签数据
     */
    WS(ws);
    [LBB_SquareTags getConditionTagsClass:10 type:10 block:^(NSArray<LBB_SquareTags*> *files, NSError *error){
    
        NSLog(@"获取行程时间files:%@",files);
        ws.selectTimeArray = files;
    }];
    
    
    [LBB_SquareTags getConditionTagsClass:10 type:9 block:^(NSArray<LBB_SquareTags*> *files, NSError *error){
        
        NSLog(@"获取个性标签files:%@",files);
        ws.tagsArray = [NSMutableArray arrayWithArray:files];
        [ws.tagView configContentView:ws.tagsArray];
        [ws.view layoutSubviews];
    }];
}




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
    self.scenicArray = [NSMutableArray new];
    
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
        make.centerX.width.equalTo(ws.startTimeSelectView);
    }];
    UILabel* l = [UILabel new];
    [l setText:@"个性标签"];
    [l setFont:Font14];
    [l setTextAlignment:NSTextAlignmentCenter];
    [tagView addSubview:l];
    [l mas_makeConstraints:^(MASConstraintMaker* make){
        make.left.top.equalTo(tagView);
        make.width.equalTo(@100);
    }];
    
    self.tagView = [[LBB_DiscoveryCustomizedLabelView alloc]init];
    [tagView addSubview:self.tagView];

    [self.tagView mas_makeConstraints:^(MASConstraintMaker* make){
        make.top.bottom.equalTo(tagView);
        make.left.equalTo(l.mas_right);
        make.right.equalTo(tagView);
    }];
    
    [self.tagView configContentView:self.tagsArray];
    
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
    

    self.startTimeSelectView.bgCtrlView.bk_shouldBeginEditingBlock = ^(UITextField* text){
        
        UIAlertController *c = [UIAlertController alertControllerWithTitle:@"请选择行程时间" message:nil preferredStyle:UIAlertControllerStyleActionSheet];

        for (LBB_SquareTags* tag in ws.selectTimeArray) {
            UIAlertAction *action = [UIAlertAction actionWithTitle:tag.tagName style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
                [text setText:tag.tagName];
                ws.timeLine = tag;
            }];
            [c addAction:action];
        }
        [ws presentViewController:c animated:YES completion:nil];

        return NO;
    };
    self.areaSelectView.bgCtrlView.bk_shouldBeginEditingBlock = ^(UITextField* text){
    
        [text resignFirstResponder];
        LBB_AddressAddViewController* dest = [[LBB_AddressAddViewController alloc]init];
        dest.selectedArray = ws.scenicArray;
        dest.click = ^(LBB_AddressAddViewController* add,LBB_SpotAddress* address){
            [ws.scenicArray addObject:address];//回调回来数据
            [ws refreshScenicPanel];
            [add.navigationController popViewControllerAnimated:YES];
        };
        [ws.navigationController pushViewController:dest animated:YES];
        return NO;
    };
    
    self.addMoreAreaView.bgCtrlView.bk_shouldBeginEditingBlock = ^(UITextField* text){
        
        [text resignFirstResponder];
        LBB_AddressAddViewController* dest = [[LBB_AddressAddViewController alloc]init];
        dest.selectedArray = ws.scenicArray;
        dest.click = ^(LBB_AddressAddViewController* add,LBB_SpotAddress* address){
            [ws.scenicArray addObject:address];//回调回来数据
            [ws refreshScenicPanel];
            [add.navigationController popViewControllerAnimated:YES];
        };
        [ws.navigationController pushViewController:dest animated:YES];
        return NO;
    };
    
    [submit bk_addEventHandler:^(id sender){
        
        if (!ws.timeLine) {
            [ws showHudPrompt:@"请选择行程时间!"];
            return ;
        }
        
        if (ws.scenicArray.count <= 0) {
            [ws showHudPrompt:@"请选择景点!"];
            return ;
        }
        
        if (ws.tagView.selectArray.count <= 0) {
            [ws showHudPrompt:@"请选择标签!"];
            return ;
        }
        
        
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
            ws.click(ws,ws.timeLine,ws.scenicArray,ws.tagView.selectArray);
            
         //   [ws.navigationController popViewControllerAnimated:YES];
        } forControlEvents:UIControlEventTouchUpInside];
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self initViewModel];
    
}

//刷新选择的景点的数据
-(void)refreshScenicPanel{

    WS(ws);
    [self.scenicPanel removeAllSubviews];
    
    NSInteger count = self.scenicArray.count;
    for (int i = 0; i < count; i++) {
        
        LBB_SpotAddress* address = [self.scenicArray objectAtIndex:i];
        LBB_DiscoveryCustomizedSelectView* scenic = [[LBB_DiscoveryCustomizedSelectView alloc]init];
        [scenic showDeleteImageView:YES];
        [scenic.bgCtrlView setText:[NSString stringWithFormat:@"%@",address.allSpotsName]];
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
            [ws.scenicArray removeObjectAtIndex:i];
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
