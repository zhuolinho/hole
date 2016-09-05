//
//  ViewController.m
//  appViewer
//
//  Created by JuZhen on 16/6/3.
//  Copyright © 2016年 JuZhen. All rights reserved.
//

#import "ViewController.h"
#import "API.h"

@interface ViewController () <UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, APIProtocol> {
    API *urAPI;
    UIImagePickerController *imagePicker;
    UIActivityIndicatorView *activity;
}

@end

@implementation ViewController
- (IBAction)myButtonClick:(id)sender {
    [urAPI login:@"zhuolinho" password:@"abc123"];
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"修改头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从照片库中选", nil];
    [actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePicker animated:YES completion:nil];
    } else if (buttonIndex == 1) {
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    CGFloat height = chosenImage.size.height;
    CGFloat width = chosenImage.size.width;
    if (height > width) {
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
    [activity startAnimating];
}

- (void)didReceiveAPIErrorOf:(API *)api data:(long)errorNo {
    NSLog(@"%ld", errorNo);
}

- (void)didReceiveAPIResponseOf:(API *)api data:(NSDictionary *)data {
    NSLog(@"%@", data);
    if (api == urAPI) {
        [activity stopAnimating];
        [imagePicker dismissViewControllerAnimated:YES completion:nil];
        return;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    urAPI = [[API alloc]init];
    urAPI.delegate = self;
    imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate = self;
    activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//    activity.color = THEMECOLOR;
    activity.center = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2);
    activity.hidesWhenStopped = YES;
    [imagePicker.view addSubview:activity];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
