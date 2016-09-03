//
//  UploadBase.m
//  appViewer
//
//  Created by JuZhen on 16/6/5.
//  Copyright © 2016年 JuZhen. All rights reserved.
//

#import "UploadBase.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "head.h"
#import "UploadImageLayout.h"
#define ImgNumGap 50
#define ImgNumWidth 40
@interface UploadBase ()<UIScrollViewDelegate>{
    int viewPage;
}
@end

@implementation UploadBase
+ (instancetype)initWithSectionNumber:(int)secNum{
    UploadBase * svc = [UploadBase alloc];
    [svc initWithSectionNumber:secNum];
    return svc;
}
- (instancetype)initWithSectionNumber:(int)secNum{
    self = [super init];
    viewPage = 0 ;
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,120,SCREEN_WIDTH,SCREEN_HEIGHT-120)];
    [self.scrollView setContentSize:CGSizeMake(secNum*SCREEN_WIDTH,0)];
    self.scrollView.pagingEnabled=YES;
    //self.scrollView.bounces=NO;
    self.scrollView.scrollEnabled=YES;
    self.scrollView.backgroundColor=[UIColor whiteColor];
    self.scrollView.alwaysBounceHorizontal=YES;
    self.scrollView.delegate=self;
    self.ImgNumView = [[NSMutableArray alloc] init];
    float startX = (SCREEN_WIDTH-secNum*ImgNumWidth-(secNum-1)*ImgNumGap)/2;
    for(int i = 0 ; i < secNum ; i++){
        UIImageView * imgView = [[UIImageView alloc] init];
        imgView.frame=CGRectMake(startX+i*(ImgNumGap+ImgNumWidth),80,ImgNumWidth,ImgNumWidth);
        if(i==0) {
            imgView.backgroundColor = [UIColor redColor];
        }
        else{
            imgView.backgroundColor=[UIColor blackColor];
        }
        UIImage * img = [UIImage imageNamed:@"logo_500.jpg"];
        UIImage * imgS= [UIImage imageNamed:@"ImgNum4S"];
        [self.ImgNumPic addObject:img];
        [self.ImgNumPicSelected addObject:imgS];
        [imgView setImage:self.ImgNumPic[(NSUInteger) i]];
        [self.ImgNumView addObject:imgView];
        //[self.view addSubview:imgView];
    }
    [self.view addSubview:self.scrollView];
    for(int i = 0 ; i < secNum ; i++){
        [self.view addSubview:self.ImgNumView[i]];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated {
    //self.tabBarController.view.hidden=YES;
 //   [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
}
-(void)viewWillDisappear:(BOOL)animated {
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int num = (int)(scrollView.contentOffset.x/SCREEN_WIDTH);
    NSLog(@"%d",num);
    if(num != viewPage){
        [self.ImgNumView[viewPage] setImage:self.ImgNumPic[viewPage]];
        [self.ImgNumView[num] setImage:self.ImgNumPicSelected[num]];
        [self.ImgNumView[viewPage] setBackgroundColor:[UIColor blackColor]];
        [self.ImgNumView[num] setBackgroundColor:[UIColor redColor]];
        viewPage = num;
    }
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
