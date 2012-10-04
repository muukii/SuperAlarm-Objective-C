//
//  AddAlarmViewController.h
//  UltimateAlarm
//
//  Created by むーきー on 12/07/26.
//
//

#import <UIKit/UIKit.h>
#import "AlarmSoundTableViewCotroller.h"
#import "AlarmWhatDayViewController.h"
//#import "ClockViewController.h"
@protocol AlarmTimeDelegate;


@interface AddAlarmViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,whatDaySelectDidFinishDelegate>
{
    NSMutableDictionary *alarmDictionary;
    UISwitch *repeatUISwitch;
    UISwitch *snoozeUISwitch;
    int switchTag;
    
}
- (IBAction)AddAlarmTime:(id)sender;
//-(void)setDetailItem:(id)newDetailItem;
-(void)setDetailItem:(id)newDetailItem indexPath:(NSIndexPath *)indexPath switchTag:(int)_switchTag;

@property (weak, nonatomic) IBOutlet UITableView *SettingTableView;
@property (nonatomic, assign) id  delegate;
@property (weak, nonatomic) IBOutlet UIDatePicker *alarmTimePicker;
@property (weak, nonatomic) IBOutlet UITableView *settingTable;
@property (strong, nonatomic) id detailItem;
@property int switchTag;


@end

@protocol AddAlarmViewControllerDelegate
- (void)AddAlarmViewControllerDidFinish:(AddAlarmViewController *)controller;
@end
@protocol AlarmTimeDelegate
@optional
- (void)AlarmTimeSetDidFinish:(NSDate *)alarmTime;
-(void)AlarmDictionarySetDidFinish:(NSDictionary *)alarmDictionary;
-(void)AlarmEditDictionarySetDidFinish:(NSDictionary *)alarmDictionary indexPath:(NSIndexPath *)indexPath;

@end


