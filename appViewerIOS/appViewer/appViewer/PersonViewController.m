//
//  PersonViewController.m
//  appViewer
//
//  Created by JuZhen on 16/6/3.
//  Copyright © 2016年 JuZhen. All rights reserved.
//

#import "PersonViewController.h"
#import "UploadVC.h"
#import "head.h"
#import "LoginVC.h"
#include "RegisterVC.h"
#import "AboutVC.h"
#import "PersonDetail.h"
#import "KxMovieViewController.h"
#import "InterestVC.h"
#import "MessageCenter.h"
#include "personSetting.h"
#import "API.h"
#import "ForumViewController.h"
@interface PersonViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIAlertViewDelegate, APIProtocol> {
    API *myAPI;
}
@property (nonatomic, strong) UITableView * PersonTbl;
@property (nonatomic, strong) UIImageView *avaterImg;
@property (nonatomic, strong) UILabel * username;
@property (nonatomic, strong) UIImageView * floatView;
@end

@implementation PersonViewController
@synthesize PersonTbl;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=NO;
    self.title = @"个人中心";
    //[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];//[[UIBarButtonItem alloc] initWithTitle:@"Back" styleUIBarButtonItemStuleBorderd: target:nil action nil];(UIBarButtonItemStyle)    
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [bgImgView setImage:[UIImage imageNamed:@"bg-1"]];
    [self.view addSubview:bgImgView];
//    self.floatView=[[UIImageView alloc] initWithFrame:CGRectMake(20, 70,  SCREEN_WIDTH-40, SCREEN_HEIGHT-90)];
//
//    self.floatView.backgroundColor=[UIColor grayColor];
//    self.floatView.layer.cornerRadius=40;
//    self.floatView.userInteractionEnabled=YES;
//    self.floatView.alpha=0.9;
//    [self.view addSubview:self.floatView];
    //self.view.backgroundColor=[UIColor whiteColor];
    [self InitTbl];
    myAPI = [[API alloc]init];
    myAPI.delegate = self;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.PersonTbl reloadData];
}
-(void)InitTbl{
    PersonTbl = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64) style:UITableViewStyleGrouped];
    PersonTbl.dataSource =self;
    PersonTbl.delegate=self;
    PersonTbl.backgroundColor = [UIColor clearColor];
    PersonTbl.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:PersonTbl];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

#pragma mark 返回每组行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0)
        return 1;
    else
        return 7;
}

#pragma mark返回每行的单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil   ];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if(indexPath.section == 0)
    {
         self.avaterImg = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 100)/2, 20, 100, 100)];
        self.avaterImg.layer.masksToBounds=YES;
        self.avaterImg.layer.cornerRadius=50;
        UITapGestureRecognizer * singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(LoginOrReg:)];
        self.avaterImg.userInteractionEnabled=YES;
        [self.avaterImg addGestureRecognizer:singleTap];
        [self.avaterImg setImage:[UIImage imageNamed:@"avater"]];
        [cell.contentView addSubview:self.avaterImg];
        
        
        
        self.username = [[UILabel alloc] initWithFrame:CGRectMake(10, 125, SCREEN_WIDTH - 20, 20)];
        self.username.textAlignment = NSTextAlignmentCenter;
        self.username.textColor = [UIColor colorWithRed:155 / 255.0 green:195 / 255.0 blue:192 / 255.0 alpha:1];
        if(![[NSUserDefaults standardUserDefaults] valueForKey:@"username"]){
            self.username.text = @"点击登陆";
        }else{
            self.username.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
        }
        [cell.contentView addSubview:self.username];
        
    }
    if(indexPath.section == 1)
    {
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 52)];
        img.image = [UIImage imageNamed:@"cellBg"];
        cell.backgroundView = img;
        cell.textLabel.textColor = [UIColor colorWithRed:155 / 255.0 green:195 / 255.0 blue:192 / 255.0 alpha:1];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        if(indexPath.row == 0){
            cell.textLabel.text=@"   更改个人信息";
        }
        if(indexPath.row == 1){
            cell.textLabel.text=@"   我的关注";
        }
        if(indexPath.row == 4){
            cell.textLabel.text = @"   关于软件提前看";
        }
        if(indexPath.row == 2){
            cell.textLabel.text = @"   设置中心";
        }
        if(indexPath.row == 5){
            cell.textLabel.text = @"   消息中心";
        }
        if(indexPath.row == 6){
            cell.textLabel.text = @"   退出登陆";
        }
        if (indexPath.row == 3) {
            cell.textLabel.text = @"   论坛";
        }

    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section==0){
        return 150;
    }
    return 52;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
