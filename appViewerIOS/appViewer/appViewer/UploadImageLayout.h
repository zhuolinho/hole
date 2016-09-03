//
// Created by czz on 16/3/28.
// Copyright (c) 2016 Jin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void(^AddIconClick)();

@interface UploadImageLayout : UIView

@property (nonatomic, copy) AddIconClick addIconClick;
- (instancetype)initWithFrame: (CGRect)frame;
- (instancetype)initWithFrame: (CGRect)frame andUrls: (NSArray *)urls;
-(void)addOneImage: (UIImage *)image;
- (NSUInteger)allUploaded;
- (NSArray *)getUrls;

@end