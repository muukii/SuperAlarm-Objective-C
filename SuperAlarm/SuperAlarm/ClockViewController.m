//
//  ClockViewController.m
//  UltimateAlarm
//
//  Created by  on 12/07/05.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ClockViewController.h"
#import "AlarmAppDelegate.h"
#import <AVFoundation/AVFoundation.h>



@interface ClockViewController ()
{
    NSDateFormatter *timeFormatter;
    NSString *date;
    int sec,min,hour;
    double _radianSec,_radianMin,_radianHour;
    
    NSMutableArray *alarmTimeOnList;
    NSDateFormatter* formatterTimeH ;
    NSDateFormatter* formatterTimeM ;
    NSDateFormatter* formatterTimeS ;
    NSDateFormatter* formatterDay ;
    NSDateFormatter* formatterMonth ;
    int playingAlarmIndex;
    NSCalendar *calendar;
    NSDateComponents *comps;
    NSInteger weekday;
}
@end

@implementation ClockViewController
@synthesize weekDayLable;
@synthesize iconImageVIewC;
@synthesize iconImageView;
@synthesize nextAlarmTextLabel;
__strong static id nextAlarmTimeStatic;

@synthesize nextAlarmTimeLabel;
@synthesize next2AlarmTimeLabel;
@synthesize next3AlarmTimeLabel;
@synthesize dayLabel;
@synthesize monthLabel;
@synthesize alarmButton;

@synthesize clockLabelH;
@synthesize clockLabelM;
@synthesize alarmTimeLabel;
@synthesize circle;
@synthesize imageView;
@synthesize clockLabelS;


static NSMutableArray *staticAlarmTimeList;
static NSMutableArray *alarmNextTimeList;
+(void)setAlarmTimeList:(NSMutableArray *)__alarmTimeList
{
    staticAlarmTimeList = [NSMutableArray arrayWithArray:(NSMutableArray *)__alarmTimeList];
}
+(id)getAlarmTimeList{
    return staticAlarmTimeList;
}
+(id)getNextAlarmTimeStatic
{
    return nextAlarmTimeStatic;
}


+(void)setNextAlarmTimeStatic{
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    NSUserDefaults *alarmDictionaryUserDefaults = [NSUserDefaults standardUserDefaults];
    calendar = [NSCalendar currentCalendar];
	// Do any additional setup after loading the view.
    //全画面表示
    staticAlarmTimeList = [[NSMutableArray alloc]init];
    // NSDateFormatter を用意します。
   formatterTimeH = [[NSDateFormatter alloc] init];
   formatterTimeM = [[NSDateFormatter alloc] init];
   formatterTimeS = [[NSDateFormatter alloc] init];
   formatterDay = [[NSDateFormatter alloc] init];
   formatterMonth = [[NSDateFormatter alloc] init];
    
    
    // 変換用の書式を設定します。
    [formatterTimeH setDateFormat:@"HH"];
    [formatterTimeM setDateFormat:@"mm"];
    [formatterTimeS setDateFormat:@"ss"];
    [formatterDay setDateFormat:@"dd"];
    [formatterMonth setDateFormat:@"MM"];
    
    
    [UIApplication sharedApplication].statusBarHidden = YES;
    //画面サイズがxibファイル等で決まっていて、高さが合わない時はフルスクリーンサイズで上書きする。
    [self.view setFrame:[[UIScreen mainScreen] bounds]];
    //[self TimeChange]; //時間の表示
    //時計表示のためのタイマー TimeChangeメソッド
    playAlarm = [[PlayAlarm alloc]init];
                            
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(TimeChange) userInfo:nil repeats:YES];
    
    timeFormatter = [[NSDateFormatter alloc] init];
    [circle alarmSwitch:NO];
    playAlarm.playing = NO;
    alarmTimeOnList = [[NSMutableArray alloc] init];
   // alarmAppDelegate = [[AlarmAppDelegate alloc]init];
    //alarmAppDelegate = (AlarmAppDelegate *)[[UIApplication sharedApplication] delegate];
   
    staticAlarmTimeList = [NSMutableArray arrayWithArray:[alarmDictionaryUserDefaults arrayForKey:@"alarmTimeList"]];
    
    NSLog(@"%d",[staticAlarmTimeList count]);
    NSLog(@"%@",[staticAlarmTimeList description]);

    alarmTimeOnList = [[NSMutableArray alloc] init];
    alarmNextTimeList = [[NSMutableArray alloc] init];
    [self progressChange];
    
    [self firstAnimation];
    [super viewDidLoad];

}
-(void)firstAnimation
{
    clockLabelM .center = CGPointMake(334,110);
     clockLabelH.center = CGPointMake(-26,110);
    monthLabel.center = CGPointMake(-44, 288);
    dayLabel.center = CGPointMake(364, 288);
    nextAlarmTextLabel.center = CGPointMake(160,480);
    nextAlarmTimeLabel.center = CGPointMake(160,590);
    clockLabelS.alpha = 0.0f;
    iconImageView.alpha = 0.0f;
    iconImageVIewC.alpha = 0.0f;
    weekDayLable.center = CGPointMake(160,-30);

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
  
     clockLabelH.center = CGPointMake(84,110);
    clockLabelM .center = CGPointMake(234,110);
    monthLabel.center = CGPointMake(106, 288);
    dayLabel.center = CGPointMake(214, 288);
    nextAlarmTextLabel.center = CGPointMake(160,367);
    nextAlarmTimeLabel.center = CGPointMake(160,399);
    weekDayLable.center = CGPointMake(160, 244);

    clockLabelS.alpha = 0.4f;
    iconImageView.alpha = 1.0f;
    iconImageVIewC.alpha = 1.0f;

    [UIView commitAnimations];
    
   

}
- (void)viewWillAppear:(BOOL)animated//画面移動時に実行されるメソッド
{
    
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    
    [outputFormatter setDateFormat:@"HH:mm"];
 NSLog(@"%@",[staticAlarmTimeList description]);
    
}


