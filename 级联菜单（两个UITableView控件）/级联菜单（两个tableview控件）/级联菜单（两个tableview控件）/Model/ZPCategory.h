//
//  ZPCategory.h
//  级联菜单
//
//  Created by apple on 2016/12/12.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZPCategory : NSObject

@property (nonatomic, copy) NSString *highlighted_icon;  //高亮图标
@property (nonatomic, copy) NSString *icon;  //普通图标
@property (nonatomic, copy) NSString *name;  //类别名称
@property (nonatomic, strong) NSArray *subcategories;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
+ (instancetype)categoryWithDict:(NSDictionary *)dictionary;

@end
