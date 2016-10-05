//
//  FroViewController.h
//  appViewer
//
//  Created by HoJolin on 16/9/28.
//  Copyright © 2016年 JuZhen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFSegementView.h"
#import "API.h"

@interface FroViewController : UIViewController <TouchLabelDelegate, APIProtocol, UITableViewDataSource, UITableViewDelegate> {
    XFSegementView *segementView;
    API *myAPI;
    NSArray *arr;
}

@property NSDictionary *data;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UIButton *republicButton;

@end
