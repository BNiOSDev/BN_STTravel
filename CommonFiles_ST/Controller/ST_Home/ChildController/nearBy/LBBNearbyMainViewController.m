//
//  LBBNearbyMainViewController.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBNearbyMainViewController.h"
#import "LBBHomeHotestTableViewCellItem.h"

@interface LBBNearbyMainViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;


@end

@implementation LBBNearbyMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    WS(ws);
    
    [self addBackButton:nil];
    [self setBaseNavigationBarTitle:@"附近"];
    UICollectionViewFlowLayout *horizontalCellLayout = [UICollectionViewFlowLayout new];
    horizontalCellLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
    horizontalCellLayout.sectionInset = UIEdgeInsetsMake(15, 8, 15, 8);
    horizontalCellLayout.minimumInteritemSpacing = 10;
    horizontalCellLayout.minimumLineSpacing = 10;
    horizontalCellLayout.itemSize = CGSizeMake(UISCREEN_WIDTH * 2/3, UISCREEN_WIDTH * 2/3-30);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:horizontalCellLayout];
    //  self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) collectionViewLayout:horizontalCellLayout];
    
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.showsHorizontalScrollIndicator = NO;
    
    self.collectionView.alwaysBounceHorizontal = YES;
    //    self.collectionView.alwaysBounceVertical = YES;
    
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
    
    [self.baseContentView addSubview:_collectionView];
    
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.baseContentView);
        make.left.right.equalTo(ws.baseContentView);
        //   make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width);
        
        make.height.equalTo(@( UISCREEN_WIDTH * 2/3));
    }];
    
    [_collectionView registerClass:NSClassFromString(@"LBBHomeHotestTableViewCellItem")
        forCellWithReuseIdentifier:@"LBBHomeHotestTableViewCellItem"];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LBBHomeHotestTableViewCellItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LBBHomeHotestTableViewCellItem"forIndexPath:indexPath];
    
    [cell sizeToFit];
    if (!cell) {
        NSLog(@"无法创建LBBHomeHotestTableViewCellItem时打印，自定义的cell就不可能进来了。");
    }
    
    [cell.mainImageView sd_setImageWithURL:[NSURL URLWithString:@"http://s7.sinaimg.cn/middle/3d312b52gc448d757ad86&690"] placeholderImage:IMAGE(@"poohtest")];
    
    return cell;
}

@end
