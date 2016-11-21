//
//  CZAppView.h
//  九宫格MVC
//
//  Created by jinde on 15/11/25.
//  Copyright © 2015年 jsz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CZApp;
@interface CZAppView : UIView
@property(nonatomic, strong) CZApp *model;

// 为自定义view封装一个类方法, 这个类方法的作用就是创建一个view对象
+(instancetype) appView;

@end
