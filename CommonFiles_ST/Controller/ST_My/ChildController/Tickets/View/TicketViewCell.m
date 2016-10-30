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
@property (assign,nonatomic) MineBaseViewType stateType;
@property (assign,nonatomic) TicketClickType clickType;
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
    self.goodNumLabel.text = [cellInfo objectForKey:@"GoogNum"];
    self.goodMoneyLabel.text = [cellInfo objectForKey:@"TotalMonney"];
    self.stateType = [[cellInfo objectForKey:@"TicketState"] intValue];
    switch (self.stateType) {
        case eTicket_WaitPay://待付款
        {
            self.rightBtn.hidden = NO;
            self.leftBtn.hidden = NO;
            self.stateLabel.text = @"待支付";
            [self.rightBtn setTitle:@"立即支付" forState:UIControlStateNormal];
            [self.leftBtn setTitle:@"取消订单" forState:UIControlStateNormal];
        }
            break;
        case eTicket_WaitGetTicket://待取票
        {
            self.rightBtn.hidden = NO;
            self.leftBtn.hidden = YES;
            self.stateLabel.text = @"待取票";
            [self.rightBtn setTitle:@"立即取票" forState:UIControlStateNormal];
        }
            break;
        case eTicket_WaitComment://待评价
        {
            self.rightBtn.hidden = NO;
            self.leftBtn.hidden = YES;
            self.stateLabel.text = @"待评价";
            [self.rightBtn setTitle:@"立即评价" forState:UIControlStateNormal];
        }
            break;
        case eTicket_Refund://退款
        {
            self.rightBtn.hidden = NO;
            self.leftBtn.hidden = YES;
            self.stateLabel.text = @"已退款";
            [self.rightBtn setTitle:@"查看详情" forState:UIControlStateNormal];
        }
            break;
        default:
            break;
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - tableView delegate

CGFloat ticketDetailCellHeight(NSString *nameStr ,NSString *typeStr)
{
    CGFloat height = 60.f;
    
//    CGSize constranedTypeSize = CGSizeMake(9999, 16.f);
//    CGSize typeSize = sizeOfString(typeStr, constranedTypeSize, [UIFont systemFontOfSize:13.f]);
//    
//    CGSize constranedSize = CGSizeMake(DeviceWidth - 135.f, 99999.f);
//    if (typeSize.width > 29.f) {
//        constranedSize = CGSizeMake(DeviceWidth - 135.f - (typeSize.width - 29.f), 99999.f);
//    }
//    CGSize nameSize = sizeOfString(nameStr, constranedSize, [UIFont systemFontOfSize:13.f]);
//    if (nameSize.height > 16) {
//        height += nameSize.height - 16;
//    }
    return height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourceArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *detailDict = [self.dataSourceArray objectAtIndex:indexPath.row];
    CGFloat height = ticketDetailCellHeight([detailDict objectForKey:@"Title"], [detailDict objectForKey:@"Type"]);
    return height;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.mDelegate &&
        [self.mDelegate respondsToSelector:@selector(ticketDetailDelegate:StateType:TicketClickType:)]) {
        [self.mDelegate ticketDetailDelegate:self.cellInfo
                                   StateType:self.stateType
                             TicketClickType:eShowDetail];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UI Action

- (IBAction)rightBtnAction:(id)sender {
    if (self.mDelegate &&
        [self.mDelegate respondsToSelector:@selector(cellBtnClickDelegate:StateType:TicketClickType:)]) {
        [self.mDelegate cellBtnClickDelegate:self.cellInfo
                                   StateType:self.stateType
                             TicketClickType:[self clickType:NO]];
    }
}

- (IBAction)leftBtnAction:(id)sender {
    
    if (self.mDelegate &&
        [self.mDelegate respondsToSelector:@selector(cellBtnClickDelegate:StateType:TicketClickType:)]) {
        [self.mDelegate cellBtnClickDelegate:self.cellInfo
                                   StateType:self.stateType
                             TicketClickType:[self clickType:YES]];
    }
}

- (TicketClickType)clickType:(BOOL)isLeft
{
    if (isLeft) {
        switch (self.stateType) {
            case eTicket_WaitPay:
            {
                _clickType = eCancelTicket;
            }
                break;
                
            default:
                break;
        }
    }else {
        switch (self.stateType) {
            case eTicket_WaitPay:
            {
                _clickType = eTicketPay;
            }
                break;
            case eTicket_WaitGetTicket:
            {
                _clickType = eGetTicket;
            }
                break;
            case eTicket_WaitComment:
            {
                _clickType = eComment;
            }
                break;
            case eTicket_Refund:
            {
                _clickType = eShowDetail;
            }
                break;
            default:
                break;
        }
    }
    return _clickType;
}

@end
