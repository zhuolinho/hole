//
//  JUtils.m
//  seven_CP
//
//  Created by Jin on 15/12/25.
//  Copyright (c) 2015年 Jin. All rights reserved.
//

#import "JUtils.h"
#import "head.h"
//#import "UIImage+ImageWithColor.h"

@implementation JUtils
@synthesize toNextViewDelegate;



+ (NSString *)getFormatTime:(NSString *)str {
    NSString *l_str = [str substringWithRange:NSMakeRange(0, 10)];
    return l_str;
}

+ (NSString *)getUserId {
//    NSMutableDictionary *userdic = [[NSUserDefaults standardUserDefaults] objectForKey:LoginUser];
    NSString *str = @"";
    return str;
}

+ (void)showError:(NSString *)responseError {
    NSData *jsonData = [responseError dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:nil];
    NSString *str = dic[@"message"];
    if (str) {
        str = @"网络连接失败";
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:str delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

+ (NSDictionary *)dictionaryWithJsonString:(id)string {
    if ([string isKindOfClass:[NSDictionary class]]) {
        return string;
    }
    NSString *jsonString = string;
    if (jsonString == nil) {
        return nil;
    }

    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if (err) {
        NSLog(@"json解析失败：%@", err);
        return nil;
    }
    return dic;
}


//+ (void)httpShowWarn:(NSString *)str {
//    if (str) {
//        JNSLOG(str, @"-----");
//        NSDictionary *dic = [JUtils dictionaryWithJsonString:str];
//        NSString *message = dic[@"message"];
//        if (message == nil)
//            message = @"网络请求错误";
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
//    }
//}

+ (NSString *)beforeTime:(NSString *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    NSDate *d = [formatter dateFromString:date];
    [formatter setDateFormat:@"yyy-MM-dd HH:mm:ss"];
    int interval = - (int) d.timeIntervalSinceNow;
    if (interval < 0)
        interval = 0;
    if (interval < 60)
        return [NSString stringWithFormat:@"%d秒前", interval];
    interval /= 60;
    if (interval < 60)
        return [NSString stringWithFormat:@"%d分钟前", interval];
    interval /= 60;
    if (interval < 24)
        return [NSString stringWithFormat:@"%d小时前", interval];

    [formatter setDateFormat:@"MM-dd"];
    return [formatter stringFromDate: d];
}

+ (NSString *)leftTime:(NSString *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    NSDate *d = [formatter dateFromString:date];
    [formatter setDateFormat:@"yyy-MM-dd HH:mm:ss"];
    int interval = (int) d.timeIntervalSinceNow;
    if (interval < 0)
        interval = -interval;
    if (interval < 60)
        return [NSString stringWithFormat:@"还有%d秒结束", interval];
    interval /= 60;
    if (interval < 60)
        return [NSString stringWithFormat:@"还有%d分钟结束", interval];
    interval /= 60;
    if (interval < 24)
        return [NSString stringWithFormat:@"还有%d小时结束", interval];
    return [NSString stringWithFormat:@"还有%d天结束", interval/24];
}

+ (NSDate *)getDate:(NSString *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    return [formatter dateFromString:date];
}

+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}


+ (CGFloat)calculateHeight:(NSString *)content andFont:(UIFont *)font andWidth:(CGFloat)width {
    return [content sizeWithFont:font constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)
        lineBreakMode: NSLineBreakByWordWrapping].height;
}

+ (CGFloat)calculateWidth:(NSString *)content andFont:(UIFont *)font andHeight:(CGFloat)height {
    return [content sizeWithFont:font constrainedToSize:CGSizeMake(CGFLOAT_MAX, height)
        lineBreakMode: NSLineBreakByCharWrapping].width;
}

+ (NSString *)toHttpImageUrl:(NSString *)url {
    if ([url rangeOfString:@"http"].location != NSNotFound)
        return url;
    return [NSString stringWithFormat:@"%@%@", AppViewUrl, url];
}

+ (NSString *)toHttpImageThumbUrl:(NSString *)url andSize: (NSUInteger)size{
    NSString *string = url;
    if ([string rangeOfString:@"http"].location == NSNotFound)
        string = [NSString stringWithFormat:@"%@%@", AppViewUrl, string];
    if ([string rangeOfString:AppViewUrl].location == NSNotFound)
        return string;
    return [NSString stringWithFormat:@"%@?imageView2/0/w/%d", string, size];
}


