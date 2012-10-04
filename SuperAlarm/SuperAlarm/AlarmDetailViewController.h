//
//  AlarmDetailViewController.h
//  k
//
//  Created by むーきー on 2012/07/31.
//  Copyright (c) 2012年 むーきー. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlarmTime.h"

@interface AlarmDetailViewController : UIViewController
@property (nonatomic, assign) id  delegate;
- (IBAction)CancelAlarmTime:(id)sender;

- (IBAction)AddAlarmTime:(id)sender;

@property (weak, nonatomic) IBOutlet UIDatePicker *alarmTimePicker;
@property (strong, nonatomic) AlarmTime *detailItem;
@property (weak, nonatomic) IBOutlet UISwitch *repeatSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *snoozeSwitch;
@property (weak, nonatomic) IBOutlet UILabel *soundsLabel;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
