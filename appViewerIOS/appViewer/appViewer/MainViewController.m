//
//  MainViewController.m
//  appViewer
//
//  Created by JuZhen on 16/6/3.
//  Copyright © 2016年 JuZhen. All rights reserved.
//

#import "MainViewController.h"
#import "PersonViewController.h"
#include "head.h"
#import "SecondLay.h"
#import "ThirdLay.h"
#import "HttpHelper.h"
#import "SearchResult.h"
#include <AVFoundation/AVFoundation.h>
@interface MainViewController ()<UISearchBarDelegate>{
    bool darkOflight;
    double angle;
    double radius;
    double centerX;
    double centerY;
}
@property (nonatomic, strong) UIButton * btn;
@property (nonatomic, strong) UIImageView * Person;

@property (nonatomic,strong) UIImageView * Base1;
@property (nonatomic,strong) UIImageView * Base2;
@property (nonatomic,strong) UIImageView * Base3;
@property (nonatomic,strong) UISearchBar *searchBar;
@property (nonatomic,strong) UIView *searchView;

@property (nonatomic,strong) AVAudioPlayer * AVPlayer;

@property (nonatomic,strong)NSString * searchStr;
@end

@implementation MainViewController
@synthesize btn,Person,searchBar,searchView;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self initSearchBar];
    [self initPlayer];
    [self InitSearchBar];
    darkOflight = false;
    angle=0;
    //self.view.frame=CGRectMake(0, 100, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]];
    //self.view.backgroundColor=[UIColor whiteColor];
    [self InitGotoPersonImageView];
    angle=0;radius=50;centerX=SCREEN_WIDTH/20;centerY=SCREEN_WIDTH/2;centerY=SCREEN_WIDTH/2;
    [self InitCircle];
    //[NSTimer scheuledTimerWithTimeInterval:1.0/60.0  target: self  selector:@selector(timerAdvanced:) userInfo:nil  repeats: YES];
    [NSTimer scheduledTimerWithTimeInterval:1.0/60.0 target:self selector:@selector(timerAdvanced:) userInfo:nil repeats:YES];

    
    // Do any additional setup after loading the view.
}
-(void)InitSearchBar{
    UISwipeGestureRecognizer *recognizer;
    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionDown)];
    [self.view addGestureRecognizer:recognizer];
}
-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
    
    if(recognizer.direction==UISwipeGestureRecognizerDirectionDown) {
        self.navigationController.navigationBarHidden=NO;
    }
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
}
-(void)viewWillDisappear:(BOOL)animated:(BOOL)animated{
    self.navigationController.navigationBarHidden=NO;
}
-(void)viewDidDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden=NO;
}
-(void) initPlayer{
    NSURL *url=[[NSBundle mainBundle]URLForResource:@"235319.mp3" withExtension:Nil];
    self.AVPlayer=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:Nil];
    [self.AVPlayer prepareToPlay];
}
-(void) startPlay{
    [self.AVPlayer play];
}
-(void) endPlay{
    [self.AVPlayer stop];
}
-(void)initSearchBar{
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0,0.0f,SCREEN_WIDTH-10,44.0f)];
    searchBar.delegate = self;
    [searchBar setPlaceholder:@"搜索"];
    
    searchView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 768, 44)];
    searchView.backgroundColor = [UIColor clearColor];
    [searchView addSubview:searchBar];
    [self.navigationItem setTitleView:searchView];
    // self.navigationItem.titleView = searchView;
}
-(void)timerAdvanced:(NSTimer * )timer
{
 //   NSLog(@"%f ",angle);
//      	stdout << angle ;
    if(darkOflight){
        angle -= 0.003;
    }else{
        angle += 0.003;
    }
    if(angle < 0.0)
        darkOflight = false;
    if(angle > 0.5)
        darkOflight = true;
    self.Base1.alpha=angle+0.5;
    self.Base2.alpha=0.7-angle;
    self.Base3.alpha=angle + 0.2;
    
    int CenterX1 = 301*SCREEN_WIDTH/591 + 0.5 * (290*SCREEN_WIDTH/591);
    int CenterY1 = 100*SCREEN_HEIGHT/1063 + 0.5 * 174*SCREEN_HEIGHT/1063;
    int CenterX2 = 12 *SCREEN_WIDTH/591 + 0.5 * (298*SCREEN_WIDTH/591);
    int CenterY2 = 166*SCREEN_HEIGHT/1063 + 0.5 * (253*SCREEN_HEIGHT/1063);
    int CenterX3 = 175*SCREEN_WIDTH/591 +0.5 * (416*SCREEN_WIDTH/591);
    int CenterY3 = 409*SCREEN_HEIGHT/1063 + 0.5 * (406*SCREEN_HEIGHT/1063);
    
    [self.Base1 setCenter:CGPointMake(CenterX1+(angle-0.25)/0.08,CenterY1+(angle-0.20)/0.06)];
    [self.Base2 setCenter:CGPointMake(CenterX2,CenterY2+(angle-0.25)/0.08)];
    [self.Base3 setCenter:CGPointMake(CenterX3+(angle-0.25)/0.08,CenterY3)];
}
-(void)InitCircle{
    self.Base1=[[UIImageView alloc] initWithFrame:CGRectMake(301*SCREEN_WIDTH/591, 100  *SCREEN_HEIGHT/1063, 290*SCREEN_WIDTH/591, 174*SCREEN_HEIGHT/1063)];
    self.Base2=[[UIImageView alloc] initWithFrame:CGRectMake(12 *SCREEN_WIDTH/591, 166*SCREEN_HEIGHT/1063, 298*SCREEN_WIDTH/591, 253*SCREEN_HEIGHT/1063)];
    self.Base3=[[UIImageView alloc] initWithFrame:CGRectMake(175*SCREEN_WIDTH/591, 409*SCREEN_HEIGHT/1063, 416*SCREEN_WIDTH/591, 406*SCREEN_HEIGHT/1063)];
    UIImage * _img1 = [self reSizeImage:[UIImage imageNamed:@"star1"] toSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)];
    UIImage * _img2 = [self reSizeImage:[UIImage imageNamed:@"star2"] toSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)];
    UIImage * _img3 = [self reSizeImage:[UIImage imageNamed:@"star3"] toSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)];
    UIImage * img1 = [self clipImageInRect:_img1 withRect:CGRectMake(301*SCREEN_WIDTH/591, 0  *SCREEN_HEIGHT/1063, 290*SCREEN_WIDTH/591, 174*SCREEN_HEIGHT/1063)];
    UIImage * img2 = [self clipImageInRect:_img2 withRect:CGRectMake(12 *SCREEN_WIDTH/591, 166*SCREEN_HEIGHT/1063, 298*SCREEN_WIDTH/591, 253*SCREEN_HEIGHT/1063)];
    UIImage * img3 = [self clipImageInRect:_img3 withRect:CGRectMake(175*SCREEN_WIDTH/591, 409*SCREEN_HEIGHT/1063, 416*SCREEN_WIDTH/591, 406*SCREEN_HEIGHT/1063)];
    
    UILabel * label1 = [[UILabel alloc] initWithFrame:CGRectMake(301*SCREEN_WIDTH/591+70,100  *SCREEN_HEIGHT/1063+30, 50, 30)];
    UILabel * label2 = [[UILabel alloc] initWithFrame:CGRectMake(12 *SCREEN_WIDTH/591+90, 166*SCREEN_HEIGHT/1063+50, 50, 30)];
    UILabel * label3 = [[UILabel alloc] initWithFrame:CGRectMake(175*SCREEN_WIDTH/591+120, 409*SCREEN_HEIGHT/1063+90, 50, 30)];
    
    label1.text=@"付费";
    //label1.font= [UIFont fontWithName:@"STXinwei" size:22];
    label2.text=@"游戏";
    label3.text=@"生活";
    
    label1.textColor=[UIColor whiteColor];
    label2.textColor=[UIColor whiteColor];
    label3.textColor=[UIColor whiteColor];
    
    [self.Base1 setImage:img1];
    [self.Base2 setImage:img2];
    [self.Base3 setImage:img3];
    
    self.Base1.userInteractionEnabled=YES;
    self.Base2.userInteractionEnabled=YES;
    self.Base3.userInteractionEnabled=YES;
    
    self.Base1.tag=1;
    self.Base2.tag=2;
    self.Base3.tag=3;
    
    UITapGestureRecognizer * singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bthClick:)];
    UITapGestureRecognizer * singleTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bthClick:)];
    UITapGestureRecognizer * singleTap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bthClick:)];
    
    [self.Base1 addGestureRecognizer:singleTap1];
    [self.Base2 addGestureRecognizer:singleTap2];
    [self.Base3 addGestureRecognizer:singleTap3];
    
    [self.view addSubview:self.Base1];
    [self.view addSubview:self.Base2];
    [self.view addSubview:self.Base3];
    
    [self.view addSubview:label1];
    [self.view addSubview:label2];
    [self.view addSubview:label3];
}

