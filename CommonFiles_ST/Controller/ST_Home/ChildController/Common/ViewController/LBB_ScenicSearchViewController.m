//
//  LBB_ScenicSearchViewController.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/25.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_ScenicSearchViewController.h"
#import "LBB_SceninSearchCollectionViewCell.h"
#import "LBB_ScenicSearchCollectionReusableView.h"

@interface LBB_ScenicSearchViewController ()<UISearchBarDelegate,UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, retain)UISearchBar* searchBar;


@end

@implementation LBB_ScenicSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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


-(void)loadCustomNavigationButton{
    WS(ws);
   
  //  self.title = @"取消";
    UIButton *cancel = [[UIButton alloc] init];
    cancel.titleLabel.font = Font14;
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancel.frame = CGRectMake(0, 0, 45, 45);
    [cancel bk_addEventHandler:^(id sender){
        
        [ws.navigationController popViewControllerAnimated:YES];
        
    }forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithCustomView:cancel];
    self.navigationItem.rightBarButtonItem = cancelItem;

    
    CGFloat height = NavHeight - 10;
    CGFloat width = DeviceWidth - 45 - 15;
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];//allocate titleView
    UISearchBar *bar = [UISearchBar new];
    bar.barStyle = UIBarStyleDefault;
    
    bar.layer.borderColor = [UIColor blackColor].CGColor;
    bar.layer.borderWidth = 0.8;
    bar.layer.cornerRadius = height/2;
    bar.layer.masksToBounds = YES;
    [bar setBackgroundImage:[UIImage new]];
    bar.delegate = self;
    bar.placeholder = self.placeHolderString;//@"输入关键字搜索景点";
    [bar setContentMode:UIViewContentModeLeft];
    self.searchBar = bar;
    [titleView addSubview:bar];
    [bar mas_makeConstraints:^(MASConstraintMaker* make){
        make.center.width.height.equalTo(titleView);
    }];
    
    [self.navigationItem.titleView sizeToFit];
    self.navigationItem.titleView = titleView;
    
}

#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    NSLog(@"searchBarSearchButtonClicked");
    
}

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    [self.searchBar becomeFirstResponder];
    return YES;
}

/*
 *  setup UI
 */
-(void)buildControls{
    
    WS(ws);
    UICollectionViewFlowLayout *horizontalCellLayout = [UICollectionViewFlowLayout new];
    horizontalCellLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    CGFloat margin = 10;
    //(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
    horizontalCellLayout.sectionInset = UIEdgeInsetsMake(margin, margin, margin, margin);
    horizontalCellLayout.minimumInteritemSpacing = margin;
    horizontalCellLayout.minimumLineSpacing = margin;
    CGFloat width = (DeviceWidth - 4*margin)/3;
    horizontalCellLayout.itemSize = CGSizeMake(width, width/3);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:horizontalCellLayout];
    
    _collectionView.backgroundColor = ColorBackground;
    self.collectionView.alwaysBounceVertical = YES;

    _collectionView.scrollEnabled = YES;

    [self.view addSubview:_collectionView];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.center.width.height.equalTo(ws.view);
    }];
    
    
    [_collectionView registerClass:NSClassFromString(@"LBB_SceninSearchCollectionViewCell")
        forCellWithReuseIdentifier:@"LBB_SceninSearchCollectionViewCell"];
    [self.collectionView registerClass:[LBB_ScenicSearchCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LBB_ScenicSearchCollectionReusableView"];

    _collectionView.dataSource = self;
    _collectionView.delegate = self;
}


#pragma mark - UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LBB_SceninSearchCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LBB_SceninSearchCollectionViewCell"forIndexPath:indexPath];
    
    [cell sizeToFit];
    if (!cell) {
        NSLog(@"无法创建LBB_SceninSearchCollectionViewCell时打印，自定义的cell就不可能进来了。");
    }
    
    [cell.textLabel setText:@"pooh"];
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(DeviceWidth, 45);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"viewForSupplementaryElementOfKind");
    UICollectionReusableView *reusable = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        
        LBB_ScenicSearchCollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LBB_ScenicSearchCollectionReusableView" forIndexPath:indexPath];
        NSArray* icons = @[@"景区标签_热门",@"景区标签_标签"];
        NSArray* titles = @[@"最热门景点",@"最热门标签"];

        view.titleLabel.text = titles[indexPath.section];
        [view.iconImageView setImage:IMAGE(icons[indexPath.section])];
        reusable = view;
    }
    return reusable;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    self.click(self,indexPath);//数据回调
    
}


@end
