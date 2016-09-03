//
//  JUtils.h
//  seven_CP
//
//  Created by Jin on 15/12/25.
//  Copyright (c) 2015年 Jin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@protocol ToNextViewDelegate <NSObject>
-(void)toNextView:(UIViewController *)viewcontroller;
@end

@interface JUtils : NSObject
@property (nonatomic,assign) id<ToNextViewDelegate> toNextViewDelegate;

#pragma mark --------获取当前学校
+ (NSString *)getCurrentSchool;

+(NSString *)getFormatTime:(NSString *)str;

//获取UserId
+(NSString *)getUserId;

//推荐，滚动等跳转页的处理
- (void)ToNextView:(NSString *)str andDic:(NSDictionary *)dic and:(UIView *)imageView;

+(CGSize)downloadImageSizeWithURL:(id)imageURL;

//字符串转化成字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

+ (void)httpShowWarn:(NSString *)str;

// 转化为类似于5秒钱 2小时前 2月12日
+ (NSString *)beforeTime:(NSString *)date;
// 转化为类似于还有5秒结束 还有22小时结束 还有2天结束
+ (NSString *)leftTime:(NSString *)date;
+ (NSDate *)getDate:(NSString *)date;

+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;
+ (CGFloat)calculateHeight: (NSString *)content andFont: (UIFont *)font andWidth: (CGFloat) width;
+ (CGFloat)calculateWidth: (NSString *)content andFont: (UIFont *)font andHeight: (CGFloat) height;
+ (NSString *)toHttpImageUrl: (NSString *)url;
+ (NSString *)toHttpImageThumbUrl: (NSString *)url andSize: (NSUInteger)size;
+ (UIColor *)stringToColor:(NSString *)str;
@end
