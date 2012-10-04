//
//  AlarmAppDelegate.m
//  UltimateAlarm
//
///  Created by  on 12/07/01.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AlarmAppDelegate.h"

@implementation AlarmAppDelegate

@synthesize window = _window;
@synthesize navigationController;
//@synthesize alarmTime;
@synthesize alarmStr;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    navigationController.delegate = self;
    
    // Add the navigation controller's view to the window and display.
    [self.window addSubview:navigationController.view];
    [self.window makeKeyAndVisible];
   // alarmTime = nil;
   // alarmTimeList =nil;
    clockViewController = [[ClockViewController alloc]init];
    
    [self customAppearance];
    myApplication = [UIApplication sharedApplication];
    myApplication.idleTimerDisabled = YES;
    
    AVAudioSession* audioSession = [AVAudioSession sharedInstance];
    NSError* error = nil;
   [audioSession setCategory:AVAudioSessionCategoryPlayback error:&error];
    [audioSession setActive:YES error:&error];
   // [self performSelector:@selector(playAlarm) withObject:self afterDelay:3];
    playAlarm = [[PlayAlarm alloc]init];
    return YES;
}
-(void)playAlarm{
    NSLog(@"play");
}
-(void)customAppearance
{
    UIColor *brownC = [[UIColor alloc] initWithRed:(CGFloat)120/255 green:(CGFloat)71/255 blue:(CGFloat)30/255 alpha:1];
    [[UITabBar appearance] setTintColor:brownC];
    [[UINavigationBar appearance] setTintColor:brownC];
    //[[UIDatePicker appearance] setTintColor:brownC];
   
    //[[UIButton appearance] setTintColor:[UIColor blackColor]];
    
}


- (void)navigationController:(UINavigationController *)navController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([viewController respondsToSelector:@selector(willAppearIn:)])
        [viewController performSelector:@selector(willAppearIn:) withObject:navController];
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    NSLog(@"Inactive");
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    NSLog(@"GO BackGround");
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    //[clockViewController addPush:clockViewController.nextAlarmTimeLabel.text];
    NSLog(@"sleeep");
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateInactive) {
        // 画面ロック
        [clockViewController addNofication];
    } else {
        [clockViewController addNofication];
    }
    
    myApplication.idleTimerDisabled = NO; //自動スリープ禁止
    NSUserDefaults *alarmDictionaryUserDefaults = [NSUserDefaults standardUserDefaults];

    [alarmDictionaryUserDefaults setObject:[ClockViewController getAlarmTimeList] forKey:@"alarmTimeList"];
    if([alarmDictionaryUserDefaults synchronize]){
        NSLog(@"同期完了");
    }
    
    //[ClockViewController performSelector:@selector(startAlarm) withObject:nil afterDelay:3];
    
   
   //バックグラウンドに入っても続行
    /*
    void (^handler)(void)  = ^{
        UIApplication* app = [UIApplication sharedApplication];
        [app endBackgroundTask:bgTask];
        bgTask = UIBackgroundTaskInvalid;
    };
    bgTask = [application beginBackgroundTaskWithExpirationHandler:handler];
    [application setKeepAliveTimeout:600 handler:^{
        if (!bgTask || bgTask == UIBackgroundTaskInvalid) {
            UIApplication* app = [UIApplication sharedApplication];
            bgTask = [app beginBackgroundTaskWithExpirationHandler:handler];
        }
    }];
    */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    NSLog(@"came");

}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     NSLog(@"active");
}

- (void)applicationWillTerminate:(UIApplication *)application
{
   
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    NSLog(@"通知うけとり");
  [[UIApplication sharedApplication] cancelLocalNotification:notification];
}




@end
