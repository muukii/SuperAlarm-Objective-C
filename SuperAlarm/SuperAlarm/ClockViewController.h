//
//  ClockViewController.h
//  UltimateAlarm
//
//  Created by  on 12/07/05.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "AlarmAppDelegate.h"
#import "PlayAlarm.h"
#import "WBNoticeView.h"
#import "WBErrorNoticeView.h"
#import "WBSuccessNoticeView.h"
#import "WBStickyNoticeView.h"
#import "Circle.h"
#import "AlarmMiniView.h"
//#import "AlarmTableViewController.h"

//#import <AVFoundation/AVFoundation.h>

@interface ClockViewController : UIViewController <AVAudioPlayerDelegate,alarmMiniViewTouchUpDelegate>
{
    PlayAlarm *playAlarm;
    NSString* dateString;
   // AlarmAppDelegate *alarmAppDelegate;
   
    AlarmMiniView *miniView;
    
}
@property (weak, nonatomic) IBOutlet UILabel *weekDayLable;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageVIewC;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nextAlarmTextLabel;
+(void)setAlarmTimeList:(NSMutableArray *)__alarmTimeList;
+(id)getAlarmTimeList;
+(void)setNextAlarmTimeStatic;
+(id)getNextAlarmTimeStatic;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
-(void)addNofication;
- (IBAction)stop:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *clockLabelS;
@property (weak, nonatomic) IBOutlet UILabel *clockLabelH;
@property (weak, nonatomic) IBOutlet UILabel *clockLabelM;
@property (weak, nonatomic) IBOutlet UILabel *alarmTimeLabel;
@property (strong, nonatomic) IBOutlet Circle *circle;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)testAlarm:(id)sender;
- (IBAction)NoticeView:(id)sender;
- (IBAction)alarmUISwith:(id)sender;
-(void)checkAlarmTimeList;
@property (weak, nonatomic) IBOutlet UIButton *alarmButton;
@property (weak, nonatomic) IBOutlet UILabel *nextAlarmTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *next2AlarmTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *next3AlarmTimeLabel;
- (void)startAlarm;

- (IBAction)test:(id)sender;
- (IBAction)showMiniView:(id)sender;




@end
