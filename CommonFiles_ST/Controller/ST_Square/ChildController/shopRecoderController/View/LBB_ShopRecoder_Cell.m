//
//  LBB_ShopRecoder_Cell.m
//  ST_Travel
//
//  Created by dawei che on 2016/10/28.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_ShopRecoder_Cell.h"
#import "Header.h"

@implementation LBB_ShopRecoder_Cell
{
    
    UIImageView   *image;
    UILabel            *catoryLabel;
    UILabel            *percentLabel;
    UILabel            *priceLabel;
    NSArray           *itemArray;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setup];
        itemArray =  @[@{@"image":@"zjmtravelhouseed",@"title":@"名宿",@"selectImage":@"zjmtravelhouse"},@{@"image":@"zjmtranported",@"title":@"交通",@"selectImage":@"zjmtranpord"},@{@"image":@"zjmhaochideed",@"title":@"美食",@"selectImage":@"zjmhaochide"},@{@"image":@"zjmmenpiaoed",@"title":@"门票",@"selectImage":@"zjmmenpiao"},@{@"image":@"zjmyuleed",@"title":@"娱乐",@"selectImage":@"zjmyule"},@{@"image":@"zjmshoped",@"title":@"购物",@"selectImage":@"zjmshoping"},@{@"image":@"zjmothered",@"title":@"其他",@"selectImage":@"zjmother"}] ;

    }
    return self;
}



- (void)setup
{
    image = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0, AUTO(13), AUTO(13))];
    image.centerY = AUTO(25);
    [self addSubview:image];
    
    catoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(image.right + AUTO(15), 0, AUTO(60), AUTO(20))];
    catoryLabel.textColor = MORELESSBLACKCOLOR;
    catoryLabel.font = FONT(AUTO(14.0));
    catoryLabel.centerY = AUTO(25);
    [self addSubview:catoryLabel];
    
    percentLabel = [[UILabel alloc] initWithFrame:CGRectMake(catoryLabel.right , 0, AUTO(200), AUTO(20))];
    percentLabel.textColor = MORELESSBLACKCOLOR;
    percentLabel.font = FONT(AUTO(14.0));
    percentLabel.centerY = AUTO(25);
    [self addSubview:percentLabel];
    
    priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0 , 0, DeviceWidth - 10, AUTO(20))];
    priceLabel.textColor = MORELESSBLACKCOLOR;
    priceLabel.font = FONT(AUTO(14.0));
    priceLabel.centerY = AUTO(25);
    priceLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:priceLabel];
    
}

- (void)setDataaArray:(NSDictionary *)dataaArray
{
    _dataaArray = dataaArray;
    
    image.image = IMAGE(dataaArray[@"image"]);
    catoryLabel.text = dataaArray[@"title"];
    percentLabel.text = dataaArray[@"percent"];
    priceLabel.text = dataaArray[@"price"];
}

- (void)setModel:(BN_SquareTravelNotesConsumeRatios *)model
{
    image.image = IMAGE(itemArray[model.consumptionType - 1][@"selectImage"]);
    catoryLabel.text = itemArray[model.consumptionType - 1][@"title"];
    percentLabel.text = [NSString stringWithFormat:@"%d%@",model.ratio,@"%"];
    priceLabel.text = [NSString stringWithFormat:@"%.2f",model.amount.floatValue];
}

@end
