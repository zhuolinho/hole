//
//  ImgDetailVC.m
//  appViewer
//
//  Created by JuZhen on 16/6/21.
//  Copyright © 2016年 JuZhen. All rights reserved.
//

#import "ImgDetailVC.h"
#import "head.h"
#import "CommentView.h"
#import "CommentView.h"
@interface ImgDetailVC()<UITextFieldDelegate>{
    BOOL display;
}

@property(nonatomic,strong) UIScrollView * uiScrollView;
@property(nonatomic,strong) UITextView * detailTextView;
@property(nonatomic,strong) UIImageView * commentImgView;
@property(nonatomic,strong) UIImageView * CommenBGView;

@end
@implementation ImgDetailVC
@synthesize imgArr,descriptionStr;
-(void)viewDidLoad{
    [super viewDidLoad];
    display = true;
    self.view.backgroundColor=[UIColor whiteColor];
    [self initScrollView];
    [self initDetailView];
    [self initCommentView];
    [self InittapEvent];
    
}
-(void)viewDidAppear:(BOOL)animated{
    display=false;
    self.navigationController.navigationBarHidden=YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    display=true;
    self.navigationController.navigationBarHidden=NO;
}
-(void)initScrollView{
    self.uiScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    [self.uiScrollView setContentSize:CGSizeMake(SCREEN_WIDTH*[imgArr count], 0)];
    self.uiScrollView.pagingEnabled=YES;
    for(int i = 0 ; i < [imgArr count];i++){
        UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        NSString * imgStr = [NSString stringWithFormat:@"%@%@",@"http://139.196.56.202:8080/",imgArr[i]];
        imgStr=[imgStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [imgView setImageWithURL:[NSURL URLWithString:imgStr]];
        imgView.userInteractionEnabled=YES;
        [self.uiScrollView addSubview:imgView];
    }
    
    [self.view addSubview:self.uiScrollView];
}
-(void)initDetailView{
    self.CommenBGView=[[UIImageView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-80, SCREEN_WIDTH, 80)];
    self.CommenBGView.backgroundColor=[UIColor blackColor];
    self.CommenBGView.alpha=0.6;
    self.detailTextView=[[UITextView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-50, 80)];
    self.detailTextView.text=descriptionStr;
    self.detailTextView.delegate=self;
    self.detailTextView.backgroundColor=[UIColor blackColor];
    self.detailTextView.textColor=[UIColor whiteColor];
    self.detailTextView.alpha=1;
    [self.CommenBGView addSubview:self.detailTextView];
    [self.view addSubview:self.CommenBGView];
}

-(void)initCommentView{
    self.commentImgView=[[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-50, SCREEN_HEIGHT-50, 50, 50)];
    self.commentImgView.backgroundColor=[UIColor clearColor];
    //self.commentImgView.alpha=0.36;
    //self.commentImgView.backgroundColor=[UIColor greenColor];
    [self.commentImgView setImage:[UIImage imageNamed:@"comment2"]];
    self.commentImgView.userInteractionEnabled=YES;
    
    UITapGestureRecognizer * singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bthClick:)];
    [self.commentImgView addGestureRecognizer:singleTap1];

    [self.view addSubview:self.commentImgView];
    
}
-(void) bthClick:(UITapGestureRecognizer *)tap
{
    CommentView * svc = [[CommentView alloc] init];
    //svc.commentArr= [NSArray arrayWithObjects:@"one",@"two",@"1", nil];
    svc.entryID=self.entryID;
    self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
    [self.navigationController pushViewController:svc animated:YES];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return NO;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
//    if(display){
//        display=false;
//        self.navigationController.navigationBarHidden=YES;
//    }else{
//        display=true;
//        self.navigationController.navigationBarHidden=NO;
//    }
    
}
-(void)InittapEvent{
    UITapGestureRecognizer *recognizer;
    recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(oneTap:)];
    //[recognizer setDirection:(UISwipeGestureRecognizerDirectionDown)];
    [self.view addGestureRecognizer:recognizer];
}
-(void)oneTap:(UITapGestureRecognizer *)recognizer{
    if(display){
        display=false;
        self.navigationController.navigationBarHidden=YES;
    }else{
        display=true;
        self.navigationController.navigationBarHidden=NO;
    }
}
@end
