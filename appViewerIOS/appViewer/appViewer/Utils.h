//
//  Utils.h
//  RemindIt
//
//  Created by Li, Xiaotong on 4/25/15.
//  Copyright (c) 2015 Cloud Reminding. All rights reserved.
//

#import <Foundation/Foundation.h>

// 将来其他文件都可以import 这个类来 方便调用基类
// Utils 类 分为4个部分：
//  1. 常量：全局变量／nsuserdefaults 的key 宏定义
//  2. 工具：UILabel UIButton UIView 的功能性拓展
//  3. 第三方库：
//  4. 应用的整体风格：提供各种 font 与 各种 uibutton 使应用内部风格一致
@interface Utils : NSObject

@end

//  1. 常量：全局变量/ ENUM / nsuserdefaults 的key 宏定义
#import "head.h"

//  2. 工具：方便编程 UILabel UIButton UIView 的功能性拓展
#import "UIView+Extension.h"

//  3. 第三方库： 已经放在 Supporting Files / PrefixHeader.pch

//  4. 应用的整体风格：提供各种 font 与 各种 uibutton 使应用内部风格一致
#import "UILabel+YW.h" 
#import "UIButton+YW.h"
#import "UIImage+ImageWithColor.h"

