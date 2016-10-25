//
//  ThirdLay.m
//  appViewer
//
//  Created by JuZhen on 16/6/7.
//  Copyright © 2016年 JuZhen. All rights reserved.
//

#import "ThirdLay.h"
#include "DetailView.h"
#include "head.h"
#import "InterestVC.h"
@interface ThirdLay()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UIActionSheetDelegate>{
    bool darkOflight;
    double angle;
    double radius;
    double centerX;
    double centerY;
    double length;
}
@property (nonatomic,strong)UIScrollView * scrollView;
@property (nonatomic, strong) UIButton * btn;
@property (nonatomic, strong) UIImageView * Person;

@property (nonatomic,strong) UIImageView * Base1;
@property (nonatomic,strong) UIImageView * Base2;
@property (nonatomic,strong) UIImageView * Base3;

@property (nonatomic,strong) UITableView * listView;

@property (nonatomic,strong)UIImageView * bgImgView;

@property (nonatomic,strong)NSMutableArray * infArr;
@end
@implementation ThirdLay
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self setBar];
    [self InitData];
    darkOflight = false;
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.scrollView setContentSize:CGSizeMake(0, SCREEN_HEIGHT)];
    self.scrollView.pagingEnabled=NO;
    self.scrollView.bounces=NO;
    self.scrollView.scrollEnabled=YES;
    [self.view addSubview:self.scrollView];
    
    angle=0;radius=120;centerX=SCREEN_WIDTH/2;centerY=SCREEN_HEIGHT/2-130;length=80;

    // Do any additional setup after loading the view.
}
-(void)InitData{
    NSMutableDictionary * requestDic=[NSMutableDictionary new];
    requestDic[@"offset"]=[NSNumber numberWithInt:0];
    requestDic[@"limit"]=[NSNumber numberWithInt:100];
    
    if([self.isSub intValue]==0){
        requestDic[@"categoryID"]=self.categoryId;
    }else{
        requestDic[@"categorySubID"]=self.categoryId;
    }
    [HttpHelper get:[NSString stringWithFormat:@"%@%@",AppViewUrl,@"getEntries.action"] params:requestDic success:^(id responseObj) {
        NSMutableDictionary* infDic=responseObj;
        NSLog(@"%@",infDic);
        self.infArr = infDic[@"result"];
        if([self.infArr count] > 3){
            [self.scrollView setContentSize:CGSizeMake(0, SCREEN_HEIGHT+100*([self.infArr count]-3))];
        }
        [self InitBG];
        [self InitCircle];
        [NSTimer scheduledTimerWithTimeInterval:1.0/60.0 target:self selector:@selector(timerAdvanced:) userInfo:nil repeats:YES];
        [self initListView];
    } failure:^(NSError *error) {
        
    }];
}
-(void)InitBG{
    UIImageView * fImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-100)];
    [fImgView setImage:[UIImage imageNamed:@"TrdBg1"]];
    [self.scrollView addSubview:fImgView];
    float height = SCREEN_HEIGHT-300;
    for(int i = 0 ; i + 3 < [self.infArr count];i++){
        UIImageView * sImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-300+i*100, SCREEN_WIDTH, 100)];
        [sImgView setImage:[UIImage imageNamed:@"TrdBg2"]];
        [self.scrollView addSubview:sImgView];
        height += 100;
    }
    if(height < SCREEN_HEIGHT-100)
    {
        height = SCREEN_HEIGHT-100;
    }
    UIImageView * tImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, height, SCREEN_WIDTH, 100)];
    [tImgView setImage:[UIImage imageNamed:@"TrdBg3"]];
    [self.scrollView addSubview:tImgView];
}
-(void)initListView{
    if([self.infArr count] > 3){
        //[self.scrollView setContentSize:CGSizeMake(0, SCREEN_HEIGHT + 100*[self.infArr count]-3)];
        self.listView=[[UITableView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT -350, SCREEN_WIDTH, 100*[self.infArr count]-3) style:UITableViewStyleGrouped];
        UIView * _view = [[UIView alloc] initWithFrame:CGRectZero];
        [self.listView setTableHeaderView:_view];
        self.listView.tableHeaderView.backgroundColor=[UIColor blackColor];
        self.listView.backgroundColor=[UIColor whiteColor];
        self.listView.delegate=self;
        self.listView.dataSource=self;
        self.listView.alpha=0.9;//self.tableView?.tableHeaderView = UIView.init(frame: CGRectMake(0, 0, 0, 0.01))
\
        [self.scrollView addSubview:self.listView];
    }
}
-(void)timerAdvanced:(NSTimer * )timer
{

    angle += 0.003;
    
    if(angle > 6.283)
        angle-=6.283;
    if(fabs(angle-6.283/4*3)<6.283/12  ){
        self.Base1.alpha=fabs(angle-6.283/4*3)/fabs(6.283/12);
    }
    if(fabs(angle+6.283/3-6.283/4*3)<6.283/12){
        self.Base2.alpha=fabs(angle+6.283/3-6.283/4*3)/fabs(6.283/12);
    }
    if(fabs(angle-6.283/3+6.283/4)<6.283/12){
        self.Base3.alpha=fabs(angle-6.283/3+6.283/4)/fabs(6.283/12);
    }
    if([self.infArr count]>=1)
        [self.Base1 setCenter:CGPointMake(centerX+ cos(angle)* radius*1.2,centerY + sin(angle)* radius/2)];
    if([self.infArr count]>=2)
        [self.Base2 setCenter:CGPointMake(centerX+ cos(angle+6.283/3)* radius*1.2,centerY + sin(angle+6.283/3)* radius/2)];
    if([self.infArr count]>=3)
        [self.Base3 setCenter:CGPointMake(centerX+ cos(angle-6.283/3)* radius*1.2,centerY + sin(angle-6.283/3)* radius/2)];
}