- (void) InitGotoPersonImageView{
    Person = [[UIImageView alloc] initWithFrame:CGRectMake(140*SCREEN_WIDTH/591, 817*SCREEN_HEIGHT/1063, 314*SCREEN_WIDTH/591, 217*SCREEN_HEIGHT/1063)];
    
    UIImage * home = [UIImage imageNamed:@"home"];
    home = [self reSizeImage:home toSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)];
    int width = home.size.width;
    int height = home.size.height;
    UIImage * newhome =[[UIImage alloc] init];
    newhome= [self clipImageInRect:home withRect:CGRectMake(140*SCREEN_WIDTH/591, 817*SCREEN_HEIGHT/1063, 314*SCREEN_WIDTH/591, 217*SCREEN_HEIGHT/1063)];//(140*width/591, 817*height/1063, 314*width/591, 217*height/1063)
    [Person setImage:newhome];
    Person.contentMode=UIViewContentModeTopLeft;
    Person.clipsToBounds=YES;
    //Person.frame = CGRectMake(140*SCREEN_WIDTH/591, 817*SCREEN_HEIGHT/1063, 314*SCREEN_WIDTH/591, 217*SCREEN_HEIGHT/1063);
    
    NSString * imgStr =@"http://139.196.56.202:8080/picture/payment/game/relax/Cut the Rope/1.4.0/IMG_1364.PNG";
    imgStr=[imgStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //[Person setImageWithURL:[NSURL URLWithString:imgStr]];
    Person.userInteractionEnabled = YES;
    [Person setTag:0];
    UITapGestureRecognizer * singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoPersonCenter:)];
    [Person addGestureRecognizer:singleTap];
    [self.view addSubview:Person];
}
- (void)downloadImage
{
    NSURL *imageUrl =[[NSURL alloc] init];
    NSString * str = @"http://139.196.56.202:8080/picture/payment/game/relax/Cut the Rope/1.4.0/IMG_1364.PNG";
    str = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    imageUrl= [NSURL URLWithString:str];
    UIImage *image = [[UIImage alloc] init];
    image= [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
    [Person setImage:image];
}
-(void) gotoPersonCenter:(UITapGestureRecognizer *)tap
{
    UIImageView * img = [tap view];
    if(img.tag == 0){
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.01];
        [UIView setAnimationDidStopSelector:@selector(gotoPersonCenter1:)];
        [UIView setAnimationDelegate:self];
        CGPoint point = Person.center;
        [Person setCenter:point];
        [UIView commitAnimations];
    }
}
-(void) gotoPersonCenter1:(UIView *)uiview
{
    [Person setCenter:CGPointMake(140*SCREEN_WIDTH/591 + 0.5*(314*SCREEN_WIDTH/591), 817*SCREEN_HEIGHT/1063 + 0.5 * (217*SCREEN_HEIGHT/1063))];
    PersonViewController * svc = [[PersonViewController alloc] init];
    self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
    [self.navigationController pushViewController:svc animated:nil];
}
-(void) bthClick:(UITapGestureRecognizer *)tap
{
    int CenterX1 = 301*SCREEN_WIDTH/591 + 0.5 * (290*SCREEN_WIDTH/591);
    int CenterY1 = 100*SCREEN_HEIGHT/1063 + 0.5 * 174*SCREEN_HEIGHT/1063;
    int CenterX2 = 12 *SCREEN_WIDTH/591 + 0.5 * (298*SCREEN_WIDTH/591);
    int CenterY2 = 166*SCREEN_HEIGHT/1063 + 0.5 * (253*SCREEN_HEIGHT/1063);
    int CenterX3 = 175*SCREEN_WIDTH/591 +0.5 * (416*SCREEN_WIDTH/591);
    int CenterY3 = 409*SCREEN_HEIGHT/1063 + 0.5 * (406*SCREEN_HEIGHT/1063);
    UIImageView * img = [tap view];
    if(img.tag == 1){
        //AudioServicesPlaySystemSound(1202);
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.01];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [UIView setAnimationDidStopSelector:@selector(gotoSub1:)];
        [UIView setAnimationDelegate:self];
//        CGPoint point = Person.center;
//        point.x = CenterX1;
//        point.y = CenterY1;
//        [Person setCenter:point];
        [UIView commitAnimations];
    }else if (img.tag == 2){
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.01];
        [UIView setAnimationDidStopSelector:@selector(gotoSub2:)];
        [UIView setAnimationDelegate:self];
