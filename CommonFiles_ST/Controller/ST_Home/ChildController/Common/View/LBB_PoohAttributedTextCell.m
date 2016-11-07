//
//  LBB_PoohAttributedTextCell.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/1.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_PoohAttributedTextCell.h"
#import "PoohCommon.h"

@implementation LBB_PoohAttributedTextCell

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
        
        
        CGFloat margin = 8;
        
        self.attributedTextLabel = [UILabel new];
        [self.contentView addSubview:self.attributedTextLabel];
        [self.attributedTextLabel mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.top.equalTo(ws.contentView).offset(margin);
            make.bottom.equalTo(ws.contentView).offset(-margin);
            make.left.equalTo(ws.contentView).offset(2*margin);
            make.right.equalTo(ws.contentView).offset(-2*margin);
            make.centerX.equalTo(ws.contentView);
        }];
    }
    return self;
}

-(void)setAttributedText:(NSString *)text{

    NSString * htmlString = @"<html><body> Some html string \n <font size=\"13\" color=\"red\">This is some text!</font> </body></html>";
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    self.attributedTextLabel.attributedText = attrStr;
    
}

@end
