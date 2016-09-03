//
//  UIImage+ImageWithColor.m
//  UIImage-ImageWithColor
//
//  Created by Bruno Tortato Furtado on 14/12/13.
//  Copyright (c) 2013 No Zebra Network. All rights reserved.
//

#import "UIImage+ImageWithColor.h"

@implementation UIImage (ImageWithColor)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)imageResize :(UIImage*)img andResizedTo:(CGSize)newSize
{
    CGFloat scale = [[UIScreen mainScreen]scale];
    //UIGraphicsBeginImageContext(newSize);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, scale);
    [img drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+(NSString*)saveImage:(UIImage *)image withName:(NSString *)name
{
    //grab the data from our image
    NSData *data = UIImageJPEGRepresentation(image, 0.8);
    if (data == nil)
    {
        data = UIImagePNGRepresentation(image);
    }
    //get a path to the documents Directory
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,  YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    // Add out name to the end of the path with .JPG
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@.jpg",[self timeString],[self randomAlphanumericStringWithLength:10 ]]];
    //Save the file, over write existing if exists.
    [fileManager createFileAtPath:fullPath contents:data attributes:nil];
    
    //计算压缩后的文件大小
    NSDictionary *sourceAttributes = [fileManager attributesOfItemAtPath:fullPath error:nil];
    NSNumber *sourceFileSize = [sourceAttributes objectForKey:NSFileSize];
    long long fileSize = [sourceFileSize longLongValue];
    NSLog(@"Filesize = %lld", fileSize / 1024);
    
    return fullPath;
}
+ (NSString *)randomAlphanumericStringWithLength:(NSInteger)length
{
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity:length];
    
    for (int i = 0; i < length; i++)
    {
        [randomString appendFormat:@"%C", [letters characterAtIndex:arc4random() % [letters length]]];
    }
    
    return randomString;
}
+ (NSString *) timeString {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat: @"yyyyMMddHHmm"];
    return [formatter stringFromDate:[NSDate date]];
}


@end