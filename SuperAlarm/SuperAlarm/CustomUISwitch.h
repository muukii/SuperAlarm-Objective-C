//
//  CustomUISwitch.h
//  SuperAlarm
//
//  Created by むーきー on 2012/08/18.
//  Copyright (c) 2012年 むーきー. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomUISwitch : UIButton
-(void)switchChange:(BOOL)_on;
-(void)initAlarmImage;
-(void)AlarmOn:(BOOL)On;

@property(nonatomic,getter=isOn) BOOL on;
@property BOOL alarmOn;
//@property UIImage *alarmImageOn;
//@property UIImage *alarmImageOff;
@end