//        CGPoint point = Person.center;
//        point.x = CenterX2;
//        point.y = CenterY2;
//        [Person setCenter:point];
        [UIView commitAnimations];
    }else{
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.01];
        [UIView setAnimationDidStopSelector:@selector(gotoSub3:)];
        [UIView setAnimationDelegate:self];
//        CGPoint point = Person.center;
//        point.x = CenterX3;
//        point.y = CenterY3;
//        [Person setCenter:point];
        [UIView commitAnimations];
    }
}
-(void) gotoSub1:(UIView *)uiview
{
    SecondLay * svc = [[SecondLay alloc] init];
    NSMutableDictionary * requestDic=[NSMutableDictionary new];
    requestDic[@"ifPay"]=@"true";//[NSNumber numberWithInt:0];
    [HttpHelper get:[NSString stringWithFormat:@"%@%@",AppViewUrl,@"getThemes.action"] params:requestDic success:^(id responseObj) {
        NSString * id = responseObj[@"result"][0][@"id"];
        int idInt = [id intValue];
        svc.themeId=[NSNumber numberWithInt:idInt];
        self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
        //self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@”返回“ style:UIBarButtonItemStyleBordered target:nil action:nil]
        [self.navigationController pushViewController:svc animated:NO];
    } failure:^(NSError *error) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"网络错误" delegate:nil  cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }];
}
-(void) gotoSub2:(UIView *)uiview
{
    SecondLay * svc = [[SecondLay alloc] init];
    NSMutableDictionary * requestDic=[NSMutableDictionary new];
    requestDic[@"ifPay"]=@"false";//[NSNumber numberWithInt:0];
    [HttpHelper get:[NSString stringWithFormat:@"%@%@",AppViewUrl,@"getThemes.action"] params:requestDic success:^(id responseObj) {
        NSString * title = responseObj[@"result"][0][@"title"];
        int idInt;
        if([title isEqualToString:@"游戏"]){
            NSString * id = responseObj[@"result"][0][@"id"];
            idInt = [id intValue];
        }
        else{
            NSString * id = responseObj[@"result"][1][@"id"];
            idInt = [id intValue];
        }
        svc.themeId=[NSNumber numberWithInt:idInt];
        self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
        [self.navigationController pushViewController:svc animated:NO];
    } failure:^(NSError *error) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"网络错误" delegate:nil  cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }];
}
-(void) gotoSub3:(UIView *)uiview
{
    SecondLay * svc = [[SecondLay alloc] init];
    NSMutableDictionary * requestDic=[NSMutableDictionary new];
    requestDic[@"ifPay"]=@"false";//[NSNumber numberWithInt:0];
    [HttpHelper get:[NSString stringWithFormat:@"%@%@",AppViewUrl,@"getThemes.action"] params:requestDic success:^(id responseObj) {
        NSString * title = responseObj[@"result"][0][@"title"];
        int idInt;
        if([title isEqualToString:@"生活"]){
            NSString * id = responseObj[@"result"][0][@"id"];
            idInt = [id intValue];
        }
        else{
            NSString * id = responseObj[@"result"][1][@"id"];
            idInt = [id intValue];
        }
        svc.themeId=[NSNumber numberWithInt:idInt];
        self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
        [self.navigationController pushViewController:svc animated:NO];
    } failure:^(NSError *error) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"网络错误" delegate:nil  cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
//点击屏幕空白处去掉键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.navigationController.navigationBarHidden=YES;
    [self.view endEditing:YES];
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}
-(UIImage*)getSubImage:(UIImage*) img withRect:(CGRect)rect
{
    CGImageRef subImageRef = CGImageCreateWithImageInRect(img.CGImage, rect);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    
    return smallImage;
}
-(UIImage *)getImageFromImage:(UIImage*)bigImage withRect:(CGRect)myImageRect{
    CGImageRef imageRef = bigImage.CGImage;
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, myImageRect);
    CGSize size;
    size.width = myImageRect.size.width;
    size.height = myImageRect.size.height;
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, myImageRect, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    return smallImage;
}

