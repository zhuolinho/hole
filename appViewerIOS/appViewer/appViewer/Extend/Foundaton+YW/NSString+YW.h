//
//  NSString+YW.h
//  TheStoreApp
//
//  Created by xingyong on 14-5-13.
//  Copyright (c) 2014年 YiYaoWang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (YW)
//获取当前的时间，转成字符串 格式默认为 yyyy-MM-dd
+ (NSString *)stringWithNowDate;
+ (NSString *)stringWithDate:(NSDate *)date formater:(NSString *)formater;

 
//转换文件大小成字符串,
//fileSize 单位：B   结果格式为 *.*G *.*M  ...
+ (NSString *)stringWithSize:(float)fileSize;

- (BOOL) isEmail ;

/** 手机号码验证 */
- (BOOL)isPhoneNum;

- (NSString *) stringFromMD5;

+ (NSString *)getBundlePathForFile:(NSString *)fileName;
+ (NSString *)getDocumentsDirectoryForFile:(NSString *)fileName;
+ (NSString *)getLibraryDirectoryForFile:(NSString *)fileName;
+ (NSString *)getCacheDirectoryForFile:(NSString *)fileName;


- (BOOL)containsString:(NSString *)string;
- (BOOL)containsString:(NSString *)string
               options:(NSStringCompareOptions) options;
/**
 *  URLEncode编码
 *
 *  @return URLEncode编码
 */
- (NSString*) URLEncode;
/**
 *  URLEncode解码
 *
 *  @return URLEncode解码
 */
- (NSString *)URLEncodedString;

- (NSString *)trimming;
 
@end