-(void)InitCircle{
    centerX = SCREEN_WIDTH/2;centerY=SCREEN_HEIGHT/2-130;
    radius = SCREEN_WIDTH/4;
    self.Base1=[[UIImageView alloc] initWithFrame:CGRectMake(0,0,386/4*1.8,296/4*1.8)];
    self.Base2=[[UIImageView alloc] initWithFrame:CGRectMake(0,0,448/4*1.5,357/4*1.5)];
    self.Base3=[[UIImageView alloc] initWithFrame:CGRectMake(0,0,620/4*1.5,397/4*1.5)];
    
//    self.Base1.backgroundColor=[UIColor whiteColor];
    self.Base1.alpha=1;
//    self.Base2.backgroundColor=[UIColor whiteColor];
    self.Base2.alpha=1;
//    self.Base3.backgroundColor=[UIColor whiteColor];
    self.Base3.alpha=1;
    
    UILabel * label1=[[UILabel alloc] initWithFrame:CGRectMake(20, 10, 150, 20)];
    UILabel * label2=[[UILabel alloc] initWithFrame:CGRectMake(20, 10, 150, 20)];
    UILabel * label3=[[UILabel alloc] initWithFrame:CGRectMake(70, 10, 150, 20)];
    
    
    UILabel * label1D=[[UILabel alloc] initWithFrame:CGRectMake(20, 40, 150, 20)];
    UILabel * label2D=[[UILabel alloc] initWithFrame:CGRectMake(20, 40, 150, 20)];
    UILabel * label3D=[[UILabel alloc] initWithFrame:CGRectMake(70, 40, 150, 20)];
    
    if([self.infArr count]>=1){
        label1.text=self.infArr[0][@"title"];
        label1.font=[UIFont fontWithName:@"Arial-BoldItalicMT" size:16];
        NSString * cao = self.infArr[0][@"description"];
        if(cao == [NSNull null]){
            //cell.detailTextLabel.text=@"暂无描述";
        }else{
            label1D.text=cao;
        }
        label1D.font=[UIFont fontWithName:@"Arial-BoldItalicMT" size:12];
        label1D.textColor=RGB(128 ,128 ,105);
    }
    if([self.infArr count]>=2){
        label2.text=self.infArr[1][@"title"];
        label2.font=[UIFont fontWithName:@"Arial-BoldItalicMT" size:16];
        NSString * cao = self.infArr[1][@"description"];
        if(cao == [NSNull null]){
            //cell.detailTextLabel.text=@"暂无描述";
        }else{
            label2D.text=cao;
        }
        label2D.font=[UIFont fontWithName:@"Arial-BoldItalicMT" size:12];
        label2D.textColor=RGB(128 ,128 ,105);
    }
    if([self.infArr count]>=3){
        label3.text=self.infArr[2][@"title"];
        label3.font=[UIFont fontWithName:@"Arial-BoldItalicMT" size:16];
        NSString * cao = self.infArr[2][@"description"];
        if(cao == [NSNull null] ){
            //cell.detailTextLabel.text=@"暂无描述";
        }else{
            label3D.text=cao;
        }
        label3D.font=[UIFont fontWithName:@"Arial-BoldItalicMT" size:12];
        label3D.textColor=RGB(128 ,128 ,105);//[UIColor grayColor];
    }
    
    label1.textColor=[UIColor whiteColor];
    label2.textColor=[UIColor whiteColor];
    label3.textColor=[UIColor whiteColor];
    label1D.textColor=RGB(200,246,247);
    label2D.textColor=RGB(200,246,247);
    label3D.textColor=RGB(200,246,247);
    
    [self.Base1 setImage:[UIImage imageNamed:@"TrdXin1"]];
    [self.Base2 setImage:[UIImage imageNamed:@"TrdXin2"]];
    [self.Base3 setImage:[UIImage imageNamed:@"TrdXin3"]];
    
    [self.Base1 addSubview:label1];
    [self.Base2 addSubview:label2];
    [self.Base3 addSubview:label3];
    [self.Base1 addSubview:label1D];
    [self.Base2 addSubview:label2D];
    [self.Base3 addSubview:label3D];
    
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
    if([self.infArr count]>=1)
        [self.scrollView addSubview:self.Base1];
    if([self.infArr count]>=2)
        [self.scrollView addSubview:self.Base2];
    if([self.infArr count]>=3)
        [self.scrollView addSubview:self.Base3];
}
-(void) bthClick:(UITapGestureRecognizer *)tap
{
    if([self.infArr count]>=tap.view.tag){
    DetailView * svc = [[DetailView alloc] init];
        NSString * id = self.infArr[tap.view.tag-1][@"id"];
        svc.videoURL = self.infArr[tap.view.tag - 1][@"videoUrl"];
        svc.entryID=[NSNumber numberWithInt:[id intValue]];
        self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
        [self.navigationController pushViewController:svc animated:YES];
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

#pragma mark 返回每组行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (([self.infArr count]-3)>0)
        return [self.infArr count]-3;
    else
        return 0;
}

#pragma mark返回每行的单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    //cell.contentView.backgroundColor=[UIColor redColor];
    [cell.imageView setImage:[UIImage imageNamed:@"test"]];
    NSLog(@"%@",self.infArr);
    cell.textLabel.text=self.infArr[indexPath.row+3][@"title"];
    NSString * cao = self.infArr[indexPath.row+3][@"description"];
    if(cao == [NSNull null]){
        //cell.detailTextLabel.text=@"暂无描述";
    }else{
        cell.detailTextLabel.text=cao;
    }
    cell.imageView.alpha=1;
    cell.alpha=1;
    //cell.contentView.alpha=0;
    return cell;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

#pragma mark 返回每组头标题名称
//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    return @"dajiba";
//}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailView * svc = [[DetailView alloc] init];
    NSString * id = self.infArr[indexPath.row+3][@"id"];
    svc.entryID=[NSNumber numberWithInt:[id intValue]];
    self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
    [self.navigationController pushViewController:svc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImage *)clipImageInRect:(UIImage* ) img withRect:(CGRect)rect
{
    CGImageRef imageRef = CGImageCreateWithImageInRect([img CGImage], rect);
    UIImage *thumbScale = [UIImage imageWithCGImage:imageRef];
    　//® CGImageRelease(imageRef);
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
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    
//    return 0;
//}
-(void)setBar{
    UIBarButtonItem *barBtn3=[[UIBarButtonItem alloc] initWithTitle:@"更多 " style:UIBarButtonItemStyleDone target:self action:@selector(more:)];
    [self.navigationItem setRightBarButtonItem:barBtn3];
}

-(void)more:(UIBarButtonItem*)item{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle: nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"收藏该类别", @"我的收藏",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
}
-(void)favor:(UIBarButtonItem*)item{
    if([[NSUserDefaults standardUserDefaults] valueForKey:@"username"]){
        NSMutableDictionary * requestDic=[NSMutableDictionary new];
        requestDic[@"token"]=[[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
        if([self.isSub intValue]==0){
            requestDic[@"categoryID"]=self.categoryId;
        }else{
            requestDic[@"categorySubID"]=self.categoryId;
        }
        [HttpHelper get:[NSString stringWithFormat:@"%@%@",AppViewUrl,@"addIndividualCategory.action"] params:requestDic success:^(id responseObj) {
            NSLog(@"%@",responseObj);
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"感谢您的收藏" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
        } failure:^(NSError *error) {
            
        }];
    }else{
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"我的警告框" message:@"请先登录" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }
//    addIndividualCategory.action

}
-(void)doFavor{
    if([[NSUserDefaults standardUserDefaults] valueForKey:@"username"]){
        NSMutableDictionary * requestDic=[NSMutableDictionary new];
        requestDic[@"token"]=[[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
        if([self.isSub intValue]==0){
            requestDic[@"categoryID"]=self.categoryId;
        }else{
            requestDic[@"categorySubID"]=self.categoryId;
        }
        [HttpHelper get:[NSString stringWithFormat:@"%@%@",AppViewUrl,@"addIndividualCategory.action"] params:requestDic success:^(id responseObj) {
            NSLog(@"%@",responseObj);
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"感谢您的收藏" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
        } failure:^(NSError *error) {
            
        }];
    }else{
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"我的警告框" message:@"请先登录" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }
    //    addIndividualCategory.action
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self doFavor];
    }else if (buttonIndex == 1) {
        InterestVC * svc = [[InterestVC alloc] init];
        self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
        [self.navigationController pushViewController:svc animated:NO];
    }else {
        NSLog(@"3");
    } 
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
}

- (void)viewDidAppear:(BOOL)animated{
    //    self.navigationController.navigationBar.hidden=YES;
    //self.navigationController.view.alpha=0.5;
    
}
@end
