//
//  ProjectModel.h
//  PlantBox
//
//  Created by admin on 16/5/12.
//  Copyright © 2016年 JCK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProjectModel : NSObject
@property (nonatomic, copy) NSString *applyManName;     // 申请人
@property (nonatomic, copy) NSString *telephone;        // 电话
@property (nonatomic, copy) NSString *createTime;       // 时间
@property (nonatomic, copy) NSString *natureType;       // 项目性质
@property (nonatomic, copy) NSString *money;            // 投资总额
@property (nonatomic, copy) NSString *projectName;      // 项目名称
@property (nonatomic, copy) NSString *companyType;      // 项目分类
@property (nonatomic, copy) NSString *categoryType;     // 行业
@property (nonatomic, copy) NSString *processStatus;    // 项目进度标识
@property (nonatomic, copy) NSString *questions;        // 存在问题
@property (nonatomic, copy) NSString *classTypeName;    // 投资种类
@property (nonatomic, copy) NSString *status;           // 项目状态标识

@property (nonatomic, copy) NSString *summary;          // 内容
@property (nonatomic, copy) NSString *title;            // 标题
@property (nonatomic, copy) NSString *author;           // 报告人 / 图片
@property (nonatomic, copy) NSString *listCreateDate;   // 时间
@property (nonatomic, copy) NSString *projectIDofModel; // 项目ID

@property (nonatomic, copy) NSString *linkManName;      // 联系人名字
@property (nonatomic, copy) NSString *linkPhone;        // 联系人手机
@property (nonatomic, copy) NSString *linkMobile;       // 联系人座机
@property (nonatomic, copy) NSString *zhiWuName;        // 联系人职务
@property (nonatomic, copy) NSString *linkID;

#pragma mark - 项目进度详情
@property (nonatomic, copy) NSString *process;
@property (nonatomic, copy) NSString *processID; // 产品ID
@property (nonatomic, copy) NSString *processStructureName;
@property (nonatomic, copy) NSString *processCheckTime;
@property (nonatomic, copy) NSString *processCheckUserName;
@property (nonatomic, copy) NSString *processCheckCuauses;
@property (nonatomic, copy) NSString *processCurrNumber;
#pragma mark - 广告
@property (nonatomic, copy) NSString *homeImg;
#pragma mark - 群发
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *messageime;
@property (nonatomic, copy) NSString *messageFrom;
@property (nonatomic, copy) NSString *messageTo;

#pragma mark - 产品列表
@property (nonatomic, strong) NSMutableArray *productListImgs;
@property (nonatomic, copy) NSString *totalComment;
@property (nonatomic, copy) NSString *hits;
@property (nonatomic, copy) NSString *totalCollect;
@property (nonatomic, copy) NSString *productName;
@property (nonatomic, copy) NSString *productImg;
@property (nonatomic, copy) NSString *productListID;
@property (nonatomic, copy) NSString *productUserID;
@property (nonatomic, copy) NSString *prodeuctAddress;
@property (nonatomic, copy) NSString *prodeuctNotice;
#pragma mark - 商品列表
@property (nonatomic, copy) NSString *shopListID;
@property (nonatomic, copy) NSString *shopListNotice;
@property (nonatomic, copy) NSString *shopListName;
@property (nonatomic, copy) NSString *shopListTotalBuy;
@property (nonatomic, copy) NSString *shopListImg;

#pragma mark - 商品详细列表
@property (nonatomic, copy) NSString *shopInfoListNotice;
@property (nonatomic, copy) NSString *shopInfoListName;
@property (nonatomic, copy) NSString *shopInfoListTotalBuy;
@property (nonatomic, copy) NSString *shopinfoListPrice;
@property (nonatomic, copy) NSString *shopinfobuyID;
@property (nonatomic, strong) NSArray *shopinfoListImgs;
@property (nonatomic, copy) NSString *shopinfoListID;

#pragma mark - 基地信息
@property (nonatomic, copy) NSString *myBaseDistance;
@property (nonatomic, copy) NSString *myBasePlantName;
@property (nonatomic, copy) NSString *myBaseUserName;
#pragma mark - 附近信息
@property (nonatomic, copy) NSString *nearDistance;
@property (nonatomic, copy) NSString *nearName;
@property (nonatomic, copy) NSString *nearPraiseCount;
@property (nonatomic, copy) NSString *nearImg;
@property (nonatomic, copy) NSString *nearID;
@property (nonatomic, copy) NSString *nearAddress;
#pragma mark - 收藏列表
@property (nonatomic, copy) NSString *colletName;
@property (nonatomic, copy) NSString *collectTime;
@property (nonatomic, copy) NSString *collectID;
@property (nonatomic, copy) NSString *collcetImg;
#pragma mark - 评论列表
@property (nonatomic, copy) NSString *comName;
@property (nonatomic, copy) NSString *comment;
@property (nonatomic, copy) NSString *comTime;
@property (nonatomic, copy) NSString *comImg;

#pragma mark - 订单列表
@property (nonatomic, copy) NSString *myOrderName;
@property (nonatomic, copy) NSString *myOrderAddress;
@property (nonatomic, copy) NSString *myOrderNo;
@property (nonatomic, copy) NSString *myOrderTime;

#pragma mark - 我的发布植物列表
@property (nonatomic, copy) NSString *goodpageName;
@property (nonatomic, copy) NSString *goodpagImg;
@property (nonatomic, copy) NSString *goodpagID;

#pragma mark - 教程
@property (nonatomic, copy) NSString *headTitle;
@property (nonatomic, strong) NSArray *goodComImgLists;
@property (nonatomic, copy) NSString *goodsCom;
@property (nonatomic, copy) NSString *goodsID;
@property (nonatomic, copy) NSString *goodsTime;
@property (nonatomic, copy) NSString *goodImg;

#pragma mark - 教程详情
@property (nonatomic, copy) NSString *rcourseTitle;
@property (nonatomic, strong) NSArray *rcourseImgLists;
@property (nonatomic, copy) NSString *rcourseCom;
@property (nonatomic, copy) NSString *recourseTime;

#pragma mark - 用户基地详情
@property (nonatomic, copy) NSString *baseName;
@property (nonatomic, copy) NSString *baseImg;
@property (nonatomic, strong) NSArray *baseImgLists;
@property (nonatomic, copy) NSString *baseCom;
@property (nonatomic, copy) NSString *baseTime;
@property (nonatomic, copy) NSString *baseID;
@end


