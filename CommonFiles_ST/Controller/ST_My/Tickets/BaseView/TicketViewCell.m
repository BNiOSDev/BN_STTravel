//
//  TicketViewCell.m
//  LUBABA
//
//  Created by Diana on 16/10/12.
//  Copyright © 2016年 Diana. All rights reserved.
//

#import "TicketViewCell.h"
#import "TicketDetailViewCell.h"

@interface TicketViewCell()<
UITableViewDelegate,
UITableViewDataSource
>
@property (strong,nonatomic) NSMutableArray *dataSourceArray;

@end

@implementation TicketViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UINib *nib = [UINib nibWithNibName:@"TicketDetailViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"TicketDetailViewCell"];
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.numLabel.text = @"";
    self.stateLabel.text = @"";
    self.goodNumLabel.text = @"";
    self.goodMoneyLabel.text = @"";
    self.rightBtn.hidden = YES;
    self.leftBtn.hidden = YES;
    [self.tableView reloadData];
}

- (void)setCellInfo:(NSDictionary*)cellInfo
{
    self.dataSourceArray = [cellInfo objectForKey:@"GoodList"];
    self.numLabel.text = [cellInfo objectForKey:@"TicketNum"];
    self.stateLabel.text = [cellInfo objectForKey:@"State"];
    self.goodNumLabel.text = [cellInfo objectForKey:@"GoogNum"];
    self.goodMoneyLabel.text = [cellInfo objectForKey:@"TotalMonney"];
    self.rightBtn.hidden = NO;
    self.leftBtn.hidden = NO;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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
    static NSString *CellIdentifier = @"TicketDetailViewCell";
    TicketDetailViewCell *cell = nil;
    
    NSDictionary *cellDict = [self.dataSourceArray objectAtIndex:[indexPath row]];
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[TicketDetailViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectedBackgroundView.backgroundColor = RGB(240, 240, 240);
    cell.nameLabel.text = [cellDict objectForKey:@"Title"];
    cell.typeLabel.text = [cellDict objectForKey:@"Type"];
    cell.monneyLabel.text = [cellDict objectForKey:@"Money"];
    cell.numLabel.text = [cellDict objectForKey:@"Num"];
    cell.imgView.image = [UIImage imageNamed:[cellDict objectForKey:@"Image"]];
    cell.accessoryView =  nil;
    
    if (indexPath.row == self.dataSourceArray.count - 1) {
        cell.lineView.hidden = YES;
    }else {
        cell.lineView.hidden = NO;
    }
    
    return cell;
}

#pragma mark - UI Action

- (IBAction)rightBtnAction:(id)sender {
    if (self.mDelegate && [self.mDelegate respondsToSelector:@selector(cellBtnClickDelegate:StateType:)]) {
        [self.mDelegate cellBtnClickDelegate:self.cellInfo StateType:eHavePayState];
    }
}
- (IBAction)leftBtnAction:(id)sender {
    
    if (self.mDelegate && [self.mDelegate respondsToSelector:@selector(cellBtnClickDelegate:StateType:)]) {
        [self.mDelegate cellBtnClickDelegate:self.cellInfo StateType:eWaitReceiveState];
    }
}

@end
