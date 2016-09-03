//
//  HUDPromptToast.h
//  SmartHome
//
//  Created by zhaishixi on 14-10-15.
//  Copyright (c) 2014年 GBCOM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"
/**
 *  用户提示框
 */
@interface HUDPromptToast : NSObject
+ (MBProgressHUD *)showSimple:(UIView<MBProgressHUDDelegate> *)context block:(SEL)method;
+ (MBProgressHUD *)showWithLabel:(UIView *)context;
+ (MBProgressHUD *)showWithDetailsLabel:(UIView<MBProgressHUDDelegate> *)context block:(SEL)method;
+(MBProgressHUD *)showWithDetailsLabel:(UIView *)context;
+ (MBProgressHUD *)showWithLabelDeterminate:(UIView<MBProgressHUDDelegate> *)context block:(SEL)method;
+ (MBProgressHUD *)showWIthLabelAnnularDeterminate:(UIView<MBProgressHUDDelegate> *)context block:(SEL)method;
+ (MBProgressHUD *)showWithLabelDeterminateHorizontalBar:(UIView<MBProgressHUDDelegate>*)context block:(SEL)method;
+ (MBProgressHUD *)showWithCustomView:(UIView<MBProgressHUDDelegate> *)context Text:text;
+ (MBProgressHUD *)showWithCustomView1:(UIView<MBProgressHUDDelegate> *)context Text:text;
+ (MBProgressHUD *)showWithLabelMixed:(UIView<MBProgressHUDDelegate> *)context block:(SEL)method;
+ (MBProgressHUD *)showUsingBlocks:(UIView<MBProgressHUDDelegate> *)context block:(SEL)method;
+ (MBProgressHUD *)showOnWindow:(UIView<MBProgressHUDDelegate> *)context block:(SEL)method ;
+ (MBProgressHUD *)showURL:(UIView<MBProgressHUDDelegate> *)context url:(NSString *)method;
+ (MBProgressHUD *)showWithGradient:(UIView<MBProgressHUDDelegate> *)context block:(SEL)method;
+ (MBProgressHUD *)showTextOnly:(UIView<MBProgressHUDDelegate> *)context Text:text;
+ (MBProgressHUD *)showWithColor:(UIView<MBProgressHUDDelegate> *)context block:(SEL)method;
@end
