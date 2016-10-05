//
//  ForumViewController.m
//  appViewer
//
//  Created by HoJolin on 16/9/26.
//  Copyright © 2016年 JuZhen. All rights reserved.
//

#import "ForumViewController.h"
#import "FroViewController.h"

@implementation ForumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"论坛";
    for (NSDictionary *dic in _data) {
        FroViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"FroViewController"];
        vc.data = dic;
        vc.title = dic[@"title"];
        [self addChildViewController:vc];
    }
    [self setUpTitleEffect:^(UIColor *__autoreleasing *titleScrollViewColor, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor, UIFont *__autoreleasing *titleFont, CGFloat *titleHeight, CGFloat *titleWidth) {
        
        // 设置标题字体
        *titleFont = [UIFont systemFontOfSize:20];
    }];
    
    [self setUpUnderLineEffect:^(BOOL *isShowUnderLine, BOOL *isDelayScroll, CGFloat *underLineH, CGFloat *underLineW, UIColor *__autoreleasing *underLineColor) {
        // 是否显示标签
        *isShowUnderLine = YES;
        
        // 标题填充模式
        *underLineColor = [UIColor redColor];
    }];
}

@end
