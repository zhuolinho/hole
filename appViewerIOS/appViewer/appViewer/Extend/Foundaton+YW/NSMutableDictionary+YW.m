//
//  NSMutableDictionary+YW.m
//  YYW
//
//  Created by xingyong on 14-5-20.
//  Copyright (c) 2014年 xingyong. All rights reserved.
//

#import "NSMutableDictionary+YW.h"


@implementation NSMutableDictionary (YW)
- (void)setSafeObject:(id)object forKey:(id<NSCopying>)aKey{
    
    if (object) {
        [self setObject:object forKey:aKey];
    }
    
}



@end
