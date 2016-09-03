//
//  UILabel+YW.h
//  YWShop
//
//  Created by xingyong on 14-5-16.
//  Copyright (c) 2014年 YiYaoWang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (YW)
+ (UILabel *)labelWithTitle:(NSString *)text withFrame:(CGRect)frame;

+(UILabel *)labelWithRect:(CGRect)rect text:(NSString *)text textColor:(UIColor *)color font:(UIFont *)font;

+(UILabel *)labelWithRect:(CGRect)rect text:(NSString *)text textColor:(UIColor *)color font:(UIFont *)font textAlignment:(NSTextAlignment)alignment;

+(UILabel *)labelLinewithFrame:(CGRect)frame backgroundColor:(UIColor *)color;

@end
