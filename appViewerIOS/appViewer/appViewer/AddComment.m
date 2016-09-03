//
//  AddComment.m
//  appViewer
//
//  Created by JuZhen on 16/6/21.
//  Copyright © 2016年 JuZhen. All rights reserved.
//

#import "AddComment.h"
#import "head.h"
#import "HttpHelper.h"
@interface AddComment()<UIAlertViewDelegate>
@property(nonatomic,strong) UITextView * textView;
@property(nonatomic,strong) UIImageView * topImgView;
@property(nonatomic,strong) UIButton * confirmButton;
@end;
@implementation AddComment
-(void)viewDidLoad{
    [super viewDidLoad];
    //self.view.backgroundColor= RGBA(190,198,204,250);
    //self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bgf"]];
    UIImageView * bgimg =[[UIImageView alloc] initWithFrame:self.view.bounds];
    [bgimg setImage:[UIImage imageNamed:@"bgf"]];
    [self.view addSubview:bgimg];
    self.topImgView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 80, SCREEN_WIDTH-60, 300)];
    self.topImgView.backgroundColor=[UIColor grayColor];
    self.topImgView.layer.cornerRadius=25;
    self.topImgView.alpha = 0.5;
    self.topImgView.userInteractionEnabled=YES;
    
    self.textView=[[UITextView alloc] initWithFrame:CGRectMake(30, 40,SCREEN_WIDTH-120, 150)];
    self.textView.layer.cornerRadius=15;
    
    self.confirmButton=[[UIButton alloc] initWithFrame:CGRectMake(30, 230, SCREEN_WIDTH-120, 50)];
    [self.confirmButton setImage:[UIImage imageNamed:@"confirm"] forState:UIControlStateNormal];
    [self.confirmButton addTarget:self action:@selector(confirmButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UILabel * sendLabel = [[UILabel alloc] initWithFrame:self.confirmButton.bounds];
    sendLabel.text=@"发送";
    sendLabel.textAlignment=NSTextAlignmentCenter;
    [self.confirmButton addSubview:sendLabel];
    [self.view addSubview:self.topImgView];
    [self.topImgView addSubview:self.textView];
    [self.topImgView addSubview:self.confirmButton];
}


-(void)confirmButtonClick{
    //params: { token: String, entryID: Integer, content: String }
    NSMutableDictionary *dic = [NSMutableDictionary new];
    dic[@"entryID"]=self.entryID;
    dic[@"token"]=[[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *str = self.textView.text;
    NSData *data = [str dataUsingEncoding:enc];
    NSString *retStr = [[NSString alloc] initWithData:data encoding:enc];
    
    dic[@"content"]=self.textView.text;
    NSLog(@"%@",dic);
    NSString* url = [NSString stringWithFormat:@"%@%@",AppViewUrl,@"addEntryComment.action"];
    NSString *urlStrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [HttpHelper get:urlStrl params:dic success:^(id responseObj) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"我的警告框" message:@"发表评论成功" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        alert.delegate=self;
        [alert show];
    } fail:^(AFHTTPRequestOperation *operation) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"我的警告框" message:@"发表评论失败" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        alert.delegate=nil;
        [alert show];
    }];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self.navigationController popViewControllerAnimated:NO];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
//点击屏幕空白处去掉键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.textView resignFirstResponder];

}
@end
