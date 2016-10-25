//
//  RepublicViewController.m
//  appViewer
//
//  Created by HoJolin on 16/10/25.
//  Copyright © 2016年 JuZhen. All rights reserved.
//

#import "RepublicViewController.h"
#import "API.h"

@interface RepublicViewController () <APIProtocol, UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate> {
    UIImagePickerController *imagePicker;
    API *urAPI;
    NSString *imgURL;
    int picCount;
}
@property (weak, nonatomic) IBOutlet UITextField *myTextField;
@property (weak, nonatomic) IBOutlet UITextView *myTextView;
@property (weak, nonatomic) IBOutlet UIButton *addPic;

@end

@implementation RepublicViewController
- (IBAction)republicButtoClick:(id)sender {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    urAPI = [[API alloc]init];
    urAPI.delegate = self;
    imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate = self;
    [_addPic addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addButtonClick {
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
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(16, 376.5, 72, 72)];
        [self.view addSubview:imgView];
//        NSLog(@"%f", _addPic.frame.size.height);
        if (picCount) {
            [imgURL stringByAppendingString:[NSString stringWithFormat:@",%@", data[@"result"]]];
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
                    _addPic.frame = CGRectMake(200, 200, 83, 83);
                }
            }
        }];
    }
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
