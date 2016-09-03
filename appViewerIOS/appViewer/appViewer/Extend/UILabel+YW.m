//
//  UILabel+YW.m
//  YWShop
//
//  Created by xingyong on 14-5-16.
//  Copyright (c) 2014年 YiYaoWang. All rights reserved.
//

#import "UILabel+YW.h"

@implementation UILabel (YW)

+ (UILabel *)labelWithTitle:(NSString *)text withFrame:(CGRect)frame
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    [label setNumberOfLines:0];

    [label setValue:text forKey:@"text"];
    [label setTextColor:[UIColor darkGrayColor]];
    [label setTextAlignment:NSTextAlignmentLeft];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setFont:[UIFont systemFontOfSize:14.0f]];
 
    return label;
}


+(UILabel *)labelWithRect:(CGRect)rect text:(NSString *)text textColor:(UIColor *)color font:(UIFont *)font{
    UILabel *label = [[UILabel alloc]initWithFrame:rect];
    label.numberOfLines = 0;
    label.text = text;
    label.textColor = color;
    label.backgroundColor = [UIColor clearColor];
    label.font = font;
    return label;
}

+(UILabel *)labelWithRect:(CGRect)rect text:(NSString *)text textColor:(UIColor *)color font:(UIFont *)font textAlignment:(NSTextAlignment)alignment{
    UILabel *label = [[UILabel alloc]initWithFrame:rect];
    label.numberOfLines = 0;
    label.text = text;
    label.textColor = color;
    label.textAlignment = alignment;
    label.backgroundColor = [UIColor clearColor];
    label.font = font;
    return label;


}

+(UILabel *)labelLinewithFrame:(CGRect)frame backgroundColor:(UIColor *)color{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.backgroundColor = color;
    return label;
}

@end
