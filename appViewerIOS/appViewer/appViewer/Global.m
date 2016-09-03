//
//  Global.m
//  Tutor
//
//  Created by syzhou on 13-11-6.
//  Copyright (c) 2013年 syzhou. All rights reserved.
//

#import "Global.h"
#import "GTMBase64.h"
#import "AppDelegate.h"
//#import "Reachability.h"

#define kAppVersionKey @"appVersionKey"
//#define     LocalStr_None           @""
//static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

@implementation Global

CGSize getSizeForLabel(UILabel* label, CGSize size)
{
    return getSizeForNSString(label.text, label.font, label.lineBreakMode, size);
}

BOOL checkResult(id result) {
    BOOL flag = NO;
    if ([result isKindOfClass:[NSDictionary class]]) {
        if (![[result objectForKey:@"status"] intValue]) {
            flag = YES;
        }
    }
    
    return flag;
}

CGSize getSizeForNSString(NSString *string, UIFont *font, NSLineBreakMode mode, CGSize size)
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        CGRect expectedFrame = [string boundingRectWithSize:size
                                                        options:NSStringDrawingUsesLineFragmentOrigin
                                                     attributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                 font, NSFontAttributeName,
                                                                 nil]
                                                        context:nil];
        expectedFrame.size.width = ceil(expectedFrame.size.width);
        expectedFrame.size.height = ceil(expectedFrame.size.height);
        return expectedFrame.size;
    } else {
        return [string sizeWithFont:font
                      constrainedToSize:size
                          lineBreakMode:mode];
    }
}

NSString * handleNullString(NSString * str)
{
    NSString *result = nil;
    if ([str isKindOfClass:[NSNull class]]) {
        result = @"";
    } else {
        if ([str isKindOfClass:[NSString class]]) {
            if ([str isEqualToString:@"(null)"]) {
                return @"";
            } else if (![str length]) {
                return @"";
            }
        } else if (str == nil) {
            return @"";
        } else if ([str isKindOfClass:[NSNumber class]]) {
            str = [NSString stringWithFormat:@"%@",str];
        }
        result = str;
    }
    return result;
}

BOOL isNullOrNot(NSString *string)
{
    BOOL ret = NO;
    if (!string)
    {
        ret = YES;
    }
    else if ([string isKindOfClass:[NSNull class]])
    {
        ret = YES;
    }

    return ret;
}

AppDelegate *getAppDelegate(void)
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}


NSString * stringFromDate(NSDate *date,NSString *format) {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:date];
}


// return yes show startView,otherwise not show
BOOL compareVersionNumber()
{
    NSString *nativeVersionNumber = [[NSUserDefaults standardUserDefaults] objectForKey:kAppVersionKey];
    if (nativeVersionNumber)
    {
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        NSInteger nativeVersion = [[nativeVersionNumber stringByReplacingOccurrencesOfString:@"." withString:@""] integerValue];
        NSInteger appVersion = [[app_Version stringByReplacingOccurrencesOfString:@"." withString:@""] integerValue];
        return (appVersion > nativeVersion) ? YES : NO;
    }
    
    return YES;
}

void setNewAppVersion(void)
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    [[NSUserDefaults standardUserDefaults] setObject:app_Version forKey:kAppVersionKey];
}

NSDate * dateFromString(NSString *date,NSString *format) {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    
    return [formatter dateFromString:date];
}

void showAlertViewWithMessage(NSString *message, NSString *confirm,NSString *cancel) {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:cancel otherButtonTitles:confirm, nil];
    [alert show];
}

#define DEFAULT_VOID_COLOR [UIColor whiteColor]

UIColor * colorWithHexString(NSString *stringToConvert)
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString length] < 6)
        return DEFAULT_VOID_COLOR;
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return DEFAULT_VOID_COLOR;
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

//NSString *MD5(NSString *handleString)
//{
//    const char *cStr = [handleString UTF8String];
//    unsigned char result[16];
//    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
//    return [NSString stringWithFormat:
//            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
//            result[0], result[1], result[2], result[3],
//            result[4], result[5], result[6], result[7],
//            result[8], result[9], result[10], result[11],
//            result[12], result[13], result[14], result[15]
//            ];
//}
//
//NSString *MD5Base64String(NSString *string)
//{
//    unsigned char result[CC_MD5_DIGEST_LENGTH];
//    
//    CC_MD5([[string dataUsingEncoding:NSUTF8StringEncoding] bytes], (int)[string length], result);
//    
//    NSData *data = [NSData dataWithBytes:result length:CC_MD5_DIGEST_LENGTH];
//    
//    data = [GTMBase64 encodeData:data];
//    
//    NSString * base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    
//    return base64String;
//}

void addShadow(UIView *view)
{
    [[view layer] setShadowOffset:CGSizeMake(0, 4)];
    [[view layer] setShadowRadius:5];
    [[view layer] setShadowOpacity:1];
    [[view layer] setShadowColor:[UIColor blackColor].CGColor];
}

BOOL isNotNULL(id object)
{
    if ([object isKindOfClass:[NSNull class]])
    {
        return NO;
    }
    else if ([object isKindOfClass:[NSString class]])
    {
        if ([object isEqualToString:@"(null)"])
        {
            return NO;
        }
    }
    else if (!object)
    {
        return NO;
    }

    return YES;
}

