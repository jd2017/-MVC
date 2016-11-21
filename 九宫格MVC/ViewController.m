//
//  ViewController.m
//  九宫格MVC
//
//  Created by jinde on 15/11/23.
//  Copyright © 2015年 jsz. All rights reserved.
//

#import "ViewController.h"
#import "CZApp.h"
#import "CZAppView.h"

@interface ViewController ()

// 用来保存所有应该的数据
@property(nonatomic, strong) NSArray *apps;

@end

@implementation ViewController

//懒加载app.plist 文件
-(NSArray *) apps
{
    if (_apps == nil) {
        //1, 加载 apps.plist 文件
        NSString *path = [[NSBundle mainBundle] pathForResource:@"app.plist" ofType:nil];
        //2, 根据路径加载数据
        NSArray *arrayDict = [NSArray arrayWithContentsOfFile:path];
        //3, 创建一个可变的数组保存一个模型对象
        NSMutableArray *arrayModels = [NSMutableArray array];

        //循环字典数组， 把每个字典对象转换成一个模型对象
        for (NSDictionary *dict in arrayDict) {
            // 创建一个模型
            CZApp *model = [CZApp appWithDict:dict];
            // 把模型加到arrayModels中
            [arrayModels addObject:model];
        }
        _apps = arrayModels;
    }
    return _apps;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    //假设每行的应用个数
    int columns = 3;
    //获取控制器所管理的View的宽度
     CGFloat viewWidth = self.view.frame.size.width;
    //每个应用的宽和高：
    CGFloat appW = 75;
    CGFloat appH = 90;
    CGFloat marginTop = 30; //距顶部距离
    CGFloat marginX = (viewWidth - appW*columns)/(columns +1); //列 间隔
    CGFloat marginY =marginX;

    //for 循环 applist 数据赋值：
    for (int i= 0; i < self.apps.count; i++) {
        //获取当前应用的数据字典
        CZApp * appModel = self.apps[i];

        //1，通过Xib 封装到View中创建
        CZAppView *appView = [CZAppView appView];

        //2.1 设置appView 的frame 属性
        // 每个单元格所在的列的索引
        int colIdx = i % columns;
        // 计算每个单元格的行索引
        int rowIdx = i / columns;
        CGFloat appX = marginX + colIdx*(appW + marginX);
        CGFloat appY = marginTop + rowIdx*(appH + marginY);
        appView.frame = CGRectMake(appX, appY, appW, appH);
        //3, 将 appView 添加到 self.view 中
        [self.view addSubview:appView];
        //4，设置appView 的子控件
         appView.model = appModel;
    }
}
// 按钮的单击事件
-(void) btnDownlaodClick
{
    NSLog(@"btnClick 被点击了");
}

-(void)subView: (UIView *)appView : (CZApp *)appModel{
    //4.1 增加一个 图片框
    UIImageView *imgViewIcon = [[UIImageView alloc] init];
    CGFloat iconW = 45;
    CGFloat iconH = 45;
    CGFloat iconX = (appView.frame.size.width -iconW)*0.5;
    CGFloat iconY = 0;
    imgViewIcon.frame = CGRectMake(iconX, iconY, iconW, iconH);
    [appView addSubview:imgViewIcon];

    // 设置图片框的数据
    imgViewIcon.image = [UIImage imageNamed:appModel.icon];

    //4.2 增加一个Label(标签)
    //创建Label
    UILabel *lblName = [[UILabel alloc] init];
    // 设置frame
    CGFloat nameW = appView.frame.size.width;
    CGFloat nameH = 20;
    CGFloat nameY = iconH;
    CGFloat nameX = 0;
    lblName.frame = CGRectMake(nameX, nameY, nameW, nameH);


    //添加到appView中
    [appView addSubview:lblName];

    lblName.text = appModel.name;
    //设置lable的文字大小
    lblName.font = [UIFont systemFontOfSize:12];
    //设置文字居中
    lblName.textAlignment = NSTextAlignmentCenter;

    //4.3 增加一个按钮（UIButton）
    UIButton *btnDownload = [[UIButton alloc] init];
    CGFloat btnW = iconW;
    CGFloat btnH = 20;
    CGFloat btnX = iconX;
    // 补充:控件的最大的Y值 = 控件的Y值 + 控件的高度
    // 控件的最大的X值 = 控件的X值 + 控件的宽度
    CGFloat btnY = CGRectGetMaxY(lblName.frame);
    btnDownload.frame = CGRectMake(btnX, btnY, btnW, btnH);
    // 添加到appView中
    [appView addSubview:btnDownload];

    // 设置按钮的数据
    // 1. 设置按钮上的文字
    [btnDownload setTitle:@"下载" forState:UIControlStateNormal];
    [btnDownload setTitle:@"已下载" forState:UIControlStateDisabled];
    //2，设置背景图片
    [btnDownload setBackgroundImage:[UIImage imageNamed:@"buttongreen"] forState:UIControlStateNormal];
    [btnDownload setBackgroundImage:[UIImage imageNamed:@"buttongreen_highlighted"] forState:UIControlStateHighlighted];
    //3，设置按钮文字的大小
    btnDownload.titleLabel.font = [UIFont systemFontOfSize:14];

    //为按钮注册一个单击事件
    [btnDownload addTarget:self action:@selector(btnDownlaodClick) forControlEvents:UIControlEventTouchUpInside];
}
@end