- (IBAction)test:(id)sender {
}

- (IBAction)showMiniView:(id)sender {
    NSDate* date_source = [NSDate date];
    NSDateFormatter *compareFormatterNow = [[NSDateFormatter alloc] init];
    [compareFormatterNow setDateFormat:@"HH:mm"];
    NSString *compareStringNow = [compareFormatterNow stringFromDate:date_source];
    [self showAlarmView:compareStringNow index:nil];
    [self addPush:nextAlarmTimeLabel.text];

}
-(void)showAlarmView:(NSString*)str index:(int)index
{
    playingAlarmIndex = index;
    miniView = [[AlarmMiniView alloc] initWithFrame:CGRectMake(160, 190,0,0)];
    miniView.delegate = self;
    miniView.str = str;
    miniView.opaque = NO;
    miniView.backgroundColor = [UIColor clearColor];
    miniView.alpha = 0;
    //[miniView drawRect:CGRectMake(0, 0, 316,316)];
    [UIView beginAnimations:nil context:nil];
     [UIView setAnimationDuration:1.0];
    [circle addSubview:miniView];
   
    miniView.frame = CGRectMake(0,0,320, 460);
    miniView.alpha = 1;
    // miniView.alpha = 0.0f;
    
    [UIView commitAnimations];
    NSLog(@"%@",[staticAlarmTimeList objectAtIndex:playingAlarmIndex]);

}
-(void)touchUp{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    miniView.frame = CGRectMake(160,190,0, 0);
    [circle addSubview:miniView];
    
    miniView.alpha = 0.0f;
    
    [UIView commitAnimations];
    [miniView performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:1.0];
    [[staticAlarmTimeList objectAtIndex:(NSInteger)playingAlarmIndex] setValue:[[NSNumber alloc]initWithBool:NO] forKey:@"On"];
    [self checkAlarmTimeList];
    alarmTimeOnList = [[NSMutableArray alloc] init];
    alarmNextTimeList = [[NSMutableArray alloc] init];
    NSLog(@"%@",[staticAlarmTimeList objectAtIndex:playingAlarmIndex]);
    playAlarm.playing = NO;
}
-(void)alarmTimeDraw:(NSDate *)alarmTime
{
    [timeFormatter setDateFormat:@"ss"];
    date = [timeFormatter stringFromDate:alarmTime];
    sec = [date intValue];
    
    
    [timeFormatter setDateFormat:@"mm"];
    date = [timeFormatter stringFromDate:alarmTime];
    min = [date intValue];
    
    [timeFormatter setDateFormat:@"HH"];
    date = [timeFormatter stringFromDate:alarmTime];
    hour= [date intValue];
    
    [circle AnimationDotAlarm:sec Min:min Hour:hour On:NO];
}



