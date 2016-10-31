//
//  PersonDetail.m
//  appViewer
//
//  Created by JuZhen on 16/6/17.
//  Copyright © 2016年 JuZhen. All rights reserved.
//

#import "PersonDetail.h"
#import "head.h"
#import "HttpHelper.h"
@interface PersonDetail()
@property (nonatomic ,strong) UIImageView * topImgView;

@property(nonatomic , strong) UITextField * nickName;
@property(nonatomic , strong) UITextField * gender;
@property(nonatomic , strong) UITextField * email;
@property(nonatomic , strong) UIButton * confirmButton;
@end

@implementation PersonDetail
-(void)viewDidLoad{
    [super viewDidLoad];
    //self.view.backgroundColor=[UIColor grayColor];
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [bgImgView setImage:[UIImage imageNamed:@"bg-1"]];
    [self.view addSubview:bgImgView];
    
    //self.view.backgroundColor=[UIColor whiteColor];
    [self InitView];
}
-(void)InitView{
    self.topImgView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 150, SCREEN_WIDTH-100, 300)];
    self.topImgView.backgroundColor=[UIColor grayColor];
    self.topImgView.layer.cornerRadius=25;
    self.topImgView.alpha = 0.5;
    self.topImgView.userInteractionEnabled=YES;
    
    self.nickName = [[UITextField alloc] initWithFrame:CGRectMake(30, 30, SCREEN_WIDTH-160, 45)];
    self.gender = [[UITextField alloc] initWithFrame:CGRectMake(30, 100, SCREEN_WIDTH-160, 45)];
    self.email = [[UITextField alloc] initWithFrame:CGRectMake(30, 170, SCREEN_WIDTH-160, 45)];
    self.confirmButton=[[UIButton alloc] initWithFrame:CGRectMake(30, 240, SCREEN_WIDTH-160, 50)];
    
    self.nickName.layer.cornerRadius = 20;
    self.gender.layer.cornerRadius = 20;
    self.email.layer.cornerRadius = 20;
    
    self.nickName.textAlignment=NSTextAlignmentCenter;
    self.gender.textAlignment=NSTextAlignmentCenter;
    self.email.textAlignment=NSTextAlignmentCenter;
    
    self.nickName.placeholder=@"请输入您的昵称";
    self.gender.placeholder=@"请输入您的性别（M or F）";
    self.email.placeholder=@"请输入您的电子邮件地址";
    
    self.nickName.backgroundColor=[UIColor whiteColor];
    self.gender.backgroundColor=[UIColor whiteColor];
    self.email.backgroundColor=[UIColor whiteColor];
    //self.confirmButton.backgroundColor=[UIColor whiteColor];
    [self.confirmButton setBackgroundColor:[UIColor colorWithRed:39 / 255.0 green:217 / 255.0 blue:179 / 255.0 alpha:1]];
    
    UILabel * qqq = [[UILabel alloc] initWithFrame:self.confirmButton.bounds];
    qqq.textColor = [UIColor whiteColor];
    qqq.text=@"确定";
    qqq.textAlignment=NSTextAlignmentCenter;
    [self.confirmButton addSubview:qqq];
    //self.confirmButton.titleLabel.text=@"dfjaskfjaksjfkla";
    
    [self.confirmButton addTarget:self action:@selector(confirmButtonClick) forControlEvents:UIControlEventTouchUpInside];
    //[self.confirmButton setBackgroundColor:[UIColor grayColor]];
    
    [self.view addSubview:self.topImgView];
    [self.topImgView addSubview:self.nickName];
    [self.topImgView addSubview:self.gender];
    [self.topImgView addSubview:self.email];
    [self.topImgView addSubview:self.confirmButton];
    
    NSString * url = [NSString stringWithFormat:@"%@%@",AppViewUrl,@"getIndividualInfo.action"];
    NSMutableDictionary * dic = [NSMutableDictionary new];
    dic[@"uid"] = [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];
    dic[@"username"] = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    dic[@"token"] = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    [HttpHelper get:url params:dic success:^(id responseObj) {
        NSDictionary * retDic = responseObj;
        NSLog(@"%@",retDic);
        NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
        NSString * B = [numberFormatter stringFromNumber:retDic[@"errno"]];
        if([B isEqualToString:@"0"]){
//            self.nickName.text = retDic[@"result"][@"nickname"];
//            self.gender.text =retDic[@"result"][@"gender"];
//            self.email.text=retDic[@"result"][@"email"];
        }
    } fail:^(AFHTTPRequestOperation *operation) {
       // <#code#>
    }];
}
-(void)confirmButtonClick{
    NSString * token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    NSString * url1 = [NSString stringWithFormat:@"%@%@",AppViewUrl,@"setNickname.action"];
    NSString * url2 = [NSString stringWithFormat:@"%@%@",AppViewUrl,@"setGender.action"];
    NSString * url3 = [NSString stringWithFormat:@"%@%@",AppViewUrl,@"setEmail.action"];
    
    NSMutableDictionary * dic1 = [NSMutableDictionary new];
    NSMutableDictionary * dic2 = [NSMutableDictionary new];
    NSMutableDictionary * dic3 = [NSMutableDictionary new];
    
    dic1[@"token"]=token;
    dic2[@"token"]=token;
    dic3[@"token"]=token;
    
    dic1[@"nickname"]=self.nickName.text;
    dic2[@"gender"]=self.gender.text;
    dic3[@"email"]=self.email.text;
    if((![self.gender.text isEqualToString:@"F"])&&(![self.gender.text isEqualToString:@"M"])){
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"我的警告框" message:@"请按提示输入正确性别" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }
    if(![self isValidateEmail:self.email.text]){
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"我的警告框" message:@"请按提示输入正确邮箱地址" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }
    if((([self.gender.text isEqualToString:@"F"])||([self.gender.text isEqualToString:@"M"]))
       &&([self isValidateEmail:self.email.text])){
        [HttpHelper get:url1 params:dic1 success:^(id responseObj) {
        } fail:^(AFHTTPRequestOperation *operation) {
        }];
        
        [HttpHelper get:url2 params:dic2 success:^(id responseObj) {
        } fail:^(AFHTTPRequestOperation *operation) {
        }];
        
        [HttpHelper get:url3 params:dic3 success:^(id responseObj) {
        } fail:^(AFHTTPRequestOperation *operation) {
        }];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"我的警告框" message:@"修改个人信息成功" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }

}
-(BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
//点击屏幕空白处去掉键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.nickName resignFirstResponder];
    [self.gender resignFirstResponder];
    [self.email resignFirstResponder];
}

@end
