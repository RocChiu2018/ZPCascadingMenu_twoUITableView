//
//  ZPCategory.m
//  级联菜单
//
//  Created by apple on 2016/12/12.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZPCategory.h"

@implementation ZPCategory

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        [self setValuesForKeysWithDictionary:dictionary];
    }
    
    return self;
}

+ (instancetype)categoryWithDict:(NSDictionary *)dictionary
{
    return [[self alloc] initWithDictionary:dictionary];
}

@end
