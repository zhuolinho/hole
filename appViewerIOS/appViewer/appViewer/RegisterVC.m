//
//  RegisterVC.m
//  appViewer
//
//  Created by JuZhen on 16/6/5.
//  Copyright © 2016年 JuZhen. All rights reserved.
//

#import "RegisterVC.h"
#include "head.h"
#import "HttpHelper.h"
@interface RegisterVC()
@property (nonatomic,strong) UIButton * cancelButton;
@property (nonatomic,strong) UIButton * confirmButton;
@property (nonatomic,strong) UILabel * usernameTip;
@property (nonatomic,strong) UILabel * passwordTip;
@property (nonatomic,strong) UITextField * username;
@property (nonatomic,strong) UITextField * password;
@property (nonatomic,strong) UIImageView * imageView;
@end
@implementation RegisterVC
-(void)viewDidLoad{
    [super viewDidLoad];
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 140, SCREEN_WIDTH-30, 260)];
    self.imageView.backgroundColor=[UIColor blackColor];
    self.imageView.userInteractionEnabled=YES;
    self.imageView.layer.cornerRadius=30;
    self.imageView.alpha = 0.7;
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"mainBG"]];
    //self.view.backgroundColor=[UIColor whiteColor];
    self.usernameTip=[[UILabel alloc] initWithFrame:CGRectMake(5, 30, 120, 40)];
    self.usernameTip.text=@"邮箱注册";
    self.usernameTip.textAlignment=NSTextAlignmentCenter;
    self.usernameTip.backgroundColor=[UIColor grayColor];
    self.usernameTip.layer.cornerRadius=10;
    self.usernameTip.alpha=0.9;
    
    self.username = [[UITextField alloc] initWithFrame:CGRectMake(125, 30, SCREEN_WIDTH - 170, 40)];
    self.username.placeholder=@"请使用您的邮箱进行注册";
    self.username.textAlignment=NSTextAlignmentCenter;
    self.username.backgroundColor=[UIColor whiteColor];
    //self.username.layer.cornerRadius=10;
    self.username.alpha=0.9;
    
    self.passwordTip=[[UILabel alloc] initWithFrame:CGRectMake(5, 100, 120, 40)];
    self.passwordTip.text=@"密码";
    self.passwordTip.textAlignment=NSTextAlignmentCenter;
    self.passwordTip.backgroundColor=[UIColor grayColor];
    self.passwordTip.layer.cornerRadius=10;
    self.passwordTip.alpha=0.9;
    
    self.password = [[UITextField alloc] initWithFrame:CGRectMake(125, 100, SCREEN_WIDTH - 170, 40)];
    self.password.placeholder=@"请输入该软件登录密码";
    self.password.textAlignment=NSTextAlignmentCenter;
    self.password.backgroundColor=[UIColor whiteColor];
    //self.password.layer.cornerRadius=10;
    self.password.alpha=0.9;
    self.password.secureTextEntry = YES;
    
    self.confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(45,190,(SCREEN_WIDTH-120),50)];
    self.confirmButton.titleLabel.text = @"confirm";
    [self.confirmButton setBackgroundColor:[UIColor grayColor]];
    
    UILabel * qqq = [[UILabel alloc] initWithFrame:self.confirmButton.bounds];
    qqq.text=@"确定";
    qqq.textAlignment=NSTextAlignmentCenter;
    [self.confirmButton addSubview:qqq];
    
    //    self.cancelButton = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH+60)/2,200,(SCREEN_WIDTH-120)/2,30];
    //    self.cancelButton.titleLabel.text = @"cancel";
    [self.confirmButton addTarget:self action:@selector(confirmButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.confirmButton setBackgroundColor:[UIColor grayColor]];
    //    btn = [[UIButton alloc] initWithFrame:CGRectMake(textView.MaxX, kGap, SCREEN_WIDTH-textView.MaxX, 20)];
    //    [btn addTarget:self action:@selector(bthClick) forControlEvents:UIControlEventTouchUpInside];
    //    [btn setTitle:@"发送" forState:UIControlStateNormal];
    
    [self.imageView addSubview:self.usernameTip];
    [self.imageView addSubview:self.username];
    [self.imageView addSubview:self.passwordTip];
    [self.imageView addSubview:self.password];
    [self.imageView addSubview:self.confirmButton];
    [self.view addSubview:self.imageView];
    //[self.view addSubview:self.cancelButton];
}

-(void)confirmButtonClick{
    if([self.password.text isEqualToString:@""]||[self.username.text isEqualToString:@""]){
    
    }
    else{
        NSString * url = [NSString stringWithFormat:@"%@%@",AppViewUrl,@"registerWithoutPhone.action"];
        NSMutableDictionary * dic = [NSMutableDictionary new];
        [dic setObject:self.username.text forKey:@"username"];
        [dic setObject:self.password.text forKey:@"password"];
        NSLog(@"%@",dic);
        NSLog(@"%@",dic);
        if(![self isValidateEmail:self.username.text])
        {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请使用邮箱注册" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
        }
        else{
            [HttpHelper get:url params:dic success:^(id respond){
                NSDictionary * resDic = respond;
                NSLog(@"%@",resDic);
                NSLog(@"%d",(int)resDic[@"result"]);
                NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
                NSString * B = [numberFormatter stringFromNumber:resDic[@"result"]];
                NSLog(@"%d",B);
                if([B isEqualToString:@"-1"]){
                    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"该账号已经被注册" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                    [alert show];
                }else if([B isEqualToString:@"1"]){
                    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"注册成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                    [alert show];
                }
            } failure:^(NSError * error){
                NSLog(@"%@",error);
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"注册失败 " delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alert show];
            }];
        }
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
//点击屏幕空白处去掉键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.username resignFirstResponder];
    [self.password resignFirstResponder];
}
-(BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

@end
