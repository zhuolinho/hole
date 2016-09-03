//
// Created by czz on 16/3/28.
// Copyright (c) 2016 Jin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void(^RequestRemove)(UIView *view);

@interface UploadUIImageView : UIView

@property (nonatomic) NSString *url;

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *close;
@property (nonatomic, strong) UIView *reload;

@property (nonatomic, copy) RequestRemove requestRemove;

- (void)setUploadImage: (UIImage *)img;
@end