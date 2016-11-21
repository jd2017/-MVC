//
//  CZApp.m
//  九宫格MVC
//
//  Created by jinde on 15/11/23.
//  Copyright © 2015年 jsz. All rights reserved.
//

#import "CZApp.h"

@implementation CZApp

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.name = dict[@"name"];
        self.icon = dict[@"icon"];
    }
    return self;
}

+ (instancetype)appWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}



@end
