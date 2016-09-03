//
//  LoginVC.m
//  appViewer
//
//  Created by JuZhen on 16/6/5.
//  Copyright © 2016年 JuZhen. All rights reserved.
//

#import "LoginVC.h"
#import "head.h"
#import "HttpHelper.h"
@interface LoginVC()<UIAlertViewDelegate>
@property (nonatomic,strong) UIButton * cancelButton;
@property (nonatomic,strong) UIButton * confirmButton;
@property (nonatomic,strong) UILabel * usernameTip;
@property (nonatomic,strong) UILabel * passwordTip;
@property (nonatomic,strong) UITextField * username;
@property (nonatomic,strong) UITextField * password;
@property (nonatomic,strong) UIImageView * imageView;
@end
@implementation LoginVC
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
    self.usernameTip.text=@"注册邮箱";
    self.usernameTip.textAlignment=NSTextAlignmentCenter;
    self.usernameTip.backgroundColor=[UIColor grayColor];
    self.usernameTip.layer.cornerRadius=10;
    self.usernameTip.alpha=0.9;
    
    self.username = [[UITextField alloc] initWithFrame:CGRectMake(125, 30, SCREEN_WIDTH - 170, 40)];
    self.username.placeholder=@"";
    self.username.textAlignment=NSTextAlignmentCenter;
    self.username.backgroundColor=[UIColor whiteColor];
    //self.username.layer.cornerRadius=10;
    self.username.alpha=0.9;

    self.passwordTip=[[UILabel alloc] initWithFrame:CGRectMake(5, 100, 120, 40)];
    self.passwordTip.text=@"登录密码";
    self.passwordTip.textAlignment=NSTextAlignmentCenter;
    self.passwordTip.backgroundColor=[UIColor grayColor];
    self.passwordTip.layer.cornerRadius=10;
    self.passwordTip.alpha=0.9;

    self.password = [[UITextField alloc] initWithFrame:CGRectMake(125, 100, SCREEN_WIDTH - 170, 40)];
    self.password.placeholder=@"";
    self.password.textAlignment=NSTextAlignmentCenter;
    self.password.backgroundColor=[UIColor whiteColor];
    //self.password.layer.cornerRadius=10;
    self.password.alpha=0.9;
    self.password.secureTextEntry = YES;

    self.confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(45,190,(SCREEN_WIDTH-120),50)];
   // self.confirmButton.titleLabel.text = @"confirm";
 //   [self.confirmButton setBackgroundColor:[UIColor grayColor]];
//    self.cancelButton = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH+60)/2,200,(SCREEN_WIDTH-120)/2,30];
//    self.cancelButton.titleLabel.text = @"cancel";
    [self.confirmButton addTarget:self action:@selector(confirmButtonClick) forControlEvents:UIControlEventTouchUpInside];
    //[self.confirmButton setBackgroundColor:[UIColor grayColor]];
    [self.confirmButton setImage:[UIImage imageNamed:@"login"] forState:UIControlStateNormal];
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
    NSString * url = [NSString stringWithFormat:@"%@%@",AppViewUrl,@"auth.action"];
    NSMutableDictionary *dic = [NSMutableDictionary new];
    dic[@"username"]=self.username.text;
    dic[@"password"]=self.password.text;
    [HttpHelper get:url params:dic success:^(id respond){
        NSDictionary * resDic = respond;

        //NSLog(@"%d",(int)resDic[@"result"]);
        //NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
        //NSString * B = [numberFormatter stringFromNumber:resDic[@"result"]];
        if(dic[@"errno"]==0){
            //NSDictionary resultDic = dic[""]
            if([resDic[@"result"][@"username"] isEqualToString:@"wrong"]){
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"我的警告框" message:@"账号或者密码错误" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alert show];
            }
            else{
                [[NSUserDefaults standardUserDefaults] setObject:resDic[@"result"][@"username"] forKey:@"username"];
                 [[NSUserDefaults standardUserDefaults] setObject:resDic[@"result"][@"token"] forKey:@"token"];
                
                NSString * s = resDic[@"result"][@"token"];
                
                NSLog(@"%@",s);
                
                NSArray * uid = [s componentsSeparatedByString:@":"];
                [[NSUserDefaults standardUserDefaults] setObject:[uid objectAtIndex:0] forKey:@"uid"];
                
                NSString * url1 = [NSString stringWithFormat:@"%@%@",AppViewUrl,@"getIndividualInfo.action"];
                NSMutableDictionary * dic1 = [NSMutableDictionary new];
                dic1[@"uid"] = [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];
                dic1[@"username"] = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
                dic1[@"token"] = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
                [HttpHelper get:url1 params:dic1 success:^(id responseObj) {
                    NSDictionary * retDic = responseObj;
                    NSLog(@"%@",retDic);
                    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
                    NSString * B = [numberFormatter stringFromNumber:retDic[@"errno"]];
                    if([B isEqualToString:@"0"]){
                        //            self.nickName.text = retDic[@"result"][@"nickname"];
                        //            self.gender.text =retDic[@"result"][@"gender"];
                     [[NSUserDefaults standardUserDefaults] setObject:resDic[@"result"][@"nickname"] forKey:@"nickname"];
                    }
                } fail:^(AFHTTPRequestOperation *operation) {
                    // <#code#>
                }];
                
                
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"我的警告框" message:@"登陆成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alert setTag:100];
                [alert show];
            }
        }
    } failure:^(NSError * error){

    }];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    //    NSLog(@"%ld",(long)buttonIndex);
    if(alertView.tag==100){
        [self.navigationController popViewControllerAnimated:NO];
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

@end