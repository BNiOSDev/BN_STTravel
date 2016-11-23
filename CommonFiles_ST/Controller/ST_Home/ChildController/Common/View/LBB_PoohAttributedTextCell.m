//
//  LBB_PoohAttributedTextCell.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/1.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_PoohAttributedTextCell.h"
#import "PoohCommon.h"

@interface LBB_PoohAttributedTextCell()<UIWebViewDelegate>

@end

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
          //  make.height.equalTo(@400);
            make.centerX.equalTo(ws.contentView);
        }];
    }
    return self;
}

-(void)setAttributedText:(NSString *)text{

    NSLog(@"setAttributedText:%@",text);
    NSString* att = text;
    if (!att) {
        att = @"";
    }
//    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[text dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
//    self.attributedTextLabel.attributedText = attrStr;
    
    NSMutableAttributedString *htmlString =[[NSMutableAttributedString alloc] initWithData:[att dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute:[NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes:NULL error:nil];
    
   // [htmlString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} range:NSMakeRange(0, htmlString.length)];
    
    //CGSize textSize = [htmlString boundingRectWithSize:(CGSize){self.frame.size.width - 20, CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    
    self.attributedTextLabel.attributedText = htmlString;
   /*self.attributedTextLabel.frame = CGRectMake(self.attributedTextLabel.frame.size.width
                                                , self.attributedTextLabel.frame.size.height,
                                                textSize.width,
                                                textSize.height);*/
   /* [self.attributedTextLabel loadHTMLString:text baseURL:nil];
    self.attributedTextLabel.delegate = self;
    self.attributedTextLabel.scrollView.bounces = NO;
    self.attributedTextLabel.scrollView.alwaysBounceVertical = NO;
    self.attributedTextLabel.scrollView.alwaysBounceHorizontal = NO;
*/
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    WS(ws);
    CGFloat margin = 8;
    NSLog(@"webViewDidFinishLoad");
    CGFloat height = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] floatValue];
    NSLog(@"webViewDidFinishLoad height:%f",height);

    [self.attributedTextLabel mas_remakeConstraints:^(MASConstraintMaker* make){
        
        make.top.equalTo(ws.contentView).offset(margin);
        make.bottom.equalTo(ws.contentView).offset(-margin);
        make.left.equalTo(ws.contentView).offset(2*margin);
        make.right.equalTo(ws.contentView).offset(-2*margin);
        make.height.mas_equalTo(height);
        make.centerX.equalTo(ws.contentView);
    }];
    
    [self.contentView layoutSubviews];
}
@end
