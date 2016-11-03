//
//  MessageCenter.m
//  appViewer
//
//  Created by JuZhen on 16/7/2.
//  Copyright © 2016年 JuZhen. All rights reserved.
//

#import "MessageCenter.h"
#include "head.h"
#import "HttpHelper.h"
#import "AppCommentTableViewController.h"
#import "CommentViewController.h"

@interface MessageCenter()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView * likeTableView;
@property (nonatomic,strong) NSMutableArray * infArr;
@end

@implementation MessageCenter

-(void)viewDidLoad{
    [super viewDidLoad];
    [self InitView];
    [self getData];
    self.title=@"我的消息中心";
}
-(void)getData{
    NSMutableDictionary * requestDic=[NSMutableDictionary new];
    requestDic[@"token"]=[[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    [HttpHelper get:[NSString stringWithFormat:@"%@%@",AppViewUrl,@"getMessages.action"] params:requestDic success:^(id responseObj) {
        NSLog(@"%@",responseObj);
        self.infArr = responseObj[@"result"];
        [self.likeTableView reloadData];
    } failure:^(NSError *error) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"网络错误" delegate:nil  cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }];
}
-(void)InitView{
    self.automaticallyAdjustsScrollViewInsets=NO;
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [bgImgView setImage:[UIImage imageNamed:@"bg-1"]];
    [self.view addSubview:bgImgView];
    self.likeTableView=[[UITableView alloc] initWithFrame:CGRectMake(15, 74, SCREEN_WIDTH-30, SCREEN_HEIGHT-84)];
    self.likeTableView.layer.cornerRadius=20;
    self.likeTableView.dataSource=self;
    self.likeTableView.delegate=self;
    self.likeTableView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.0];
    [self.view addSubview:self.likeTableView];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.infArr count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = self.infArr[indexPath.row][@"title"];
    cell.textLabel.textColor = RGB(39, 217, 179);
    cell.detailTextLabel.text=self.infArr[indexPath.row][@"description"];
    cell.detailTextLabel.textColor = RGB(155, 195, 192);
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 250, 70, 200, 12)];
    timeLabel.text = self.infArr[indexPath.row][@"createTime"];
    timeLabel.font = [UIFont systemFontOfSize:12];
    timeLabel.textAlignment = NSTextAlignmentRight;
    timeLabel.textColor = RGB(155, 195, 192);
    [cell addSubview:timeLabel];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
//-(NSString*)tableView:(UITableView*)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath*)indexpath{
//    return @"删除通知";
//}
//-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
//    if (editingStyle==UITableViewCellEditingStyleDelete) {
//        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"我的警告框" message:@"确认删除该通知？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        [alert show];
//    }
//}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_infArr[indexPath.row][@"entryID"]) {
        AppCommentTableViewController *svc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"AppCommentTableViewController"];
        svc.entryID = [NSString stringWithFormat:@"%@", _infArr[indexPath.row][@"entryID"]];
        [self.navigationController pushViewController:svc animated:YES];
    } else if(_infArr[indexPath.row][@"forum"]) {
        CommentViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CommentViewController"];
        vc.dic = _infArr[indexPath.row][@"forum"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

@end
