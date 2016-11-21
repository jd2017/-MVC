//
//  CZApp.h
//  九宫格MVC
//
//  Created by jinde on 15/11/23.
//  Copyright © 2015年 jsz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CZApp : NSObject

@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *icon;

- (instancetype) initWithDict:(NSDictionary *)dict;
+ (instancetype) appWithDict:(NSDictionary *)dict;

@end
