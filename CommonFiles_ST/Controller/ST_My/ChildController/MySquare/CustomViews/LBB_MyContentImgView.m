//
//  LBB_MyContentImgView.m
//  ST_Travel
//
//  Created by 晨曦 on 16/12/2.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_MyContentImgView.h"
#import "Mine_Common.h"
#import "Header.h"

#define TagContentTag   10000

@interface LBB_MyContentImgView()

@property(nonatomic,assign) int tagCount;

@end

@implementation LBB_MyContentImgView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = ColorLine;
    }
    return self;
}

- (void)dealloc
{
    _tagList = nil;
    _imageURL = nil;
}

- (void)prepareForReuse
{
   [self removeAllSubviews];
}

- (void)setTagList:(NSArray *)tagList
{
    _tagList = tagList;
    [self removeAllSubviews];
    
    CGRect selfFrame = self.bounds;
    CGFloat bottomY = selfFrame.size.height - 10.f;
    for (int i = 0; i < _tagList.count; i++) {
        NSString *tagContent = _tagList[i];
        CGSize contentSize = sizeOfString(tagContent, CGSizeMake(9999, 20), Font12);
        UIImage *image = IMAGE(@"我的_标签");
        UIImageView *tagImgView = [[UIImageView alloc] initWithImage:[image resizableImageWithCapInsets:
                                                                     UIEdgeInsetsMake(image.size.height * (1.f/2.f), image.size.width * .5f,
                                                                                      image.size.height * (1.f/2.f), image.size.width * .5f)]];
        
        if (contentSize.width > (selfFrame.size.width * (2.f/3.f))) {
            contentSize.width = selfFrame.size.width * (2.f/3.f);
        }
        
        tagImgView.frame = CGRectMake(selfFrame.size.width - contentSize.width - AUTO(25), bottomY - contentSize.height - AUTO(5), contentSize.width + AUTO(15), contentSize.height + AUTO(5));
        bottomY -= AUTO(25);
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(tagImgView.bounds.size.width - contentSize.width - 5.f,(tagImgView.bounds.size.height - contentSize.height)/2.0,  contentSize.width, contentSize.height)];
        label.font = Font12;
        label.textColor = ColorWhite;
        label.text = tagContent;
        label.adjustsFontSizeToFitWidth = YES;
        [tagImgView addSubview:label];
        [self addSubview:tagImgView];
        if (bottomY < 30) {
            break;
        }
    }
}

- (void)setImageURL:(NSString *)imageURL
{
    _imageURL = imageURL;
    if ([_imageURL length]) {
        [self  sd_setImageWithURL:[NSURL URLWithString:_imageURL] placeholderImage:DEFAULTIMAGE];
    }else {
        self.image = nil;
    }
    
}


@end
