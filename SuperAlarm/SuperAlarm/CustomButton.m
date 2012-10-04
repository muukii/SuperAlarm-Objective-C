//
//  CustomButton.m
//  UltimateAlarm
//
//  Created by 寛 木村 on 12/07/25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
    //// General Declarations
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Gradient Declarations
    NSArray* gradientColors = [NSArray arrayWithObjects: 
                               (id)[UIColor darkGrayColor].CGColor, 
                               (id)[UIColor colorWithRed: 0.22 green: 0.22 blue: 0.22 alpha: 1].CGColor, 
                               (id)[UIColor blackColor].CGColor, nil];
    CGFloat gradientLocations[] = {0, 0.51, 0.55};
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)gradientColors, gradientLocations);
    
    
    //// Rounded Rectangle Drawing
    UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0.5, 0.5, 89, 39) cornerRadius: 4];
    CGContextSaveGState(context);
    [roundedRectanglePath addClip];
    CGContextDrawLinearGradient(context, gradient, CGPointMake(45, 0.5), CGPointMake(45, 39.5), 0);
    CGContextRestoreGState(context);
    
    [[UIColor darkGrayColor] setStroke];
    roundedRectanglePath.lineWidth = 1;
    [roundedRectanglePath stroke];
    
    //// Cleanup
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}

@end
