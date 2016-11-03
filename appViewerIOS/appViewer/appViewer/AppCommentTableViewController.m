//
//  AppCommentTableViewController.m
//  appViewer
//
//  Created by HoJolin on 16/11/2.
//  Copyright © 2016年 JuZhen. All rights reserved.
//

#import "AppCommentTableViewController.h"
#import "API.h"
#import "EntryCommentViewController.h"

@interface AppCommentTableViewController () <APIProtocol> {
    API *myAPI;
    NSArray *comments;
}

@end

@implementation AppCommentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评论";
    myAPI = [[API alloc]init];
    myAPI.delegate = self;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonClick)];
    UIImageView *bg = [[UIImageView alloc]initWithFrame:self.view.bounds];
    bg.image = [UIImage imageNamed:@"bg-1"];
    [self.tableView setBackgroundView:bg];
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
    [myAPI getEntryComments:_entryID];
}

- (void)addButtonClick {
    EntryCommentViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"EntryCommentViewController"];
    vc.entryID = _entryID;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return comments.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    if ([comments[section][@"picturePaths"]isEqualToString:@""] || [comments[section][@"picturePaths"]isEqualToString:@"*"]) {
        return 2;
    } else {
        return 3;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 18;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 25;
    } else if (indexPath.row == 1) {
        NSString *str =  comments[indexPath.section][@"content"];
        if (comments[indexPath.section][@"talkerNickname"]) {
            str = [NSString stringWithFormat:@"@%@ %@", comments[indexPath.section][@"talkerNickname"], str];
        }
        CGSize size = [str sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(self.view.frame.size.width - 30, 1000) lineBreakMode:NSLineBreakByWordWrapping];
        return size.height + 16;
    } else if (indexPath.row == 2 && ![comments[indexPath.section][@"picturePaths"]isEqualToString:@""] && ![comments[indexPath.section][@"picturePaths"]isEqualToString:@"*"]) {
        CGFloat cellWidth = self.view.bounds.size.width / 4;
        unsigned long lines;
        NSArray *picArray = [comments[indexPath.section][@"picturePaths"]componentsSeparatedByString:@","];
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

- (void)didReceiveAPIErrorOf:(API *)api data:(long)errorNo {
    NSLog(@"%ld", errorNo);
}

- (void)didReceiveAPIResponseOf:(API *)api data:(NSDictionary *)data {
    comments = data[@"result"];
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EntryCommentViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"EntryCommentViewController"];
    vc.dic = comments[indexPath.section];
    vc.entryID = _entryID;
    [self.navigationController pushViewController:vc animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"TitleCell" forIndexPath:indexPath];
        cell.textLabel.text = comments[indexPath.section][@"nickname"];
        cell.detailTextLabel.text = comments[indexPath.section][@"createTime"];
    } else if (indexPath.row == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell" forIndexPath:indexPath];
        UILabel *commentLabel = [cell viewWithTag:111];
        NSString *str = comments[indexPath.section][@"content"];
        if (comments[indexPath.section][@"talkerNickname"]) {
            str = [NSString stringWithFormat:@"@%@ %@", comments[indexPath.section][@"talkerNickname"], str];
        }
        commentLabel.text = str;
    } else if (indexPath.row == 2 && ![comments[indexPath.section][@"picturePaths"]isEqualToString:@""] && ![comments[indexPath.section][@"picturePaths"]isEqualToString:@"*"]) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"PicCell" forIndexPath:indexPath];
        for (UIView *sub in cell.contentView.subviews) {
            [sub removeFromSuperview];
        }
        NSArray *picArr = [comments[indexPath.section][@"picturePaths"]componentsSeparatedByString:@","];
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
        cell.detailTextLabel.text = comments[indexPath.section][@"createTime"];
    }

    // Configure the cell...
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    return cell;
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
