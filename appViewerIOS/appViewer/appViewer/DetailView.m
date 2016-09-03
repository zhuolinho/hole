//
//  DetailView.m
//  appViewer
//
//  Created by JuZhen on 16/6/7.
//  Copyright © 2016年 JuZhen. All rights reserved.
//

#import "DetailView.h"
#import "head.h"
#import "ImgDetailVC.h"

#define GAP_X ((SCREEN_WIDTH - 86)/3)
#define GAP_Y ((SCREEN_WIDTH - 86)/3) * SCREEN_HEIGHT / SCREEN_WIDTH
@interface DetailView()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>{
    int viewPage;
    NSMutableDictionary * infDic;
    NSMutableArray * infArr;
}
@property (nonatomic,strong) UIScrollView * scrollView;
@property (nonatomic,strong) UILabel* showHintLabel;
@property (nonatomic,strong) NSMutableArray * versionImgArr;
@property (nonatomic,strong) UIImageView * topImgView;
@property (nonatomic,strong) NSMutableDictionary * isInit;
@end
@implementation DetailView
-(void)viewDidLoad{
    [super viewDidLoad];
    [self setBar];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"mainBG"]];
    infDic = [NSMutableDictionary new];
    infArr=[NSMutableArray new];
    NSMutableDictionary * requestDic=[NSMutableDictionary new];
    requestDic[@"offset"]=[NSNumber numberWithInt:0];
    requestDic[@"limit"]=[NSNumber numberWithInt:10];
    //self.view.backgroundColor=[UIColor whiteColor];//RGBA(220,238,234,190);//RGBA(223,223,224,220);
    requestDic[@"entryID"]=self.entryID;//[NSNumber numberWithInt:179];
    [HttpHelper get:[NSString stringWithFormat:@"%@%@",AppViewUrl,@"getEntrySubs.action"] params:requestDic success:^(id responseObj) {
        NSLog(@"%@",responseObj);
        infDic=responseObj;
        NSMutableArray * temp = [NSMutableArray new];
        temp = infDic[@"result"];
        BOOL isC = false;
        NSString * totalVersion=@"";
        for(int i = 0 ; i < [temp count];i++){
            NSString * description =temp[i][@"description"];
            NSArray * arr = temp[i][@"picList"];
            if([description isEqualToString:@""] && ([arr count]==0)){
                if(isC){
                    totalVersion = [NSString stringWithFormat:@"%@%@%@",totalVersion,@",",temp[i][@"version"]];
                }else{
                    totalVersion=temp[i][@"version"];
                    isC=true;
                }
                if((i+1)==[temp count]){
                    NSMutableDictionary * _dic = [NSMutableDictionary new];
                    //_dic=temp[i];
                    _dic[@"version"]=@"hunhe";
                    NSMutableArray * pic = [NSMutableArray new];
                    _dic[@"picList"]=pic;
                    _dic[@"description"]=[NSString stringWithFormat:@"%@%@",totalVersion,@" 没有明显改动"];
                    [infArr addObject:_dic];
                }
            }else{
                if(isC){
                    isC=false;
                    NSMutableDictionary * _dic = [NSMutableDictionary new];
                    //_dic=temp[i-1];
                    NSMutableArray * pic = [NSMutableArray new];
                    _dic[@"picList"]=pic;
                    _dic[@"version"]=@"hunhe";
                    _dic[@"description"]=[NSString stringWithFormat:@"%@%@",totalVersion,@" 没有明显改动"];
                    totalVersion=@"";
                    [infArr addObject:_dic];
                    [infArr addObject:temp[i]];
                }else{
                    [infArr addObject:temp[i]];
                }
            }
        }
        //infArr = infDic[@"result"];
        [self InitScrollView:(int)infArr.count];
        [self InitTopView:(int)infArr.count];
    } failure:^(NSError *error) {
        
    }];
    
}
-(void)setBar{
    UIBarButtonItem *barBtn3=[[UIBarButtonItem alloc] initWithTitle:@"收藏" style:UIBarButtonItemStyleDone target:self action:@selector(favor:)];
    [self.navigationItem setRightBarButtonItem:barBtn3];
}
-(void)favor:(UIBarButtonItem*)item{
    if([[NSUserDefaults standardUserDefaults] valueForKey:@"username"]){
        NSMutableDictionary * requestDic=[NSMutableDictionary new];
        requestDic[@"token"]=[[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
        requestDic[@"entryID"]=self.entryID;
        [HttpHelper get:[NSString stringWithFormat:@"%@%@",AppViewUrl,@"addIndividualEntry.action"] params:requestDic success:^(id responseObj) {
            NSLog(@"%@",responseObj);
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"感谢您的收藏" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
        } failure:^(NSError *error) {
            
        }];
    }else{
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"感谢您的收藏" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }

}
-(void)InitScrollView:(int)num{
    viewPage = 0;
    self.scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, SCREEN_HEIGHT-200)];
    [self.scrollView setContentSize:CGSizeMake(num*SCREEN_WIDTH,0)];
    self.scrollView.pagingEnabled=YES;
    //self.scrollView.bounces=NO;
    self.scrollView.scrollEnabled=YES;
    self.scrollView.backgroundColor=[UIColor whiteColor];
    self.scrollView.alwaysBounceHorizontal=YES;
    self.scrollView.delegate=self;
    self.isInit=[NSMutableDictionary new];
    for(int i = 0 ; i < infArr.count ;i++){
        [self.isInit setObject:@"false" forKey:[NSNumber numberWithInt:i]];
        //[self InitDetailVersion:i withDic:infArr[i]];
    }
    [self InitDetailVersion:0 withDic:infArr[0]];
    [self.isInit setObject:@"true" forKey:[NSNumber numberWithInt:0]];
    [self.view addSubview:self.scrollView];
}
-(void)InitDetailVersion:(int)num withDic: (NSDictionary *) dic{
    UIImageView * desImgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * num + 10, 10, SCREEN_WIDTH-20, 70)];
    UITextView * descriptView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-20, 50)];
    NSString * description =infArr[num][@"description"];
    if([description isEqualToString:@""]){
        descriptView.text=@"暂无描述 ";
    }else{
        descriptView.text=infArr[num][@"description"];
    }
    [desImgView addSubview:descriptView];
    [self.scrollView addSubview:desImgView];

    NSArray * imgArr = infArr[num][@"picList"];
    //return [imgArr count];
    if([imgArr count] > 0){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 1;
        UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * num + 40, 90, SCREEN_WIDTH - 80 , SCREEN_HEIGHT - 300)  collectionViewLayout:layout];
        collectionView.backgroundColor=RGB(250, 250, 250);
        [collectionView setTag:num];
        self.automaticallyAdjustsScrollViewInsets = NO;
        collectionView.alpha=1;
    //self.collectionView.layer.cornerRadius=10;
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"myCell"];
        collectionView.delegate=self;
        collectionView.dataSource=self;
        [self.scrollView addSubview:collectionView];
    }
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray * arr = infArr[collectionView.tag][@"picList"];
    return [arr count];
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"myCell";
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    //UIImageView* detailImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, GAP_X, GAP_Y)];
    UIImageView * detailImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, GAP_X, GAP_Y)];
    NSString * imgStr = [NSString stringWithFormat:@"%@%@",@"http://139.196.56.202:8080/",infArr[collectionView.tag][@"picList"][indexPath.row]];
    imgStr=[imgStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [detailImageView setImageWithURL:[NSURL URLWithString:imgStr]];
    detailImageView.userInteractionEnabled=YES;
    [cell.contentView addSubview:detailImageView];
//    [cell.contentView addSubview:detailImageView];
    
    cell.backgroundColor = [UIColor colorWithRed:((100 * 2) / 255.0) green:((200 * 2)/255.0) blue:((300 * 2)/255.0) alpha:1.0f];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
        return CGSizeMake(GAP_X, GAP_Y);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(1, 1, 1, 1);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImgDetailVC * svc = [[ImgDetailVC alloc] init];
    svc.entryID=self.entryID;//[NSNumber numberWithInt:40];
    svc.descriptionStr=infArr[collectionView.tag][@"description"];
    svc.imgArr=infArr[collectionView.tag][@"picList"];
    self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
    [self.navigationController pushViewController:svc animated:YES];
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
//#define ThemeGreenColor  RGB(33, 197, 147)
//#define ThemeOrangeColor RGB(253, 112, 4)
//#define GreyLineColor RGBA(190,198,204,20)
//#define MoreGreyLineColor RGBA(190,198,204,100)
//#define ReloadBGColor RGBA(190,198,204,200)
//self.view.backgroundColor=RGBA(223,223,224,220);//[UIColor grayColor];
-(void)InitTopView:(int)num{
    self.topImgView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    self.topImgView.backgroundColor = RGB(245, 245, 245);
    self.topImgView.alpha=0.0;
    [self.view addSubview:self.topImgView];
    
    self.showHintLabel=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 70, 140, 140, 40)];
    self.showHintLabel.textColor=[UIColor whiteColor];
    self.showHintLabel.textAlignment=NSTextAlignmentCenter;
    NSString * firstVersionString = infArr[0][@"version"];
    if([firstVersionString isEqualToString:@"hunhe"]){
    }else{
        self.showHintLabel.text = infArr[0][@"version"] ;
    }
    [self.view addSubview:self.showHintLabel];
    //NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    //self.showHintLabel.text=[numberFormatter stringFromNumber:0];
    
    UIImageView * slideImgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 100, 107,  200, 2)];
    slideImgView.backgroundColor=GreyLineColor;//[UIColor grayColor];
    [self.view addSubview:slideImgView];
    
    self.versionImgArr=[NSMutableArray new];
    for(int i = 0 ; i < num ; i++){
        UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 100 + i * 200/(num-1) - 7, 100, 14, 14) ];
        imgView.layer.cornerRadius=7;
        if(i==0){
            imgView.backgroundColor=[UIColor whiteColor];
        }
        else{
            imgView.backgroundColor=MoreGreyLineColor;//[UIColor grayColor];
        }
        //[self.view addSubview:imgView];
        [self.versionImgArr addObject:imgView];
    }
    for(int i = 0 ; i < [self.versionImgArr count];i++){
        [self.view addSubview: self.versionImgArr[i]];
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int num = (int)(scrollView.contentOffset.x/SCREEN_WIDTH);
    NSLog(@"%d",num);
    
    if(num != viewPage){
        NSString * ooq = [self.isInit objectForKey:[NSNumber numberWithInt:num]] ;
        if([ooq isEqualToString:@"false"]){
            [self InitDetailVersion:num withDic:infArr[num]];
            [self.isInit setObject:@"true" forKey:[NSNumber numberWithInt:num]];
        }
        //[self.topImgView setBackgroundColor:RGB(255-(num%2)*10, 255-(num%2)*10, 255-(num%2)*10)];
        NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
        NSString* versonNumber = [numberFormatter stringFromNumber:[NSNumber numberWithInt:num]];
        if(![infArr[num][@"version"] isEqualToString:@"hunhe"]){
            self.showHintLabel.text = infArr[num][@"version"];
        }else{
            self.showHintLabel.text = @"";
        }
        [self.versionImgArr[viewPage] setBackgroundColor:MoreGreyLineColor];//[UIColor grayColor]
        [self.versionImgArr[num] setBackgroundColor:[UIColor whiteColor]];
        viewPage = num;
    }
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0)
        return 1;
    else{
        NSArray * imgArr = infArr[tableView.tag][@"picList"];
        return [imgArr count];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section==0){
        return 40;
    }
    return SCREEN_HEIGHT;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [[UITableViewCell alloc] init];
    
    if(indexPath.section==0){
        NSString * description = infArr[tableView.tag][@"description"];
        if([description isEqualToString:@""]){
            cell.textLabel.text=@"还未有描述";
        }
        else{
            cell.textLabel.text=description;
        }
    }
    else{
        UIImageView* detailImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        NSString * imgStr = [NSString stringWithFormat:@"%@%@",@"http://139.196.56.202:8080/",infArr[tableView.tag][@"picList"][indexPath.row]];
        imgStr=[imgStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [detailImageView setImageWithURL:[NSURL URLWithString:imgStr]];
        detailImageView.userInteractionEnabled=YES;
        [cell.contentView addSubview:detailImageView];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==1){
        ImgDetailVC * svc = [[ImgDetailVC alloc] init];
        svc.entryID=[NSNumber numberWithInt:40];
        svc.descriptionStr=@"暂无描述";
        svc.imgArr=infArr[tableView.tag][@"picList"];
        self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
        [self.navigationController pushViewController:svc animated:YES];
    }
}


@end
