//
//  NextManger.h
//  PlantBox
//
//  Created by admin on 16/5/12.
//  Copyright © 2016年 JCK. All rights reserved.
//

#import <Foundation/Foundation.h>
extern NSString *NetManagerRefreshNotify;
/*
 ---- 公共接口 ----
 方式	地址	说明
 POST	common/article/getarticlelist
 No documentation available.
 
 POST	common/file/upload
 上传 ResourceType值说明： 1 头像 201 项目图片
 
 POST	common/advertise/getlist
 广告列表
 
 POST	common/user/login
 登录
 
 POST	common/user/update
 修改个人信息
 
 
 ---- 项目管理 ----
 方式	地址	说明
 
 POST	project/home/getprojectlist
 项目列表
 
 POST	project/home/getproject
 项目详情
 
 POST	project/home/projectsave
 保存上报项目
 
 
 ---- 系统设置 ----
 方式	地址	说明
 
 POST	systemset/account/updatepassword
 修改密码
 
 POST	systemset/account/resetpassword
 重置用户密码
 
 POST	systemset/getlatestversoin
 获取最新版本
 
 POST	systemset/addfeedback
 添加系统反馈
 
 POST	systemset/addfeedbacktest
 添加系统反馈测试
 */

typedef enum
{
    RequestOfGetarticlelist = 0,    // 获取内容列表
    
    RequestOfUpload,                // 上传 ResourceType值说明： 1 头像 201 项目图片
    
    RequestOfGetlist,               // 广告列表
    
    RequestOfLogin,                 // 登录
    
    RequestOfUpdate,                // 修改个人信息
    
    RequestOfGetprojectlist,        // 项目列表
    
    RequestOfGetprojectt,           // 项目详情
    
    RequestOfProjectsave,           // 保存上报项目
    
    RequestOfUpdatepassword,        // 修改密码
    
    RequestOfResetpassword,         // 重置用户密码
    
    RequestOfGetlatestversoin,      // 获取最新版本
    
    RequestOfAddfeedback,           // 添加系统反馈
    
    RequestOfAddfeedbacktest,       // 添加系统反馈测试
    
    RequestOfuserGetcontacts,        // 获取常用联系人
    
    RequestOfGetprojectts,           // 项目进度详情
    
    RequestOfProjectcheck,           // 项目审核
    
    RequestOfMeagessList,           // 群发列表
    
    RequestOfSendMeagess,           // 群发
    
    RequestOfGetproductlist,     // 获取商品列表
    
    RequestOfGetproduct,         // 获取商品列表

    RequestOfGetusergoodpagelist,        // 获取商品列表
    
    RequestOforderSaveorder,        // 获取订单列表
    
    RequestOfgetusergoodnear,         // 获取附近列表
    
    RequestOfuserCollect,         // 收藏
    
    RequestOfuserCollectList,         // 收藏列表
    
    RequestOfuserSubscribe,         // 点赞
    
    RequestOfusercomment,        // 评论
    
    RequestOfuserGetcommentlist,        // 评论列表
    
    RequestOfregister,       // 评论列表
    
    RequestOfgetorderlist,        // 我的订单
    
    RequestOfloginbythird,        // 第三方登录
    
    RequestOfgetusergoodpagelistmine ,       // 获取某用户自己的基地或植物列表
    
    RequestOfsendgoodrecord,        // 发表个人教程
    
    RequestOfgetusercoursepagelistmine,        // 获取我的用户教程
    
    RequestOfgetusercoursepagelist,        // 获取用户教程
    
    RequestOfgetusercourse ,       // 获取教程详情
    
    RequestOfgetusergoodsrecordpagelistUserID  ,      // 获取基地详情
    
    RequestOfgetqrcode        // 扫码返回
    
}RequestState;
@interface NextManger : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *password;
#pragma mark - 注册
@property (nonatomic, copy) NSString *registerName;
@property (nonatomic, copy) NSString *registerPwd;
#pragma mark - 登录用户信息
@property (nonatomic, copy) NSString *userLat;
@property (nonatomic, copy) NSString *userLon;
@property (nonatomic, copy) NSString *userID_Code; // ID
@property (nonatomic, copy) NSString *userC_Name; //用户名字
@property (nonatomic, copy) NSString *userLoginName; //用户账号
@property (nonatomic, copy) NSString *versionName;
@property (nonatomic, copy) NSString *oldPword; // 旧密码
@property (nonatomic, copy) NSString *passwordOfnew; // 新密码
@property (nonatomic, copy) NSString *createTime; // 用户创建时间
@property (nonatomic, copy) NSString *userAddress; // 用户地址
@property (nonatomic, copy) NSString *projectID; //商品ID
@property (nonatomic, copy) NSString *channelID;
@property (nonatomic, strong) NSArray *formArray;
@property (nonatomic, copy) NSString *keyword; // 搜索关键字
@property (nonatomic, copy) NSString *cheakComment;
@property (nonatomic, copy) NSString *userMobile; // 用户手机
@property (nonatomic, copy) NSString *userEWM; // 用户二维码
@property (nonatomic, copy) NSString *checkStatus;
@property (nonatomic, copy) NSString *currNumber;
@property (nonatomic, copy) NSString *structureId;
@property (nonatomic, copy) NSString *userId;// 用户ID
@property (nonatomic, copy) NSArray *userThirdInfos;
@property (nonatomic, copy) NSString *userPhoto; // 头像
@property (nonatomic, copy) NSString *homekeyWork;
@property (nonatomic, copy) NSString *orderID;
@property (nonatomic, strong) NSMutableArray *totalCollects; // 收藏数;
@property (nonatomic, strong) NSMutableArray *m_details;
@property (nonatomic, strong) NSMutableArray *m_projectInfoArr;
@property (nonatomic, strong) NSMutableArray *m_listArr;
@property (nonatomic, strong) NSMutableArray *m_getcontacts;
@property (nonatomic, strong) NSMutableArray *m_processArr;
@property (nonatomic, strong) NSMutableArray *m_imgArr;// 广告图片
@property (nonatomic, strong) NSMutableArray *m_imgLink; // 图片链接
@property (nonatomic, strong) NSMutableArray *m_messages;
#pragma mark - 订单参数
@property (nonatomic, copy) NSString *orderAddress;
@property (nonatomic, copy) NSString *orderPEId;
@property (nonatomic, copy) NSString *orderProID;
@property (nonatomic, copy) NSString *orderMobile;
@property (nonatomic, copy) NSString *orderQty;
@property (nonatomic, copy) NSString *orderPrice;
@property (nonatomic, copy) NSString *orderName;
#pragma mark - 订单数组
@property (nonatomic, strong) NSMutableArray *m_MyorderLists;
#pragma mark - 基地数组
@property (nonatomic, strong) NSMutableArray *m_baseLists;
#pragma mark - 产品数组
@property (nonatomic, strong) NSMutableArray *m_ProductLists;

