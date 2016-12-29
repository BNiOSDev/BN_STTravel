//
//  LBB_ShopChatViewController.m
//  ST_Travel
//
//  Created by dhxiang on 16/12/29.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_ShopChatViewController.h"
#import "SPKitExample.h"

@interface LBB_ShopChatViewController ()

@property(nonatomic,strong) NSString *chatID;
@property(nonatomic,strong) UINavigationController *parentNavi;

@end

@implementation LBB_ShopChatViewController

/**
 * 商场聊天
 * @parames chatid 百川聊天ID
 **/
- (instancetype)initWithChatId:(NSString*)chatID
{
    self = [super init];
    if(self) {
        self.chatID = chatID;
        self.title = self.chatID;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    YWPerson *person=[[YWPerson alloc]initWithPersonId:self.chatID EServiceGroupId:nil baseContext:[SPKitExample sharedInstance].ywIMKit.IMCore];
    YWConversation *conversation=[YWP2PConversation fetchConversationByPerson:person creatIfNotExist:YES baseContext:[SPKitExample sharedInstance].ywIMKit.IMCore];
    
    YWConversationViewController *conversationController=[[SPKitExample sharedInstance].ywIMKit makeConversationViewControllerWithConversationId:conversation.conversationId];
    
    [self addChildViewController:conversationController];
    
    
    for (int i=0; i<self.childViewControllers.count; i++) {
        UIViewController * vc = self.childViewControllers[i];
        vc.view.frame = CGRectMake(i * DeviceWidth, 0, DeviceWidth, self.view.frame.size.height);
        [self.view addSubview:vc.view];
    }
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
