//
//  UploadBase.h
//  appViewer
//
//  Created by JuZhen on 16/6/5.
//  Copyright © 2016年 JuZhen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UploadImageLayout.h"

@interface UploadBase : UIViewController


@property (nonatomic,strong) UIScrollView * scrollView;
@property (nonatomic, strong) NSMutableArray * ImgNumView;
@property (nonatomic, strong) NSMutableArray * ImgNumPic;
@property (nonatomic, strong) NSMutableArray * ImgNumPicSelected;
+ (instancetype)initWithSectionNumber:(int)secNum;
- (instancetype)initWithSectionNumber:(int)secNum;

@end
