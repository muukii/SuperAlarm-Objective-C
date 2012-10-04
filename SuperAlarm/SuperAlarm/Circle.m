//
//  Circle.m
//  SuperAlarm
//
//  Created by むーきー on 2012/08/01.
//  Copyright (c) 2012年 むーきー. All rights reserved.
//

#import "Circle.h"

@implementation Circle
@synthesize ovalLineWidth,ovalX,ovalY,ovalHeight,ovalWidth;
@synthesize dotSecX,dotSecY,dotMinX,dotMinY,dotHourX,dotHourY,dotWidth,dotHeight;
@synthesize radius,triX,triY;
@synthesize sec,min,hour,alarmSec,alarmMin,alarmHour;
@synthesize alarmDotSecX,alarmDotSecY,alarmDotMinX,alarmDotMinY,alarmDotHourX,alarmDotHourY;
@synthesize __sec,__min,__hour;
@synthesize dot12X,dot12Y,dot15X,dot15Y,dot18X,dot18Y,dot21X,dot21Y;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    NSLog(@"init");
    self.opaque = NO;
    //[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(progressChange) userInfo:nil repeats:YES];
   
    return self;
    
    
    
}


- (void)drawRect:(CGRect)rect
{
    ovalX =  160;
    ovalY = 190;
    ovalLineWidth = 26;
    ovalWidth = 288; //円の大きさ
    radius = ovalWidth/2;
    //// Color Declarations
    UIColor* color = [UIColor colorWithRed:1 green:1 blue:1  alpha: 0.3];
    //// Oval sec Drawing
    UIBezierPath* ovalSecPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(ovalX-(ovalWidth/2), ovalY-(ovalWidth/2), ovalWidth, ovalWidth)];
    [color setStroke];
    ovalSecPath.lineWidth = ovalLineWidth;
    [ovalSecPath stroke];
    color = [UIColor colorWithRed:1 green:1 blue:1  alpha: 0.1];
    //// Oval  min Drawing
    UIBezierPath* ovalMinPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(ovalX-(ovalWidth/2)+30, ovalY-(ovalWidth/2)+30, ovalWidth-60, ovalWidth-60)];
    [color setStroke];
    ovalMinPath.lineWidth = ovalLineWidth;
    [ovalMinPath stroke];
    
    UIBezierPath* ovalHourPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(ovalX-(ovalWidth/2)+60, ovalY-(ovalWidth/2)+60, ovalWidth-120, ovalWidth-120)];
    [color setStroke];
    ovalHourPath.lineWidth = ovalLineWidth;
    [ovalHourPath stroke];
     /*
    color = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 0.1];
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(ovalX-(ovalWidth/2)+90, ovalY-(ovalWidth/2)+90, ovalWidth-180, ovalWidth-180)];
    [color setStroke];
    ovalPath.lineWidth = ovalLineWidth;
    [ovalPath stroke];
    
    color = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 0.1];
    
    UIBezierPath* oval2Path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(ovalX-(ovalWidth/2)+120, ovalY-(ovalWidth/2)+120, ovalWidth-240, ovalWidth-240)];
    [color setStroke];
    oval2Path.lineWidth = ovalLineWidth;
    [oval2Path stroke];
    */
    
    ///////////////////////////     DOT   ////////////////////////////////////////////////
    //
    color = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 0.1];
    //// dot sec Drawing
    UIBezierPath* dot12Path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(dot12X,dot12Y, ovalLineWidth, ovalLineWidth)];
    [color setFill];
    [dot12Path fill];
    [color setStroke];
    dot12Path.lineWidth = 0.5;
    [dot12Path stroke];
    
    //// dot min Drawing
    UIBezierPath* dot15Path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(dot15X,dot15Y, ovalLineWidth, ovalLineWidth)];
    [color setFill];
    [dot15Path fill];
    [color setStroke];
    dot15Path.lineWidth = 0.5;
    [dot15Path stroke];
    
    //// dot min Drawing
    UIBezierPath* dot18Path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(dot18X,dot18Y, ovalLineWidth, ovalLineWidth)];
    [color setFill];
    [dot18Path fill];
    [color setStroke];
    dot18Path.lineWidth = 0.5;
    [dot18Path stroke];
    
    UIBezierPath* dot21Path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(dot21X,dot21Y, ovalLineWidth, ovalLineWidth)];
    [color setFill];
    [dot21Path fill];
    [color setStroke];
    dot21Path.lineWidth = 0.5;
    [dot21Path stroke];

    //時計の表示 リアルタイム
    color = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 0.5];
    //// dot sec Drawing
    UIBezierPath* dotSecPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(dotSecX,dotSecY, ovalLineWidth, ovalLineWidth)];
    [color setFill];
    [dotSecPath fill];
    [color setStroke];
    dotSecPath.lineWidth = 0.5;
    [dotSecPath stroke];
    
    //// dot min Drawing
    UIBezierPath* dotMinPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(dotMinX,dotMinY, ovalLineWidth, ovalLineWidth)];
    [color setFill];
    [dotMinPath fill];
    [color setStroke];
    dotMinPath.lineWidth = 0.5;
    [dotMinPath stroke];
    
    //// dot min Drawing
    UIBezierPath* dotHourPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(dotHourX,dotHourY, ovalLineWidth, ovalLineWidth)];
    [color setFill];
    [dotHourPath fill];
    [color setStroke];
    dotHourPath.lineWidth = 0.5;
    [dotHourPath stroke];
    
    
    //アラームの表示
    color = alarmColor;//[UIColor colorWithRed: 1 green: 0.5 blue: 0.7 alpha: 0.5];
    //// dot sec Drawing
    UIBezierPath* alarmDotSecPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(alarmDotSecX,alarmDotSecY, ovalLineWidth, ovalLineWidth)];
    [color setFill];
    [alarmDotSecPath fill];
    [color setStroke];
    alarmDotSecPath.lineWidth = 0.5;
    [alarmDotSecPath stroke];
    
    //// dot min Drawing
    UIBezierPath* alarmDotMinPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(alarmDotMinX,alarmDotMinY, ovalLineWidth, ovalLineWidth)];
    [color setFill];
    [alarmDotMinPath fill];
    [color setStroke];
    alarmDotMinPath.lineWidth = 0.5;
    [alarmDotMinPath stroke];
    
    //// dot min Drawing
    UIBezierPath* alarmDotHourPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(alarmDotHourX,alarmDotHourY, ovalLineWidth, ovalLineWidth)];
    [color setFill];
    [alarmDotHourPath fill];
    [color setStroke];
    alarmDotHourPath.lineWidth = 0.5;
    [alarmDotHourPath stroke];

       
}
-(void)AnimationDot:(int)_sec Min:(int)_min Hour:(int)_hour
{
    
    
    double sec12 = -90;
    sec12 = sec12 * M_PI / 180.0;
    dot12X = (ovalWidth/2)*cos(sec12) + (ovalWidth/2)+2.5;
    dot12Y = (ovalWidth/2)*sin(sec12) + (ovalWidth/2)+32.5;
    
    double sec15 = 0;
    sec15 = sec15 * M_PI / 180.0;
    dot15X = ((ovalWidth/2))*cos(sec15) + (ovalWidth/2)+2.5;
    dot15Y = ((ovalWidth/2))*sin(sec15) + (ovalWidth/2)+32.5;
    
    double sec18 = 90;
    sec18 = sec18 * M_PI / 180.0;
    dot18X = ((ovalWidth/2))*cos(sec18) + (ovalWidth/2)+2.5;
    dot18Y = ((ovalWidth/2))*sin(sec18) + (ovalWidth/2)+32.5;
    
    double sec21 = 180;
    sec21 = sec21 * M_PI / 180.0;
    dot21X = ((ovalWidth/2))*cos(sec21) + (ovalWidth/2)+2.5;
    dot21Y = ((ovalWidth/2))*sin(sec21) + (ovalWidth/2)+32.5;
    
    /*
     dotX = ((ovalX-ovalLineWidth/2)*cos(radian))+(ovalWidth/2);
     dotY = ((ovalY-ovalLineWidth/2)*sin(radian))+(ovalWidth/2);//-(ovalWidth/2);
     */
    sec = (_sec*6)-90;
    sec = sec * M_PI / 180.0;
    dotSecX = (ovalWidth/2)*cos(sec) + (ovalWidth/2)+2.5;
    dotSecY = (ovalWidth/2)*sin(sec) + (ovalWidth/2)+32.5;
    
    min = (_min*6)-90;
    min = min * M_PI / 180.0;
    dotMinX = ((ovalWidth/2)-30)*cos(min) + (ovalWidth/2)+2.5;
    dotMinY = ((ovalWidth/2)-30)*sin(min) + (ovalWidth/2)+32.5;
    
    hour = (_hour*30)-90;
    hour = hour * M_PI / 180.0;
    dotHourX = ((ovalWidth/2)-60)*cos(hour) + (ovalWidth/2)+2.5;
    dotHourY = ((ovalWidth/2)-60)*sin(hour) + (ovalWidth/2)+32.5;
    
    //NSLog(@"sec:%d  min:%d Hour:%d",_sec,_min,_hour);
    
    //NSLog(@"sec:%f,%f  min:%f,%f  Hour:%f,%f",dotSecX,dotSecY,dotMinX,dotMinY,dotHourX,dotHourY);
    
    [self setNeedsDisplay];
}
-(void)AnimationDotAlarm:(int)_sec Min:(int)_min Hour:(int)_hour On:(BOOL)_alarmSwitch
{
    
    sec = -90;
    sec = sec * M_PI / 180.0;
    alarmDotSecX = (ovalWidth/2)*cos(sec) + (ovalWidth/2)+2.5;
    alarmDotSecY = (ovalWidth/2)*sin(sec) + (ovalWidth/2)+2.2;
    
    min = (_min*6)-90;
    min = min * M_PI / 180.0;
    alarmDotMinX = ((ovalWidth/2)-30)*cos(min) + (ovalWidth/2)+2.5;
    alarmDotMinY = ((ovalWidth/2)-30)*sin(min) + (ovalWidth/2)+2.2;
    
    hour = (_hour*30)-90;
    hour = hour * M_PI / 180.0;
    alarmDotHourX = ((ovalWidth/2)-60)*cos(hour) + (ovalWidth/2)+2.5;
    alarmDotHourY = ((ovalWidth/2)-60)*sin(hour) + (ovalWidth/2)+2.2;
    
    //NSLog(@"sec:%d  min:%d Hour:%d",_sec,_min,_hour);

    //NSLog(@"sec:%f,%f  min:%f,%f  Hour:%f,%f",dotSecX,dotSecY,dotMinX,dotMinY,dotHourX,dotHourY);
    
    //[self setNeedsDisplay];
}
-(void)alarmSwitch:(BOOL)_alarmSwitch
{
    if(_alarmSwitch)
    {
        alarmColor = [UIColor colorWithRed:0.2 green:0.6 blue:1 alpha:0.4];
        
        
    }else{
        
        alarmColor = [UIColor clearColor];
    }
}

- (void)progressChange
{
    //原点は (ovalX,ovalY)  (ovalY-(ovalHeight/2))-
    //円周は (ovalWidth/2)  (ovalX-(ovalWidth/2))+
    //00秒の時の座標は X = (ovalX,ovalY-(ovalWidth/2))
    [timeFormatter setDateFormat:@"ss"];
    date = [timeFormatter stringFromDate:[NSDate date]];
    __sec = [date intValue];
    
    
    [timeFormatter setDateFormat:@"mm"];
    date = [timeFormatter stringFromDate:[NSDate date]];
    __min = [date intValue];
    
    [timeFormatter setDateFormat:@"HH"];
    date = [timeFormatter stringFromDate:[NSDate date]];
    __hour= [date intValue];
    
    
    //NSLog(@"sec:%d  min:%d Hour:%d",__sec,__min,__hour);

    
    [self AnimationDot:__sec Min:__min Hour:__hour];
    
    [self setNeedsDisplay];
    //[circle setNeedsDisplay];
    
}



@end
