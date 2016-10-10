//
//  FroViewController.m
//  appViewer
//
//  Created by HoJolin on 16/9/28.
//  Copyright © 2016年 JuZhen. All rights reserved.
//

#import "FroViewController.h"
#import "CommentViewController.h"

@implementation FroViewController
- (IBAction)republicButtonClick:(id)sender {
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"RepublicViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    myAPI = [[API alloc]init];
    myAPI.delegate = self;
    segementView = [[XFSegementView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
    NSMutableArray *arrTemp = [[NSMutableArray alloc]init];
    for (NSDictionary *dic in _data[@"categories"]) {
        [arrTemp addObject:dic[@"title"]];
    }
    segementView.titleArray = arrTemp;
    segementView.scrollLineColor = [UIColor clearColor];
    segementView.titleSelectedColor = [UIColor orangeColor];
    segementView.touchDelegate = self;
    [self.view addSubview:segementView];
    segementView.contentSize = CGSizeMake(64 * segementView.titleArray.count, 50);
    segementView.showsHorizontalScrollIndicator = NO;
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    [_myTableView setTableHeaderView:[[UIView alloc]initWithFrame:CGRectMake(0, 0, 1, 1)]];
    [_myTableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectMake(0, 0, 1, 1)]];
    if (((NSArray *)_data[@"categories"]).count) {
        [myAPI getForums:[NSString stringWithFormat:@"%@", _data[@"categories"][0][@"id"]]];
    }
    _republicButton.layer.cornerRadius = 15;
    _republicButton.layer.masksToBounds = YES;
}

- (void)touchLabelWithIndex:(NSInteger)index{
    [myAPI getForums:[NSString stringWithFormat:@"%@", _data[@"categories"][index][@"id"]]];
}

- (void)didReceiveAPIErrorOf:(API *)api data:(long)errorNo {
    NSLog(@"%ld", errorNo);
}

- (void)didReceiveAPIResponseOf:(API *)api data:(NSDictionary *)data {
    arr = data[@"result"];
    [_myTableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return arr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([arr[section][@"picturePaths"]isEqualToString:@""]) {
        return 3;
    } else {
        return 4;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 25;
    } else if (indexPath.row == 1) {
        CGSize size = [arr[indexPath.section][@"description"]sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(self.view.frame.size.width - 30, 1000) lineBreakMode:NSLineBreakByWordWrapping];
        return size.height + 16;
    } else if (indexPath.row == 2 && ![arr[indexPath.section][@"picturePaths"]isEqualToString:@""]) {
        CGFloat cellWidth = self.view.bounds.size.width / 4;
        unsigned long lines = ([arr[indexPath.section][@"picturePaths"]componentsSeparatedByString:@","].count - 2) / 4 + 1;
        return lines * cellWidth + 8;
    } else {
        return 25;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"TitleCell" forIndexPath:indexPath];
        cell.textLabel.text = [NSString stringWithFormat:@"%@：%@", arr[indexPath.section][@"nickname"], arr[indexPath.section][@"title"]];
    } else if (indexPath.row == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell" forIndexPath:indexPath];
        UILabel *commentLabel = [cell viewWithTag:111];
        commentLabel.text = arr[indexPath.section][@"description"];
    } else if (indexPath.row == 2 && ![arr[indexPath.section][@"picturePaths"]isEqualToString:@""]) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"PicCell" forIndexPath:indexPath];
        for (UIView *sub in cell.contentView.subviews) {
            [sub removeFromSuperview];
        }
        NSArray *picArr = [arr[indexPath.section][@"picturePaths"]componentsSeparatedByString:@","];
        CGFloat cellWidth = self.view.bounds.size.width / 4;
        for (int i = 0; i < picArr.count - 1; i++) {
            UIImageView *myView = [[UIImageView alloc]initWithFrame:CGRectMake(15 + cellWidth * (i % 4), 8 + i / 4 * cellWidth, cellWidth - 8, cellWidth - 8)];
            [cell.contentView addSubview:myView];
            NSString *imgURL = picArr[i];
            NSString *str = [NSString stringWithFormat:@"%@/%@", HOST, imgURL];
            NSURL *url = [NSURL URLWithString:str];
            NSURLRequest *requst = [NSURLRequest requestWithURL:url];
            [NSURLConnection sendAsynchronousRequest:requst queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
                if (connectionError == nil) {
                    UIImage *img = [UIImage imageWithData:data];
                    if (img) {
                        myView.image = img;
                    }
                }
            }];

        }
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"TimeCell" forIndexPath:indexPath];
        cell.detailTextLabel.text = arr[indexPath.section][@"createTime"];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CommentViewController"];
    vc.dic = arr[indexPath.section];
    [self.navigationController pushViewController:vc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
