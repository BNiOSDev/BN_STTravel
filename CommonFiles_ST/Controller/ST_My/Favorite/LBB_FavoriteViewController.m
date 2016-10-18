//
//  LBB_FavoriteViewController.m
//  ST_Travel
//
//  Created by dhxiang on 16/10/16.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_FavoriteViewController.h"
#import "SwitchViewCell.h"

@interface LBB_FavoriteViewController ()
<UITableViewDelegate,
UITableViewDataSource
>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *dataSourceArray;
@property (weak, nonatomic) IBOutlet UIView *segmentControlBgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *segmentControlHeighConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewTopConstraint;
    
@end

@implementation LBB_FavoriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableViewTopConstraint.constant = self.segmentControlHeighConstraint.constant;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourceArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SwitchViewCell";
    SwitchViewCell *cell = nil;
    
    NSDictionary *cellDict = [self.dataSourceArray objectAtIndex:[indexPath row]];
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[SwitchViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectedBackgroundView.backgroundColor = RGB(240, 240, 240);
    cell.contentLabel.text = [cellDict objectForKey:@"Title"];
    cell.descLabel.hidden = ![[cellDict objectForKey:@"ShowDesc"] boolValue];
    [cell.switchBtn setOn:[[cellDict objectForKey:@"SwitchOn"] boolValue]];
    NSLog(@"%d",[[cellDict objectForKey:@"SwitchOn"] boolValue]);
    cell.accessoryView =  nil;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
[tableView deselectRowAtIndexPath:indexPath animated:YES];
NSMutableDictionary *tmpDict = [NSMutableDictionary dictionaryWithDictionary:self.dataSourceArray[indexPath.row]];
if ([[tmpDict objectForKey:@"SwitchOn"] boolValue]) {
    [tmpDict setObject:[NSNumber numberWithBool:NO] forKey:@"SwitchOn"];
}else {
    [tmpDict setObject:[NSNumber numberWithBool:YES] forKey:@"SwitchOn"];
}
[self.dataSourceArray replaceObjectAtIndex:indexPath.row withObject:tmpDict];
[self.tableView reloadData];
}


@end
