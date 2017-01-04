//
//  LBB_ScenicDetailTagsCell.m
//  ST_Travel
//
//  Created by pooh on 17/1/4.
//  Copyright © 2017年 GL_RunMan. All rights reserved.
//

#import "LBB_ScenicDetailTagsCell.h"


static const NSInteger kViewMarginLeft = 50;

static const NSInteger kPictureMaxCol = 3;
static const NSInteger kPictureInterval = 8;

@interface LBB_ScenicDetailTagsCell()

@property(nonatomic, retain)UIView* panelView;

@end

@implementation LBB_ScenicDetailTagsCell

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
        
        self.showButton = [UIButton new];
        [self.showButton setTitle:@"缩起景点详情" forState:UIControlStateNormal];
        [self.showButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.showButton setImage:IMAGE(@"景点详情_小箭头下") forState:UIControlStateNormal];
        self.showButton.imageEdgeInsets = UIEdgeInsetsMake(0, AutoSize(92), 0, 0);
        //CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
        self.showButton.titleEdgeInsets = UIEdgeInsetsMake(0, AutoSize(-15), 0, AutoSize(15));

        [self.showButton.titleLabel setFont:AutoFont(13)];
        self.showButton.layer.borderColor = [UIColor lightGrayColor].CGColor;//ColorLine.CGColor;
        self.showButton.layer.borderWidth = 1;
        [self.contentView addSubview:self.showButton];
        [self.showButton mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerX.equalTo(ws.contentView);
            make.top.equalTo(ws.contentView).offset(13);
            make.width.mas_equalTo(AutoSize(240/2));
            make.height.mas_equalTo(AutoSize(50/2));
        }];
        
        
        self.panelView = [UIView new];
        [self.panelView setBackgroundColor:ColorWhite];
        [self.contentView addSubview:self.panelView];
        [self.panelView mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.right.bottom.equalTo(ws.contentView);
            make.top.equalTo(ws.showButton.mas_bottom).offset(13);
        }];
        
#pragma button action
        [self.showButton bk_addEventHandler:^(id sender){
        
            ws.block(nil);
        } forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}


-(void)setTags:(NSMutableArray<LBB_SpotsTag *> *)tags{
    
    _tags = tags;
    
    if (self.isOpen) {
        [self.showButton setImage:IMAGE(@"景点详情_小箭头上") forState:UIControlStateNormal];
        [self.showButton setTitle:@"缩起景点详情" forState:UIControlStateNormal];
        switch (self.homeType) {
            case LBBPoohHomeTypeFoods:
                [self.showButton setTitle:@"缩起美食详情" forState:UIControlStateNormal];
                break;
            case LBBPoohHomeTypeHostel:
                [self.showButton setTitle:@"缩起民宿详情" forState:UIControlStateNormal];
                break;
            default:
                break;
        }
    }
    else{
        [self.showButton setImage:IMAGE(@"景点详情_小箭头下") forState:UIControlStateNormal];
        [self.showButton setTitle:@"完整景点详情" forState:UIControlStateNormal];
        switch (self.homeType) {
            case LBBPoohHomeTypeFoods:
                [self.showButton setTitle:@"完整美食详情" forState:UIControlStateNormal];
                break;
            case LBBPoohHomeTypeHostel:
                [self.showButton setTitle:@"完整民宿详情" forState:UIControlStateNormal];
                break;
            default:
                break;
        }
    }
    
    
    
    
    [self.panelView removeAllSubviews];
    WS(ws);
    CGFloat margin = 8;
    
    CGFloat width = ([UIScreen mainScreen].bounds.size.width - 2*kViewMarginLeft - 2*kPictureInterval)/kPictureMaxCol;
    CGFloat height = AutoSize(40/2);
    
    UIView *lastView = nil;
    
    NSInteger count  = tags.count;
    
    for (int i = 0; i < count; i++) {
        UIButton *v = [UIButton new];
        LBB_SpotsTag* tag = [tags objectAtIndex:i];
        [v setTitleColor:ColorBtnYellow forState:UIControlStateNormal];
        v.layer.borderColor = ColorBtnYellow.CGColor;
        v.layer.borderWidth = 2/2;
        v.layer.masksToBounds = YES;
        [v.titleLabel setFont:AutoFont(10)];
        [v setTitle:tag.tagName forState:UIControlStateNormal];
        [self.panelView addSubview:v];
        
        int col = i % kPictureMaxCol;
        int row = i / kPictureMaxCol;
        
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(height);
            make.left.equalTo(ws.panelView).offset(col*(width+kPictureInterval)+kViewMarginLeft);
            make.top.equalTo(ws.panelView).offset(row*(height+kPictureInterval) + kPictureInterval);
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
