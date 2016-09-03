//
//  NSArray+YW.m
//  YYW
//
//  Created by xingyong on 14-5-20.
//  Copyright (c) 2014年 xingyong. All rights reserved.
//

#import "NSArray+YW.h"

@implementation NSArray (YW)

-(BOOL)isEmpty{
    if ([self count]==0) {
        return NO;
    }
    return YES;
}
//
//- (id)initWithDictionaries:(NSArray *)anotherArray forKey:(NSString *)key
//{
//    self = [super init];
//    if (self)
//    {
//        NSMutableArray *result = [[NSMutableArray alloc] init];
//        
//        for (int i = 0; i < [anotherArray count]; i++)
//        {
//            NSDictionary *dict = [anotherArray objectAtIndex:i];
//            
//            id object = [dict objectForKey:key];
//            if (object) [result addObject:object];
//        }
//        
//        return (NSArray *)result;
//    }
//    return self;
//}

-(id)safeObjectAtIndex:(NSUInteger)index
{
    //NSLog(@"safeObjectAtIndex: %d",index);
    
    if ([self count] > 0) return [self objectAtIndex:index];
    else return nil;
    
    /*
     @try {
     return [self objectAtIndex:index];
     }
     @catch (id theException) {
     NSLog(@"*** safeObjectAtIndex exception: %@", theException);
     return nil;
     }
     */
}

- (id)objectSortedByKey:(NSString *)key atIndex:(NSUInteger)index
{
    return [[self sortByKey:key] objectAtIndex: index];
}

- (NSArray *)sortByKey:(NSString *)key
{
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    return [self sortedArrayUsingDescriptors:sortDescriptors];
}

/*
 - (id)objectSortedByPosition:(NSString *)key atIndex:(NSUInteger)index
 {
 NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:YES];
 NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
 NSArray *sortedArray = [self sortedArrayUsingDescriptors:sortDescriptors];
 
 return [sortedArray objectAtIndex:index];
 }
 */
- (NSArray *)reversedArray
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:[self count]];
    NSEnumerator *enumerator = [self reverseObjectEnumerator];
    
    for (id element in enumerator) [array addObject:element];
    
    return array;
}

 

- (NSArray *)removeAllObjects
{
    NSMutableArray *array = [NSMutableArray arrayWithArray:self];
    [array removeAllObjects];
    return array;
}


@end
