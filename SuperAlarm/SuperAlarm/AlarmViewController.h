//
//  AlarmViewController.h
//  UltimateAlarm
//
//  Created by  on 12/07/05.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlarmAppDelegate.h"
#import "ClockViewController.h"
#import "AddAlarmViewController.h"

@interface AlarmViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *alarmTimeList;
    
	NSDate* selectedDate;
    
    AlarmAppDelegate *alarmAppDelegate;
}


@property (weak, nonatomic) IBOutlet UITableView *alarmTimeTable;

- (IBAction)EditButton:(id)sender;


@end