#pragma mark - 产品列表数组
@property (nonatomic, strong) NSMutableArray *m_ProductShopLists;

#pragma mark - 商品信息数组
@property (nonatomic, strong) NSMutableArray *m_ProductShopInfoLists;

#pragma mark - 基地信息数组
@property (nonatomic, strong) NSMutableArray *m_myBases;

#pragma mark - 附近信息数组
@property (nonatomic, strong) NSMutableArray *m_nears;
@property (nonatomic, copy) NSString *nearLon;
@property (nonatomic, copy) NSString *nearLat;
@property (nonatomic, strong) NSMutableArray *nearDatas;
#pragma mark - 收藏
@property (nonatomic, copy) NSString *userCollectFKId;
@property (nonatomic, copy) NSString *IsCollect;
#pragma mark - 收藏列表
@property (nonatomic, strong) NSMutableArray *m_collectLists;
@property (nonatomic, strong) NSArray *nams;
@property (nonatomic, copy) NSString *messageContent;
@property (nonatomic, assign) BOOL isKeyword;
#pragma mark - 评论
@property (nonatomic, copy) NSString *content;
@property (nonatomic, strong) NSMutableArray *m_comLists;

#pragma mark - 发布植物列表
@property (nonatomic, strong) NSMutableArray *m_goodPageLists;
@property (nonatomic, strong) NSArray *goodComImgLists;
@property (nonatomic, copy) NSString *goodsCom;
@property (nonatomic, copy) NSString *goodsID;
@property (nonatomic, copy) NSString *newgoodsID;
@property (nonatomic, copy) NSString *goodsHeadTitle;

#pragma mark - 教程列表
@property (nonatomic, strong) NSMutableArray *m_jcLists;
#pragma mark - 我的教程列表
@property (nonatomic, strong) NSMutableArray *m_jcListsmine;

@property (nonatomic, strong) NSMutableArray *m_rcourses;

+ (instancetype)shareInstance;
- (void)loadData:(RequestState)requet;
@end
