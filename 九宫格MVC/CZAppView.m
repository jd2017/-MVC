//
//  CZAppView.m
//  九宫格MVC
//
//  Created by jinde on 15/11/25.
//  Copyright © 2015年 jsz. All rights reserved.
//

#import "CZAppView.h"
#import "CZApp.h"

@interface CZAppView ()

@property (weak, nonatomic) IBOutlet UIImageView *imgViewIcon;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UIButton *btnDownload;
- (IBAction)btnDownloadClick:(UIButton *)sender;

@end

@implementation CZAppView

// 重写model属性的set方法
- (void)setModel:(CZApp *)model
{
    //先赋值
    _model = model;
    //解析模型数据， 把模型数据赋值给UIView中的各个子控件
    self.imgViewIcon.image = [UIImage imageNamed:model.icon];
    self.lblName.text = model.name;
}
// 为自定义view封装一个类方法, 这个类方法的作用就是创建一个view对象
+(instancetype)appView
{
    //1，通过Xib 创建每应用 UIView
    NSBundle *rootBuldle = [NSBundle mainBundle];
    return [[rootBuldle loadNibNamed:@"CZAppView" owner:nil options:nil] lastObject];
}

- (IBAction)btnDownloadClick:(UIButton *)sender {
    //点击后不可用
    sender.enabled = NO;
    // 2. 弹出一个消息提醒框(这个消息提醒框其实就是一个UILabel)
    UILabel *lblMsg = [[UILabel alloc] init];

    // 2.1 设置lblMsg的显示文字
    lblMsg.text = @"正在下载...";
    lblMsg.backgroundColor = [UIColor blackColor];
    lblMsg.textColor = [UIColor redColor];
    lblMsg.textAlignment = NSTextAlignmentCenter;
    lblMsg.font = [UIFont boldSystemFontOfSize:17];
    //设置文字的透明度
    lblMsg.alpha = 0.0;
    //设置lable 的弧度，设置半径
    lblMsg.layer.cornerRadius = 10;
    //多余的裁减掉
    lblMsg.layer.masksToBounds = YES;
    // 2.9通过动画的方式来显示Label
     // 开启一个动画, 这个动画要执行1.5秒钟,延迟1.0秒后，消失
    [UIView animateWithDuration:1.5 animations:^{
        lblMsg.alpha = 0.6;
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:1.5 delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
                 lblMsg.alpha = 0;
            } completion:^(BOOL finished) {
                [lblMsg removeFromSuperview];
            }];
        }
    }];
    CGFloat viewW = self.superview.frame.size.width;
    CGFloat viewH = self.superview.frame.size.height;
    CGFloat msgW = 200;
    CGFloat msgH = 30;
    CGFloat msgX = (viewW - msgW) / 2;
    CGFloat msgY = (viewH - msgH) * 0.5;
    lblMsg.frame = CGRectMake(msgX, msgY, msgW, msgH);

    [self.superview addSubview:lblMsg];

}
@end
