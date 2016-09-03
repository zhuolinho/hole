//
//  NSArray+YW.h
//  YYW
//
//  Created by xingyong on 14-5-20.
//  Copyright (c) 2014年 xingyong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (YW)

//- (id)initWithDictionaries:(NSArray *)anotherArray forKey:(NSString *)key;

- (id)safeObjectAtIndex:(NSUInteger)index;
- (NSArray *)sortByKey:(NSString *)key;
- (id)objectSortedByKey:(NSString *)key atIndex:(NSUInteger)index;

- (NSArray *)reversedArray;

- (NSArray *)removeAllObjects;

-(BOOL)isEmpty;

@end