+ (CGSize)downloadImageSizeWithURL:(id)imageURL {
    NSURL *URL = nil;
    if ([imageURL isKindOfClass:[NSURL class]]) {
        URL = imageURL;
    }
    if ([imageURL isKindOfClass:[NSString class]]) {
        URL = [NSURL URLWithString:imageURL];
    }
    if (URL == nil)
        return CGSizeZero;

    NSString *absoluteString = URL.absoluteString;

#ifdef dispatch_main_sync_safe
    if([[SDImageCache sharedImageCache] diskImageExistsWithKey:absoluteString])
    {
        UIImage* image = [[SDImageCache sharedImageCache] imageFromMemoryCacheForKey:absoluteString];
        if(!image)
        {
            NSData* data = [[SDImageCache sharedImageCache] performSelector:@selector(diskImageDataBySearchingAllPathsForKey:) withObject:URL.absoluteString];
            image = [UIImage imageWithData:data];
        }
        if(image)
        {
            return image.size;
        }
    }
#endif

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:URL];
    NSString *pathExtendsion = [URL.pathExtension lowercaseString];

    CGSize size = CGSizeZero;
    if ([pathExtendsion isEqualToString:@"png"]) {
        size = [self downloadPNGImageSizeWithRequest:request];
    }
    else if ([pathExtendsion isEqual:@"gif"]) {
        size = [self downloadGIFImageSizeWithRequest:request];
    }
    else {
        size = [self downloadJPGImageSizeWithRequest:request];
    }
    if (CGSizeEqualToSize(CGSizeZero, size)) {
        NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:URL] returningResponse:nil error:nil];
        UIImage *image = [UIImage imageWithData:data];
        if (image) {
#ifdef dispatch_main_sync_safe
            [[SDImageCache sharedImageCache] storeImage:image recalculateFromImage:YES imageData:data forKey:URL.absoluteString toDisk:YES];
#endif
            size = image.size;
        }
    }
    return size;
}

+ (CGSize)downloadPNGImageSizeWithRequest:(NSMutableURLRequest *)request {
    [request setValue:@"bytes=16-23" forHTTPHeaderField:@"Range"];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if (data.length == 8) {
        int w1 = 0, w2 = 0, w3 = 0, w4 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        [data getBytes:&w3 range:NSMakeRange(2, 1)];
        [data getBytes:&w4 range:NSMakeRange(3, 1)];
        int w = (w1 << 24) + (w2 << 16) + (w3 << 8) + w4;
        int h1 = 0, h2 = 0, h3 = 0, h4 = 0;
        [data getBytes:&h1 range:NSMakeRange(4, 1)];
        [data getBytes:&h2 range:NSMakeRange(5, 1)];
        [data getBytes:&h3 range:NSMakeRange(6, 1)];
        [data getBytes:&h4 range:NSMakeRange(7, 1)];
        int h = (h1 << 24) + (h2 << 16) + (h3 << 8) + h4;
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}

+ (CGSize)downloadGIFImageSizeWithRequest:(NSMutableURLRequest *)request {
    [request setValue:@"bytes=6-9" forHTTPHeaderField:@"Range"];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if (data.length == 4) {
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        short w = w1 + (w2 << 8);
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(2, 1)];
        [data getBytes:&h2 range:NSMakeRange(3, 1)];
        short h = h1 + (h2 << 8);
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}

+ (CGSize)downloadJPGImageSizeWithRequest:(NSMutableURLRequest *)request {
    [request setValue:@"bytes=0-209" forHTTPHeaderField:@"Range"];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];

    if ([data length] <= 0x58) {
        return CGSizeZero;
    }

    if ([data length] < 210) {// 肯定只有一个DQT字段
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
        [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
        short w = (w1 << 8) + w2;
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
        [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
        short h = (h1 << 8) + h2;
        return CGSizeMake(w, h);
    } else {
        short word = 0x0;
        [data getBytes:&word range:NSMakeRange(0x15, 0x1)];
        if (word == 0xdb) {
            [data getBytes:&word range:NSMakeRange(0x5a, 0x1)];
            if (word == 0xdb) {// 两个DQT字段
                short w1 = 0, w2 = 0;
                [data getBytes:&w1 range:NSMakeRange(0xa5, 0x1)];
                [data getBytes:&w2 range:NSMakeRange(0xa6, 0x1)];
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                [data getBytes:&h1 range:NSMakeRange(0xa3, 0x1)];
                [data getBytes:&h2 range:NSMakeRange(0xa4, 0x1)];
                short h = (h1 << 8) + h2;
                return CGSizeMake(w, h);
            } else {// 一个DQT字段
                short w1 = 0, w2 = 0;
                [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
                [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
                [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
                short h = (h1 << 8) + h2;
                return CGSizeMake(w, h);
            }
        } else {
            return CGSizeZero;
        }
    }
}

+ (UIColor *)stringToColor:(NSString *)str  {
    if (!str || [str isEqualToString:@""]) {
        return nil;
    }
    unsigned red,green,blue;
    NSRange range;
    range.length = 2;
    range.location = 1;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&red];
    range.location = 3;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&green];
    range.location = 5;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&blue];
    UIColor *color= [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1];
    return color;
}

@end
