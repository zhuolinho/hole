//
//  UploadVC.m
//  appViewer
//
//  Created by JuZhen on 16/6/5.
//  Copyright © 2016年 JuZhen. All rights reserved.
//

#import "UploadVC.h"
#import "SGActionView.h"
#include "head.h"
@interface UploadVC ()<UIActionSheetDelegate>
@property (nonatomic, strong) UIScrollView * FirstPage;
@property (nonatomic, strong) UIScrollView * SecondPage;
@property (nonatomic, strong) UIActionSheet * actSheet;

@property (nonatomic, strong) UILabel * FPTitleLabel;
@property (nonatomic, strong) UILabel * FPDetailLabel;
@property (nonatomic, strong) UILabel * FPOriginLabel;
@property (nonatomic, strong) UILabel * FPNowLabel;
@property (nonatomic, strong) UITextField * FirstPageTitle;
@property (nonatomic, strong) UITextField * FirstPageDetail;
@property (nonatomic, strong) UITextField * FirstPageOriginPrice;
@property (nonatomic, strong) UITextField * FirstPageNowPrice;
@property (nonatomic,strong) UploadImageLayout * uploadView;
@property (nonatomic ,strong) UITextField * appName;
@property (nonatomic, strong) UITextView * detailDescription;

//@property (nonatomic, strong) CPTextLabelCell *
@end
@implementation UploadVC
@synthesize FirstPageDetail,FirstPageTitle,FirstPageNowPrice,FirstPageOriginPrice,FPTitleLabel,FPDetailLabel,FPOriginLabel,FPNowLabel;
-(instancetype)init {
    self = [super initWithSectionNumber:2];
    self.FirstPage=[[UIScrollView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT-120)];
    self.FirstPage.backgroundColor=[UIColor colorWithWhite:0.9 alpha:0.5];
    self.SecondPage=[[UIScrollView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH,0,SCREEN_WIDTH,SCREEN_HEIGHT-120)];
    self.SecondPage.backgroundColor=[UIColor colorWithWhite:0.9 alpha:0.5];
    [self initFirstPage];
    [self initSecondPage];
    [self.scrollView addSubview:self.FirstPage];
    [self.scrollView addSubview:self.SecondPage];
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)initFirstPage{
    UILabel * appNameTip = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, 80, 40)];
    appNameTip.backgroundColor=[UIColor whiteColor];
    appNameTip.layer.masksToBounds=YES;
    appNameTip.layer.cornerRadius=5;
    [appNameTip setText:@"软件名"];
    [appNameTip setTextColor:[UIColor orangeColor]];
    
    [self.FirstPage addSubview:appNameTip];
    self.appName = [[UITextField alloc] initWithFrame:CGRectMake(100, 40, SCREEN_WIDTH-110, 40)];
    self.appName.placeholder=@"请输入软件名称";
    self.appName.backgroundColor=[UIColor whiteColor];
    self.appName.layer.masksToBounds=YES;
    self.appName.layer.cornerRadius=5;
    [self.FirstPage addSubview:self.appName];
    
    UILabel * descriptionTip = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 80, 160)];
    descriptionTip.backgroundColor=[UIColor whiteColor];
    descriptionTip.layer.masksToBounds=YES;
    descriptionTip.layer.cornerRadius=5;
    [descriptionTip setText:@"软件描述"];
    [descriptionTip setTextColor:[UIColor orangeColor]];
    [self.FirstPage addSubview:descriptionTip];
    
    self.detailDescription=[[UITextView alloc] initWithFrame:CGRectMake(100, 100, SCREEN_WIDTH-110, 160)];
    self.detailDescription.layer.masksToBounds=YES;
    self.detailDescription.layer.cornerRadius=5;
    [self.FirstPage addSubview:self.detailDescription];
}
-(void)initSecondPage{
    self.uploadView = [[UploadImageLayout alloc] initWithFrame:CGRectMake(0,10, SCREEN_WIDTH, 0)];
    self.uploadView.addIconClick = ^(void){
        [self PicUpload];
    };
    [self.SecondPage addSubview:self.uploadView];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)PicUpload{
    self.actSheet = [[UIActionSheet alloc] initWithTitle:@"选择方式f" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册中选取",   nil];
    self.actSheet.actionSheetStyle=UIActionSheetStyleBlackOpaque;
    [self.actSheet showInView:self.view];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString* title = [actionSheet buttonTitleAtIndex:buttonIndex];
    if([title  isEqual: @"拍照"]){
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = NO;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
    else if ([title isEqual: @"从相册中选取"]){
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = NO;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *img = info[UIImagePickerControllerOriginalImage];
    [self.uploadView addOneImage:img];
    self.SecondPage.contentSize=CGSizeMake(SCREEN_WIDTH,self.uploadView.frame.origin.y + self.uploadView.frame.size.height + 10);
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(void) showHint{
    [SGActionView showAlertWithTitle:@"服务说明"
                             message:@"本商品由品牌供货商提供，诚·品大学团队对该商品提供质量担保\n\n您在收到商品后的7天里，不论商品是否使用，都可申请退换货，诚·品大学团队会上门取货并全额退款或更换商品，您不会为此承担任何费用"
                     leftButtonTitle:@"关闭"
                    rightButtonTitle:nil
                      selectedHandle:nil];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
//点击屏幕空白处去掉键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.appName resignFirstResponder];
    [self.detailDescription resignFirstResponder];
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