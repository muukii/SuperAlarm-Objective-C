//
//  AlarmMiniView.m
//  SuperAlarm
//
//  Created by むーきー on 2012/08/18.
//  Copyright (c) 2012年 むーきー. All rights reserved.
//

#import "AlarmMiniView.h"

@implementation AlarmMiniView
@synthesize ovalLineWidth,ovalX,ovalY,ovalHeight,ovalWidth;
@synthesize delegate,str;
@synthesize iconImage,iconImageView,showIs;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        iconImage = [UIImage imageNamed:@"clock.png"];
        iconImageView = [[UIImageView alloc] initWithImage:iconImage];
        //iconImageView.center = CGPointMake(160, 190);
        showIs = YES;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    ovalX =  160;
    ovalY = 190;
    ovalLineWidth = 26;
    ovalWidth = 316; //円の大きさ
    //// Abstracted Graphic Attributes
    CGRect ovalRect = CGRectMake(ovalX-(ovalWidth/2), ovalY-(ovalWidth/2), ovalWidth, ovalWidth);
    
    
    //// Oval Drawing
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect:ovalRect];
    [[UIColor whiteColor] setFill];
    [ovalPath fill];
    
    //// Color Declarations
    UIColor* color = [UIColor colorWithRed: 0.82 green: 0.45 blue: 0.59 alpha: 1];
    
    //// Abstracted Graphic Attributes
    CGRect textRect = CGRectMake(0, 140, 320, 50);
    NSString* textContent = str;
    
    
    //// Text Drawing
    [color setFill];
    [textContent drawInRect: textRect withFont: [UIFont fontWithName: @"Futura-Medium" size: 80] lineBreakMode: UILineBreakModeWordWrap alignment: UITextAlignmentCenter];
    //iconImageView.center = CGPointMake(160, 190);
 
    
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.delegate touchUp];
    showIs = NO;
}


@end
