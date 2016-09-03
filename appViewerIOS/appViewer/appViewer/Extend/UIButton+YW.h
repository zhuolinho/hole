//
//  UIButton+YW.h
//  YWShop
//
//  Created by xingyong on 14-5-16.
//  Copyright (c) 2014年 YiYaoWang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utils.h"

@interface UIButton (YW)

/** Creates and returns a new button of type `UIButtonCustom` with the specified frame.
 @param frame The frame for the button view.
 @return A newly create button.
 */
+ (id) buttonWithFrame:(CGRect)frame;

/** Creates and returns a new button of type `UIButtonCustom` with the specified frame and title.
 @param frame The frame for the button view.
 @param title The title for `UIControlStateNormal`.
 @return A newly create button.
 */
+ (id) buttonWithFrame:(CGRect)frame title:(NSString*)title;

/** Creates and returns a new button of type `UIButtonCustom` with the specified frame, title and background image.
 @param frame The frame for the button view.
 @param title The title for `UIControlStateNormal`.
 @param backgroundImage The background image for `UIControlStateNormal`.
 @return A newly create button.
 */
+ (id) buttonWithFrame:(CGRect)frame title:(NSString*)title backgroundImage:(UIImage*)backgroundImage;

/** Creates and returns a new button of type `UIButtonCustom` with the specified frame, title and background image.
 @param frame The frame for the button view.
 @param title The title for `UIControlStateNormal`.
 @param backgroundImage The background image for `UIControlStateNormal`.
 @param highlightedBackgroundImage The background image for `UIControlStateHighlighted`
 @return A newly create button.
 */
+ (id) buttonWithFrame:(CGRect)frame title:(NSString*)title backgroundImage:(UIImage*)backgroundImage highlightedBackgroundImage:(UIImage*)highlightedBackgroundImage;


/** Creates and returns a new button of type `UIButtonCustom` with the specified frame and image.
 @param frame The frame for the button view.
 @param image The image for `UIControlStateNormal`.
 @return A newly create button.
 */
+ (id) buttonWithFrame:(CGRect)frame image:(UIImage*)image;

/** Creates and returns a new button of type `UIButtonCustom` with the specified frame, title and background image.
 @param frame The frame for the button view.
 @param image The image for `UIControlStateNormal`.
 @param highlightedImage The image for `UIControlStateHighlighted`.
 @return A newly create button.
 */
+ (id) buttonWithFrame:(CGRect)frame image:(UIImage*)image highlightedImage:(UIImage*)highlightedImage;
//生活-推荐
+ (id)buttonWithFrame:(CGRect)frame title:(NSString *)title backgroundImage:(UIImage *)backgroundImage highlightedBackgroundImage:(UIImage *)highlightedBackgroundImage imageName:(NSString *)imageName;

+ (id)buttonRoundWithFrame:(CGRect)frame title:(NSString *)title backgroundImage:(UIImage *)backgroundImage highlightedBackgroundImage:(UIImage *)highlightedBackgroundImage imageName:(NSString *)imageName;
@end
