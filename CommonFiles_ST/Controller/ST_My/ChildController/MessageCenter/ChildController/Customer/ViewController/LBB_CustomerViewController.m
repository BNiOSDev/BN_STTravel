//
//  LBB_CustomerViewController.m
//  ST_Travel
//
//  Created by Diana on 16/10/26.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_CustomerViewController.h"
#import "LBB_MessageCenterViewCell.h"
#import "UIImageView+WebCache.h"

@interface LBB_CustomerViewController ()
<UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic,weak) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataSourceArray;

@end

@implementation LBB_CustomerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buildControls
{
    UINib *nib = [UINib nibWithNibName:@"LBB_MessageCenterViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"LBB_MessageCenterViewCell"];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.dataSourceArray = [[NSMutableArray alloc] initWithArray:@[@{@"UserImage":@"19.pic.jpg",
                                                                     @"UserName":@"小路粑粑",
                                                                     @"Content":@"您好，请问有什么可以帮到您",
                                                                     @"Date":@"07-17"
                                                                     },
                                                                   @{@"UserImage":@"19.pic.jpg",
                                                                     @"UserName":@"小路粑粑",
                                                                     @"Content":@"您好，请问有什么可以帮到您",
                                                                     @"Date":@"07-17"
                                                                     },
                                                                   @{@"UserImage":@"19.pic.jpg",
                                                                     @"UserName":@"小路粑粑",
                                                                     @"Content":@"您好，请问有什么可以帮到您",
                                                                     @"Date":@"07-17"
                                                                     },
                                                                   @{@"UserImage":@"19.pic.jpg",
                                                                     @"UserName":@"小路粑粑",
                                                                     @"Content":@"您好，请问有什么可以帮到您",
                                                                     @"Date":@"07-17"
                                                                     },
                                                                   @{@"UserImage":@"19.pic.jpg",
                                                                     @"UserName":@"小路粑粑",
                                                                     @"Content":@"您好，请问有什么可以帮到您",
                                                                     @"Date":@"07-17"
                                                                     }
                                                                   ]];
}

#pragma mark - tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourceArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = [tableView fd_heightForCellWithIdentifier:@"LBB_MessageCenterViewCell"
                                                 configuration:^(LBB_MessageCenterViewCell *cell) {
                                                     NSDictionary *cellDict = [self.dataSourceArray objectAtIndex:[indexPath row]];
                                                     [self configCell:cell Model:cellDict];
                                                 }];
    return height;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"LBB_MessageCenterViewCell";
    LBB_MessageCenterViewCell *cell = nil;
    
    NSDictionary *cellDict = [self.dataSourceArray objectAtIndex:indexPath.row];
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[LBB_MessageCenterViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.accessoryView =  nil;
    [self configCell:cell Model:cellDict];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *cellDict = [self.dataSourceArray objectAtIndex:[indexPath section]];
}

- (void)configCell:(LBB_MessageCenterViewCell*)cell Model:(NSDictionary*)cellDict
{
    cell.titleLabel.text = [cellDict objectForKey:@"UserName"];
    cell.contentLabel.text = [cellDict objectForKey:@"Content"];
    cell.dateLabel.text = [cellDict objectForKey:@"Date"];
    
    cell.iconImgView.image = IMAGE([cellDict objectForKey:@"UserImage"]);
    //todo
    [cell.imageView sd_cancelCurrentImageLoad];
//    cell.iconImgView sd_setImageWithURL:<#(NSURL *)#> placeholderImage:<#(UIImage *)#>
}


@end
