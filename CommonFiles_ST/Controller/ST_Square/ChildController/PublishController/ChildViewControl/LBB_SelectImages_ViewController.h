//
//  LBB_SelectImages_ViewController.h
//  ST_Travel
//
//  Created by dawei che on 2016/11/3.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "Base_BaseViewController.h"
#import "LBB_ZJMPhotoList.h"
#import "Header.h"

typedef void (^returnBackPhotoArr)(id data);

@interface LBB_SelectImages_ViewController : Base_BaseViewController
@property(nonatomic,strong)LBB_ZJMPhotoList *listModel;

/**
 *  小图浏览的相册标题
 */
@property(nonatomic,strong)NSString * smallTitle;
/**
 *  小图浏览的数据源
 */
@property(nonatomic,strong)NSArray * fetchResult;

/**
 *  所能选择的图片上限
 */
@property(nonatomic,assign)NSInteger addNum;

/**
 *  控制器的区分
 */
@property(nonatomic,assign)NSInteger fatherNum;

@property(nonatomic,copy)returnBackPhotoArr     returnBlock;
@property(nonatomic,strong)hideBaseController   _blockHideControl;
@property(nonatomic,strong)JumpToController     _blockJumpControl;

#pragma mark - Photo library change observer
- (void)registerChangeObserver;
- (void)unregisterChangeObserver;

@end
