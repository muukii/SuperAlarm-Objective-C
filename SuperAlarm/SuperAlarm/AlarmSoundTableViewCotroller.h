//
//  AlarmSoundTableViewCotroller.h
//  SuperAlarm
//
//  Created by むーきー on 2012/08/24.
//  Copyright (c) 2012年 むーきー. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlarmSoundTableViewCotroller : UITableViewController
- (IBAction)saveButtonPushed:(id)sender;
@property (nonatomic, assign) id delegate;
@end
