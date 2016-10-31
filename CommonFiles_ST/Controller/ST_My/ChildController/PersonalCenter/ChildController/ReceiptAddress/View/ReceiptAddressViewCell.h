//
//  ReceiptAddressViewCell.h
//  ST_Travel
//
//  Created by Diana on 16/10/19.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ReceiptAddressViewCellDelegate <NSObject>

@optional
- (void)didDeleteCellAddress:(id)cellInfo;
- (void)didEditCellAddress:(id)cellInfo;
- (void)setDefautlCellAdress:(id)cellInfo;

@end

@interface ReceiptAddressViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *defaultLabel;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UILabel *adressLabel;
@property (weak, nonatomic) IBOutlet UIButton *defaultBtn;
@property (weak, nonatomic) IBOutlet UILabel *streetLabel;

@property (nonatomic,strong) NSDictionary *cellInfo;
@property (nonatomic,weak)id<ReceiptAddressViewCellDelegate> delegate;

@end
