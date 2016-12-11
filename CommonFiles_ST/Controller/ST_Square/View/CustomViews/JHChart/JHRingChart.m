//
//  JHRingChart.m
//  JHChartDemo
//
//  Created by 简豪 on 16/7/5.
//  Copyright © 2016年 JH. All rights reserved.
//

#import "JHRingChart.h"
#define k_COLOR_STOCK @[[UIColor colorWithRed:1.000 green:0.783 blue:0.371 alpha:1.000], [UIColor colorWithRed:1.000 green:0.562 blue:0.968 alpha:1.000],[UIColor colorWithRed:0.313 green:1.000 blue:0.983 alpha:1.000],[UIColor colorWithRed:0.560 green:1.000 blue:0.276 alpha:1.000],[UIColor colorWithRed:0.239 green:0.651 blue:0.170 alpha:1.000],[UIColor colorWithRed:0.460 green:1.000 blue:0.246 alpha:1.000],[UIColor colorWithRed:0.339 green:0.751 blue:0.170 alpha:1.000]]

@interface JHRingChart ()
{
    NSArray *itemArray;
}

//环图间隔 单位为π
@property (nonatomic,assign)CGFloat itemsSpace;

//数值和
@property (nonatomic,assign) CGFloat totolCount;

@property (nonatomic,assign) CGFloat redius;

@end


@implementation JHRingChart



-(instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.chartOrigin = CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame)/2);
        _redius = (CGRectGetHeight(self.frame) - 60*k_Width_Scale)/3;
        
        itemArray =  @[@{@"image":@"zjmtravelhouseed",@"title":@"名宿",@"selectImage":@"zjmtravelhouse"},@{@"image":@"zjmtranported",@"title":@"交通",@"selectImage":@"zjmtranpord"},@{@"image":@"zjmhaochideed",@"title":@"美食",@"selectImage":@"zjmhaochide"},@{@"image":@"zjmmenpiaoed",@"title":@"门票",@"selectImage":@"zjmmenpiao"},@{@"image":@"zjmyuleed",@"title":@"娱乐",@"selectImage":@"zjmyule"},@{@"image":@"zjmshoped",@"title":@"购物",@"selectImage":@"zjmshoping"},@{@"image":@"zjmothered",@"title":@"其他",@"selectImage":@"zjmother"}] ;
    }
    return self;
}



-(void)setValueDataArr:(NSArray *)valueDataArr{
    
    
    _valueDataArr = valueDataArr;
    
    [self configBaseData];
    
}

- (void)setConsumeRatios:(NSMutableArray<BN_SquareTravelNotesConsumeRatios *> *)consumeRatios
{
    _consumeRatios = consumeRatios;
     [self configBaseData];
}

- (void)configBaseData{
    
    _totolCount = 0;
//    _itemsSpace =  (M_PI * 2.0 * 10 / 360)/_valueDataArr.count ;
    _itemsSpace = 0;
    for (BN_SquareTravelNotesConsumeRatios *obj in _consumeRatios) {
        _totolCount += obj.ratio;
    }

}

//开始动画
- (void)showAnimation{
    
    /*        动画开始前，应当移除之前的layer         */
    for (CALayer *layer in self.layer.sublayers) {
        [layer removeFromSuperlayer];
    }
    
    
    CGFloat lastBegin = -M_PI/2;
    
    CGFloat totloL = 0;
    NSInteger  i = 0;
    for (BN_SquareTravelNotesConsumeRatios *obj in _consumeRatios) {
        
        CAShapeLayer *layer = [CAShapeLayer layer] ;

        UIBezierPath *path = [UIBezierPath bezierPath];
        
        layer.fillColor = [UIColor clearColor].CGColor;
        layer.strokeColor =[k_COLOR_STOCK[i] CGColor];

        CGFloat cuttentpace = obj.ratio / _totolCount * (M_PI * 2 - _itemsSpace * _consumeRatios.count);
        totloL += obj.ratio / _totolCount;

        [path addArcWithCenter:self.chartOrigin radius:_redius - 20 startAngle:lastBegin  endAngle:lastBegin  + cuttentpace clockwise:YES];
        
        layer.path = path.CGPath;
        [self.layer addSublayer:layer];
        layer.lineWidth = 30*k_Width_Scale;
        CABasicAnimation *basic = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        basic.fromValue = @(0);
        basic.toValue = @(1);
        basic.duration = 0.5;
        basic.fillMode = kCAFillModeForwards;
        
        [layer addAnimation:basic forKey:@"basic"];
        lastBegin += (cuttentpace+_itemsSpace);
        i++;

    }

}