- (void)progressChange
{
    //原点は (ovalX,ovalY)  (ovalY-(ovalHeight/2))-
    //円周は (ovalWidth/2)  (ovalX-(ovalWidth/2))+
    //00秒の時の座標は X = (ovalX,ovalY-(ovalWidth/2))
    [timeFormatter setDateFormat:@"ss"];
    date = [timeFormatter stringFromDate:[NSDate date]];
    sec = [date intValue];
    
    
    [timeFormatter setDateFormat:@"mm"];
    date = [timeFormatter stringFromDate:[NSDate date]];
    min = [date intValue];
    
    [timeFormatter setDateFormat:@"HH"];
    date = [timeFormatter stringFromDate:[NSDate date]];
    hour= [date intValue];
    
    
    
    
    [circle AnimationDot:sec Min:min Hour:hour];
    
    [self.view setNeedsDisplay];
    //[circle setNeedsDisplay];
    
}


-(void)TimeChange
{
    [self progressChange];
    //時計の表示
    
    NSDate* date_source = [NSDate date];
    comps = [calendar components:(NSWeekCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit)
                        fromDate:date_source];
    weekday = [comps weekday];

    // NSDate を NSString に変換します。
    NSString *timeH = [formatterTimeH stringFromDate:date_source];
    NSString *timeM = [formatterTimeM stringFromDate:date_source];
    NSString *timeS = [formatterTimeS stringFromDate:date_source];
    NSString *day = [formatterDay stringFromDate:date_source];
    NSString *month = [formatterMonth stringFromDate:date_source];
   
    //date_converted = [formatterDate stringFromDate:date_source];
    
    
    clockLabelH.text = timeH;
    clockLabelM.text = timeM;
    clockLabelS.text = timeS;
    monthLabel.text = month;
    dayLabel.text = day;
    if(weekday == 1){
        weekDayLable.text = @"Sunday";
    }else if(weekday == 2){
        weekDayLable.text = @"Monday";
    }else if(weekday == 3){
        weekDayLable.text = @"Tuesday";
    }else if(weekday == 4){
        weekDayLable.text = @"Wednesday";
    }else if(weekday == 5){
        weekDayLable.text = @"Thursday";
    }else if(weekday == 6){
        weekDayLable.text = @"Friday";
    }else if(weekday == 7){
        weekDayLable.text = @"Saturday";
    }
    
    [self alarmTimeCompare];
           
    
}

-(NSString *)dateFormatterToString:(NSDate*)convertDate format:(NSString *)formatString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formatString];
    NSString *covertedStr = [formatter stringFromDate:convertDate];
    return covertedStr;
}

