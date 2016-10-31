//
//  InterestVC.m
//  appViewer
//
//  Created by JuZhen on 16/6/29.
//  Copyright © 2016年 JuZhen. All rights reserved.
//
#import "ThirdLay.h"
#import "DetailView.h"
#import "InterestVC.h"
#include "head.h"
#import "HttpHelper.h"
@interface InterestVC()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UILabel * titile;
@property (nonatomic,strong) UITableView * likeTableView;
@property (nonatomic,strong) NSMutableArray * infArr;
@property (nonatomic,strong) NSMutableArray * infArrSingle;
@end
@implementation InterestVC
-(void)viewDidLoad{
    [super viewDidLoad];
    [self InitView];
}
-(void)InitView{
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.infArr = [NSMutableArray new];
    //self.view.backgroundColor=[UIColor whiteColor];
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [bgImgView setImage:[UIImage imageNamed:@"bg-1"]];
    [self.view addSubview:bgImgView];
    self.titile=[[UILabel alloc] initWithFrame:CGRectMake(100, 80, SCREEN_WIDTH-200, 40)];
    self.titile.text=@"我的关注";
    self.titile.textColor = RGB(39, 217, 179);
    self.titile.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:self.titile];
    self.likeTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 130, SCREEN_WIDTH, SCREEN_HEIGHT-100)];
    self.likeTableView.dataSource=self;
    self.likeTableView.delegate=self;
    self.likeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.likeTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.likeTableView];
    NSMutableDictionary * requestDic=[NSMutableDictionary new];
    requestDic[@"token"]=[[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    [HttpHelper get:[NSString stringWithFormat:@"%@%@",AppViewUrl,@"getFollowedCategories.action"] params:requestDic success:^(id responseObj) {
        NSLog(@"%@",responseObj);
        self.infArr = responseObj[@"result"];
        [self.likeTableView reloadData];
    } failure:^(NSError *error) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"网络错误" delegate:nil  cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }];
    [HttpHelper get:[NSString stringWithFormat:@"%@%@",AppViewUrl,@"getFollowedEntries.action"] params:requestDic success:^(id responseObj) {
        NSLog(@"%@",responseObj);
        self.infArrSingle = responseObj[@"result"];
        [self.likeTableView reloadData];
    } failure:^(NSError *error) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"网络错误" delegate:nil  cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 52;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 300, 40)];
    lab.textColor = RGB(39, 217, 179);
    if(section==0){
        lab.text = @"关注的类别";
    }else{
        lab.text = @"关注的app";
    }
    [view addSubview:lab];
    return view;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return [self.infArr count];
    }else{
        return [self.infArrSingle count];
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell=[[UITableViewCell alloc] init];
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 52)];
    img.image = [UIImage imageNamed:@"cellBg"];
    cell.backgroundColor = [UIColor clearColor];
    cell.backgroundView = img;
    cell.textLabel.textColor = RGB(155, 195, 192);
    if(indexPath.section==0){
        cell.text = [NSString stringWithFormat:@"   %@", self.infArr[indexPath.row][@"title"]];
    }else{
        cell.text = [NSString stringWithFormat:@"   %@", self.infArrSingle[indexPath.row][@"title"]];
    }
    return cell;
}
-(NSString*)tableView:(UITableView*)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath*)indexpath{
    return @"取消关注";
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    if (editingStyle==UITableViewCellEditingStyleDelete) {
            if(indexPath.section==0){
            NSMutableDictionary * requestDic=[NSMutableDictionary new];
            requestDic[@"token"]=[[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
            NSMutableDictionary * dic = self.infArr[indexPath.row];
            if ([dic objectForKey:@"categoryID"]) {
                requestDic[@"categoryID"]=dic[@"categoryID"];
            }else{
                requestDic[@"categorySubID"]=dic[@"categorySubID"];
            }
            [HttpHelper get:[NSString stringWithFormat:@"%@%@",AppViewUrl,@"getFollowedCategories.action"] params:requestDic success:^(id responseObj) {
                NSLog(@"%@",responseObj);
                self.infArr = responseObj[@"result"];
                [self.likeTableView reloadData];
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"取消关注成功" delegate:nil  cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alert show];
            } failure:^(NSError *error) {
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"网络错误" delegate:nil  cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alert show];
            }];
        }
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        ThirdLay * svc = [[ThirdLay alloc] init];
        NSMutableDictionary * dic = self.infArr[indexPath.row];
        if ([dic objectForKey:@"categoryID"]) {
            svc.categoryId=dic[@"categoryID"];
            svc.isSub=[NSNumber numberWithInt:0];
        }else{
            svc.categoryId=dic[@"categorySubID"];
            svc.isSub=[NSNumber numberWithInt:1];
        }
        self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
        [self.navigationController pushViewController:svc animated:NO];
    }else{
        DetailView * detailView = [[DetailView alloc] init];
        NSString * id = self.infArrSingle[indexPath.row][@"id"];
        detailView.entryID=[NSNumber numberWithInt:[id intValue]];
        self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
        [self.navigationController pushViewController:detailView animated:NO];
    }
}
@end
