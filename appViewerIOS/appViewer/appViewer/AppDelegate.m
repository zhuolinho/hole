//
//  AppDelegate.m
//  appViewer
//
//  Created by JuZhen on 16/6/3.
//  Copyright © 2016年 JuZhen. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "JPUSHService.h"
#include <AVFoundation/AVFoundation.h>
@interface AppDelegate ()
@property (nonatomic,strong) AVAudioPlayer * AVPlayer;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    } else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    
    //如不需要使用IDFA，advertisingIdentifier 可为nil
    [JPUSHService setupWithOption:launchOptions
                           appKey:@"90b94d0aaffe62d6656ffe24"
                          channel:@"Publish channel"
                 apsForProduction:YES
            advertisingIdentifier:nil];
    [self initPlayer];
    if([[NSUserDefaults standardUserDefaults] valueForKey:@"playMusic"]){
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"playMusic"] isEqualToString:@"yes"]) {
            [self startPlay];
        }
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"playMusic"];
        [self startPlay];
    }
    [NSTimer scheduledTimerWithTimeInterval:20/60.0 target:self selector:@selector(timerAdvanced:) userInfo:nil repeats:YES];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    MainViewController * main = [[MainViewController alloc] init];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:main];

    [self.window setRootViewController:nav1];
    [self.window makeKeyAndVisible];
    // Override point for customization after application launch.
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [JPUSHService handleRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
      [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)timerAdvanced:(NSTimer * )timer
{
    if([[NSUserDefaults standardUserDefaults] valueForKey:@"playMusic"]){
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"playMusic"] isEqualToString:@"yes"]) {
            [self startPlay];
        }else{
            [self endPlay];
        }
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"playMusic"];
        [self endPlay];
    }
}

-(void) initPlayer{
    NSString * musicPath=[[NSBundle mainBundle] pathForResource:@"1" ofType:@"MP4"];
    //NSURL *url1=[NSURL fileURLWithPath:[[[NSBundle mainBundle] pathForResource:@"1" ofType:@"mp4"]];
    //AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:url1 error:nil];
    NSURL *url=[[NSBundle mainBundle]URLForResource:@"811_0015_1.MP4" withExtension:Nil];
    self.AVPlayer=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:Nil];
    [self.AVPlayer prepareToPlay];
}
-(void) startPlay{
    [self.AVPlayer play];
}
-(void) endPlay{
    [self.AVPlayer stop];
}
-(void) buttonMusicPlay{
    //1.获得音效文件的全路径
    
    NSURL *url=[[NSBundle mainBundle]URLForResource:@"1.MP4" withExtension:nil];
    
    //2.加载音效文件，创建音效ID（SoundID,一个ID对应一个音效文件）
    SystemSoundID soundID=0;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundID);
    
    //把需要销毁的音效文件的ID传递给它既可销毁
    //AudioServicesDisposeSystemSoundID(soundID);
    
    //3.播放音效文件
    //下面的两个函数都可以用来播放音效文件，第一个函数伴随有震动效果
    AudioServicesPlayAlertSound(soundID);
    //AudioServicesPlaySystemSound(<#SystemSoundID inSystemSoundID#>)
}
@end
