//
//  LBB_ScenicDetailEquipmentCell.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/26.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_ScenicDetailEquipmentCell.h"
#import "LBBPoohVerticalButton.h"

static const NSInteger kViewMarginLeft = 0;

static const NSInteger kPictureMaxCol = 4;
static const NSInteger kPictureInterval = 0;

@interface LBB_ScenicDetailEquipmentCell()

@property(nonatomic, retain)UIView* panelView;

@end

@implementation LBB_ScenicDetailEquipmentCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    WS(ws);
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
     /*   NSArray* titleArray = @[@"Wi-Fi", @"地铁",@"近商圈",@"有酒吧区域"];
        NSArray* iconArray = @[@"景点详情_设施1",@"景点详情_设施2",@"景点详情_设施3",@"景点详情_设施4"];
        
        NSInteger count = [titleArray count];
        CGFloat margineLeft = 25;
        CGFloat width = (DeviceWidth - (count+1)*margineLeft)/count;
        
        UIView *sub = [UIView new];
        [self.contentView addSubview:sub];
        [sub mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.right.equalTo(ws.contentView);
            make.top.equalTo(ws.contentView).offset(8);
           // make.bottom.equalTo(ws.contentView).offset(-8);
         //   make.centerY.equalTo(ws.contentView);
        }];
        
        for (int i = 0 ; i<count; i++) {
            
            LBBPoohVerticalButton* btn = [[LBBPoohVerticalButton alloc]init];
            [btn setTag:i];
            [btn.titleLabel setText:[titleArray objectAtIndex:i]];
            [btn.titleLabel setTextColor:[UIColor blackColor]];
            [btn.titleLabel setFont:Font14];
            [btn.imageView setImage:IMAGE([iconArray objectAtIndex:i])];
            [sub addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker* make){
                make.top.equalTo(sub);
                make.left.equalTo(sub).offset(i*(width+margineLeft)+margineLeft);
                make.width.mas_equalTo(width);
                make.bottom.equalTo(sub);
            }];
            [btn bk_addEventHandler:^(LBBPoohVerticalButton* sender){
                
                NSLog(@"touch button %ld",sender.tag);
                
            } forControlEvents:UIControlEventTouchUpInside];
        }*/
        
        self.panelView = [UIView new];
        [self.panelView setBackgroundColor:ColorWhite];
        [self.contentView addSubview:self.panelView];
        [self.panelView mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.right.equalTo(ws.contentView);
            make.top.equalTo(ws.contentView).offset(8);
        }];
        
         UIView* sep = [UIView new];
         [sep setBackgroundColor:ColorLine];
         [self.contentView addSubview:sep];
         [sep mas_makeConstraints:^(MASConstraintMaker* make){
             make.top.equalTo(ws.panelView.mas_bottom).offset(8);
             make.left.right.equalTo(ws.contentView);
             make.height.mas_equalTo(SeparateLineWidth);
             make.bottom.equalTo(ws.contentView);
         }];
    }
    return self;
}


-(void)setFacilities:(NSMutableArray<LBB_SpotsFacilities *> *)facilities{
    
    WS(ws);
        
    _facilities = facilities;
    
    [self.panelView removeAllSubviews];
    
    CGFloat margin = 8;
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width/kPictureMaxCol;
    CGFloat height = AutoSize(58/2);
    
    UIView *lastView = nil;
    
    NSInteger count  = facilities.count;
    
    for (int i = 0; i < count; i++) {
        UIButton *v = [UIButton new];
        LBB_SpotsFacilities* tag = [facilities objectAtIndex:i];
        [v setTitle:tag.tagName forState:UIControlStateNormal];
        [v.titleLabel setFont:Font13];
        [v setTitleColor:ColorBlack forState:UIControlStateNormal];
       // [v setBackgroundColor:[UIColor getRandomColor]];
        [self.panelView addSubview:v];
        
        int col = i % kPictureMaxCol;
        int row = i / kPictureMaxCol;
        
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(height);
            make.left.equalTo(ws.panelView).offset(col*(width+kPictureInterval)+kViewMarginLeft);
            make.top.equalTo(ws.panelView).offset(row*(height+kPictureInterval) + kViewMarginLeft - 3);
            if (i == count - 1) {
                make.bottom.equalTo(ws.panelView).offset(-margin);
            }
        }];
        v.tag = i;
        lastView = v;
        
        [v bk_addEventHandler:^(id sender){
            
        } forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    [self.contentView layoutSubviews];

    
}

@end
