//
//  LBB_ScenicDetailAddressCell.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/26.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_ScenicDetailAddressCell.h"
#import "PoohCommon.h"
@implementation LBB_ScenicDetailAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    WS(ws);
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        CGFloat margin = 8;
        
        self.telButton = [UIButton new];
        [self.telButton setBackgroundImage:IMAGE(@"景点详情_电话") forState:UIControlStateNormal];
        [self.contentView addSubview:self.telButton];
        [self.telButton mas_makeConstraints:^(MASConstraintMaker* make){
            make.right.equalTo(ws.contentView).offset(-2*margin);
            make.width.height.mas_equalTo(AutoSize(22));
            make.top.equalTo(ws.contentView).offset(2*margin);

        }];
        
        self.nameLable = [UILabel new];
        [self.nameLable setFont:Font13];
        [self.nameLable setText:@"厦门曾厝垵景区"];
        [self.contentView addSubview:self.nameLable];
        [self.nameLable mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.centerY.equalTo(ws.telButton);
            make.left.equalTo(ws.contentView).offset(margin);
        }];
        
        self.addressButton = [UIButton new];
        [self.addressButton setBackgroundImage:IMAGE(@"景点详情_地址") forState:UIControlStateNormal];
        [self.contentView addSubview:self.addressButton];
        [self.addressButton mas_makeConstraints:^(MASConstraintMaker* make){
            make.right.equalTo(ws.telButton);
            make.width.height.equalTo(ws.telButton);
            make.top.equalTo(ws.telButton.mas_bottom).offset(margin);
        }];
        
        self.addressLable = [UILabel new];
        [self.addressLable setFont:Font13];
        [self.addressLable setText:@"厦门市思明区前埔路大家接口的"];
        [self.contentView addSubview:self.addressLable];
        [self.addressLable mas_makeConstraints:^(MASConstraintMaker* make){
            
         //   make.top.equalTo(ws.nameLable.mas_bottom).offset(2*margin);
            make.left.equalTo(ws.nameLable);
            make.centerY.equalTo(ws.addressButton);

        }];
        
        

       
        
        UIView* sep2 = [UIView new];
        [sep2 setBackgroundColor:ColorLine];
        [self.contentView addSubview:sep2];
        [sep2 mas_makeConstraints:^(MASConstraintMaker* make){
            make.bottom.centerX.width.equalTo(ws.contentView);
            make.height.mas_equalTo(SeparateLineWidth);
            make.top.equalTo(ws.addressLable.mas_bottom).offset(2*margin);
        }];
        
        [self.telButton bk_whenTapped:^{
            Base_BaseViewController* curVC = (Base_BaseViewController*)[ws getViewController];
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"" message:ws.model.phoneNo preferredStyle:UIAlertControllerStyleActionSheet];
            
            
            UIAlertAction* call = [UIAlertAction actionWithTitle:@"直接拨打" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action){
                
               // [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://4008-910-654"]];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",ws.model.phoneNo]]];

                
            }];
            UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action){
            
            }];
            [alert addAction:call];
            [alert addAction:cancel];
            [curVC presentViewController:alert animated:YES completion:nil];
            
        
        }];

        
    }
    return self;
}


-(void)setModel:(LBB_SpotDetailsViewModel *)model{
    
    _model = model;
    [self.nameLable setText:model.phoneNoRemark];
    [self.addressLable setText:model.address];
    
}

@end
