//
//  UIImage+YW.h
//  YYW
//
//  Created by xingyong on 14-5-20.
//  Copyright (c) 2014年 xingyong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YW)

+(id)strethImageWith:(NSString *)imageName;

+ (UIImage *)resizeImage:(NSString *)imgName;

- (UIImage *)resizeImage;

- (UIImage *)blurredImageWithRadius:(CGFloat)radius iterations:(NSUInteger)iterations tintColor:(UIColor *)tintColor;
@end
