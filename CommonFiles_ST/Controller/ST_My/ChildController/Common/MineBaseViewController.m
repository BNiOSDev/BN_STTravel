//
//  MineBaseViewController.m
//  LUBABA
//
//  Created by Dianar on 16/10/9.
//  Copyright © 2016年 Dianar. All rights reserved.
//

#import "MineBaseViewController.h"
#import "ST_TabBarController.h"


@interface MineBaseViewController ()

@end

@implementation MineBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadCustomNavigationButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buildControls
{
    self.bottomViewBottomContraint.constant = TabHeight;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setNavigationBarHidden:NO];
}
    
- (void)setBaseViewType:(MineBaseViewType)baseViewType
{
    _baseViewType = baseViewType;
    [self initTopBarUI];
}

- (void)initTopBarUI
{ 
    switch (self.baseViewType) {
        case eWallet://我的钱包
        {
           self.navigationItem.title = NSLocalizedString(@"我的钱包", nil);
        }
            break;
        case ePersonalCenter://个人中心
        {
            self.navigationItem.title = NSLocalizedString(@"个人中心", nil);
        }
            break;
        case eEditUserName://用户名
        {
            self.navigationItem.title = NSLocalizedString(@"用户名", nil);
        }
            break;
        case eEditUserSignature://用户名
        {
            self.navigationItem.title = NSLocalizedString(@"个人签名", nil);
        }
            break;
        case eAddress://收货地址
        {
            self.navigationItem.title = NSLocalizedString(@"收货地址", nil);
        }
            break;
        case eAddAddress://新建收货地址
        {
            self.navigationItem.title = NSLocalizedString(@"新建收货地址", nil);
        }
            break;
        case eBalance://我的余额:
        {
            self.navigationItem.title = NSLocalizedString(@"我的余额", nil);
        }
            break;
        case eBalanceExtract: //余额提现
        {
           self.navigationItem.title = NSLocalizedString(@"余额提现", nil);
        }
            break;
        case eExtractVerification: //提现验证
        {
            self.navigationItem.title = NSLocalizedString(@"提现验证", nil);
        }
            break;
            
        case eBalanceDetail: //余额明细
        {
           self.navigationItem.title = NSLocalizedString(@"余额明细", nil);
        }
            break;
        case eCard: //我的银行卡
        {
//           self.topBarNibView.contentView.rightBtn.hidden  = NO;
           self.navigationItem.title = NSLocalizedString(@"我的银行卡", nil);
        }
            break;
        case eAddCard: //我的银行卡
        {
            self.navigationItem.title = NSLocalizedString(@"添加银行卡", nil);
        }
        break;
        
        case eCardDetail://银行卡详情
        {
           self.navigationItem.title = NSLocalizedString(@"余额明细", nil);
        }
            break;
        case ePoints://我的积分
        {
            self.navigationItem.title = NSLocalizedString(@"我的积分", nil);
        }
            break;
        case ePointConvert://积分兑换
        {
            self.navigationItem.title = NSLocalizedString(@"积分兑换", nil);
        }
            break;
        case ePointDetail://积分明细
        {
            self.navigationItem.title = NSLocalizedString(@"积分明细", nil);
        }
            break;
        case eTickets://查看全部-门票
        case eTicket_WaitPay: //我的门票_待付款
        case eTicket_WaitGetTicket: //我的门票_待取票
        case eTicket_WaitComment: //我的门票_待评价
        case eTicket_Refund: //我的门票_退款
        {
            self.navigationItem.title = NSLocalizedString(@"我的门票", nil);
        }
            break;
        case eFavorite://我的收藏
        {
            self.navigationItem.title = NSLocalizedString(@"我的收藏", nil);
        }
            break;
        case eTravels://我的游记
        {
            self.navigationItem.title = NSLocalizedString(@"我的游记", nil);
        }
            break;
        case eDownload://我的下载
        {
           self.navigationItem.title = NSLocalizedString(@"我的下载", nil);
        }
            break;
        case eFightGroups://我的拼团
        {
           self.navigationItem.title = NSLocalizedString(@"我的拼团", nil);
        }
            break;
        case eRoute://我的线路
        {
            self.navigationItem.title = NSLocalizedString(@"我的线路", nil);
        }
            break;
        case eSetting: //我的设置
        {
            self.navigationItem.title = NSLocalizedString(@"设置", nil);
        }
            break;
        case eSettingPush://推送消息
        {
            self.navigationItem.title = NSLocalizedString(@"推送消息", nil);
        }
            break;
        case eSettingPrivace: //隐私
        {
            self.navigationItem.title = NSLocalizedString(@"隐私", nil);
        }
            break;
        case eMessageCenter://消息中心
        {
            self.navigationItem.title = NSLocalizedString(@"消息中心", nil);
        }
            break;
        case ePromotions://消息中心- 优惠促销
        {
            self.navigationItem.title = NSLocalizedString(@"优惠促销", nil);
        }
            break;
        case eCustomer://消息中心-我的客服
        {
            self.navigationItem.title = NSLocalizedString(@"我的客服", nil);
        }
            break;
        case ePurchageNotifion://消息中心-购买通知
        {
            self.navigationItem.title = NSLocalizedString(@"购买通知", nil);
        }
            break;
        case eNotice://消息中心-鹭爸公告
        {
            self.navigationItem.title = NSLocalizedString(@"鹭爸公告", nil);
        }
            break;
        case eSquareTravel://消息中心-广场游记
        {
            self.navigationItem.title = NSLocalizedString(@"广场游记", nil);
        }
            break;

        default:
            break;
    }
   
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark -  UI Action
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)leftBtnClickDelegate:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
