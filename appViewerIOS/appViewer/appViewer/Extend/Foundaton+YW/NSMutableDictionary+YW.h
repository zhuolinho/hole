//
//  NSMutableDictionary+YW.h
//  YYW
//
//  Created by xingyong on 14-5-20.
//  Copyright (c) 2014年 xingyong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (YW)
- (void)setSafeObject:(id)object forKey:(id<NSCopying>)aKey;

@end
