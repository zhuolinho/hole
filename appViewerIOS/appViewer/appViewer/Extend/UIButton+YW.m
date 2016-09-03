//
//  UIButton+YW.m
//  YWShop
//
//  Created by xingyong on 14-5-16.
//  Copyright (c) 2014年 YiYaoWang. All rights reserved.
//

#import "UIButton+YW.h"

@implementation UIButton (YW)
+ (id) buttonWithFrame:(CGRect)frame{
	return [UIButton buttonWithFrame:frame title:nil];
}
+ (id) buttonWithFrame:(CGRect)frame title:(NSString*)title{
	return [UIButton buttonWithFrame:frame title:title backgroundImage:nil];
}
+ (id) buttonWithFrame:(CGRect)frame title:(NSString*)title backgroundImage:(UIImage*)backgroundImage{
	return [UIButton buttonWithFrame:frame title:title backgroundImage:backgroundImage highlightedBackgroundImage:nil];
}
+ (id) buttonWithFrame:(CGRect)frame title:(NSString*)title backgroundImage:(UIImage*)backgroundImage highlightedBackgroundImage:(UIImage*)highlightedBackgroundImage{
	UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
	btn.frame = frame;
	[btn setTitle:title forState:UIControlStateNormal];
//    [btn setShowsTouchWhenHighlighted:YES];
    [btn setExclusiveTouch:YES];
	[btn setBackgroundImage:backgroundImage forState:UIControlStateNormal];
	[btn setBackgroundImage:highlightedBackgroundImage forState:UIControlStateHighlighted];
	return btn;
}

+ (id)buttonWithFrame:(CGRect)frame title:(NSString *)title backgroundImage:(UIImage *)backgroundImage highlightedBackgroundImage:(UIImage *)highlightedBackgroundImage imageName:(NSString *)imageName {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    //    [btn setShowsTouchWhenHighlighted:YES];
    [btn setExclusiveTouch:YES];
    [btn setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    [btn setBackgroundImage:highlightedBackgroundImage forState:UIControlStateHighlighted];
    UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake((frame.size.width - 76)/2, 5, 76, 65)];
    image.image  = [UIImage imageNamed:imageName];
    [btn addSubview:image];
    
    UILabel * label = [UILabel labelWithRect:CGRectMake(0, CGRectGetMaxY(image.frame), frame.size.width, 20) text:title textColor:[UIColor whiteColor] font:SYSTEMFONT(16) textAlignment:NSTextAlignmentCenter];
    [btn addSubview:label];
        return btn;

}



+ (id) buttonWithFrame:(CGRect)frame image:(UIImage*)image{
	return [UIButton buttonWithFrame:frame image:image highlightedImage:nil];
}
+ (id) buttonWithFrame:(CGRect)frame image:(UIImage*)image highlightedImage:(UIImage*)highlightedImage{
	UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
	btn.frame = frame;
	[btn setImage:image forState:UIControlStateNormal];
	[btn setImage:image forState:UIControlStateHighlighted];
    [btn setExclusiveTouch:YES];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)];
    
	return btn;
}

+ (id)buttonRoundWithFrame:(CGRect)frame title:(NSString *)title backgroundImage:(UIImage *)backgroundImage highlightedBackgroundImage:(UIImage *)highlightedBackgroundImage imageName:(NSString *)imageName {
    UIButton * btn = [[UIButton alloc]initWithFrame:frame];
    [btn setExclusiveTouch:YES];
    [btn setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    [btn setBackgroundImage:highlightedBackgroundImage forState:UIControlStateHighlighted];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    btn.titleLabel.font = SYSTEMFONT(22);
    [btn setTitle:title forState:UIControlStateNormal];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = (frame.size.width)/2;
    btn.layer.borderWidth = 2;
    btn.layer.borderColor = ThemeOrangeColor.CGColor;
    btn.backgroundColor = RGBA(255, 255, 255, 120);

    return btn;
}




@end
