//
//  SearchResult.m
//  appViewer
//
//  Created by JuZhen on 16/7/8.
//  Copyright © 2016年 JuZhen. All rights reserved.
//

#import "SearchResult.h"
#include "DetailView.h"
#import "head.h"
#import "HttpHelper.h"
@interface SearchResult()<UITabBarDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView * fileList;
@property (nonatomic,strong) NSMutableArray * infArr;
@end


@implementation SearchResult
-(void)viewDidLoad{
    self.infArr=[NSMutableArray new];
    [self InitView];
    NSMutableDictionary *dic = [NSMutableDictionary new];
    dic[@"keyword"]=self.keyWord;

    NSString* url = [NSString stringWithFormat:@"%@%@",AppViewUrl,@"searchEntryByKeyword.action"];
    [HttpHelper get:url params:dic success:^(id responseObj) {
        self.infArr=responseObj[@"result"];
        [self.fileList reloadData];
    } fail:^(AFHTTPRequestOperation *operation) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:@"网络错误" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }];
}
-(void)InitView{
    self.fileList=[[UITableView alloc] initWithFrame:self.view.bounds];
    self.fileList.dataSource=self;
    self.fileList.delegate=self;
    [self.view addSubview:self.fileList];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if([self.infArr count]==0){
        return 1;
    }else{
        return [self.infArr count];
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell=[[UITableViewCell alloc] init];
    if([self.infArr count]==0){
        cell.text = @"无搜寻结果";
    }
    else{
        cell.text=self.infArr[indexPath.row][@"title"];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if([self.infArr count]>0){
        DetailView * svc = [[DetailView alloc] init];
        NSString *id = self.infArr[indexPath.row][@"id"];
        int idInt = [id intValue];
        svc.entryID=[NSNumber numberWithInt:idInt];
        self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
        [self.navigationController pushViewController:svc animated:NO];
    }
}
@end
