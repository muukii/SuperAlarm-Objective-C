//
//  Circle.h
//  SuperAlarm
//
//  Created by むーきー on 2012/08/01.
//  Copyright (c) 2012年 むーきー. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Circle : UIView
{
    UIColor *alarmColor;
    BOOL * alarmSwitch;
    NSDateFormatter *timeFormatter;
    NSString *date;
   
    double _radianSec,_radianMin,_radianHour;
}
-(void)AnimationDot:(int)_sec Min:(int)_min Hour:(int)_hour;
-(void)AnimationDotAlarm:(int)_sec Min:(int)_min Hour:(int)_hour On:(BOOL)_alarmSwitch;
-(void)alarmSwitch:(BOOL)_alarmSwitch;
@property int __sec,__min,__hour;
@property double ovalLineWidth,ovalX,ovalY,ovalWidth,ovalHeight;
@property double dotSecX,dotSecY,dotMinX,dotMinY,dotHourX,dotHourY,dotWidth,dotHeight;
@property double radius,triX,triY;
@property double sec,min,hour,alarmSec,alarmMin,alarmHour;
@property double alarmDotSecX,alarmDotSecY,alarmDotMinX,alarmDotMinY,alarmDotHourX,alarmDotHourY;
@property double dot12X,dot12Y,dot15X,dot15Y,dot18X,dot18Y,dot21X,dot21Y;
@end
