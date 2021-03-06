//
//  API.m
//  GoodLuck
//
//  Created by HoJolin on 15/8/22.
//
//

#import "API.h"

static NSMutableDictionary *picDic;
static NSMutableDictionary *nameDic;
static NSMutableDictionary *avatarDic;
static NSMutableDictionary *uidDic;
static NSDictionary *myInfo;
static NSArray *chiefTeacher;

@implementation API

- (void)login:(NSString *)username password:(NSString *)password {
    [self post:@"auth.action" dic:@{@"username": username, @"password": password}];
}

- (void)getMyInfo {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *yo_token = [ud objectForKey:@"yo_token"];
    [self post:@"getMyInfo.action" dic:@{@"token": yo_token}];
}

- (void)getMyCollectionTeachers {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *yo_token = [ud objectForKey:@"yo_token"];
    [self post:@"getMyCollectionTeachers.action" dic:@{@"token": yo_token}];
}

- (void)getTeachersFromJobTag {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *yo_token = [ud objectForKey:@"yo_token"];
    [self post:@"getTeachersFromJobTag.action" dic:@{@"token": yo_token}];
}

- (void)getTopicNews {
    [self post:@"getTopicNews.action" dic:nil];
}

- (void)setAvatar:(UIImage *)img {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *yo_token = [ud objectForKey:@"yo_token"];
    NSData *imgData = UIImageJPEGRepresentation(img, 1.0);
    NSData *base64Img = [imgData base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSString *stringImg = [[NSString alloc]initWithData:base64Img encoding:NSUTF8StringEncoding];
    stringImg = [stringImg stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
    stringImg = [NSString stringWithFormat:@"data:image/jpeg;base64,%@", stringImg];
    [self post:@"setAvatar.action" dic:@{@"token": yo_token, @"base64Files": stringImg}];
}

- (void)setNickname:(NSString *)nickname {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *yo_token = [ud objectForKey:@"yo_token"];
    [self post:@"setName.action" dic:@{@"token": yo_token, @"nickname": nickname}];
}

- (void)setAddress:(NSString *)address {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *yo_token = [ud objectForKey:@"yo_token"];
    [self post:@"setAddress.action" dic:@{@"token": yo_token, @"address": address}];
}

- (void)setEmail:(NSString *)email {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *yo_token = [ud objectForKey:@"yo_token"];
    [self post:@"setEmail.action" dic:@{@"token": yo_token, @"email": email}];
}

- (void)setPassword:(NSString *)newPass oldPass:(NSString *)oldPass {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *yo_token = [ud objectForKey:@"yo_token"];
    [self post:@"setPassword.action" dic:@{@"token": yo_token, @"newPassword": newPass, @"oldPassword": oldPass}];
}

- (void)setGender:(NSString *)gender {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *yo_token = [ud objectForKey:@"yo_token"];
    [self post:@"setGender.action" dic:@{@"token": yo_token, @"gender": gender}];
}

- (void)findPassword:(NSString *)phone {
    [self post:@"findPassword.action" dic:@{@"phone": phone}];
}

- (void)sendAuthCode:(NSString *)phone {
    [self post:@"resendAuthcode.action" dic:@{@"phone": phone}];
}

- (void)checkAuthCode:(NSString *)phone authCode:(NSString *)authCode {
    [self post:@"checkAuthcode.action" dic:@{@"phone": phone, @"auth_code": authCode}];
}

- (void)registerAction:(NSString *)username phone:(NSString *)phone password:(NSString *)password authCode:(NSString *)authCode {
    [self post:@"register.action" dic:@{@"username": username, @"phone": phone, @"password": password, @"type": @"0", @"identification": @"0", @"code": authCode}];
    
}

- (void)authForWeixin:(NSString *)weixin avatarURL:(NSString *)avatarURL nickname:(NSString *)nickname gender:(NSString *)gender {
    [self post:@"authForWeixin.action" dic:@{@"weixin": weixin, @"avatarURL": avatarURL, @"nickname": nickname, @"gender": gender}];
}

- (void)getMyVouchers {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *yo_token = [ud objectForKey:@"yo_token"];
    [self post:@"getMyVouchers.action" dic:@{@"token": yo_token}];
}

- (void)getTreasures {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *yo_token = [ud objectForKey:@"yo_token"];
    [self post:@"getTreasures.action" dic:@{@"token": yo_token}];
}

- (void)buyTreasure:(NSString *)tid addressee:(NSString *)addressee phone:(NSString *)phone address:(NSString *)address {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *yo_token = [ud objectForKey:@"yo_token"];
    [self post:@"buyTreasure.action" dic:@{@"token": yo_token, @"tid": tid, @"addressee": addressee, @"phone": phone, @"address": address}];
}

- (void)addLotteryValueWithInviteCode:(NSString *)inviteCode {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *yo_token = [ud objectForKey:@"yo_token"];
    [self post:@"addLotteryValueWithInviteCode.action" dic:@{@"token": yo_token, @"inviteCode": inviteCode}];
}

- (void)addPhoneWithVerification:(NSString *)phone verifyCode:(NSString *)verifyCode {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *yo_token = [ud objectForKey:@"yo_token"];
    [self post:@"addPhoneWithVerification.action" dic:@{@"token": yo_token, @"phone": phone, @"verifyCode": verifyCode}];
}

- (void)addLotteryRecord {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *yo_token = [ud objectForKey:@"yo_token"];
    [self post:@"addLotteryRecord.action" dic:@{@"token": yo_token}];
}

- (void)addCollectionTeacher:(NSString *)uid {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *yo_token = [ud objectForKey:@"yo_token"];
    [self post:@"addCollectionTeacher.action" dic:@{@"token": yo_token, @"teacherUID": uid}];
}

- (void)deleteCollectionTeacher:(NSString *)uid {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *yo_token = [ud objectForKey:@"yo_token"];
    [self post:@"deleteCollectionTeacher.action" dic:@{@"token": yo_token, @"teacherUID": uid}];
}

- (void)getTheme {
    [self post:@"getAllThemeCategories.action" dic:@{}];
}

- (void)getForums:(NSString *)categoryID {
    [self post:@"getForums.action" dic:@{@"categoryID": categoryID}];
}

- (void)getComments:(NSString *)forumID {
    [self post:@"getForumComments.action" dic:@{@"forumID": forumID}];
}

- (void)getEntryComments:(NSString *)entryID {
    [self post:@"getEntryComments.action" dic:@{@"entryID": entryID}];
}

- (void)addForum:(NSString *)title description:(NSString *)description categoryID:(NSString *)categoryID picturePaths:(NSString *)picturePaths {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *yo_token = [ud objectForKey:@"token"];
    [self post:@"addForum.action" dic:@{@"token": yo_token, @"title": title, @"description": description, @"categoryID": categoryID, @"picturePaths": picturePaths}];
}

- (void)addEntryComment:(NSString *)entryID talkerID:(NSString *)talkerID content:(NSString *)content picturePaths:(NSString *)picturePaths {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *yo_token = [ud objectForKey:@"token"];
    [self post:@"addEntryComment.action" dic:@{@"token": yo_token, @"entryID": entryID, @"talkerID": talkerID, @"content": content, @"picturePaths": picturePaths}];
}

- (void)uploadImage:(UIImage *)img {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *yo_token = [ud objectForKey:@"token"];
    NSData *imgData = UIImageJPEGRepresentation(img, 1.0);
    NSData *base64Img = [imgData base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSString *stringImg = [[NSString alloc]initWithData:base64Img encoding:NSUTF8StringEncoding];
    stringImg = [stringImg stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
    stringImg = [NSString stringWithFormat:@"data:image/jpeg;base64,%@", stringImg];
    [self post:@"uploadImage.action" dic:@{@"base64File": stringImg, @"token": yo_token}];
}

- (void)addForumComment:(NSString *)forumID talkerID:(NSString *)talkerID content:(NSString *)content picturePaths:(NSString *)picturePaths {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *yo_token = [ud objectForKey:@"token"];
    [self post:@"addForumComment.action" dic:@{@"token": yo_token, @"forumID": forumID, @"talkerID": talkerID, @"content": content, @"picturePaths": picturePaths}];
}

- (void)post:(NSString *)action dic:(NSDictionary *)dic {
    NSLog(@"%@", dic);
    NSString *str = [NSString stringWithFormat:@"%@/appviewer/api/%@", HOST, action];
    NSURL *url = [NSURL URLWithString:str];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    NSMutableArray *parametersArray = [[NSMutableArray alloc]init];
    for (NSString *key in [dic allKeys]) {
        id value = [dic objectForKey:key];
        if ([value isKindOfClass:[NSString class]]) {
            [parametersArray addObject:[NSString stringWithFormat:@"%@=%@",key,value]];
        }     
    }
    NSString *dicString = [parametersArray componentsJoinedByString:@"&"];
    NSData *data = [dicString dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPBody = data;
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError == nil) {
            NSError *err = nil;
            id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
            if(jsonObject != nil && err == nil){
                if([jsonObject isKindOfClass:[NSDictionary class]]){
                    NSDictionary *deserializedDictionary = (NSDictionary *)jsonObject;
                    long errNo = [deserializedDictionary[@"errno"]integerValue];
                    if (errNo == 0) {
                        if (self->_delegate) {
                            [self->_delegate didReceiveAPIResponseOf:self data:deserializedDictionary];
                        }
                    }
                    else {
                        if (self->_delegate) {
                            [self->_delegate didReceiveAPIErrorOf:self data:errNo];
                        }
                    }
                }else if([jsonObject isKindOfClass:[NSArray class]]){
                    if (self->_delegate) {
                        [self->_delegate didReceiveAPIErrorOf:self data:-999];
                    }
                }
            }
            else if(err != nil){
                if (self->_delegate) {
                    [self->_delegate didReceiveAPIErrorOf:self data:-777];
                }
            }
        }
        else {
            if (self->_delegate) {
                [self->_delegate didReceiveAPIErrorOf:self data:-888];
            }
        }
    }];
}

+ (UIImage *)getPicByKey:(NSString *)key {
    if (picDic != nil) {
        return [picDic objectForKey:key];
    }
    return nil;
}

+ (void)setPicByKey:(NSString *)key pic:(UIImage *)pic {
    if (picDic == nil) {
        picDic = [[NSMutableDictionary alloc]init];
    }
    [picDic setValue:pic forKey:key];
}

+ (NSString *)getNameByKey:(NSString *)key {
    if (nameDic != nil) {
        return [nameDic objectForKey:key];
    }
    return nil;
}

+ (void)setNameByKey:(NSString *)key name:(NSString *)name {
    if (nameDic == nil) {
        nameDic = [[NSMutableDictionary alloc]init];
    }
    [nameDic setValue:name forKey:key];
}

+ (NSString *)getAvatarByKey:(NSString *)key {
    if (avatarDic != nil) {
        return [avatarDic objectForKey:key];
    }
    return nil;
}

+ (void)setAvatarByKey:(NSString *)key name:(NSString *)name {
    if (avatarDic == nil) {
        avatarDic = [[NSMutableDictionary alloc]init];
    }
    [avatarDic setValue:name forKey:key];
}

+ (NSString *)getUidByKey:(NSString *)key {
    if (uidDic != nil) {
        return [uidDic objectForKey:key];
    }
    return nil;
}

+ (void)setUidByKey:(NSString *)key uid:(NSString *)uid {
    if (uidDic == nil) {
        uidDic = [[NSMutableDictionary alloc]init];
    }
    [uidDic setValue:uid forKey:key];
}

+ (void)setInfo:(NSDictionary *)info {
    myInfo = info;
}

+ (NSDictionary *)getInfo {
    return myInfo;
}

+ (void)setChief:(NSArray *)chief {
    chiefTeacher = chief;
}

+ (NSArray *)getChief {
    return chiefTeacher;
}

+ (NSString *)LanguageString:(NSUInteger)num {
    return @[@"All", @"English", @"French", @"Japanese", @"Korean", @"Spanish", @"Russian", @"German", @"Chinese"][num];
}

+ (NSString *)CountryString:(NSUInteger)num {
    return @[@"Other", @"US", @"UK", @"Japan", @"Korea", @"Spain", @"Italy", @"Germany", @"France", @"Belgium", @"Philippine", @"Malaysia", @"Switzerland", @"Australia", @"Thailand", @"Sweden", @"India", @"Iran", @"Russia", @"Other"][num];
}

@end
