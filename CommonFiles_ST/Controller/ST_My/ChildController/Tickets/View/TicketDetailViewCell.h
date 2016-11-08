//
//  TicketDetailViewCell.h
//  LUBABA
//
//  Created by 晨曦 on 16/10/12.
//  Copyright © 2016年 晨曦. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBB_TicketModel.h"

@interface TicketDetailViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *monneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageWidthContraint;

@property(nonatomic,strong) LBB_TicketModelDetail* cellInfo;

@end
