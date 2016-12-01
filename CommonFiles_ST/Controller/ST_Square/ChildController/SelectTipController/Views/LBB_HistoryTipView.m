//
//  LBB_HistoryTipView.m
//  ST_Travel
//
//  Created by dawei che on 2016/11/20.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_HistoryTipView.h"
#import "Header.h"
#import "CoreData+MagicalRecord.h"
#import "LBB_TagsViewModel.h"
#import "TipHistory+CoreDataClass.h"

@implementation LBB_HistoryTipView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self == [super initWithFrame:frame])
    {
        [self setup];
    }
    return self;
}

- (void)setup
{
    UIView  *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, AUTO(45))];
    topView.backgroundColor = UIColorFromRGB(0xE8EAEB);
    [self addSubview:topView];
    
    UIImageView  *historyImage = [[UIImageView alloc]initWithFrame:CGRectMake(AUTO(20), 0, AUTO(12), AUTO(15))];
    historyImage.centerY = topView.height / 2;
    historyImage.image = IMAGE(@"zjmlishibiaoqian");
    [topView addSubview:historyImage];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(historyImage.right + AUTO(5), 0, 100, historyImage.height)];
    label.centerY = historyImage.centerY;
    label.textColor = MORELESSBLACKCOLOR;
    label.font = FONT(AUTO(13.0));
    label.text = @"历史标签";
    [topView addSubview:label];
    
    UIButton  *clearBtn = [[UIButton alloc]initWithFrame:CGRectMake(DeviceWidth - AUTO(55), 0, AUTO(40), historyImage.height)];
    [clearBtn setTitle:@"清空" forState:0];
    clearBtn.titleLabel.font = FONT(12.0);
    clearBtn.centerY = label.centerY;
    [clearBtn setTitleColor:MORELESSBLACKCOLOR forState:0];
    [topView addSubview:clearBtn];
    LRViewBorderRadius(topView, 0, 1.0, UIColorFromRGB(0xD5D6D7));
    [clearBtn addTarget:self action:@selector(clearHistory) forControlEvents:UIControlEventTouchUpInside];
}
//底部的view
- (void)bottomView
{
    UIView  *topView = [[UIView alloc]initWithFrame:CGRectMake(0, self.bottom, DeviceWidth, AUTO(45))];
    topView.backgroundColor = UIColorFromRGB(0xE8EAEB);
    [self addSubview:topView];
    
    UIImageView  *historyImage = [[UIImageView alloc]initWithFrame:CGRectMake(AUTO(20), 0, AUTO(12), AUTO(10))];
    historyImage.centerY = topView.height / 2;
    historyImage.image = IMAGE(@"zjmremenbiaoqian");
    [topView addSubview:historyImage];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(historyImage.right + AUTO(5), 0, 100, historyImage.height)];
    label.centerY = historyImage.centerY;
    label.textColor = MORELESSBLACKCOLOR;
    label.font = FONT(AUTO(13.0));
    label.text = @"热门标签";
    [topView addSubview:label];
    
    self.height = topView.bottom;
}

- (void)setHistorySearch:(NSArray *)historySearch
{
    _historySearch = historySearch;
    
    [self removeAllSubviews];
    [self setup];
    
    self.height  = AUTO(45);
    CGFloat  marginX = AUTO(10);
    CGFloat  marginY = AUTO(10);
    CGFloat  btnWidth = (DeviceWidth - AUTO(50) - 2*marginX)/3.0;
    CGFloat  btnHeight = AUTO(25);
    
    if(historySearch.count > 9)
    {
        for(int i = 0;i < 9;i++)
        {
            UIButton  *btn = [[UIButton alloc]init];
            [btn setTitleColor:BLACKCOLOR forState:UIControlStateNormal];
            [btn setTitleColor:BLACKCOLOR forState:UIControlStateSelected];
            btn.titleLabel.font = FONT(AUTO(12.0));
            [btn setTitle:historySearch[i] forState:0];
            LRViewBorderRadius(btn, 0, 0.5, UIColorFromRGB(0xF0F1F2));
            btn.frame = CGRectMake(AUTO(25)+ (marginX + btnWidth) * (i % 3),AUTO(45) + (marginY + btnHeight) * (i / 3), btnWidth, btnHeight);
             self.height  = btn.bottom + marginY;
            btn.tag = 100 + i;
            [self addSubview:btn];
        }
    }else{
        for(int i = 0;i < historySearch.count;i++)
        {
            UIButton  *btn = [[UIButton alloc]init];
            [btn setTitleColor:BLACKCOLOR forState:UIControlStateNormal];
            [btn setTitleColor:BLACKCOLOR forState:UIControlStateSelected];
            btn.titleLabel.font = FONT(AUTO(12.0));
            [btn setTitle:historySearch[i] forState:0];
            LRViewBorderRadius(btn, 0, 0.5, UIColorFromRGB(0xF0F1F2));
            btn.frame = CGRectMake(AUTO(25)+ (marginX + btnWidth) * (i % 3),AUTO(55) + (marginY + btnHeight) * (i / 3), btnWidth, btnHeight);
            self.height  = btn.bottom + marginY;
            btn.tag = 100 + i;
            [self addSubview:btn];
        }
    }
     [self bottomView];
}


- (void)clearHistory
{
    
    NSArray *array = [TipHistory MR_findAll];
    for(TipHistory *model in array)
    {
        [model MR_deleteEntity];
    }
    [self setHistorySearch:nil];
    self.height = AUTO(90);
    self.clearBlock(0);
}

@end