-(void)alarmTimeCompare
{
    [self checkAlarmTimeList];
    
    NSDate* date_source = [NSDate date];
    NSString *compareStringNow = [self dateFormatterToString:date_source format:@"HHmm"];
    //NSLog(@"%@",[[alarmTimeList objectAtIndex:0 ]objectForKey:@"On"]);
   
    //NSLog(@"%d",alarmTimeOnList.count);
    NSInteger now,com;
    /*
        for(int i = 0 ; i < alarmTimeOnList.count ; i++){
           // NSLog(@"%@",[alarmTimeOnList objectAtIndex:i]);
            if((playAlarm.playing == NO) && [compareStringNow isEqualToString:[[alarmTimeOnList objectAtIndex:i] objectForKey:@"OnTime"]]){
                [self startAlarm];
                NSDateFormatter *compareFormatterNow2 = [[NSDateFormatter alloc] init];
                [compareFormatterNow2 setDateFormat:@"HH:mm"];
                NSString *compareStringNow2 = [compareFormatterNow2 stringFromDate:[alarmNextTimeList objectAtIndex:i]];
                if(!miniView.showIs){
                [self showAlarmView:compareStringNow2 index:[[[alarmTimeOnList objectAtIndex:i] objectForKey:@"staticAlarmTimeListIndex"] intValue]];
                }
            }
        }
    */
    if(!(staticAlarmTimeList == nil)){
    for(int i = 0 ; i<staticAlarmTimeList.count ; i++){
        if((playAlarm.playing == NO) && [compareStringNow isEqualToString:[self dateFormatterToString:[[staticAlarmTimeList objectAtIndex:i] objectForKey:@"AlarmTime"] format:@"HHmm"]]){
            if([[[staticAlarmTimeList objectAtIndex:i] objectForKey:@"On"] boolValue])
            {
                for(int y = 0 ; y<[[[staticAlarmTimeList objectAtIndex:i]objectForKey:@"WhatDay"] count] ; i++){
                if([weekDayLable.text isEqualToString:[[[staticAlarmTimeList objectAtIndex:i] objectForKey:@"WhatDay"] objectAtIndex:y]]){
                    [self startAlarm];
                    NSDateFormatter *compareFormatterNow2 = [[NSDateFormatter alloc] init];
                    [compareFormatterNow2 setDateFormat:@"HH:mm"];
                    NSString *compareStringNow2 = [compareFormatterNow2 stringFromDate:[alarmNextTimeList objectAtIndex:i]];
                    if(!miniView.showIs){
                        [self showAlarmView:compareStringNow2 index:[[[alarmTimeOnList objectAtIndex:i] objectForKey:@"staticAlarmTimeListIndex"] intValue]];
                        }
                    }
                }
            }
        }
                                         
    }
    
    }
    
    //次のアラームの時刻をラベルに表示
    now = [compareStringNow intValue];
    if(alarmTimeOnList.count == 0){
        nextAlarmTimeLabel.text = @"OFF";
    }else{
    for(int y = 0 ; y < alarmTimeOnList.count ; y++){
        com = [[[alarmTimeOnList objectAtIndex:y] objectForKey:@"OnTime"] intValue];
        if(now < com){
            NSDateFormatter *FormatterCom = [[NSDateFormatter alloc] init];
            [FormatterCom setDateFormat:@"HH:mm"];
            NSString *comStr = [FormatterCom stringFromDate:[alarmNextTimeList objectAtIndex:y]];
           // NSLog(@"%@",comStr);
            
            nextAlarmTimeLabel.text = comStr;
           // next2AlarmTimeLabel.text = [[NSString alloc] initWithFormat:@"%d",[[alarmTimeOnList objectAtIndex:y+1] intValue]];
           // next3AlarmTimeLabel.text = [[NSString alloc] initWithFormat:@"%d",[[alarmTimeOnList objectAtIndex:y+2] intValue]];
            break ;
        }else{
            NSDateFormatter *FormatterCom = [[NSDateFormatter alloc] init];
            [FormatterCom setDateFormat:@"HH:mm"];
            NSString *comStr = [FormatterCom stringFromDate:[alarmNextTimeList objectAtIndex:0]];
            nextAlarmTimeLabel.text = comStr;
            }
        }
    }

    nextAlarmTimeStatic = nextAlarmTimeLabel.text;
    //NSLog(@"%@",nextAlarmTimeStatic);
    
}
-(void)checkAlarmTimeList{
    alarmTimeOnList = [[NSMutableArray alloc] init];
    alarmNextTimeList = [[NSMutableArray alloc] init];
    
    NSDateFormatter *compareFormatterAlarm = [[NSDateFormatter alloc] init];
    [compareFormatterAlarm setDateFormat:@"HHmm"];
    NSDictionary *alarmTimeOnDictionary;
    for(int i = 0 ; i < [staticAlarmTimeList count] ; i++){
        if([[[staticAlarmTimeList objectAtIndex:i] objectForKey:@"On"] boolValue])
        {
            NSDate *onTime = [[staticAlarmTimeList objectAtIndex:i] objectForKey:@"AlarmTime"];
            NSString *compareStringAlarm = [compareFormatterAlarm stringFromDate:onTime];
            alarmTimeOnDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:compareStringAlarm,@"OnTime",[NSNumber numberWithInteger:(NSInteger)i],@"staticAlarmTimeListIndex", nil];
            [alarmNextTimeList addObject:onTime];
            [alarmTimeOnList addObject:alarmTimeOnDictionary];
        }
    }
   // NSLog(@"%@",alarmTimeOnList);
    
    
}
- (void)viewDidUnload
{
    [self setClockLabelS:nil];
    [self setClockLabelH:nil];
    [self setClockLabelM:nil];
    [self setAlarmTimeLabel:nil];
    [self setCircle:nil];
    [self setCircle:nil];
    [self setImageView:nil];
    [self setAlarmButton:nil];
    [self setMonthLabel:nil];
    [self setDayLabel:nil];
    [self setNextAlarmTimeLabel:nil];
    [self setNextAlarmTimeLabel:nil];
    [self setNext2AlarmTimeLabel:nil];
    [self setNext3AlarmTimeLabel:nil];
    [self setNextAlarmTextLabel:nil];
    [self setIconImageView:nil];
    [self setIconImageVIewC:nil];
    [self setWeekDayLable:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}





- (IBAction)testAlarm:(id)sender {
    [playAlarm play];
    

}


- (IBAction)NoticeView:(id)sender {
    WBErrorNoticeView *notice = [WBErrorNoticeView errorNoticeInView:self.view title:@"Wake Up!!!" message:@"Check your Clock!!!"];
    [notice show];
    
}

- (IBAction)alarmUISwith:(UISwitch *)sender {
    if(sender.on){
        [circle alarmSwitch:YES];
    }else{
        [circle alarmSwitch:NO];
    }
}
- (void)startAlarm {
    [playAlarm play];
    
}
-(void)addNofication{
   // NSLog(@"%@",alarmNextTimeList);
    if(!([nextAlarmTimeStatic isEqualToString:@"OFF"])){
        NSDateFormatter *noficationFormatter = [[NSDateFormatter alloc] init];
        [noficationFormatter  setDateFormat:@"HH:mm"];
        for(int i = 0;i<alarmNextTimeList.count ; i++){
            NSString *noficationStr = [noficationFormatter stringFromDate:[alarmNextTimeList objectAtIndex:i]];
            [self addPush:noficationStr];
            NSLog(@"通知登録 : %@",noficationStr);
        }
    }
}

-(void)addPush:(NSString *)nextAlarmTime{
    
    NSDate *now = [NSDate date];
     NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    
    [inputFormatter setDateFormat:@"yyyy-MM-dd"];
   NSString *todayDate = [inputFormatter stringFromDate:[NSDate date]];
    
    NSString* alarmDateString = [[NSString alloc] initWithFormat:@"%@ %@",todayDate,nextAlarmTime];
    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];             
    NSDate* formatterDate = [inputFormatter dateFromString:alarmDateString];
    
    NSComparisonResult result = [now compare:formatterDate];
    switch(result)
    {
        case NSOrderedAscending:
            // dt is bigger than dt1
            break;
        case NSOrderedDescending:
            formatterDate = [NSDate dateWithTimeInterval:86400 sinceDate:formatterDate];
            NSLog(@"add one day");
            // alarmTime is smaller than Now
            break;
        case NSOrderedSame:
            // dt is same with dt1
            break;
    }
    
    
    NSLog(@"%@",formatterDate);
    UILocalNotification *push = [[UILocalNotification alloc] init];
    push.timeZone = [NSTimeZone defaultTimeZone];
    push.soundName = @"bell.caf";
    // push.fireDate = [NSDate dateWithTimeIntervalSinceNow:3];
    push.fireDate = formatterDate;
    
    push.alertBody = nextAlarmTime;
    push.alertAction = @"SuperAlarm";
    [[UIApplication sharedApplication] scheduleLocalNotification:push];
}


- (IBAction)stop:(id)sender {
    [playAlarm stop];
}
@end
