//
// Created by czz on 16/3/28.
// Copyright (c) 2016 Jin. All rights reserved.
//

#import "UploadImageLayout.h"
#import "UploadUIImageView.h"
#import "UIView+Extension.h"
#import "UIImageView+AFNetworking.h"
#import "JUtils.h"
#import "head.h"
#define kGap 10
#define imageGap 20
#define imageWidth ((SCREEN_WIDTH - 2 * kGap - 3 * imageGap) / 4)

@interface UploadImageLayout ()

@property NSMutableArray *existViews;
@property (nonatomic, strong) UIView *addIcon;

@end

@implementation UploadImageLayout
@synthesize existViews, addIcon, addIconClick;

- (void)iconClick {
    addIconClick();
}
- (void)initAddIcon {
    addIcon = [[UIView alloc] initWithFrame:CGRectMake(0, 0, imageWidth, imageWidth)];
    addIcon.layer.borderColor = [UIColor grayColor].CGColor;
    addIcon.layer.borderWidth = 1;
    addIcon.layer.cornerRadius = 5;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconClick)];
    addIcon.userInteractionEnabled = YES;
    [addIcon addGestureRecognizer:tap];

    UIImageView *plus = [[UIImageView alloc] initWithFrame:CGRectMake((CGFloat) (imageWidth/2-7.5), imageWidth/4, 15, 15)];
    plus.image = [UIImage imageNamed:@"plus_image.png"];
    [addIcon addSubview:plus];

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, plus.MaxY + 5, imageWidth, 20)];
    label.textColor = ThemeOrangeColor;
    label.font = SYSTEMFONT(6);
    label.text = @"添加图片";
    label.textAlignment = NSTextAlignmentCenter;
    [addIcon addSubview:label];
}

- (void)addView: (UIView *)view andIndex: (NSUInteger)index {
    [view removeFromSuperview];
    int row = index / 4;
    int col = index % 4;
    float x = kGap + col * (imageWidth + imageGap);
    float y = row * (imageWidth + imageGap);
    view.frame = CGRectMake(x, y, imageWidth, imageWidth);
    [self addSubview:view];

    CGRect frame = self.frame;
    self.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, view.MaxY);
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initAddIcon];
        [self addView:addIcon andIndex:0];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame andUrls: (NSArray *) urls{
    self = [super initWithFrame:frame];
    if (self) {
        existViews = [NSMutableArray new];
        for (NSUInteger i = 0; i < urls.count; i++) {
            NSString *url = [JUtils toHttpImageUrl:urls[i]];
            UploadUIImageView *view = self.generateUIImageView;
            view.url = url;
            [view.imageView setImageWithURL:[[NSURL alloc] initWithString:url]];
            [existViews addObject:view];
            [self addView:view andIndex:i];
        }
        [self initAddIcon];
        [self addView:addIcon andIndex:existViews.count];
    }
    return self;
}

- (void)removeImageView: (UIView *)view {
    [view removeFromSuperview];
    NSUInteger index = [existViews indexOfObject:view];
    if (index == NSNotFound) return;

    for (NSUInteger i = index+1; i < existViews.count; i++) {
        existViews[i-1] = existViews[i];
        [self addView:existViews[i-1] andIndex:i-1];
    }
    [existViews removeLastObject];
    [self addView:addIcon andIndex:existViews.count];
}

- (UploadUIImageView *)generateUIImageView {
    UploadUIImageView *view = [[UploadUIImageView alloc] initWithFrame:CGRectMake(0, 0, imageWidth, imageWidth)];
    view.requestRemove = ^(UIView *child) {
        [self removeImageView:child];
    };
    return view;
}

- (void)addOneImage:(UIImage *)image {
    if (!existViews) {
        existViews = [NSMutableArray new];
    }

    UploadUIImageView *view = self.generateUIImageView;
    // 设置图片同时开始上传
    [view setUploadImage:image];

    NSUInteger count = existViews.count;

    [self addView:view andIndex:count];
    [self addView:addIcon andIndex:count+1];

    [existViews addObject:view];
}

// 全部上传完时返回0 否则返回index+1
- (NSUInteger)allUploaded {
    for (NSUInteger i = 0; i < existViews.count; i++) {
        UploadUIImageView *view = existViews[i];
        if (!view.url)
            return i+1;
    }
    return 0;
}

// 返回所有的url,请在allUploaded返回0之后调用
- (NSArray *)getUrls {
    NSMutableArray *urls = [NSMutableArray new];
    for (NSUInteger i = 0; i < existViews.count; i++) {
        UploadUIImageView *view = existViews[i];
        [urls addObject: view.url];
    }
    return urls;
}

@end