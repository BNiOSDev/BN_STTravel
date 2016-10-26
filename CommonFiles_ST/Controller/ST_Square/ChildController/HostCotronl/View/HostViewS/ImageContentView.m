//
//  ImageContentView.m
//  ForXiaMen
//
//  Created by dawei che on 2016/10/24.
//  Copyright © 2016年 jiangming zheng. All rights reserved.
//

#import "ImageContentView.h"
#import "NSArray+Sudoku.h"

#define IMAGEHEIGHT   250.0
#define Marign  5.0

@implementation ImageContentView
    {
        UIImageView         *oneImage;
        UIImageView         *twoImage;
        UIImageView         *threeImage;
        UIImageView         *fourImage;
        UIImageView         *fiveImage;
        UIImageView         *sevenImage;
        UIImageView         *sixImage;
        UIImageView         *eightImage;
        UIImageView         *nightImage;
    }
    
    - (instancetype)initWithFrame:(CGRect)frame
    {
        if(self == [super initWithFrame:frame])
        {
            oneImage = [UIImageView new];
            [self addSubview:oneImage];
            twoImage = [UIImageView new];
            [self addSubview:twoImage];
            threeImage = [UIImageView new];
            [self addSubview:threeImage];
            fourImage = [UIImageView new];
            fiveImage = [UIImageView new];
            sixImage = [UIImageView new];
            sevenImage = [UIImageView new];
            eightImage = [UIImageView new];
            nightImage = [UIImageView new];
        }
        return self;
    }

- (void)setImageArray:(NSArray *)imageArray
{
    _imageArray = imageArray;
    switch (imageArray.count) {
        case 1:
        {
            [oneImage mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, 0, 0, 0));
            }];
            oneImage.backgroundColor = [UIColor redColor];
        }
            break;
        case 2:
        {
            NSMutableArray  *array = [[NSMutableArray alloc]init];
            for(int i = 0;i < imageArray.count;i++)
            {
                UIImageView *imageCus = [UIImageView new];
                imageCus.backgroundColor = [UIColor greenColor];
                [self addSubview:imageCus];
                [array addObject:imageCus];
            }
            
            [array mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:Marign leadSpacing:0 tailSpacing:0];
            [array mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.mas_top);
                make.bottom.equalTo(self.mas_bottom);
            }];
            
        }
            break;

        case 3:
        {
            [oneImage mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, 0, 0, 0));
                make.height.equalTo(self.mas_height).multipliedBy(0.5).offset(-Marign / 2);
            }];
            oneImage.backgroundColor = [UIColor redColor];
            
            NSMutableArray  *array = [[NSMutableArray alloc]init];
            for(int i = 1;i < imageArray.count;i++)
            {
                UIImageView *imageCus = [UIImageView new];
                imageCus.backgroundColor = [UIColor greenColor];
                [self addSubview:imageCus];
                [array addObject:imageCus];
            }
            
            [array mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:Marign leadSpacing:0 tailSpacing:0];
            [array mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(oneImage.mas_bottom).offset(Marign);
                make.bottom.equalTo(self.mas_bottom);
            }];

        }
            break;
        case 4:
        {
            NSMutableArray  *array = [[NSMutableArray alloc]init];
            for(int i = 0;i < imageArray.count;i++)
            {
                UIImageView *imageCus = [UIImageView new];
                imageCus.backgroundColor = [UIColor greenColor];
                [self addSubview:imageCus];
                [array addObject:imageCus];
            }
    
           [array mas_distributeSudokuViewsWithFixedItemWidth:0 fixedItemHeight:0 fixedLineSpacing:5 fixedInteritemSpacing:5 warpCount:2 topSpacing:0 bottomSpacing:0 leadSpacing:0 tailSpacing:0];
        }
            break;
        case 5:
        {
            NSMutableArray  *array = [[NSMutableArray alloc]init];
            NSMutableArray  *array2 = [[NSMutableArray alloc]init];
            for(int i = 0;i < imageArray.count;i++)
            {
                UIImageView *imageCus = [UIImageView new];
                imageCus.backgroundColor = [UIColor greenColor];
                [self addSubview:imageCus];
                if(i <= 1)
                {
                    [array addObject:imageCus];
                }else{
                    [array2 addObject:imageCus];
                }
            }
            
            [array mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:Marign leadSpacing:0 tailSpacing:0];
            [array mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.mas_top);
                make.bottom.equalTo(self.mas_bottom).multipliedBy(0.5).offset(-Marign / 2.0);
            }];
            
            [array2 mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:Marign leadSpacing:0 tailSpacing:0];
            [array2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(((UIImageView *)array[1]).mas_bottom).with.offset(Marign);
                make.bottom.equalTo(self.mas_bottom);
            }];
            
        }
            break;
        case 6:
        {
            [self SixLayout];
        }
            break;
        case 7:
        {
            [self SevenLayout];
        }
            break;
        case 8:
        {
            [self EightLayout];
        }
            break;
        case 9:
        {
            NSMutableArray  *array = [[NSMutableArray alloc]init];
            for(int i = 0;i < imageArray.count;i++)
            {
                UIImageView *imageCus = [UIImageView new];
                imageCus.backgroundColor = [UIColor greenColor];
                [self addSubview:imageCus];
                [array addObject:imageCus];
            }
            
            [array mas_distributeSudokuViewsWithFixedItemWidth:0 fixedItemHeight:0 fixedLineSpacing:5 fixedInteritemSpacing:5 warpCount:3 topSpacing:0 bottomSpacing:0 leadSpacing:0 tailSpacing:0];
        }
            break;
            
        default:
            break;
    }
}

