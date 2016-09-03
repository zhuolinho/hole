//
//  head.h
//  appViewer
//
//  Created by JuZhen on 16/6/4.
//  Copyright © 2016年 JuZhen. All rights reserved.
//

#ifndef head_h
#define head_h
#import "UIImageView+AFNetworking.h"
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define KSIDEBARWidth  180

#define RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)/255.0f]

#define RGB(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define KDEFAULT_COLOR [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.00]
#define SYSTEMFONT(x) [UIFont systemFontOfSize:x]
#define JNSLOG(x,y)      NSLog(@"%@-----%@",x,y)
#define ThemeGreenColor  RGB(33, 197, 147)
#define ThemeOrangeColor RGB(253, 112, 4)
#define GreyLineColor RGBA(190,198,204,20)
#define MoreGreyLineColor RGBA(190,198,204,100)
#define ReloadBGColor RGBA(190,198,204,200)

#define IsIOS7 ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue]>=7)

#define __WEAKSELF typeof(self) __weak wself = self;

#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size)||CGSizeEqualToSize(CGSizeMake(320, 480), [[UIScreen mainScreen] currentMode].size)) : NO)

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size)||CGSizeEqualToSize(CGSizeMake(320, 568), [[UIScreen mainScreen] currentMode].size)) : NO)

#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size)||CGSizeEqualToSize(CGSizeMake(375, 667), [[UIScreen mainScreen] currentMode].size)) : NO)

#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(828, 1472), [[UIScreen mainScreen] currentMode].size)||CGSizeEqualToSize(CGSizeMake(414, 736), [[UIScreen mainScreen] currentMode].size)) : NO)
#define SchoolNameReally @"SchoolNameReally"
#define SchoolNamePretend @"SCHOOLNAME"
#define DefaultAddress @"defaultAddress"
#define CartContent  @"cartContent"
#define Iscart  @"iscart"
#define PageNum @"currentPage"

#define FrameLog(frame) NSLog(@"%d %d %d %d", (int)frame.origin.x, (int)frame.origin.y, (int)frame.size.width, (int)frame.size.height)
#define SizeLog(size) NSLog(@"%d %d", (int)size.width, (int)size.height)

#define SystemInformation @"SystemInformation"
#define AllComment @"AllComment"
#define LoginUser  @"loginUser"
#define RegistLoginUser @"registLoginUser"
#define TOKEN  @"TOKEN"
#define provinceTag  101
#define cityTag  102
#define areaTag 103
#define schoolTag 104
#define btn1Tag  200
#define btn2Tag  300
#define btn3Tag  400

#define alertTagadd  500
#define alertTagNotOnline  501
#define alertTagSuccess  502

#define mainBtnTag 500

#define UsernameColor @"#8c8888"
#define AddDateColor @"#c1b3b3"
#define PostGreyBGColor @"#f6f6f6"
#define TOKEN  @"TOKEN"
#define AppViewUrl @"http://139.196.56.202:8080/appviewer/api/"
#endif /* head_h */