-(void)drawRect:(CGRect)rect{
    
    
    CGContextRef contex = UIGraphicsGetCurrentContext();
    
    CGFloat lastBegin = 0;
    CGFloat longLen = _redius + 30*k_Width_Scale;
    for (NSInteger i = 0; i<_consumeRatios.count; i++) {
        BN_SquareTravelNotesConsumeRatios *model = _consumeRatios[i];
//        id obj = _valueDataArr[i];
        CGFloat currentSpace = model.ratio / _totolCount * (M_PI * 2 - _itemsSpace * _consumeRatios.count);;
        NSLog(@"currentSpace = %f",currentSpace);
        CGFloat midSpace = lastBegin + currentSpace/2;
        
        CGPoint begin = CGPointMake(self.chartOrigin.x + sin(midSpace) * _redius, self.chartOrigin.y - cos(midSpace)*_redius);
//        CGPoint begin = CGPointMake(self.chartOrigin.x + sin(midSpace) * _redius, self.chartOrigin.y - cos(midSpace)*_redius);
        CGPoint endx = CGPointMake(self.chartOrigin.x + sin(midSpace) * longLen, self.chartOrigin.y - cos(midSpace)*longLen);
        
        NSLog(@"%@%@",NSStringFromCGPoint(begin),NSStringFromCGPoint(endx));
        lastBegin += _itemsSpace + currentSpace;
        
        [self drawLineWithContext:contex andStarPoint:begin andEndPoint:endx andIsDottedLine:NO andColor:k_COLOR_STOCK[i]];
        [self drawPointWithRedius:3*k_Width_Scale andColor:k_COLOR_STOCK[i] andPoint:begin andContext:contex];

        CGPoint secondP = CGPointZero;
        
        CGSize size = [[NSString stringWithFormat:@"%.02f%c",model.ratio  / _totolCount * 100,'%'] boundingRectWithSize:CGSizeMake(200, 100) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10*k_Width_Scale]} context:nil].size;
        
        if (midSpace<M_PI) {
            secondP =CGPointMake(endx.x + 20*k_Width_Scale - 25, endx.y);
          [self drawText:[NSString stringWithFormat:@"%.02f%c",model.ratio / _totolCount * 100,'%'] andContext:contex atPoint:CGPointMake(secondP.x + 3, secondP.y - size.height / 2) WithColor:k_COLOR_STOCK[i] andFontSize:10*k_Width_Scale];

        }else{
             secondP =CGPointMake(endx.x - 20*k_Width_Scale + 25, endx.y);
            [self drawText:[NSString stringWithFormat:@"%.02f%c",model.ratio / _totolCount * 100,'%'] andContext:contex atPoint:CGPointMake(secondP.x - size.width - 3, secondP.y - size.height/2) WithColor:k_COLOR_STOCK[i] andFontSize:10*k_Width_Scale];
        }
        //开始矫正结束点位置
        CGFloat centerX = self.frame.size.width / 2.0;
        if(secondP.x <= centerX)
        {
            secondP.x = 20.0;
        }else{
            secondP.x = self.frame.size.width - 10.0;
        }
        //结束矫正
        //开始搭建tipLabel
        CGFloat centerY = self.frame.size.height / 2.0;
        UILabel *tipLabel = [[UILabel alloc]init];
        if(secondP.y <= centerY)
        {
            if(secondP.x < 30)
            {
                tipLabel.frame = CGRectMake(secondP.x, secondP.y + 5, 100, 15);
            }else{
                tipLabel.frame = CGRectMake(0,  secondP.y + 5, self.frame.size.width - 10, 15);
                tipLabel.textAlignment = NSTextAlignmentRight;
            }
        }else{
            if(secondP.x < 30)
            {
                tipLabel.frame = CGRectMake(secondP.x, secondP.y + 5, 100, 15);
            }else{
                tipLabel.frame = CGRectMake(0,  secondP.y + 5, self.frame.size.width - 10, 15);
                tipLabel.textAlignment = NSTextAlignmentRight;
            }
        }
        tipLabel.font = [UIFont systemFontOfSize:12.0];
        tipLabel.textColor = [UIColor whiteColor];
        tipLabel.text = itemArray[model.consumptionType - 1][@"title"];
        [self addSubview:tipLabel];
        //结束搭建
        NSLog(@"endpoint = %f  path = %ld",secondP.x,(long)i);
        [self drawLineWithContext:contex andStarPoint:endx andEndPoint:secondP andIsDottedLine:NO andColor:k_COLOR_STOCK[i]];
        [self drawPointWithRedius:3*k_Width_Scale andColor:k_COLOR_STOCK[i] andPoint:secondP andContext:contex];
 
    }
    
    
    
    
}




@end
