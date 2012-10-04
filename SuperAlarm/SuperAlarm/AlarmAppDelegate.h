//
//  AlarmAppDelegate.h
//  UltimateAlarm
//
//  Created by  on 12/07/01.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ClockViewController.h"
#import "PlayAlarm.h"

@interface AlarmAppDelegate : NSObject <UIApplicationDelegate, UINavigationControllerDelegate>

{
    UIWindow *window;
    UINavigationController *navigationController;
    NSDate *alarmTime;
    //__strong NSMutableArray *alarmTimeList;
    NSString *alarmStr;
    ClockViewController *clockViewController;
    UIApplication * myApplication;
    UIBackgroundTaskIdentifier bgTask;
    PlayAlarm *playAlarm;

}
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) NSDate *alarmTime;
//@property (strong, retain) NSMutableArray *alarmTimeList;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;


@property (strong) NSString *alarmStr;

@end
