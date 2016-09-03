//
//  Global.h
//  Tutor
//
//  Created by liuwei on 13-11-6.
//  Copyright (c) 2013年 liuwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface Global : NSObject

CGSize getSizeForLabel(UILabel* label, CGSize size);

CGSize getSizeForNSString(NSString *string, UIFont *font, NSLineBreakMode mode, CGSize size);

BOOL checkResult(id result);

NSString * handleNullString(NSString * str);

BOOL isNullOrNot(NSString *string);

AppDelegate *getAppDelegate();

NSString * stringFromDate(NSDate *date,NSString *format);

NSDate * dateFromString(NSString *date,NSString *format);

void showAlertViewWithMessage(NSString *message, NSString *confirm,NSString *cancel);

UIColor * colorWithHexString(NSString *stringToConvert);

//MD5加密
NSString *MD5(NSString *handleString);

//先 MD5加密 然后,BASE64加密
NSString *MD5Base64String(NSString *string);

//添加阴影
void addShadow(UIView *view);

//系统的时间
NSDictionary *getSystemDate(NSDate *date);

//空值判断
BOOL isNotNULL(id object);

NSString *ascii2String(NSString *strAscii);

NSString *hexStringFromString(NSString *string);

//获取系统当前的时间 格式YYYY-MM-DD HH:mm:ss
NSString *getCurrentDate(void);

// 比较本地版本跟app版本
BOOL compareVersionNumber();

//设置最新的版本号
void setNewAppVersion(void);

//判断是不是数字
BOOL isPureIntString(NSString*string);

// 字符串是否纯英文
BOOL isCharacterString(NSString *string);

// 字符串纯字符
BOOL isStringOfString(NSString *string);

//判断一个号码是否为手机号码
BOOL isValidateMobile(NSString *mobile);

//判断是否为一个合法的银行卡号
BOOL isValidateBankCard(NSString *bankNo);

//判断一个名字
BOOL isValidateNickname(NSString *nickName);

// 判断当前是否为一个金额
BOOL isValidateAmount(NSString *strAmount);

//反转字符串
NSString *reverseString(NSString *StringPtr);

// 处理卡号,前六后四
NSString *handleCardNumber(NSString *cardNo);

// 普通字符串转16进制字符串
NSString *hexStringFromString(NSString *string);

//检测当前网络状态
BOOL currentNetWorkStates(void);

UIImage* imageWithImagescaledToSize(UIImage*image, CGSize newSize);

BOOL isIphone4(void);
@end
