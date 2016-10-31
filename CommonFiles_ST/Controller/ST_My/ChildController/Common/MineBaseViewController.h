//
//  MineBaseViewController.h
//  LUBABA
//
//  Created by Dianar on 16/10/9.
//  Copyright © 2016年 Dianar. All rights reserved.
//

#import "Base_BaseViewController.h"
#import "Mine_Common.h"

@interface MineBaseViewController : Base_BaseViewController
    
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineHeightConstraint;
@property (assign, nonatomic) MineBaseViewType baseViewType;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewBottomContraint;

@end