NSString *ascii2String(NSString *hexString)
{
    char *myBuffer = (char *)malloc((int)[hexString length] / 2 + 1);
    bzero(myBuffer, [hexString length] / 2 + 1);
    for (int i = 0; i < [hexString length] - 1; i += 2) {
        unsigned int anInt;
        NSString * hexCharStr = [hexString substringWithRange:NSMakeRange(i, 2)];
        NSScanner * scanner = [[NSScanner alloc] initWithString:hexCharStr];
        [scanner scanHexInt:&anInt];
        myBuffer[i / 2] = (char)anInt;
    }
    NSString *unicodeString = [NSString stringWithCString:myBuffer encoding:4];
    free(myBuffer);
    return unicodeString;
}

NSString *getCurrentDate(void)
{
    NSDate *senddate = [NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    
    return [dateformatter stringFromDate:senddate];
}

/*手机号码验证 MODIFIED BY HELENSONG*/
BOOL isValidateMobile(NSString *mobile)
{
    //手机号以13, 15,18开头,八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

// 判断银行卡
BOOL isValidateBankCard(NSString *bankCard)
{
    NSString *cardRegex = @"/^\\d{16,19}$|^\\d{6}\\d{10,13}$|^\\d{4}\\d{4}\\d{4}\\d{4,7}$/";
    NSPredicate *bankTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",cardRegex];
    return [bankTest evaluateWithObject:bankCard];
}

//判断姓名
BOOL isValidateNickname(NSString *nickName)
{
    NSString *nameRegex = @"^[\u4e00-\u9fa5]{2,8}$";
    NSPredicate *nameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nameRegex];
    return [nameTest evaluateWithObject:nickName];
}

BOOL isValidateAmount(NSString *strAmount)
{
    NSString *amountRegex = @"^(([1-9]\\d{0,4})(\\.\\d{1,2})?)$|(0\\.0?([1-9]\\d?))$";
    NSPredicate *amountTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",amountRegex];
    return [amountTest evaluateWithObject:strAmount];
}

//判断是不是数字
BOOL isPureIntString(NSString*string)
{
    NSString *numRegex = @"^\\d+$";
    NSPredicate *amountTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",numRegex];
    
    return [amountTest evaluateWithObject:string];
}

BOOL isCharacterString(NSString *string)
{
    NSString *chracterRegex = @"^[A-Za-z]+$";
    NSPredicate *characterTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",chracterRegex];
    
    return [characterTest evaluateWithObject:string];
}

BOOL isStringOfString(NSString *string)
{
    NSString *stringRegex = @"[^0-9a-zA-Z]*";
    NSPredicate *characterTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",stringRegex];
    
    return [characterTest evaluateWithObject:string];
}

NSString *reverseString(NSString *StringPtr)
{
    int length = [StringPtr length];
     NSMutableString *reversedString;

    reversedString = [[NSMutableString alloc] initWithCapacity: length];
     while (length > 0)
     {
           [reversedString appendString:[NSString stringWithFormat:@"%C", [StringPtr characterAtIndex:--length]]];
      }
  
     return reversedString;
}

NSString *handleCardNumber(NSString *cardNo)
{
    if (!cardNo)
        return  @"";
    
    NSString *strHeader = [cardNo substringWithRange:NSMakeRange(0, 6)];
    NSString *strTail = [cardNo substringWithRange:NSMakeRange(cardNo.length - 4, 4)];
    
    NSString *strStar = @"";
    for (int i = 0; i < 4; i++)
    {
        strStar = [strStar stringByAppendingString:@"*"];
    }
    return [NSString stringWithFormat:@"%@%@%@", strHeader , strStar, strTail];
}

NSString *hexStringFromString(NSString *string)
{
    NSData *myD = [string dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr = @"";
    for (int  i = 0; i < [myD length]; i++)
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x", bytes[i] & 0xff]; ///16进制数
        if ([newHexStr length] == 1)
            hexStr = [NSString stringWithFormat:@"%@0%@", hexStr, newHexStr];
        else
            hexStr = [NSString stringWithFormat:@"%@%@", hexStr, newHexStr];
    }
    return  hexStr;
}

//BOOL currentNetWorkStates(void)
//{
//    BOOL netWorkNormal = YES;
//    Reachability *reachablity = [Reachability reachabilityWithHostname:@"www.apple.com"];
//    switch ([reachablity currentReachabilityStatus]) {
//        case NotReachable:
//            netWorkNormal = NO;
//            break;
//            
//        case ReachableViaWiFi: //wifi
//            break;
//            
//        case ReachableViaWWAN: //3G
//            break;
//            
//        default:
//            break;
//    }
//    return netWorkNormal;
//}

//UIImage* imageWithImagescaledToSize(UIImage*image, CGSize newSize)
//{
//    // Create a graphics image context
//    UIGraphicsBeginImageContext(newSize);
//    
//    // Tell the old image to draw in this new context, with the desired
//    // new size
//    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
//    
//    // Get the new image from the context
//    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
//    
//    // End the context
//    UIGraphicsEndImageContext();
//    
//    // Return the new image.
//    return [newImage imageWithScale:0.0001];
//}

@end
