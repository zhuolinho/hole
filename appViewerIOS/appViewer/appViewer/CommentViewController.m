//
//  CommentViewController.m
//  appViewer
//
//  Created by HoJolin on 16/10/8.
//  Copyright © 2016年 JuZhen. All rights reserved.
//

#import "CommentViewController.h"
#import "API.h"
#import "ForumCommentViewController.h"

@interface CommentViewController () <APIProtocol> {
    API *myAPI;
    NSArray *comments;
}

@end

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    myAPI = [[API alloc]init];
    myAPI.delegate = self;
    self.title = @"论坛";
    NSLog(@"%@", _dic);
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [myAPI getComments:[NSString stringWithFormat:@"%@", _dic[@"id"]]];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    if (section) {
        return comments.count;
    } else {
        if ([_dic[@"picturePaths"]isEqualToString:@""] || [_dic[@"picturePaths"]isEqualToString:@"*"]) {
            return 3;
        } else {
            return 4;
        }
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section) {
        return @"回复：";
    } else {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 18;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section) {
        NSString *talker = @"";
        if (comments[indexPath.row][@"talkerNickname"]) {
            talker = [NSString stringWithFormat:@"@%@ ", comments[indexPath.row][@"talkerNickname"]];
        }
        NSString *str = [NSString stringWithFormat:@"%@：%@%@", comments[indexPath.row][@"nickname"], talker, comments[indexPath.row][@"content"]];
        CGSize size = [str sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(self.view.frame.size.width - 30, 1000) lineBreakMode:NSLineBreakByWordWrapping];
        CGFloat cellWidth = self.view.bounds.size.width / 4;
        int lines = 0;
        if (![comments[indexPath.row][@"picturePaths"]isEqualToString:@""] && ![comments[indexPath.row][@"picturePaths"]isEqualToString:@"*"]) {
            unsigned long lines;
            NSArray *picArray = [comments[indexPath.row][@"picturePaths"]componentsSeparatedByString:@","];
            if ([picArray[picArray.count - 1]isEqualToString:@""]) {
                lines = (picArray.count - 2) / 4 + 1;
            } else {
                lines = (picArray.count - 1) / 4 + 1;
            }
        }
        return size.height + lines * cellWidth + 16;
    } else {
        if (indexPath.row == 0) {
            return 25;
        } else if (indexPath.row == 1) {
            CGSize size = [_dic[@"description"]sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(self.view.frame.size.width - 30, 1000) lineBreakMode:NSLineBreakByWordWrapping];
            return size.height + 16;
        } else if (indexPath.row == 2 && ![_dic[@"picturePaths"]isEqualToString:@""] && ![_dic[@"picturePaths"]isEqualToString:@"*"]) {
            CGFloat cellWidth = self.view.bounds.size.width / 4;
            unsigned long lines;
            NSArray *picArray = [_dic[@"picturePaths"]componentsSeparatedByString:@","];
            if ([picArray[picArray.count - 1]isEqualToString:@""]) {
                lines = (picArray.count - 2) / 4 + 1;
            } else {
                lines = (picArray.count - 1) / 4 + 1;
            }
            return lines * cellWidth + 8;
        } else {
            return 25;
        }
    }
}

- (void)didReceiveAPIErrorOf:(API *)api data:(long)errorNo {
    NSLog(@"%ld", errorNo);
}

- (void)didReceiveAPIResponseOf:(API *)api data:(NSDictionary *)data {
    comments = data[@"result"];
    [self.tableView reloadData];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (indexPath.section) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"MutilCell" forIndexPath:indexPath];
        for (UIView *sub in cell.contentView.subviews) {
            if (sub.tag != 111) {
                [sub removeFromSuperview];
            }
        }
        UILabel *commentLabel = [cell viewWithTag:111];
        NSString *talker = @"";
        if (comments[indexPath.row][@"talkerNickname"]) {
            talker = [NSString stringWithFormat:@"@%@ ", comments[indexPath.row][@"talkerNickname"]];
        }
        NSString *nickname = comments[indexPath.row][@"nickname"];
        NSString *temp = [NSString stringWithFormat:@"%@：%@%@", nickname, talker, comments[indexPath.row][@"content"]];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:temp];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0, nickname.length)];
        commentLabel.attributedText = str;
        CGSize size = [temp sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(self.view.frame.size.width - 30, 1000) lineBreakMode:NSLineBreakByWordWrapping];
        NSArray *picArr = [comments[indexPath.row][@"picturePaths"]componentsSeparatedByString:@","];
        CGFloat cellWidth = self.view.bounds.size.width / 4;
        for (int i = 0; i < picArr.count; i++) {
            UIImageView *myView = [[UIImageView alloc]initWithFrame:CGRectMake(15 + cellWidth * (i % 4), 16 + i / 4 * cellWidth + size.height, cellWidth - 8, cellWidth - 8)];
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
        if (indexPath.row == 0) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"TitleCell" forIndexPath:indexPath];
            cell.textLabel.text = [NSString stringWithFormat:@"%@：%@", _dic[@"nickname"], _dic[@"title"]];
        } else if (indexPath.row == 1) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell" forIndexPath:indexPath];
            UILabel *commentLabel = [cell viewWithTag:111];
            commentLabel.text = _dic[@"description"];
        } else if (indexPath.row == 2 && ![_dic[@"picturePaths"]isEqualToString:@""] && ![_dic[@"picturePaths"]isEqualToString:@"*"]) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"PicCell" forIndexPath:indexPath];
            for (UIView *sub in cell.contentView.subviews) {
                [sub removeFromSuperview];
            }
            NSArray *picArr = [_dic[@"picturePaths"]componentsSeparatedByString:@","];
            CGFloat cellWidth = self.view.bounds.size.width / 4;
            for (int i = 0; i < picArr.count; i++) {
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
            cell.detailTextLabel.text = _dic[@"createTime"];
        }

    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    ForumCommentViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ForumCommentViewController"];
    if (indexPath.section) {
        vc.uid = [NSString stringWithFormat:@"%@", comments[indexPath.row][@"uid"]];
        vc.data = _dic;
    } else {
        vc.uid = [NSString stringWithFormat:@"%@", _dic[@"uid"]];
        vc.data = _dic;
    }
    [self.navigationController pushViewController:vc animated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
