//
//  ForumCommentViewController.m
//  appViewer
//
//  Created by HoJolin on 16/10/26.
//  Copyright © 2016年 JuZhen. All rights reserved.
//

#import "ForumCommentViewController.h"
#import "API.h"

@interface ForumCommentViewController () <APIProtocol, UIAlertViewDelegate> {
    API *myAPI;
}

@property (weak, nonatomic) IBOutlet UITextView *myTextView;

@end

@implementation ForumCommentViewController
- (IBAction)bgClick:(id)sender {
    [_myTextView resignFirstResponder];
}

- (IBAction)commitButtonClick:(id)sender {
    if ([_myTextView.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"内容不能空" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    } else {
        [myAPI addForumComment:[NSString stringWithFormat:@"%@", _data[@"id"]] talkerID:_uid content:_myTextView.text picturePaths:@""];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    myAPI = [[API alloc]init];
    myAPI.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didReceiveAPIErrorOf:(API *)api data:(long)errorNo {
    NSLog(@"%ld", errorNo);
}

- (void)didReceiveAPIResponseOf:(API *)api data:(NSDictionary *)data {
    if ([data[@"result"]integerValue] == 1) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"发布成功" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self.navigationController popViewControllerAnimated:YES];
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
