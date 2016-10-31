//
//  personSetting.m
//  appViewer
//
//  Created by JuZhen on 16/7/7.
//  Copyright © 2016年 JuZhen. All rights reserved.
//

#import "personSetting.h"
#import "head.h"

@interface personSetting()
@property (nonatomic,strong) UILabel * textLabel;
@property (nonatomic,strong) UISwitch * onOrOff;
@end

@implementation personSetting
-(void)viewDidLoad{
    [super viewDidLoad];
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [bgImgView setImage:[UIImage imageNamed:@"bg-1"]];
    [self.view addSubview:bgImgView];
    UIImageView * bgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 110, SCREEN_WIDTH-20, 60)];
    bgView.backgroundColor=RGBA(245,246,247,100);
    bgView.layer.cornerRadius=12;
    [self.view addSubview:bgView];
    self.textLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, 120, 150, 40)];
    self.textLabel.text=@"音效开关";
    self.textLabel.textColor = RGB(39, 217, 179);
    [self.view addSubview:self.textLabel];
    
    self.onOrOff=[[UISwitch alloc] initWithFrame:CGRectMake(250, 125, 60, 40)];
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"playMusic"] isEqualToString:@"yes"]){
        [self.onOrOff setOn:YES];
    }
    else{
        [self.onOrOff setOn:NO];
    }
    [self.onOrOff addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.onOrOff];
}
-(void)switchAction:(id)sender
{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        [self onMusic];
    }else {
        [self offMusic];
    }
}
-(void)offMusic{
    [[NSUserDefaults standardUserDefaults] setObject:@"no" forKey:@"playMusic"];
}
-(void)onMusic{
    [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"playMusic"];
}
@end
