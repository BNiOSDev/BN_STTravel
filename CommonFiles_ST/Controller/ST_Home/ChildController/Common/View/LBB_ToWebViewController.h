//
//  LBB_ToWebViewController.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/21.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "PoohBaseViewController.h"

@interface LBB_ToWebViewController : Base_BaseViewController

@property(nonatomic,copy)NSString* webTitle;

@property(nonatomic,copy)NSURL* url;

@property(nonatomic,copy)NSString* htmlString;
@property(nonatomic,assign)BOOL isLoadHtml;

@end
