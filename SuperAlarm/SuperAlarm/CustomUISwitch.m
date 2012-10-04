//
//  CustomUISwitch.m
//  SuperAlarm
//
//  Created by むーきー on 2012/08/18.
//  Copyright (c) 2012年 むーきー. All rights reserved.
//

#import "CustomUISwitch.h"

@implementation CustomUISwitch
@synthesize on,alarmOn;
static UIImage *alarmImageOn;

static UIImage *alarmImageOff;
-(void)initAlarmImage
{
    alarmImageOn = [UIImage imageNamed:@"alarmOn.png"];

    alarmImageOff = [UIImage imageNamed:@"alarmOff.png"];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        alarmImageOn = [UIImage imageNamed:@"alarmOn.png"];
        
        alarmImageOff = [UIImage imageNamed:@"alarmOff.png"];
    }
    [self setBackgroundImage:alarmImageOn forState:UIControlStateNormal];

    
    return self;
}
-(void)AlarmOn:(BOOL)On
{
    if(On){
        alarmOn = YES;
        [self setBackgroundImage:alarmImageOn forState:UIControlStateNormal];
        //NSLog(@"setOn");
    }else{
        alarmOn = NO;
        [self setBackgroundImage:alarmImageOff forState:UIControlStateNormal];
        //NSLog(@"setOff");
    }
}
-(void)switchChange:(BOOL)_on{
    if(_on){
        [self setBackgroundImage:[UIImage imageNamed:@"alarmOn.png"] forState:UIControlStateNormal];
    }else{
        [self setBackgroundImage:[UIImage imageNamed:@"alarmOff.png"] forState:UIControlStateNormal];

    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
