//
//  AppDelegate.m
//  MusicPartnerDownload
//
//  Created by 度周末网络-王腾 on 16/1/25.
//  Copyright © 2016年 dzmmac. All rights reserved.
//

#import "AppDelegate.h"
#import "MusicPartnerDownloadManager.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[MusicPartnerDownloadManager sharedInstance] initUnFinishedTask];
    
    NSDate *now = [NSDate new];
    NSArray *contentArr = @[now];
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) lastObject] stringByAppendingPathComponent:@"demo.plist"];
    BOOL isSuccess = [contentArr writeToFile:path atomically:YES];
    if (isSuccess)
    {
        NSLog(@"写入成功");
    }
    else
    {
        NSLog(@"写入失败");
    }
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
 
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
 
}

- (void)applicationWillEnterForeground:(UIApplication *)application {

}

- (void)applicationDidBecomeActive:(UIApplication *)application {

}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}

@end
