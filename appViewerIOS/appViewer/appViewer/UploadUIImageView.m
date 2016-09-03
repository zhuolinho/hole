//
// Created by czz on 16/3/28.
// Copyright (c) 2016 Jin. All rights reserved.
//

#import "UploadUIImageView.h"
#include <UIKit/UIKit.h>
#include "head.h"
#include "JUtils.h"
#import "HttpHelper.h"
@interface UploadUIImageView()
@property (nonatomic)UIImage *image;
@end

@implementation UploadUIImageView
@synthesize imageView, close, reload, requestRemove, image;

#define MaxImageSize 850

- (void)removeSelf {
    requestRemove(self);
}

- (void)reloadClick {
    if (!self.image) return;
    [self hideReload];
    [self startUploadImage:self.image];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        imageView = [[UIImageView alloc] initWithFrame:frame];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;

        close = [[UIImageView alloc] initWithFrame:CGRectMake(-5, -5, 15, 15)];
        close.image = [UIImage imageNamed:@"close.png"];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeSelf)];
        close.userInteractionEnabled = YES;
        [close addGestureRecognizer:tap];

        reload = [[UIView alloc] initWithFrame:CGRectMake(4, 4, frame.size.width-8, frame.size.height-8)];
        reload.backgroundColor = ReloadBGColor;
        reload.hidden = YES;
        tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(reloadClick)];
        reload.userInteractionEnabled = YES;
        [reload addGestureRecognizer:tap];


        CGSize size = reload.frame.size;
        UILabel *t1 = [[UILabel alloc] init];
        t1.textColor = [UIColor whiteColor];
        t1.font = SYSTEMFONT(7);
        float width = [JUtils calculateWidth:@"失败" andFont:t1.font andHeight:15];
        t1.frame = CGRectMake((size.width-width)/2, 15, width, 10);
        t1.text = @"失败";
        [reload addSubview:t1];

        t1 = [[UILabel alloc] init];
        t1.textColor = [UIColor whiteColor];
        t1.font = SYSTEMFONT(7);
        width = [JUtils calculateWidth:@"点击重试" andFont:t1.font andHeight:20];
        t1.frame = CGRectMake((size.width-width)/2, 25, width, 15);
        t1.text = @"点击重试";
        [reload addSubview:t1];

        [self addSubview:imageView];
        [self addSubview:close];
        [self addSubview:reload];
    }
    return self;
}

- (void)showReload {
    reload.hidden = NO;
    [self bringSubviewToFront:reload];
    [self bringSubviewToFront:close];
}

- (void)hideReload {
    reload.hidden = YES;
}

- (void)setUploadImage:(UIImage *)img {
    img = [UploadUIImageView resizeImage:img];
    self.imageView.image = img;
    [self startUploadImage:img];
}

- (void)startUploadImage: (UIImage *)img {
    self.image = img;
    NSString *url = [NSString stringWithFormat:@"%@/api/image", AppViewUrl];
    [HttpHelper postImg:url img:img success:^(id resp) {
        NSDictionary *dic = resp;
        self.url = dic[@"url"];
    } failure:^(NSError *error) {
        // 重新上传的view显示出来
        [self showReload];
    }];
}

+ (UIImage *)resizeImage: (UIImage *)image {
    float size = MAX(image.size.height, image.size.width);
    if (size <= MaxImageSize) return image;

    float scale = MaxImageSize / size;
    return [JUtils scaleToSize:image size:CGSizeMake(image.size.width * scale, image.size.height * scale)];
}

@end