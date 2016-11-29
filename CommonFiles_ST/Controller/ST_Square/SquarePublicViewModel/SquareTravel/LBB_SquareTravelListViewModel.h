//
//  LBB_SquareTravelListViewModel.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/26.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LBB_TagsViewModel.h"
#import "BN_SquareTravelNotesModel.h"

@interface BN_SquareTravelList : BN_BaseDataModel

@property(nonatomic, assign)long travelNotesId;//	Long	游记主键
@property(nonatomic, strong)NSString* travelNotesName; //	String	游记名称
@property(nonatomic, strong)NSString* travelNotesPicUrl;//	String	游记封面
@property(nonatomic, strong)NSString* lastReleaseTime;//	String	发布日期
@property(nonatomic, assign)int dayCount;//	Int	天数
@property(nonatomic, assign)long totalPageViews;//	Long	浏览总数
@property(nonatomic, assign)long userId;//	Long	用户ID
@property(nonatomic, strong)NSString* userName;//	String	用户名称
@property(nonatomic, strong)NSString* userPicUrl;//	String	用户头像
@property(nonatomic, strong)NSArray<LBB_SquareTags*>* tags;//	List	标签集合
@property(nonatomic, assign)int isLiked;//	int	是否点赞
@property(nonatomic, assign)int likeNum;//	Int	点赞数
@property(nonatomic, assign)int commentsNum;//	Int	评论数
@property(nonatomic, assign)int isCollected;//	int	是否收藏
@property(nonatomic, assign)int totalCollected;//	Int	收藏数

/**
 3.4.17 主页-游记详情/游记下载（已测）
 */
@property(nonatomic, strong)BN_SquareTravelNotesModel* travelDetailModel;
-(void)getTravelDetailModel;

@end



/**
 3.4.16 主页-游记列表（已测）
 */
@interface LBB_SquareTravelListViewModel : BN_BaseDataModel

@property(nonatomic, strong)NSMutableArray<BN_SquareTravelList*>* squareTravelArray;

- (void)getSquareTravelList:(BOOL)clear;



@end