//
//  LBB_SerCover_CollectionViewController.m
//  ST_Travel
//
//  Created by dawei che on 2016/12/8.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_SerCover_CollectionViewController.h"
#import "Header.h"
#import "LBB_SetCover_CollectionViewCell.h"

@interface LBB_SerCover_CollectionViewController ()
{
    UIView *cellView;
    UIImageView  *selectImage;
}
@end

@implementation LBB_SerCover_CollectionViewController

static NSString * const reuseIdentifier = @"SelectCoverCell";

- (instancetype)init
{
    CGFloat  itemWidth = (DeviceWidth - AUTO(37.5))/2.0;
    CGFloat  itemHeight = AUTO(95.0);
    cellView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, itemWidth, itemHeight)];
    cellView.backgroundColor = [UIColor clearColor];
    LRViewBorderRadius(cellView, 0, 1.0, ColorBtnYellow);
    selectImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, AUTO(5), AUTO(15), AUTO(15))];
    selectImage.image = IMAGE(@"zjmSynced");
    UICollectionViewFlowLayout  *layout = [[UICollectionViewFlowLayout alloc]init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    layout.sectionInset = UIEdgeInsetsMake(20, AUTO(12.5), 0, AUTO(12.5));
    // 设置cell之间间距
    layout.minimumInteritemSpacing = AUTO(12.5);
   // 设置行距
    layout.minimumLineSpacing = AUTO(12.5);
    return [super initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNav];
    self.view.backgroundColor = WHITECOLOR;
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    self.collectionView.backgroundColor = WHITECOLOR;
    
    // Register cell classes
    [self.collectionView registerClass:[LBB_SetCover_CollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

- (void)initNav
{
    UIBarButtonItem  *leftBrBtn = [[UIBarButtonItem alloc]initWithImage:IMAGE(@"back") style:0 target:self action:@selector(backControl)];
    leftBrBtn.tintColor = UIColorFromRGB(0x333333);
    self.navigationItem.leftBarButtonItem = leftBrBtn;
    
    //修改导航栏字体大小和颜色
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor blackColor]}];
    self.navigationItem.title = @"设置封面";
    
    UIBarButtonItem  *rightBrBtn = [[UIBarButtonItem alloc]initWithImage:IMAGE(@"zjmcorfirm") style:0 target:self action:@selector(okSelect)];
    rightBrBtn.tintColor = UIColorFromRGB(0xAC793B);
    self.navigationItem.rightBarButtonItem = rightBrBtn;
}

- (void)okSelect
{
    NSLog(@"选中啦");
}

- (void)backControl
{
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LBB_SetCover_CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    UIImageView  *cellImage = [[UIImageView alloc]initWithFrame:cell.frame];
    [cellImage sd_setImageWithURL:[NSURL URLWithString:@"http://c.hiphotos.baidu.com/image/pic/item/6c224f4a20a446230b10a7179a22720e0df3d7e8.jpg"] placeholderImage:DEFAULTIMAGE];
    cell.backgroundView = cellImage;

    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    LBB_SetCover_CollectionViewCell  *cell = (LBB_SetCover_CollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell addSubview:cellView];
    selectImage.left = cell.width - AUTO(20);
    [cell addSubview:selectImage];
    
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
