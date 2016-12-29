//
//  LBB_ShopChatViewController.h
//  ST_Travel
//
//  Created by 美少男 on 16/12/29.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "Base_BaseViewController.h"

@interface LBB_ShopChatViewController : Base_BaseViewController

/**
 * 商场聊天
 * @parames chatid 百川聊天ID
 **/
- (instancetype)initWithChatId:(NSString*)chatID;

/**
 * 设置聊天ID
 * @parames chatid 百川聊天ID
 **/

- (void)setupChatID:(NSString *)chatID;

@end
