//
//  SecondLay.m
//  appViewer
//
//  Created by JuZhen on 16/6/7.
//  Copyright © 2016年 JuZhen. All rights reserved.
//

#import "SecondLay.h"
#import "ThirdLay.h"
#import "head.h"
#include "HttpHelper.h"
#define Gap (SCREEN_WIDTH-100)/4
#define LENGTH_TOP (SCREEN_WIDTH - 60)
#define LENGTH_SUB (SCREEN_WIDTH - 140)
@interface SecondLay()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>{
    double angle;
    double radius;
    double centerX;
    double centerY;
}
@property(nonatomic,strong)UIView * additionView;
@property(nonatomic,strong)UITableView* tableView;
@property(nonatomic,strong)UICollectionView * collectionView;
@property(nonatomic,strong)UICollectionView * subCollectionView;

@property(nonatomic,strong)NSMutableArray * categoryArr;
@property(nonatomic,strong)NSMutableArray * subCategoryArr;

@property(nonatomic,strong)UIImageView * bgImgView;
@end
@implementation SecondLay
@synthesize bgImgView;
-(void) viewDidLoad{
    [super viewDidLoad];
    [self InitView];
}
-(void)viewDidDisappear:(BOOL)animated{
    [self RemoveSecondLayer];
}
-(void)InitView
{
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.alpha=0.4;
    self.categoryArr=[NSMutableArray new];
    self.subCategoryArr=[NSMutableArray new];
    //self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bgSec"]];
    bgImgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [bgImgView setImage:[UIImage imageNamed:@"bgSec"]];
    [self.view addSubview:bgImgView];
    self.additionView=[[UIView alloc] initWithFrame:self.view.bounds];
    NSString * url = [NSString stringWithFormat:@"%@%@",AppViewUrl,@"getCategories.action"];
    NSMutableDictionary * dic = [NSMutableDictionary new];
    dic[@"offset"]=[NSNumber numberWithInt:0];
    dic[@"limit"]=[NSNumber numberWithInt:100];
    dic[@"themeID"]=self.themeId;//[NSNumber numberWithInt:26];
    [HttpHelper get:url params:dic success:^(id responseObj){
        self.categoryArr=responseObj[@"result"];
        [self InitFirstCollectionView];
        [self.collectionView reloadData];
        NSLog(@"%@",self.categoryArr);
    } fail:^(AFHTTPRequestOperation *operation) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"网络错误" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }];
}
-(void)InitFirstCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    if([self.categoryArr count]<=2)
    {
        layout.minimumInteritemSpacing = 5;
        layout.minimumLineSpacing = 30;
        int gayW=50;
        int h1 = 150;
        int h2 = SCREEN_WIDTH + 50;
        UIImageView * cor1=[[UIImageView alloc] initWithFrame:CGRectMake(gayW-15, h1-15, 15 , 15)];
        UIImageView * cor2=[[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-gayW, h1-15, 15 , 15)];
        UIImageView * cor3=[[UIImageView alloc] initWithFrame:CGRectMake(gayW-15, h2, 15 , 15)];
        UIImageView * cor4=[[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-gayW, h2, 15 , 15)];
        [cor1 setImage:[UIImage imageNamed:@"cor1"]];
        [cor2 setImage:[UIImage imageNamed:@"cor2"]];
        [cor3 setImage:[UIImage imageNamed:@"cor3"]];
        [cor4 setImage:[UIImage imageNamed:@"cor4"]];
        [cor1 setTag:2];[cor2 setTag:2];[cor3 setTag:2];[cor4 setTag:2];
        [self.view addSubview:cor1];
        [self.view addSubview:cor2];
        [self.view addSubview:cor3];
        [self.view addSubview:cor4];
        self.collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(50, 150, SCREEN_WIDTH - 100 , SCREEN_WIDTH-100)  collectionViewLayout:layout];
    }
    else if([self.categoryArr count]==3)
    {
        layout.minimumInteritemSpacing = 3;
        layout.minimumLineSpacing = 20;
        int gayW=50;
        int h1 = 120;
        int h2 = SCREEN_WIDTH + 70;
        UIImageView * cor1=[[UIImageView alloc] initWithFrame:CGRectMake(gayW-15, h1-15, 15 , 15)];
        UIImageView * cor2=[[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-gayW, h1-15, 15 , 15)];
        UIImageView * cor3=[[UIImageView alloc] initWithFrame:CGRectMake(gayW-15, h2, 15 , 15)];
        UIImageView * cor4=[[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-gayW, h2, 15 , 15)];
        [cor1 setImage:[UIImage imageNamed:@"cor1"]];
        [cor2 setImage:[UIImage imageNamed:@"cor2"]];
        [cor3 setImage:[UIImage imageNamed:@"cor3"]];
        [cor4 setImage:[UIImage imageNamed:@"cor4"]];
        [cor1 setTag:2];[cor2 setTag:2];[cor3 setTag:2];[cor4 setTag:2];
        [self.view addSubview:cor1];
        [self.view addSubview:cor2];
        [self.view addSubview:cor3];
        [self.view addSubview:cor4];
        
        layout.minimumInteritemSpacing = 5;
        layout.minimumLineSpacing = 25;
        self.collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(50, 120, SCREEN_WIDTH - 100 , SCREEN_WIDTH - 50 )  collectionViewLayout:layout];

    }
    else if([self.categoryArr count]==4)
    {
        layout.minimumInteritemSpacing = 3;
        layout.minimumLineSpacing = 20;
        int gayW=50;
        int h1 = 100;
        int h2 = SCREEN_WIDTH + 98;
        UIImageView * cor1=[[UIImageView alloc] initWithFrame:CGRectMake(gayW-15, h1-15, 15 , 15)];
        UIImageView * cor2=[[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-gayW, h1-15, 15 , 15)];
        UIImageView * cor3=[[UIImageView alloc] initWithFrame:CGRectMake(gayW-15, h2, 15 , 15)];
        UIImageView * cor4=[[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-gayW, h2, 15 , 15)];
        [cor1 setImage:[UIImage imageNamed:@"cor1"]];
        [cor2 setImage:[UIImage imageNamed:@"cor2"]];
        [cor3 setImage:[UIImage imageNamed:@"cor3"]];
        [cor4 setImage:[UIImage imageNamed:@"cor4"]];
        [cor1 setTag:2];[cor2 setTag:2];[cor3 setTag:2];[cor4 setTag:2];
        [self.view addSubview:cor1];
        [self.view addSubview:cor2];
        [self.view addSubview:cor3];
        [self.view addSubview:cor4];
        layout.minimumInteritemSpacing = 5;
        layout.minimumLineSpacing = 20;
        self.collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(50, 100, SCREEN_WIDTH - 100 , SCREEN_WIDTH-2  )  collectionViewLayout:layout];
        
    }
    else if([self.categoryArr count]==5)
    {
        layout.minimumInteritemSpacing = 5;
        layout.minimumLineSpacing = 15;
        int gayW=50;
        int h1 = 90;
        int h2 = SCREEN_WIDTH + 130;
        UIImageView * cor1=[[UIImageView alloc] initWithFrame:CGRectMake(gayW-15, h1-15, 15 , 15)];
        UIImageView * cor2=[[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-gayW, h1-15, 15 , 15)];
        UIImageView * cor3=[[UIImageView alloc] initWithFrame:CGRectMake(gayW-15, h2, 15 , 15)];
        UIImageView * cor4=[[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-gayW, h2, 15 , 15)];
        [cor1 setImage:[UIImage imageNamed:@"cor1"]];
        [cor2 setImage:[UIImage imageNamed:@"cor2"]];
        [cor3 setImage:[UIImage imageNamed:@"cor3"]];
        [cor4 setImage:[UIImage imageNamed:@"cor4"]];
        [cor1 setTag:2];[cor2 setTag:2];[cor3 setTag:2];[cor4 setTag:2];
        [self.view addSubview:cor1];
        [self.view addSubview:cor2];
        [self.view addSubview:cor3];
        [self.view addSubview:cor4];
        self.collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(50, 90, SCREEN_WIDTH - 100 , SCREEN_WIDTH+40 )  collectionViewLayout:layout];
        
    }
    else if([self.categoryArr count]==6)
    {
        layout.minimumInteritemSpacing = 5;
        layout.minimumLineSpacing = 15;
        int gayW=50;
        int h1 = 85;
        int h2 = SCREEN_WIDTH + 175;
        UIImageView * cor1=[[UIImageView alloc] initWithFrame:CGRectMake(gayW-15, h1-15, 15 , 15)];
        UIImageView * cor2=[[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-gayW, h1-15, 15 , 15)];
        UIImageView * cor3=[[UIImageView alloc] initWithFrame:CGRectMake(gayW-15, h2, 15 , 15)];
        UIImageView * cor4=[[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-gayW, h2, 15 , 15)];
        [cor1 setImage:[UIImage imageNamed:@"cor1"]];
        [cor2 setImage:[UIImage imageNamed:@"cor2"]];
        [cor3 setImage:[UIImage imageNamed:@"cor3"]];
        [cor4 setImage:[UIImage imageNamed:@"cor4"]];
        [cor1 setTag:2];[cor2 setTag:2];[cor3 setTag:2];[cor4 setTag:2];
        [self.view addSubview:cor1];
        [self.view addSubview:cor2];
        [self.view addSubview:cor3];
        [self.view addSubview:cor4];
        self.collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(50, 85, SCREEN_WIDTH - 100 , SCREEN_WIDTH+90 )  collectionViewLayout:layout];
    }
    else
    {
        layout.minimumInteritemSpacing = 3;
        layout.minimumLineSpacing = 15;
        int gayW=30;
        int h1 = 160;
        int h2 = SCREEN_WIDTH + 80;
        UIImageView * cor1=[[UIImageView alloc] initWithFrame:CGRectMake(gayW-15, h1-15, 15 , 15)];
        UIImageView * cor2=[[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-gayW, h1-15, 15 , 15)];
        UIImageView * cor3=[[UIImageView alloc] initWithFrame:CGRectMake(gayW-15, h2, 15 , 15)];
        UIImageView * cor4=[[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-gayW, h2, 15 , 15)];
        [cor1 setImage:[UIImage imageNamed:@"cor1"]];
        [cor2 setImage:[UIImage imageNamed:@"cor2"]];
        [cor3 setImage:[UIImage imageNamed:@"cor3"]];
        [cor4 setImage:[UIImage imageNamed:@"cor4"]];
        [cor1 setTag:2];[cor2 setTag:2];[cor3 setTag:2];[cor4 setTag:2];
        [self.view addSubview:cor1];
        [self.view addSubview:cor2];
        [self.view addSubview:cor3];
        [self.view addSubview:cor4];
        self.collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(30, 180, SCREEN_WIDTH - 60 , SCREEN_WIDTH - 85)  collectionViewLayout:layout];
    }
    self.collectionView.backgroundColor=[UIColor clearColor];
    self.collectionView.tag=1;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.collectionView.alpha=1.0;
    self.collectionView.layer.cornerRadius=10;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"myCell"];
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
    [self.view addSubview:self.collectionView];
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(collectionView.tag == 1){
        return [self.categoryArr count];
    }else{
        return [self.subCategoryArr count];
    }
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"myCell";
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    UILabel * label;
    label.textAlignment=NSTextAlignmentCenter;
    if(collectionView.tag==1)
    {
        if([self.categoryArr count] <= 2)
        {
            int h=(SCREEN_WIDTH-150)/2;
            label = [[UILabel alloc] initWithFrame:CGRectMake(10, h*0.5 - 28, (SCREEN_WIDTH - 110)-20 , 50)];
            label.font=[UIFont fontWithName:@"STXinwei" size:32];
            label.textColor=[UIColor whiteColor];
        }
        else if([self.categoryArr count] == 3)
        {
            int h=(SCREEN_WIDTH-200)/2;
            label = [[UILabel alloc] initWithFrame:CGRectMake(10, h*0.5 - 28, (SCREEN_WIDTH - 110)-20 , 50)];
            label.font=[UIFont fontWithName:@"STXinwei" size:32];
            label.textColor=[UIColor whiteColor];
        }
        else if([self.categoryArr count] == 4)
        {
            int h=(SCREEN_WIDTH-231)/2;
            label = [[UILabel alloc] initWithFrame:CGRectMake(10, h*0.5 - 28, (SCREEN_WIDTH - 110)-20 , 50)];
            label.font=[UIFont fontWithName:@"STXinwei" size:32];
            label.textColor=[UIColor whiteColor];
        }
        else if([self.categoryArr count] == 5)
        {
            int h=(SCREEN_WIDTH-240)/2;
            label = [[UILabel alloc] initWithFrame:CGRectMake(10, h*0.5 - 28, (SCREEN_WIDTH - 110)-20 , 50)];
            label.font=[UIFont fontWithName:@"STXinwei" size:32];
            label.textColor=[UIColor whiteColor];
        }
        else if([self.categoryArr count] == 6)
        {
            int h=(SCREEN_WIDTH-248)/2;
            label = [[UILabel alloc] initWithFrame:CGRectMake(10, h*0.5 - 28, (SCREEN_WIDTH - 110)-20 , 50)];
            label.font=[UIFont fontWithName:@"STXinwei" size:32];
            label.textColor=[UIColor whiteColor];
        }
        else
        {
            label = [[UILabel alloc] initWithFrame:CGRectMake(10, (SCREEN_WIDTH - 60-60)/6 - 23, (SCREEN_WIDTH - 60-25)/3 - 20, 40)];
            label.font=[UIFont fontWithName:@"STXinwei" size:18];
            label.textColor=[UIColor whiteColor];
        }
        label.text=self.categoryArr[indexPath.row][@"title"];
        label.textAlignment=NSTextAlignmentCenter;
    }
    else
    {
        if([self.subCategoryArr count] <= 2)
        {
            int h=(SCREEN_WIDTH-150)/2;
            label = [[UILabel alloc] initWithFrame:CGRectMake(10, h*0.5 - 28, (SCREEN_WIDTH - 110)-20 , 50)];
            label.font=[UIFont fontWithName:@"STXinwei" size:32];
            label.textColor=[UIColor whiteColor];
        }
        else if([self.subCategoryArr count] == 3)
        {
            int h=(SCREEN_WIDTH-200)/2;
            label = [[UILabel alloc] initWithFrame:CGRectMake(10, h*0.5 - 28, (SCREEN_WIDTH - 110)-20 , 50)];
            label.font=[UIFont fontWithName:@"STXinwei" size:32];
            label.textColor=[UIColor whiteColor];
        }
        else if([self.subCategoryArr count] == 4)
        {
            int h=(SCREEN_WIDTH-231)/2;
            label = [[UILabel alloc] initWithFrame:CGRectMake(10, h*0.5 - 28, (SCREEN_WIDTH - 110)-20 , 50)];
            label.font=[UIFont fontWithName:@"STXinwei" size:32];
            label.textColor=[UIColor whiteColor];
        }
        else if([self.subCategoryArr count] == 5)
        {
            int h=(SCREEN_WIDTH-240)/2;
            label = [[UILabel alloc] initWithFrame:CGRectMake(10, h*0.5 - 28, (SCREEN_WIDTH - 110)-20 , 50)];
            label.font=[UIFont fontWithName:@"STXinwei" size:32];
            label.textColor=[UIColor whiteColor];
        }
        else if([self.subCategoryArr count] == 6)
        {
            int h=(SCREEN_WIDTH-248)/2;
            label = [[UILabel alloc] initWithFrame:CGRectMake(10, h*0.5 - 28, (SCREEN_WIDTH - 110)-20 , 50)];
            label.font=[UIFont fontWithName:@"STXinwei" size:32];
            label.textColor=[UIColor whiteColor];
        }
        else
        {
            label = [[UILabel alloc] initWithFrame:CGRectMake(10, (SCREEN_WIDTH - 60-60)/6 - 23, (SCREEN_WIDTH - 60-25)/3 - 20, 40)];
            label.font=[UIFont fontWithName:@"STXinwei" size:18];
            label.textColor=[UIColor whiteColor];
        }
        label.text=self.subCategoryArr[indexPath.row][@"title"];
        label.textAlignment=NSTextAlignmentCenter;
    }
    UIImageView* bgImageView = [[UIImageView alloc] initWithFrame:cell.bounds];
    [bgImageView setImage:[UIImage imageNamed:@"BtnLight"]];
    for (id subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    [cell.contentView addSubview:bgImageView];
    [cell.contentView addSubview:label];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(collectionView.tag == 1){
        if([self.categoryArr count] == 2)
        {
            return CGSizeMake((SCREEN_WIDTH - 100-10), (SCREEN_WIDTH-150)/2);
        }
        else if([self.categoryArr count] == 3)
        {
            return CGSizeMake((SCREEN_WIDTH - 100-10), (SCREEN_WIDTH-200)/2);
        }
        else if([self.categoryArr count] == 4)
        {
            return CGSizeMake((SCREEN_WIDTH - 100-10), (SCREEN_WIDTH-231)/2);
        }
        else if([self.categoryArr count] == 5)
        {
            return CGSizeMake((SCREEN_WIDTH - 100-10), (SCREEN_WIDTH-240)/2);
        }
        else if([self.categoryArr count] == 6)
        {
            return CGSizeMake((SCREEN_WIDTH - 100-10), (SCREEN_WIDTH-248)/2);
        }
        else
        {
            //return CGSizeMake((SCREEN_WIDTH - 60-25)/3, (SCREEN_WIDTH - 35)/4);
            return CGSizeMake((SCREEN_WIDTH - 60-25)/3, (SCREEN_WIDTH - 60-60)/3);
        }
    }
    else{
        if([self.subCategoryArr count] == 2)
        {
            return CGSizeMake((SCREEN_WIDTH - 100-10), (SCREEN_WIDTH-150)/2);
        }
        else if([self.subCategoryArr count] == 3)
        {
            return CGSizeMake((SCREEN_WIDTH - 100-10), (SCREEN_WIDTH-200)/2);
        }
        else if([self.subCategoryArr count] == 4)
        {
            return CGSizeMake((SCREEN_WIDTH - 100-10), (SCREEN_WIDTH-231)/2);
        }
        else if([self.subCategoryArr count] == 5)
        {
            return CGSizeMake((SCREEN_WIDTH - 100-10), (SCREEN_WIDTH-240)/2);
        }
        else if([self.subCategoryArr count] == 6)
        {
            return CGSizeMake((SCREEN_WIDTH - 100-10), (SCREEN_WIDTH-248)/2);
        }
        else
        {
            //return CGSizeMake((SCREEN_WIDTH - 60-25)/3, (SCREEN_WIDTH - 35)/4);
            return CGSizeMake((SCREEN_WIDTH - 60-25)/3, (SCREEN_WIDTH - 60-60)/3);
        }
    }
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(collectionView.tag == 1){
        UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        NSLog(@"%@",self.categoryArr[indexPath.row][@"ifExistSub"]);
        NSString *number = self.categoryArr[indexPath.row][@"ifExistSub"];
        BOOL q =([number intValue]==1) ;
        if(q){
            self.subCategoryArr=[NSMutableArray new];
            NSString * url = [NSString stringWithFormat:@"%@%@",AppViewUrl,@"getCategorySubs.action"];
            NSMutableDictionary * dic = [NSMutableDictionary new];
            dic[@"offset"]=[NSNumber numberWithInt:0];
            dic[@"limit"]=[NSNumber numberWithInt:100];
            dic[@"categoryID"]=self.categoryArr[indexPath.row][@"id"];
            [HttpHelper get:url params:dic success:^(id responseObj) {
                self.subCategoryArr=responseObj[@"result"];
                [self AddSecondLayer];
                [self.subCollectionView reloadData];
            } fail:^(AFHTTPRequestOperation *operation) {
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"网络错误" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alert show];
            }];
        }else{
            ThirdLay * svc = [[ThirdLay alloc] init];
            NSString *  q = self.categoryArr[indexPath.row][@"id"];
            svc.categoryId=[NSNumber numberWithInt:[q intValue]];
            svc.isSub=[NSNumber numberWithInt:0];
            self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
            [self.navigationController pushViewController:svc animated:YES];
        }
    }
    else{
        ThirdLay * svc = [[ThirdLay alloc] init];
        NSString *  q = self.subCategoryArr[indexPath.row][@"id"];
        svc.categoryId=[NSNumber numberWithInt:[q intValue]];
        svc.isSub=[NSNumber numberWithInt:1];
        self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
        [self.navigationController pushViewController:svc animated:YES];
    }
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(void) AddSecondLayer{
    [self.view addSubview:self.additionView];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    if([self.subCategoryArr count]<=2)
    {
        layout.minimumInteritemSpacing = 5;
        layout.minimumLineSpacing = 30;
        int gayW=50;
        int h1 = 150;
        int h2 = SCREEN_WIDTH + 50;
        UIImageView * cor1=[[UIImageView alloc] initWithFrame:CGRectMake(gayW-15, h1-15, 15 , 15)];
        UIImageView * cor2=[[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-gayW, h1-15, 15 , 15)];
        UIImageView * cor3=[[UIImageView alloc] initWithFrame:CGRectMake(gayW-15, h2, 15 , 15)];
        UIImageView * cor4=[[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-gayW, h2, 15 , 15)];
        [cor1 setImage:[UIImage imageNamed:@"cor1"]];
        [cor2 setImage:[UIImage imageNamed:@"cor2"]];
        [cor3 setImage:[UIImage imageNamed:@"cor3"]];
        [cor4 setImage:[UIImage imageNamed:@"cor4"]];
        [self.additionView addSubview:cor1];
        [self.additionView addSubview:cor2];
        [self.additionView addSubview:cor3];
        [self.additionView addSubview:cor4];
        self.subCollectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(50, 150, SCREEN_WIDTH - 100 , SCREEN_WIDTH-100)  collectionViewLayout:layout];
    }
    else if([self.subCategoryArr count]==3)
    {
        layout.minimumInteritemSpacing = 5;
        layout.minimumLineSpacing = 25;
        int gayW=50;
        int h1 = 120;
        int h2 = SCREEN_WIDTH + 70;
        UIImageView * cor1=[[UIImageView alloc] initWithFrame:CGRectMake(gayW-15, h1-15, 15 , 15)];
        UIImageView * cor2=[[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-gayW, h1-15, 15 , 15)];
        UIImageView * cor3=[[UIImageView alloc] initWithFrame:CGRectMake(gayW-15, h2, 15 , 15)];
        UIImageView * cor4=[[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-gayW, h2, 15 , 15)];
        [cor1 setImage:[UIImage imageNamed:@"cor1"]];
        [cor2 setImage:[UIImage imageNamed:@"cor2"]];
        [cor3 setImage:[UIImage imageNamed:@"cor3"]];
        [cor4 setImage:[UIImage imageNamed:@"cor4"]];
        [self.additionView addSubview:cor1];
        [self.additionView addSubview:cor2];
        [self.additionView addSubview:cor3];
        [self.additionView addSubview:cor4];
        self.subCollectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(50, 120, SCREEN_WIDTH - 100 , SCREEN_WIDTH - 50 )  collectionViewLayout:layout];
        
    }
    else if([self.subCategoryArr count]==4)
    {
        layout.minimumInteritemSpacing = 5;
        layout.minimumLineSpacing = 20;
        int gayW=50;
        int h1 = 100;
        int h2 = SCREEN_WIDTH + 98;
        UIImageView * cor1=[[UIImageView alloc] initWithFrame:CGRectMake(gayW-15, h1-15, 15 , 15)];
        UIImageView * cor2=[[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-gayW, h1-15, 15 , 15)];
        UIImageView * cor3=[[UIImageView alloc] initWithFrame:CGRectMake(gayW-15, h2, 15 , 15)];
        UIImageView * cor4=[[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-gayW, h2, 15 , 15)];
        [cor1 setImage:[UIImage imageNamed:@"cor1"]];
        [cor2 setImage:[UIImage imageNamed:@"cor2"]];
        [cor3 setImage:[UIImage imageNamed:@"cor3"]];
        [cor4 setImage:[UIImage imageNamed:@"cor4"]];
        [self.additionView addSubview:cor1];
        [self.additionView addSubview:cor2];
        [self.additionView addSubview:cor3];
        [self.additionView addSubview:cor4];
        self.subCollectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(50, 100, SCREEN_WIDTH - 100 , SCREEN_WIDTH-2  )  collectionViewLayout:layout];
        
    }
    else if([self.subCategoryArr count]==5)
    {
        layout.minimumInteritemSpacing = 5;
        layout.minimumLineSpacing = 15;
        int gayW=50;
        int h1 = 90;
        int h2 = SCREEN_WIDTH + 130;
        UIImageView * cor1=[[UIImageView alloc] initWithFrame:CGRectMake(gayW-15, h1-15, 15 , 15)];
        UIImageView * cor2=[[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-gayW, h1-15, 15 , 15)];
        UIImageView * cor3=[[UIImageView alloc] initWithFrame:CGRectMake(gayW-15, h2, 15 , 15)];
        UIImageView * cor4=[[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-gayW, h2, 15 , 15)];
        [cor1 setImage:[UIImage imageNamed:@"cor1"]];
        [cor2 setImage:[UIImage imageNamed:@"cor2"]];
        [cor3 setImage:[UIImage imageNamed:@"cor3"]];
        [cor4 setImage:[UIImage imageNamed:@"cor4"]];
        [self.additionView addSubview:cor1];
        [self.additionView addSubview:cor2];
        [self.additionView addSubview:cor3];
        [self.additionView addSubview:cor4];
        self.subCollectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(50, 90, SCREEN_WIDTH - 100 , SCREEN_WIDTH+40 )  collectionViewLayout:layout];
        
    }
    else if([self.subCategoryArr count]==6)
    {
        layout.minimumInteritemSpacing = 5;
        layout.minimumLineSpacing = 15;
        int gayW=50;
        int h1 = 85;
        int h2 = SCREEN_WIDTH + 175;
        UIImageView * cor1=[[UIImageView alloc] initWithFrame:CGRectMake(gayW-15, h1-15, 15 , 15)];
        UIImageView * cor2=[[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-gayW, h1-15, 15 , 15)];
        UIImageView * cor3=[[UIImageView alloc] initWithFrame:CGRectMake(gayW-15, h2, 15 , 15)];
        UIImageView * cor4=[[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-gayW, h2, 15 , 15)];
        [cor1 setImage:[UIImage imageNamed:@"cor1"]];
        [cor2 setImage:[UIImage imageNamed:@"cor2"]];
        [cor3 setImage:[UIImage imageNamed:@"cor3"]];
        [cor4 setImage:[UIImage imageNamed:@"cor4"]];
        [self.additionView addSubview:cor1];
        [self.additionView addSubview:cor2];
        [self.additionView addSubview:cor3];
        [self.additionView addSubview:cor4];
        self.subCollectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(50, 85, SCREEN_WIDTH - 100 , SCREEN_WIDTH+90 )  collectionViewLayout:layout];
    }
    else
    {
        layout.minimumInteritemSpacing = 3;
        layout.minimumLineSpacing = 15;
        int gayW=30;
        int h1 = 160;
        int h2 = SCREEN_WIDTH + 80;
        UIImageView * cor1=[[UIImageView alloc] initWithFrame:CGRectMake(gayW-15, h1-15, 15 , 15)];
        UIImageView * cor2=[[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-gayW, h1-15, 15 , 15)];
        UIImageView * cor3=[[UIImageView alloc] initWithFrame:CGRectMake(gayW-15, h2, 15 , 15)];
        UIImageView * cor4=[[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-gayW, h2, 15 , 15)];
        [cor1 setImage:[UIImage imageNamed:@"cor1"]];
        [cor2 setImage:[UIImage imageNamed:@"cor2"]];
        [cor3 setImage:[UIImage imageNamed:@"cor3"]];
        [cor4 setImage:[UIImage imageNamed:@"cor4"]];
        [self.additionView addSubview:cor1];
        [self.additionView addSubview:cor2];
        [self.additionView addSubview:cor3];
        [self.additionView addSubview:cor4];
        self.subCollectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(30, 180, SCREEN_WIDTH - 60 , SCREEN_WIDTH - 85)  collectionViewLayout:layout];
    }
    //self.subCollectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(70, 200, SCREEN_WIDTH - 140 , SCREEN_WIDTH - 80)  collectionViewLayout:layout];
    self.subCollectionView.tag=2;

    self.subCollectionView.alpha=1.0;
    self.subCollectionView.backgroundColor=[UIColor clearColor];
    //self.subCollectionView.layer.cornerRadius=20;
    [self.subCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"myCell"];
    self.subCollectionView.delegate=self;
    self.subCollectionView.dataSource=self;
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    self.collectionView.alpha=0;
    for(UIView * view in [self.view subviews])
    {
        if(view.tag==2)
            view.alpha=0;
    }
//    self.bgImgView.alpha=1;
    [self.additionView addSubview:self.subCollectionView];
    [UIView commitAnimations];
}
-(void) RemoveSecondLayer{
    [self.additionView removeFromSuperview];
    [self.subCollectionView removeFromSuperview];
    for(UIView *view in [self.additionView subviews])
    {
        [view removeFromSuperview];
        //[view removefromsuperview];
    }
    for(UIView * view in [self.view subviews])
    {
        if(view.tag==2)
            view.alpha=1;
    }
    self.collectionView.alpha=1.0;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self RemoveSecondLayer];
}
@end
