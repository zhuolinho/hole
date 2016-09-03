//
//  NSDictionary+YW.m
//  YYW
//
//  Created by xingyong on 14-7-2.
//  Copyright (c) 2014年 xingyong. All rights reserved.
//

#import "NSDictionary+YW.h"

@implementation NSDictionary (YW)
- (NSString *)safeObjectForKey:(id)key
{
    id result = [self objectForKey:key];
    
    return   result == [NSNull null] || result == nil || [result isEqualToString:@"(null)"] ? @"" : [NSString stringWithFormat:@"%@", result];
 
}

@end
