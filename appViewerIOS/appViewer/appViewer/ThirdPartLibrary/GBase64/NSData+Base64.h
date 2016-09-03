//
//  NSData+Base64.h
//  YYW
//
//  Created by Roy on 14/11/12.
//  Copyright (c) 2014年 YYW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Base64)

+ (NSData *)dataWithBase64EncodedString:(NSString *)string;
- (NSString *)base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;
- (NSString *)base64EncodedString;
@end
