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
#import "API.h"
@interface AddComment() <UIAlertViewDelegate, UIActionSheetDelegate, APIProtocol, UINavigationControllerDelegate, UIImagePickerControllerDelegate> {
    API *urAPI;
    UIImagePickerController *imagePicker;
    NSString *imgURL;
    UIImageView *imgView;
}
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
    self.topImgView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 80, SCREEN_WIDTH-60, 370)];
    self.topImgView.backgroundColor=[UIColor grayColor];
    self.topImgView.layer.cornerRadius=25;
    self.topImgView.alpha = 0.5;
    self.topImgView.userInteractionEnabled=YES;
    
    self.textView=[[UITextView alloc] initWithFrame:CGRectMake(30, 40,SCREEN_WIDTH-120, 150)];
    self.textView.layer.cornerRadius=15;
    self.confirmButton=[[UIButton alloc] initWithFrame:CGRectMake(30, 300, SCREEN_WIDTH-120, 50)];
    [self.confirmButton setImage:[UIImage imageNamed:@"confirm"] forState:UIControlStateNormal];
    [self.confirmButton addTarget:self action:@selector(confirmButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UILabel * sendLabel = [[UILabel alloc] initWithFrame:self.confirmButton.bounds];
    sendLabel.text=@"发送";
    sendLabel.textAlignment=NSTextAlignmentCenter;
    [self.confirmButton addSubview:sendLabel];
    [self.view addSubview:self.topImgView];
    [self.topImgView addSubview:self.textView];
    [self.topImgView addSubview:self.confirmButton];
    UIButton *addButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 4 - 40, 215, 80, 50)];
    [addButton setImage:[UIImage imageNamed:@"confirm"] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UILabel *addLabel = [[UILabel alloc]initWithFrame:addButton.bounds];
    addLabel.text = @"添加图片";
    addLabel.textAlignment = NSTextAlignmentCenter;
    [addButton addSubview:addLabel];
    [_topImgView addSubview:addButton];
    urAPI = [[API alloc]init];
    urAPI.delegate = self;
    imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate = self;
    imgView = [[UIImageView alloc]initWithFrame:CGRectMake(3 * SCREEN_WIDTH / 4 - 70, 282, 80, 80)];
    imgView.userInteractionEnabled = YES;
    [self.view addSubview:imgView];
    UIButton *closeButton = [[UIButton alloc]initWithFrame:CGRectMake(60, 0, 20, 20)];
    [closeButton setTitle:@"x" forState:UIControlStateNormal];
    [closeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [imgView addSubview:closeButton];
    imgView.hidden = YES;
}

- (void)closeButtonClick {
    imgView.hidden = YES;
    imgURL = NULL;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
    CGFloat height = chosenImage.size.height;
    CGFloat width = chosenImage.size.width;
    if (height < width) {
        width = 150 * width / height;
        height = 150;
    } else {
        height = 150 * height / width;
        width = 150;
    }
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [chosenImage drawInRect:CGRectMake(0, 0, width, height)];
    UIImage *editedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [urAPI uploadImage:editedImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveAPIErrorOf:(API *)api data:(long)errorNo {
    NSLog(@"%ld", errorNo);
}

- (void)didReceiveAPIResponseOf:(API *)api data:(NSDictionary *)data {
    imgURL = data[@"result"];
    imgView.hidden = NO;
    NSString *str = [NSString stringWithFormat:@"%@/%@", HOST, imgURL];
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *requst = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:requst queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (connectionError == nil) {
            UIImage *img = [UIImage imageWithData:data];
            if (img) {
                imgView.image = img;
            }
        }
    }];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
//        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePicker animated:YES completion:nil];
    } else if (buttonIndex == 1) {
//        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}

- (void)addButtonClick {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"添加图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从照片库中选", nil];
    [actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
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
    dic[@"picturePaths"] = imgURL;
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
