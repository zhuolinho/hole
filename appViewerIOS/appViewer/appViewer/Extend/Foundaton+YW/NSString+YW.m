//
//  NSString+YW.m
//  TheStoreApp
//
//  Created by xingyong on 14-5-13.
//  Copyright (c) 2014年 YiYaoWang. All rights reserved.
//

#import "NSString+YW.h"
#import <CommonCrypto/CommonDigest.h>
@implementation NSString (YW)
+ (NSString *)stringWithNowDate
{
    NSDate *nowDate = [NSDate date];
    NSString *formatter = @"yyyy-MM-dd";
    
    return [NSString stringWithDate:nowDate formater:formatter];
    
}

+ (NSString *)stringWithDate:(NSDate *)date formater:(NSString *)formater
{
    if (!date) {
        return  nil;
    }
    if (!formater) {
        formater = @"yyyy-MM-dd";
    }
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:formater];
    return [formatter stringFromDate:date];
}

+ (NSString *)stringWithSize:(float)fileSize
{
    NSString *sizeStr;
    if(fileSize/1024.0/1024.0/1024.0 > 1)
    {
        sizeStr = [NSString stringWithFormat:@"%0.1fGB",fileSize/1024.0/1024.0/1024.0];
    }
    else if(fileSize/1024.0/1024.0 > 1 && fileSize/1024.0/1024.0 < 1024 )
    {
        sizeStr = [NSString stringWithFormat:@"%0.1fMB",fileSize/1024.0/1024.0];
    }
    else
    {
        sizeStr = [NSString stringWithFormat:@"%0.1fKB",fileSize/1024.0];
    }
    
    
    return sizeStr;
    
}

- (NSString *) stringFromMD5{
    
    if(self == nil || [self length] == 0)
        return nil;
    
    const char *value = [self UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    
    return outputString;
}

- (BOOL) isEmail{
	
    NSString *emailRegEx =
	@"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
	@"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
	@"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
	@"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
	@"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
	@"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
	@"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
	
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    return [regExPredicate evaluateWithObject:[self lowercaseString]];
}
/* 手机号码验证 MODIFIED BY HELENSONG */
- (BOOL)isPhoneNum
{
    //手机号以13， 15，18开头，八个 \d 数字字符
     NSString *phoneRegex=@"^1[0-9]{10}";
   // NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
}

+ (NSString *)getBundlePathForFile:(NSString *)fileName
{
    NSString *fileExtension = [fileName pathExtension];
    NSString *path = [[NSBundle mainBundle] pathForResource:[fileName stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@".%@",fileExtension] withString:@""] ofType:fileExtension];
    return path;
}

+ (NSString *)getDocumentsDirectoryForFile:(NSString *)fileName
{
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/",fileName]];
    return path;
}

+ (NSString *)getLibraryDirectoryForFile:(NSString *)fileName
{
    NSString *libraryDirectory = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *destinationPath = [libraryDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/",fileName]];
    return destinationPath;
}

+ (NSString *)getCacheDirectoryForFile:(NSString *)fileName
{
    NSString *cacheDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *destinationPath = [cacheDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/",fileName]];
    return destinationPath;
}

- (BOOL)containsString:(NSString *)string
               options:(NSStringCompareOptions)options {
    NSRange rng = [self rangeOfString:string options:options];
    return rng.location != NSNotFound;
}

- (BOOL)containsString:(NSString *)string {
    return [self containsString:string options:0];
}
/**
 *  URLEncode编码
 *
 *  @return URLEncode编码
 */
- (NSString*) URLEncode{
	
	NSString *encodedString = (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(
                                                                                                    NULL,
                                                                                                    (__bridge CFStringRef)self,
                                                                                                    NULL,
                                                                                                    (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                                    kCFStringEncodingUTF8 );
	
	return encodedString;
	
	//return [self stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
}
/**
 *  URLEncode解码
 *
 *  @return URLEncode解码
 */
- (NSString *)URLEncodedString
{
    NSString *encodedString = (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                                    (CFStringRef)self,
                                                                                                    (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                                                                                    NULL,
                                                                                                    kCFStringEncodingUTF8);
    return encodedString;
}

- (NSString *)trimming{
    
    NSString *replaceStr = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *resultStr = [replaceStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    return  resultStr;
    
}
 
@end
