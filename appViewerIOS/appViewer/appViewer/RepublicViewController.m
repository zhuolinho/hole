//
//  RepublicViewController.m
//  appViewer
//
//  Created by HoJolin on 16/10/25.
//  Copyright © 2016年 JuZhen. All rights reserved.
//

#import "RepublicViewController.h"
#import "API.h"

@interface RepublicViewController () <APIProtocol, UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIAlertViewDelegate> {
    UIImagePickerController *imagePicker;
    API *myAPI;
    API *urAPI;
    NSString *imgURL;
    int picCount;
    UIButton *addPic;
}
@property (weak, nonatomic) IBOutlet UITextField *myTextField;
@property (weak, nonatomic) IBOutlet UITextView *myTextView;

@end

@implementation RepublicViewController
- (IBAction)republicButtoClick:(id)sender {
    if ([_myTextField.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"标题不能空" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    } else if ([_myTextView.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"内容不能空" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    } else {
        [myAPI addForum:_myTextField.text description:_myTextView.text categoryID:_categoryID picturePaths:imgURL];
    }
}

- (IBAction)bgClick:(id)sender {
    [_myTextField resignFirstResponder];
    [_myTextView resignFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    urAPI = [[API alloc]init];
    urAPI.delegate = self;
    myAPI = [[API alloc]init];
    myAPI.delegate = self;
    imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate = self;
    addPic = [[UIButton alloc]initWithFrame:CGRectMake(8, 338, 83, 83)];
    [addPic setImage:[UIImage imageNamed:@"addPic"] forState:UIControlStateNormal];
    [addPic addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addPic];
    imgURL = @"";
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addButtonClick {
    [_myTextField resignFirstResponder];
    [_myTextView resignFirstResponder];
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"添加图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从照片库中选", nil];
    [actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
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
    if (api == urAPI && ![data[@"errno"]integerValue]) {
        CGFloat space = (self.view.bounds.size.width - 348) / 3 + 83;
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(10.5 + space * picCount, 344.5, 70, 70)];
        [self.view addSubview:imgView];
        if (picCount) {
            imgURL = [NSString stringWithFormat:@"%@,%@", imgURL,data[@"result"]];
        } else {
            imgURL = data[@"result"];
        }
        picCount++;
        NSString *str = [NSString stringWithFormat:@"%@/%@", HOST, data[@"result"]];
        NSURL *url = [NSURL URLWithString:str];
        NSURLRequest *requst = [NSURLRequest requestWithURL:url];
        [NSURLConnection sendAsynchronousRequest:requst queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
            if (connectionError == nil) {
                UIImage *img = [UIImage imageWithData:data];
                if (img) {
                    imgView.image = img;
                    if (picCount < 4) {
                        addPic.frame = CGRectMake(8 + space * picCount, 338, 83, 83);
                    } else {
                        addPic.hidden = YES;
                    }
                }
            }
        }];
    } else if (api == myAPI) {
        if ([data[@"result"]integerValue] == 1) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"发布成功" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
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
