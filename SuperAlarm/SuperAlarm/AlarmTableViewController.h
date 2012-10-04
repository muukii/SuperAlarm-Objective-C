//
//  AlarmTableViewController.h
//  SuperAlarm
//
//  Created by むーきー on 2012/07/31.
//  Copyright (c) 2012年 むーきー. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "AlarmAppDelegate.h"
#import "AddAlarmViewController.h"
#import "CustomUISwitch.h"
#import "ClockViewController.h"

@interface AlarmTableViewController : UITableViewController <AddAlarmViewControllerDelegate,AlarmTimeDelegate>
{
    
    
    NSUserDefaults *alarmDictionaryUserDefaults;
	NSDate* selectedDate;
    //NSMutableDictionary *alarmDictionary;
   // AlarmAppDelegate *alarmAppDelegate;
}
+(void)initWithAlarmTimeList;


@property (strong,nonatomic) NSMutableArray *alarmTimeList;
@property (strong,nonatomic) NSSortDescriptor *sortDate ;
@property (strong,nonatomic) NSMutableArray *sortDescArray ;
@property (strong,nonatomic) NSMutableArray *_alarmTimeList;

@end