- (void)SixLayout
{
    [oneImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.mas_bottom).multipliedBy( 2.0 / 3.0).offset(-Marign / 2.0);
        make.right.equalTo(self.mas_right).multipliedBy( 2.0 / 3.0).offset(-Marign / 2.0);
    }];
    oneImage.backgroundColor = [UIColor redColor];
    
    [twoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(oneImage.mas_right).offset(Marign);
        make.bottom.equalTo(oneImage).multipliedBy( 0.5).offset(-Marign / 2.0);
        make.right.equalTo(self.mas_right);
    }];
    twoImage.backgroundColor = [UIColor redColor];
    
    [threeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(twoImage.mas_bottom).offset(Marign);
        make.left.equalTo(twoImage.mas_left);
        make.bottom.equalTo(oneImage.mas_bottom);
        make.right.equalTo(self.mas_right);
    }];
    threeImage.backgroundColor = [UIColor redColor];
    
    NSMutableArray  *array = [[NSMutableArray alloc]init];
    for(int i = 3;i < _imageArray.count;i++)
    {
        UIImageView *imageCus = [UIImageView new];
        imageCus.backgroundColor = [UIColor greenColor];
        [self addSubview:imageCus];
        [array addObject:imageCus];
    }
    [array mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:Marign leadSpacing:0 tailSpacing:0];
    [array mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(oneImage.mas_bottom).with.offset(Marign);
        make.bottom.equalTo(self.mas_bottom);
    }];
}

- (void)SevenLayout
{
    [oneImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom).multipliedBy( 0.5).offset(-Marign);
    }];
    oneImage.backgroundColor = [UIColor redColor];
    NSMutableArray *array = [[NSMutableArray alloc]init];
    NSMutableArray *array2 = [[NSMutableArray alloc]init];
    for(int i = 1;i < _imageArray.count;i++)
    {
        UIImageView *imageCus = [UIImageView new];
        imageCus.backgroundColor = [UIColor greenColor];
        [self addSubview:imageCus];
        if(i <= 3)
        {
            [array addObject:imageCus];
        }else{
            imageCus.backgroundColor = [UIColor redColor];
            [array2 addObject:imageCus];
        }
    }
    [array mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:Marign leadSpacing:0 tailSpacing:0];
    [array mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(oneImage.mas_bottom).offset(Marign);
        make.bottom.equalTo(self.mas_bottom).multipliedBy(0.75).offset(-Marign / 2.0);
//        make.bottom.equalTo(self.mas_bottom).multipliedBy(0.25).offset(-Marign / 2.0);
    }];
    [array2 mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:Marign leadSpacing:0 tailSpacing:0];
    [array2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(((UIImageView *)array[1]).mas_bottom).with.offset(Marign);
        make.bottom.equalTo(self.mas_bottom);
    }];
}

- (void)EightLayout
{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    NSMutableArray *array2 = [[NSMutableArray alloc]init];
    NSMutableArray *array3 = [[NSMutableArray alloc]init];
    for(int i = 0;i < _imageArray.count;i++)
    {
        UIImageView *imageCus = [UIImageView new];
        imageCus.backgroundColor = [UIColor greenColor];
        [self addSubview:imageCus];
        if(i <= 1)
        {
            [array addObject:imageCus];
        }else if(i <= 4 && i > 1) {
            [array2 addObject:imageCus];
        }else{
            [array3 addObject:imageCus];
        }
    }
    [array mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:Marign leadSpacing:0 tailSpacing:0];
    [array mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom).multipliedBy(0.5).offset(-Marign);
    }];
    [array2 mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:Marign leadSpacing:0 tailSpacing:0];
    [array2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(((UIImageView *)array[1]).mas_bottom).with.offset(Marign);
        make.bottom.equalTo(self.mas_bottom).multipliedBy(0.75).offset(-Marign/2.0);
    }];
    [array3 mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:Marign leadSpacing:0 tailSpacing:0];
    [array3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(((UIImageView *)array2[1]).mas_bottom).with.offset(Marign);
        make.bottom.equalTo(self.mas_bottom);
    }];
}

@end
