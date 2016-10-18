//
//  SetingSwitchBaseViewController.m
//  LUBABA
//
//  Created by Diana on 16/10/10.
//  Copyright © 2016年 Diana. All rights reserved.
//

#import "SetingSwitchBaseViewController.h"
#import "SwitchViewCell.h"

@interface SetingSwitchBaseViewController ()

@end

@implementation SetingSwitchBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UINib *nib = [UINib nibWithNibName:@"SwitchViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"SwitchViewCell"];
    self.automaticallyAdjustsScrollViewInsets = NO;
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
    LBBLOG(@"%d",[[cellDict objectForKey:@"SwitchOn"] boolValue]);
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
