//
//  WalletViewCell.h
//  LUBABA
//
//  Created by Dianar on 16/10/9.
//  Copyright © 2016年 Dianar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WalletViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *contentImgView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;

@end
