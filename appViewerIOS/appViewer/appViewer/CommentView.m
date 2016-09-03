//
//  CommentView.m
//  appViewer
//
//  Created by JuZhen on 16/6/21.
//  Copyright © 2016年 JuZhen. All rights reserved.
//
#define AFNETWORKING_ALLOW_INVALID_SSL_CERTIFICATES
#import "CommentView.h"
#import "head.h"
#import "AddComment.h"
#import "HttpHelper.h"
@interface CommentView()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property(nonatomic,strong)UITableView * tableView;
@end
@implementation CommentView
@synthesize commentArr;
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];
    
    NSMutableDictionary * dic = [NSMutableDictionary new];
    dic[@"offset"]=[NSNumber numberWithInt:0];
    dic[@"limit"]=[NSNumber numberWithInt:1000];
    dic[@"entryID"]=self.entryID;
    dic[@"token"]=[[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    NSString * url = [NSString stringWithFormat:@"%@%@",AppViewUrl,@"getEntryComments.action"];
    
    [HttpHelper get:url params:dic success:^(id responseObj) {
        self.commentArr=responseObj[@"result"];
        [self.tableView reloadData];
    } fail:^(AFHTTPRequestOperation *operation) {
        
    }];

    

}
-(void)viewWillAppear:(BOOL)animated{
    NSMutableDictionary * dic = [NSMutableDictionary new];
    dic[@"offset"]=[NSNumber numberWithInt:0];
    dic[@"limit"]=[NSNumber numberWithInt:1000];
    dic[@"entryID"]=self.entryID;
    dic[@"token"]=[[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    NSString * url = [NSString stringWithFormat:@"%@%@",AppViewUrl,@"getEntryComments.action"];
    NSLog(@"%@",dic);
    [HttpHelper get:url params:dic success:^(id responseObj) {
        self.commentArr=responseObj[@"result"];
        [self.tableView reloadData];
    } fail:^(AFHTTPRequestOperation *operation) {
        
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [commentArr count] + 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell ;
    if(indexPath.row==0){
        cell  = [[UITableViewCell alloc] init];
        cell.textLabel.text=@"点击评论";
        cell.textLabel.textAlignment=NSTextAlignmentCenter;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }else{
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
        
        UILabel * labelName = [[UILabel alloc] initWithFrame:CGRectMake(30, 5, 200, 26)];
        labelName.text=self.commentArr[indexPath.row-1][@"nickname"];
        [cell addSubview:labelName];
        
        UIImageView * imgLine = [[UIImageView alloc] initWithFrame:CGRectMake(30, 35, SCREEN_WIDTH-130, 1)];
        imgLine.backgroundColor=[UIColor grayColor];
        [cell addSubview:imgLine];
        
        UIImageView * imgLine1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 75, SCREEN_WIDTH, 3)];
        imgLine1.backgroundColor=RGB(235, 245, 246);
        [cell addSubview:imgLine1];
        
        UILabel * detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 40, SCREEN_WIDTH-120, 20)];
        detailLabel.text=self.commentArr[indexPath.row-1][@"content"];
        detailLabel.textColor=[UIColor grayColor];
        [cell addSubview:detailLabel];
        
//        cell.textLabel.text=self.commentArr[indexPath.row-1][@"nickname"];
//        cell.detailTextLabel.text=self.commentArr[indexPath.row-1][@"content"];
        UILabel * countLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-40, 15, 30, 30)];
        NSLog(@"%@",self.commentArr);
        NSNumber * countNumber=self.commentArr[indexPath.row-1][@"likeCount"];
        //NSLog(@"%@",dsfaf );
        //int countNumber = self.commentArr[indexPath.row][@"likeCount"];
        //NSString *stringInt = [NSString stringWithFormat:@"%d",countNumber];
        NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
        NSString *countNumberStr = [numberFormatter stringFromNumber:countNumber];
        countLabel.text=countNumberStr;
        UIImageView * dianzhan = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-80, 15, 30, 30)];
        dianzhan.userInteractionEnabled=YES;
        dianzhan.tag = indexPath.row-1;
        UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dianzhanPress:)];
        [dianzhan addGestureRecognizer:singleTap1];
        [dianzhan setImage:[UIImage imageNamed:@"dianzhan"]];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        [cell.contentView addSubview:dianzhan];
        [cell.contentView addSubview:countLabel];
    }
    return cell;
}
-(void)dianzhanPress:(UIGestureRecognizer *)gestureRecognizer
{
    UIImageView *view = [gestureRecognizer view];
    int tagvalue = view.tag;
//    likeEntryComment.action
//params: { token: String, entryCommentID: Integer}
    NSMutableDictionary * dic = [NSMutableDictionary new];
    dic[@"entryCommentID"]=self.commentArr[tagvalue][@"id"];
    dic[@"token"]=[[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    NSString * url = [NSString stringWithFormat:@"%@%@",AppViewUrl,@"likeEntryComment.action"];
    NSLog(@"%@",dic);
    [HttpHelper get:url params:dic success:^(id responseObj) {
        NSMutableDictionary * dic = [NSMutableDictionary new];
        dic[@"offset"]=[NSNumber numberWithInt:0];
        dic[@"limit"]=[NSNumber numberWithInt:1000];
        dic[@"entryID"]=self.entryID;
        dic[@"token"]=[[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
        NSString * url = [NSString stringWithFormat:@"%@%@",AppViewUrl,@"getEntryComments.action"];
        NSLog(@"%@",dic);
        [HttpHelper get:url params:dic success:^(id responseObj) {
            self.commentArr=responseObj[@"result"];
            [self.tableView reloadData];
        } fail:^(AFHTTPRequestOperation *operation) {
            
        }];
    } fail:^(AFHTTPRequestOperation *operation) {
        
    }];
    int qqq = gestureRecognizer.view.tag;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0){
        return 40;
    }
    else{
        return 80;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0){
        if([[NSUserDefaults standardUserDefaults] valueForKey:@"username"]){
            AddComment * svc = [[AddComment alloc] init];
            svc.entryID=self.entryID;
            self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
            [self.navigationController pushViewController:svc animated:YES];
        }else{
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"我的警告框" message:@"请先登录" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
        }
    }
}
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0){
        return NO;
    }
    if([[NSUserDefaults standardUserDefaults] valueForKey:@"username"]){
        NSString * username=self.commentArr[indexPath.row-1][@"username"];
        if([username isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"username"]]){
            return YES;
        }
        return NO;
    }
    else{
        return NO;
    }
}
-(NSString*)tableView:(UITableView*)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath*)indexpath{
    return @"取消评论";
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"确认删除评论" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert setTag:indexPath.row+99];
        [alert show];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag > 99){
    if(buttonIndex == 1){
            NSMutableDictionary * dic = [NSMutableDictionary new];
            dic[@"id"]=self.commentArr[alertView.tag-100][@"id"];
            dic[@"token"]=[[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
        
//        deleteEntryComment.action
//    params: { token: String, id: Integer }
            NSString * url = [NSString stringWithFormat:@"%@%@",AppViewUrl,@"deleteEntryComment.action"];
            NSLog(@"%@",dic);
            [HttpHelper get:url params:dic success:^(id responseObj) {
                NSMutableDictionary * _dic = [NSMutableDictionary new];
                _dic[@"offset"]=[NSNumber numberWithInt:0];
                _dic[@"limit"]=[NSNumber numberWithInt:1000];
                _dic[@"entryID"]=self.entryID;
                _dic[@"token"]=[[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
                NSString * _url = [NSString stringWithFormat:@"%@%@",AppViewUrl,@"getEntryComments.action"];
                [HttpHelper get:_url params:_dic success:^(id responseObj) {
                    self.commentArr=responseObj[@"result"];
                    [self.tableView reloadData];
                } fail:^(AFHTTPRequestOperation *operation) {
                    
                }];
                
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"删除评论成功" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alert show];
            } fail:^(AFHTTPRequestOperation *operation) {
            }];
        }
    }

}
@end
