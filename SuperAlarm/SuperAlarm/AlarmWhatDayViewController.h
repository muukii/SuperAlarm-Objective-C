//
//  AlarmWhatDayViewController.h
//  SuperAlarm
//
//  Created by むーきー on 2012/08/26.
//  Copyright (c) 2012年 むーきー. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlarmWhatDayViewController : UITableViewController
{
    
}
- (IBAction)saveButtonPushed:(id)sender;
-(void)setReselectDay:(id)reselectDay;

@property (nonatomic, assign) id delegate;
@property (strong, nonatomic) id detailItem;

@end
@protocol whatDaySelectDidFinishDelegate <NSObject>

-(void)whatDaySelectDidFinish:(NSMutableArray *)whatDayArray;

@end
