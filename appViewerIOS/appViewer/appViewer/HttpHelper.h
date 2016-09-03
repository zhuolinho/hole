//
//  HttpHelper.h
//  appViewer
//
//  Created by JuZhen on 16/6/4.
//  Copyright © 2016年 JuZhen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class AFHTTPRequestOperation;
@interface HttpHelper : NSObject
/**
 *  发送一个GET请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;
+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj))success fail:(void (^)(AFHTTPRequestOperation *operation))failure;

+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;

+ (void)getIdentify:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure;

+ (void)postIdentify:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure;

+ (void)deleteIdentify:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure;

+ (void)putIdentify:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure;

+ (void)postImg:(NSString *)url img:(UIImage *) img success:(void (^)(id))success failure:(void (^)(NSError *))failure;
@end
