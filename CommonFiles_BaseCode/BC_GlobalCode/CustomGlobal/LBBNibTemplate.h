//
//  LBBNibTemplate.h
//  ST_Travel
//
//  Created by Diana on 16/10/16.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#ifndef LBBNibTemplate_h
#define LBBNibTemplate_h


#define DEFINE_DHNIB_FOR_HEADER(className) \
\
@interface className##NibContainer : UIView \
\
@property (weak, nonatomic) className *contentView; \
\
@end


#define DEFINE_DHNIB_FOR_CLASS(className) \
\
@implementation className##NibContainer \
\
- (instancetype)initWithCoder:(NSCoder *)aDecoder { \
if (self = [super initWithCoder:aDecoder]) { \
\
self.backgroundColor = [UIColor clearColor]; \
NSString  *nibName = @#className; \
className *xxx = [[[NSBundle  mainBundle] loadNibNamed:nibName owner:self options:nil] firstObject]; \
xxx.frame = self.bounds; \
xxx.autoresizingMask = 0x3F; \
[self addSubview:xxx]; \
\
self.contentView = xxx; \
} \
return self; \
} \
\
@end \

#endif /* LBBNibTemplate_h */
