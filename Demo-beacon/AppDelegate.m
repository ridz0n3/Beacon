//
//  AppDelegate.m
//  Demo-beacon
//
//  Created by ME-Tech Mac User 1 on 10/12/15.
//  Copyright (c) 2015 Me-tech. All rights reserved.
//

#import "AppDelegate.h"
#import <EstimoteSDK/EstimoteSDK.h>
#import "BeaconTableViewController.h"

@interface AppDelegate ()<ESTBeaconManagerDelegate>
@property(nonatomic,strong) ESTBeaconManager *beaconManager;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [ESTConfig setupAppID:@"demo-beacon-6yj" andAppToken:@"b08c018d05d0d6176d3d609bd7f768cb"];
    
    self.beaconManager = [ESTBeaconManager new];
    self.beaconManager.delegate = self;
    // add this below:
    [self.beaconManager requestAlwaysAuthorization];
    // add this below:
    [self.beaconManager startMonitoringForRegion:[[CLBeaconRegion alloc]
                                                  initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:@"8492E75F-4FD6-469D-B132-043FE94921D8"] major:2793 minor:19481 identifier:@"monitored region"]];
    
    [[UIApplication sharedApplication]
     registerUserNotificationSettings:[UIUserNotificationSettings
                                       settingsForTypes:UIUserNotificationTypeAlert
                                       categories:nil]];
    [application registerForRemoteNotifications];
    
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *str = [NSString
                     stringWithFormat:@"Device Token=%@",deviceToken];
    NSLog(@"%@",str);
    // After device is registered in iOS to receive Push Notifications,
    // device token has to be sent to Estimote Cloud.
    
    ESTRequestRegisterDevice *request = [[ESTRequestRegisterDevice alloc] initWithDeviceToken:deviceToken];
    [request sendRequestWithCompletion:^(NSError *error) {
        
    }];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    // Verify if push is comming from Estimote Cloud and is related
    // to remote beacon management
    if ([ESTBulkUpdater verifyPushNotificationPayload:userInfo])
    {
        // pending settings are fetched and performed automatically
        // after startWithCloudSettingsAndTimeout: method call
        [[ESTBulkUpdater sharedInstance] startWithCloudSettingsAndTimeout:60 * 60];
    }
    
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    
}

- (void)beaconManager:(id)manager didEnterRegion:(CLBeaconRegion *)region {
    
    NSLog(@"%@",region);
    UILocalNotification *notification = [UILocalNotification new];
    notification.alertBody =
    @"Your gate closes in 47 minutes. "
    "Current security wait time is 15 minutes, "
    "and it's a 5 minute walk from security to the gate. "
    "Looks like you've got plenty of time!";
    
    NSDictionary *infoDict = [NSDictionary dictionaryWithObject:@"test" forKey:@"MyKeyName"];
    notification.userInfo = infoDict;
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
