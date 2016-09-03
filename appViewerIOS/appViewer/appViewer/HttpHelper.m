//
//  HttpHelper.m
//  appViewer
//
//  Created by JuZhen on 16/6/4.
//  Copyright © 2016年 JuZhen. All rights reserved.
//


#import "AFNetworking.h"
//#import "HUDPromptToast.h"
#include "head.h"
#import "AFHTTPRequestOperation.h"
#import "HttpHelper.h"
@class AFHTTPRequestOperation;
@implementation HttpHelper

+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.requestSerializer.timeoutInterval = 5;
    [mgr.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    // 2.发送GET请求
    [mgr GET:url parameters:params
     success:^(AFHTTPRequestOperation *operation, id responseObj) {
         if (success) {
             success(responseObj);
         }
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         if (failure) {
             failure(error);
         }
     }];
    
}

+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success fail:(void (^)(AFHTTPRequestOperation *))failure
{
    // 1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.requestSerializer.timeoutInterval = 5;
    [mgr.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        //[mgr.requestSerializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    // 2.发送GET请求
    [mgr GET:url parameters:params
     success:^(AFHTTPRequestOperation *operation, id responseObj) {
         if (success) {
             success(responseObj);
         }
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         if (failure) {
             failure(operation);
         }
     }];
    
}

+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //申明请求的数据是json类型
    mgr.requestSerializer = [AFJSONRequestSerializer serializer];
    //申明返回的结果是json类型
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    mgr.requestSerializer.timeoutInterval = 5;
    //[mgr.requestSerializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Accept"];
    //[mgr.requestSerializer se]
    [mgr.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    //[mgr.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    ///[mgr.requestSerializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    //[mgr.reachabilityManager setValuesForKeysWithDictionary:@"application/json;charset=utf-8"];
    NSLog(@"%@",mgr);
    // 2.发送POST请求
    [mgr POST:url parameters:params
      success:^(AFHTTPRequestOperation *operation, id responseObj) {
          if (success) {
              success(responseObj);
          }
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          if (failure) {
              failure(error);
          }
      }];
}

+ (void)getIdentify:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.requestSerializer.timeoutInterval = 5;
    mgr.requestSerializer = [AFJSONRequestSerializer serializer];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    if ([[NSUserDefaults standardUserDefaults]objectForKey:TOKEN]) {
        [mgr.requestSerializer setValue:[[NSUserDefaults standardUserDefaults]objectForKey:TOKEN] forHTTPHeaderField:@"Authorization"];
    }
    // 2.发送GET请求
    [mgr GET:url parameters:params
     success:^(AFHTTPRequestOperation *operation, id responseObj) {
         if (success) {
             success(responseObj);
         }
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         if (failure) {
             failure(error);
             //[JUtils httpShowWarn:operation.responseString];
         }
     }];
}

+ (void)postIdentify:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //申明请求的数据是json类型
    mgr.requestSerializer = [AFJSONRequestSerializer serializer];
    //申明返回的结果是json类型
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    mgr.requestSerializer.timeoutInterval = 5;
    mgr.requestSerializer = [AFJSONRequestSerializer serializer];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    if ([[NSUserDefaults standardUserDefaults]objectForKey:TOKEN]) {
        [mgr.requestSerializer setValue:[[NSUserDefaults standardUserDefaults]objectForKey:TOKEN] forHTTPHeaderField:@"Authorization"];
    }
    // 2.发送POST请求
    [mgr POST:url parameters:params
      success:^(AFHTTPRequestOperation *operation, id responseObj) {
          if (success) {
              success(responseObj);
          }
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          if (failure) {
              failure(error);
              //            NSDictionary * dic1 =  [JUtils dictionaryWithJsonString:operation.responseString];
              //             NSDictionary * dic2 = [dic1 objectForKey:@"message"];
             // [JUtils httpShowWarn:operation.responseString];
              
          }
      }];
}


+ (void)deleteIdentify:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.requestSerializer.timeoutInterval = 5;
    mgr.requestSerializer = [AFJSONRequestSerializer serializer];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    if ([[NSUserDefaults standardUserDefaults]objectForKey:TOKEN]) {
        [mgr.requestSerializer setValue:[[NSUserDefaults standardUserDefaults]objectForKey:TOKEN] forHTTPHeaderField:@"Authorization"];
    }
    // 2.发送delete请求
    [mgr DELETE:url parameters:params
        success:^(AFHTTPRequestOperation *operation, id responseObj) {
            if (success) {
                success(responseObj);
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if (failure) {
                failure(error);
                //            NSDictionary * dic1 =  [JUtils dictionaryWithJsonString:operation.responseString];
                //             NSDictionary * dic2 = [dic1 objectForKey:@"message"];
                //[JUtils httpShowWarn:operation.responseString];
                
            }
        }];
}

+ (void)putIdentify:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    // 1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.requestSerializer.timeoutInterval = 5;
    mgr.requestSerializer = [AFJSONRequestSerializer serializer];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    if ([[NSUserDefaults standardUserDefaults]objectForKey:TOKEN]) {
        [mgr.requestSerializer setValue:[[NSUserDefaults standardUserDefaults]objectForKey:TOKEN] forHTTPHeaderField:@"Authorization"];
    }
    
    [mgr PUT:url parameters:params
     success:^(AFHTTPRequestOperation *operation, id responseObj) {
         if (success) {
             success(responseObj);
         }
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         if (error) {
             //            NSDictionary * dic1 =  [JUtils dictionaryWithJsonString:operation.responseString];
             //             NSDictionary * dic2 = [dic1 objectForKey:@"message"];
             //[JUtils httpShowWarn:operation.responseString];
             
         }
     }];
}

+(void)postImg:(NSString *)url img:(UIImage *) img success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    NSData * data =UIImageJPEGRepresentation(img, 1.0);
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain", nil];
    [manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults]objectForKey:@"TOKEN"] forHTTPHeaderField:@"Authorization"];
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:data name:@"file"fileName:@"test.jpg"mimeType:@"image/jpg"];
    }success:^(AFHTTPRequestOperation *operation,id responseObject) {
        if(success){
            success(responseObject);
        }
    }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
        if(failure){
            failure(error);
        }
    }];
}
@end