- (UIImage *)clipImageInRect:(UIImage* ) img withRect:(CGRect)rect
{
    CGImageRef imageRef = CGImageCreateWithImageInRect([img CGImage], rect);
    UIImage *thumbScale = [UIImage imageWithCGImage:imageRef];
    return thumbScale;
}
- (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize

{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeImage;
}
-(void)InitCircleOld{
    self.Base1=[[UIImageView alloc] initWithFrame:CGRectMake(centerX-20 + cos(angle)* 50, centerY-20 + sin(angle)* 50, 40, 40)];
    self.Base2=[[UIImageView alloc] initWithFrame:CGRectMake(centerX-20 + cos(angle+6.283/3)* 50, centerY-20 + sin(angle+6.283/3)* 50, 40, 40)];
    self.Base3=[[UIImageView alloc] initWithFrame:CGRectMake(centerX-20 + cos(angle-6.283/3)* 50, centerY-20 + sin(angle-6.283/3)* 50, 40, 40)];
    [self.Base1 setImage:[UIImage imageNamed:@"star1"]];
    [self.Base2 setImage:[UIImage imageNamed:@"star2"]];
    [self.Base3 setImage:[UIImage imageNamed:@"star3"]];
    self.Base1.userInteractionEnabled=YES;
    self.Base2.userInteractionEnabled=YES;
    self.Base3.userInteractionEnabled=YES;
    self.Base1.tag=1;
    self.Base2.tag=2;
    self.Base3.tag=3;
    
    UITapGestureRecognizer * singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bthClick:)];
    UITapGestureRecognizer * singleTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bthClick:)];
    UITapGestureRecognizer * singleTap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bthClick:)];
    [self.Base1 addGestureRecognizer:singleTap1];
    [self.Base2 addGestureRecognizer:singleTap2];
    [self.Base3 addGestureRecognizer:singleTap3];
    
    [self.view addSubview:self.Base1];
    [self.view addSubview:self.Base2];
    [self.view addSubview:self.Base3];
}
-(void) buttonMusicPlay{
         //1.获得音效文件的全路径
    
         NSURL *url=[[NSBundle mainBundle]URLForResource:@"buyao.wav" withExtension:nil];
    
         //2.加载音效文件，创建音效ID（SoundID,一个ID对应一个音效文件）
         SystemSoundID soundID=0;
         AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundID);
    
         //把需要销毁的音效文件的ID传递给它既可销毁
         //AudioServicesDisposeSystemSoundID(soundID);
    
         //3.播放音效文件
         //下面的两个函数都可以用来播放音效文件，第一个函数伴随有震动效果
         AudioServicesPlayAlertSound(soundID);
         //AudioServicesPlaySystemSound(<#SystemSoundID inSystemSoundID#>)
}
//- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    //NSLog(@"%@",self.searchStr);
    SearchResult * svc = [[SearchResult alloc] init];
    svc.keyWord=self.searchStr;
    self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
    [self.navigationController pushViewController:svc animated:NO];
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
   // NSLog(@"%@",searchText);
    self.searchStr=searchText;
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
