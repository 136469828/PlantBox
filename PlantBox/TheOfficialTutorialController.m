
//
//  TheOfficialTutorialController.m
//  PlantBox
//
//  Created by admin on 16/5/13.
//  Copyright © 2016年 JCK. All rights reserved.
//

#import "TheOfficialTutorialController.h"
#import "TLDisplayView.h"
#define duorou @"        多肉植物是指植物营养器官肥大的高等植物，通常具根、茎、叶三种营养器官和花、果实、种子三种繁殖器官。在园艺上，又称多浆植物或多肉花卉，但以多肉植物这个名称最为常用。全世界共有多肉植物一万余种，它们都属于高等植物(绝大多数都是被子植物)。在植物分类上是隶属几十个科的。个别专家认为有67个科中含有多肉植物，但是大多数专家认为只有50余科含有多肉植物。"
#define guanhua @"        以观花为主的植物。其花色艳丽，花朵硕大，花形奇异，并具香气。春天开花的有水仙、迎春、春兰、杜鹃花、牡丹、月季、君子兰等；夏、秋季开花的有米兰、白兰花、扶桑、夹竹桃、昙花、珠兰、大丽花、荷花、菊花、一串红、桂花等；冬季开花的有一品红、腊梅、银柳等！"
#define guanye @"        观叶植物，一般指叶形和叶色美丽的植物，原生于高温多湿的热带雨林中，需光量较少﹑竹芋类﹑蕨类植物等。木本植物大多属灌木或灌木状植物，如小叶榄仁﹑鹅掌藤﹑福禄桐等等。 又分为草本植物和木本植物，草本植物多属多年生宿根草本如，椒草类。"
#define caoben @"       多年生植物是指寿命超过两年的植物。由于木本植物皆为多年生，本词通常仅指多年生的草本植物，多年生常绿草本植物,又称多年生草本、多年草等。多年生植物依气候不同而有多种型态。多年生植物的根一般比较粗壮，有的还长着块根、块茎、球茎、鳞茎等器官、冬天，地面上的部分仍安静地睡觉，到第二年气候转暖，它们又发芽生长在气候温和的地区，植物终年生长不落叶，称为常绿植物；在季节变化明显的地区多年生植物表现更为明显，植物在温暖的季节生长开花，到了冬天时，木本植物的树叶会枯黄掉落，称为落叶植物，草本植物则是仅保留地下茎或根部分进入休眠状态，称为宿根草。此外有些地区的气候变化是以干、湿季来划分，当地的植物又会有不同的生命周期。有些植物虽然有数年寿命，但生命中仅开花结果一次，然后便枯萎死亡，称为单次开花植物，如龙舌兰与竹子。"
#define muben @"       木本植物（woody plant）是指根和茎因增粗生长形成大量的木质部，而细胞壁也多数木质化的坚固的植物。植物体木质部发达，茎坚硬，多年生。与草本植物相对，人们常将前者称为树，后者称为草。木本植物依形态不同，分乔木、灌木和半灌木三类。木本植物是木材的来源，均为多年生植物。另外除买麻藤纲外所有裸子植物均属于木本植物、笔筒树是仅有的蕨类木本植物。木本植物因植株高度及分枝部位等不同，而细胞壁也多数木质化，具有形成层。地上部分为多年生的乔木和多年生的灌木。而与其相对应的便是草本植物。"
#define shuisheng @"       能在水中生长的植物，统称为水生植物。水生植物是出色的游泳运动员或潜水者。叶子柔软而透明，有的形成为丝状，如金鱼藻。丝状叶可以大大增加与水的接触面积，使叶子能最大限度地得到水里很少能得到的光照，吸收水里溶解得很少的二氧化碳，保证光合作用的进行。根据水生植物的生活方式，一般将其分为以下几大类：挺水植物、浮叶植物，沉水植物和漂浮植物以及湿生植物。"
#define shinei @"       室内绿化装饰的意义和作用 室内绿化装饰是指按照室内环境的特点，利用以室内观叶植物为主的观赏材料，结合人们的生活需要，对使用的器物和场所进行美化装饰。这种美化装饰是根据人们的物质生活与精神生活的需要出发，配合整个室内环境进行设计、装饰和布置，使室内室外融为一体，体现动和静的结合，达到人、室内环境与大自然的和谐统一，它是传统的建筑装饰的重要突破。"
#define shuipei @"       水培（Hydroponics）是一种新型的室内的植物无土栽培方式，又名营养液培：其核心是将植物根茎固定于定植篮内并使根系自然长入植物营养液中，这种营养液能代替自然土壤向植物体提供水分、养分、温度等生长因子，使植物能够正常生长并完成其整个生命周期。"
@interface TheOfficialTutorialController ()<TLDisplayViewDelegate>
{
    NSArray *datas;
}
@property (nonatomic, strong) TLDisplayView *displayView;

@end

@implementation TheOfficialTutorialController

- (void)viewDidLoad {
    [super viewDidLoad];
    for (int i = 0; i<3; i++) {
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake((i*ScreenWidth/3) + 5,20, ScreenWidth/3-15, ScreenWidth/3-15)];
        img.backgroundColor = [UIColor redColor];
        [self.view addSubview:img];
    }
    datas = @[duorou,guanhua,guanye,caoben,muben,shuisheng,shinei,shuipei];
    _displayView = [[TLDisplayView alloc] init];
    _displayView.delegate = self;
    _displayView.backgroundColor = [UIColor whiteColor];
    _displayView.numberOfLines = 5;
    [_displayView setText:datas[self.count]];
    [_displayView setOpenString:@"［查看全文］" closeString:@"［点击收起］" font:[UIFont systemFontOfSize:16] textColor:[UIColor blueColor]];
    CGSize size = [_displayView sizeThatFits:CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, MAXFLOAT)];
    _displayView.frame = CGRectMake(10, ScreenWidth/3-15+10+20, size.width, size.height);
    [self.view addSubview:_displayView];
    
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark -
#pragma mark TLDisplayViewDelegate
- (void)displayView:(TLDisplayView *)label closeHeight:(CGFloat)height {
    CGRect frame = _displayView.frame;
    frame.size.height = height;
    self.displayView.frame = frame;
}

- (void)displayView:(TLDisplayView *)label openHeight:(CGFloat)height {
    CGRect frame = _displayView.frame;
    frame.size.height = height;
    self.displayView.frame = frame;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