#pragma mark 返回每组头标题名称
//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    return @"dajiba";
//}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
//    if(indexPath.section == 0)
//    {
//        [self test];
//    }
    if(indexPath.section == 1)
    {
        if(indexPath.row == 0){
            if([[NSUserDefaults standardUserDefaults] valueForKey:@"username"]){
                PersonDetail * svc = [[PersonDetail alloc] init];
                self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
                [self.navigationController pushViewController:svc animated:NO];
            }else{
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"我的警告框" message:@"请先登录" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alert show];
            }
        }
        if(indexPath.row == 2){
            personSetting * svc = [[personSetting alloc] init];
            self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
            [self.navigationController pushViewController:svc animated:NO];
        }
        if(indexPath.row == 1){
            if([[NSUserDefaults standardUserDefaults] valueForKey:@"username"]){
                InterestVC * svc = [[InterestVC alloc] init];
                self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
                [self.navigationController pushViewController:svc animated:NO];
            }else{
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"我的警告框" message:@"请先登录" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alert show];
            }

        }
        if(indexPath.row == 4){
            AboutVC * svc = [[AboutVC alloc] init];
            self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
            [self.navigationController pushViewController:svc animated:NO];
        }
        if(indexPath.row == 5){
            if([[NSUserDefaults standardUserDefaults] valueForKey:@"username"]){
                MessageCenter * svc = [[MessageCenter alloc] init];
                self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
                [self.navigationController pushViewController:svc animated:NO];
            }else{
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"我的警告框" message:@"请先登录" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alert show];
            }
        }
        if(indexPath.row == 6){
            if([[NSUserDefaults standardUserDefaults] valueForKey:@"username"]){
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"我的警告框" message:@"确定退出登录" delegate:self cancelButtonTitle: @"确定" otherButtonTitles:@"取消", nil];
                [alert setTag:1];
                [alert show];
            }
        }
        if (indexPath.row == 3) {
            if([[NSUserDefaults standardUserDefaults] valueForKey:@"username"]){
                [myAPI getTheme];
            }else{
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"我的警告框" message:@"请先登录" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alert show];
            }
        }
    }
}
-(void) test{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:@"确定"
                                  otherButtonTitles:@"第一项", @"第二项",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
}
-(void) LoginOrReg:(UITapGestureRecognizer *)tap{
    if(![[NSUserDefaults standardUserDefaults] valueForKey:@"username"]){
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"登陆", @"注册",nil];
        actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
        [actionSheet showInView:self.view];
    }
}
 -(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        LoginVC * svc = [[LoginVC alloc] init];
        self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
        
        [self.navigationController pushViewController:svc animated:NO];
    }else if (buttonIndex == 1) {
        RegisterVC * svc = [[RegisterVC alloc] init];
        self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
        
        [self.navigationController pushViewController:svc animated:NO];
    }
    
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    NSLog(@"%ld",(long)buttonIndex);
    if((long)buttonIndex == 0&&alertView.tag==1){
        if([[NSUserDefaults standardUserDefaults] valueForKey:@"username"])
        {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"username"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"uid"];
            [PersonTbl reloadData];
        }
        
    }
}
//
#pragma mark 返回每组尾部说明
//-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
//    return @"dajiba";
//}

- (void)didReceiveAPIResponseOf:(API *)api data:(NSDictionary *)data {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ForumViewController *vc = [sb instantiateViewControllerWithIdentifier:@"ForumViewController"];
    vc.data = data[@"result"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveAPIErrorOf:(API *)api data:(long)errorNo {
    NSLog(@"%ld", errorNo);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
