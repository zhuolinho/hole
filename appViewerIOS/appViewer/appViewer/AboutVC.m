//
//  AboutVC.m
//  appViewer
//
//  Created by JuZhen on 16/6/5.
//  Copyright © 2016年 JuZhen. All rights reserved.
//

#import "AboutVC.h"
#import "head.h"
@interface AboutVC()
@property(nonatomic,strong)UITextView * textView;
@property(nonatomic,strong)UIImageView * imageView;
@property(nonatomic,strong) UILabel * label;
@end
@implementation AboutVC
-(void)viewDidLoad{
    [super viewDidLoad];
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [bgImgView setImage:[UIImage imageNamed:@"bg-1"]];
    [self.view addSubview:bgImgView];
    self.imageView=[[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, 100, 100, 100)];
    [self.imageView setImage:[UIImage imageNamed:@"icon"]];
    [self.view addSubview:self.imageView];
    //self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]];
    self.textView=[[UITextView alloc] initWithFrame:CGRectMake(50, 220, SCREEN_WIDTH-100, 300)];
    self.textView.text=@"“软件提前知”是一款真正关心你手机软件的App，帮您探索手机软件的未知领域。                       关注App—在您关注具体App之后，我们会把该软件更新之后的状况第一时间告诉您。比如该软件更新之后一些功能上的变更与消失，是否出现闪退，存储数据消失，页面改版，新增了哪些特点等。对于付费类软件我们也将率先试用，并总结好该软件的内容与特点，让您尽量避免在付费下载之后，出现后悔的情况。                                            关注类别—我们还对软件的特点与优势进行总结，在同领域之间进行比较，该软件有什么特点、哪里最好用、哪个最省钱一看就知道，根据您自己的需求能迅速找到最适合您的App。您也可以对具体软件进行评论和补足，点赞数较高的我们会予以采纳和置顶。                                                         总而言之“软件提前知”会让您手机软件的更新与下载不再被动。您在手机软件领域还不知道的就是我们要做的。";//@"“软件提前知”是一款真正关心你手机软件的App，帮您探索手机软件的未知领域。比如说软件更新之后一些功能的变更与消失，存储数据的消失，页面的改版，新增了哪些特点等。在您关注具体App之后，我们都将在该软件更新之后第一时间告诉您。对于付费类软件我们也将率先试用，并总结好该软件的内容与特点，让您尽量避免在付费下载之后，出现后悔的情况。除了这些我们还对软件的特点与优势进行总结，在同领域之间进行比较，该软件有什么特点、哪里最好用、哪个最省钱一看就知道，根据您自己的需求能迅速找到最适合您的App。您也可以对具体软件进行评论和补足，点赞数较高的我们会予以采纳和置顶。总而言之“软件提前知”会让您手机软件的更新与下载不再被动。您在手机软件领域还不知道的就是我们要做的。";
    self.textView.textAlignment=NSTextAlignmentCenter;
    self.textView.userInteractionEnabled=NO;
    self.textView.backgroundColor=[UIColor colorWithWhite:1 alpha:0.4];//RGBA(190,198,204,100);//[UIColor grayColor];
    self.textView.layer.cornerRadius=30;
    self.textView.alpha=1;
    self.label=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-150, 550, 300, 40)];
    self.label.text=@"联系我们：ruanjiantiqianzhi@163.com" ;
    self.label.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:self.label];
    self.label.backgroundColor=[UIColor colorWithWhite:1 alpha:0.4];
    [self.view addSubview:self.textView];
}
@end
