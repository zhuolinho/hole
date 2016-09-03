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
@interface PersonViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIAlertViewDelegate>
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
    //[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];//[[UIBarButtonItem alloc] initWithTitle:@"Back" styleUIBarButtonItemStuleBorderd: target:nil action nil];(UIBarButtonItemStyle)    
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"mainBG"]];
//    self.floatView=[[UIImageView alloc] initWithFrame:CGRectMake(20, 70,  SCREEN_WIDTH-40, SCREEN_HEIGHT-90)];
//
//    self.floatView.backgroundColor=[UIColor grayColor];
//    self.floatView.layer.cornerRadius=40;
//    self.floatView.userInteractionEnabled=YES;
//    self.floatView.alpha=0.9;
//    [self.view addSubview:self.floatView];
    //self.view.backgroundColor=[UIColor whiteColor];
    [self InitTbl];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.PersonTbl reloadData];
}
-(void)InitTbl{
    PersonTbl = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    PersonTbl.alpha=0.9;
    PersonTbl.dataSource =self;
    PersonTbl.delegate=self;
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
        return 6;
}

#pragma mark返回每行的单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil   ];
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
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
        if(![[NSUserDefaults standardUserDefaults] valueForKey:@"username"]){
            self.username.text = @"点击登陆";
        }else{
            self.username.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
        }
        [cell.contentView addSubview:self.username];
        
    }
    if(indexPath.section == 1)
    {
        if(indexPath.row == 0){
            [cell.imageView setImage:[UIImage imageNamed:@"TrdXin1"]];
            cell.textLabel.text=@"更改个人信息";
            [cell.imageView setFrame:CGRectMake(5, 5,10, 10)];
            
            cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
            //cell.text = @"更改个人信息";
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
        if(indexPath.row == 1){
            [cell.imageView setImage:[UIImage imageNamed:@"TrdXin2"]];
            cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
            //cell.text = @"上传文件";
            cell.text=@"我的关注";
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
        if(indexPath.row == 3){
            [cell.imageView setImage:[UIImage imageNamed:@"TrdXin3"]];
            cell.text = @"关于软件提前看";
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
        
        if(indexPath.row == 2){
            [cell.imageView setImage:[UIImage imageNamed:@"TrdXin2"]];
            cell.text = @"设置中心";
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
        if(indexPath.row == 4){
            [cell.imageView setImage:[UIImage imageNamed:@"TrdXin1"]];
            cell.text = @"消息中心";
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
        if(indexPath.row == 5){
            [cell.imageView setImage:[UIImage imageNamed:@"TrdXin3"]];
            cell.text = @"退出登陆";
        }

    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section==0){
        return 150;
    }
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 1)
        return 30;
    else
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
        if(indexPath.row == 3){
            AboutVC * svc = [[AboutVC alloc] init];
            self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
            [self.navigationController pushViewController:svc animated:NO];
        }
        if(indexPath.row == 4){
            if([[NSUserDefaults standardUserDefaults] valueForKey:@"username"]){
                MessageCenter * svc = [[MessageCenter alloc] init];
                self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
                [self.navigationController pushViewController:svc animated:NO];
            }else{
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"我的警告框" message:@"请先登录" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alert show];
            }
        }
        if(indexPath.row == 5){
            if([[NSUserDefaults standardUserDefaults] valueForKey:@"username"]){
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"我的警告框" message:@"确定退出登录" delegate:self cancelButtonTitle: @"确定" otherButtonTitles:@"取消", nil];
                [alert setTag:1];
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
