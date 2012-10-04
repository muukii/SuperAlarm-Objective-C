//
//  AddAlarmViewController.m
//  UltimateAlarm
//
//  Created by むーきー on 12/07/26.
//
//

#import "AddAlarmViewController.h"

@interface AddAlarmViewController ()
{
    NSMutableArray *alarmSettingList;
    BOOL repeatIsON;
    BOOL snoozeIsON;
    NSDate *detaildate;
    NSIndexPath *detailIndexPath;
    UIImage *cellImage;
    UIImageView *imageView;
    NSMutableArray *repeatWhatDayArray;
}
@end

@implementation AddAlarmViewController
@synthesize alarmTimePicker;
@synthesize settingTable;
@synthesize SettingTableView;
@synthesize delegate;
@synthesize switchTag;
/*
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"seuge %d",[[self.settingTable indexPathForSelectedRow]  row]);
    if([[self.settingTable indexPathForSelectedRow]  row]== 2){
        if ([[segue identifier] isEqualToString:@"SoundList"]) {
            AlarmSoundTableViewCotroller *alarmSoundTableViewController = segue.destinationViewController;
            alarmSoundTableViewController.delegate = self;
        }
    }
}
*/
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)setDetailItem:(id)newDetailItem indexPath:(NSIndexPath *)_indexPath switchTag:(int)_switchTag
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        detailIndexPath = _indexPath;
        switchTag = _switchTag;
        // Update the view.
        [self configureView];
    }
}
- (void)configureView
{
    // Update the user interface for the detail item.
    repeatWhatDayArray = [[NSMutableArray alloc] init];

    if (self.detailItem) {
            repeatIsON = [[self.detailItem objectForKey:@"Repeat"] boolValue];            
            snoozeIsON = [[self.detailItem objectForKey:@"Snooze"] boolValue];
            detaildate = [self.detailItem objectForKey:@"AlarmTime"];
            repeatWhatDayArray = [self.detailItem objectForKey:@"WhatDay"];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.opaque = NO;
    self.view.backgroundColor = [UIColor clearColor];
    settingTable.dataSource=self;
    settingTable.delegate = self;
    alarmSettingList =[NSMutableArray arrayWithObjects:@"Repeat",@"Snooze",@"Sounds",nil];
   if (self.detailItem) {
    alarmTimePicker.date = detaildate;
   }else{
    
    NSDate* date_converted;
    date_converted = [NSDate dateWithTimeIntervalSinceNow:[[NSTimeZone systemTimeZone] secondsFromGMT]];
    NSString* date_source = @"00:00";
    
    // NSDateFormatter を用意します。
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    
    // 変換用の書式を設定します。
    [formatter setDateFormat:@"HH:mm"];
    
    // NSString を NSDate に変換します。
    date_converted = [formatter dateFromString:date_source];
    alarmTimePicker.date = date_converted;
       
       
   }
    cellImage = [UIImage imageNamed:@"cellGros.png"];
    UIImage *bImage = [UIImage imageNamed:@"skyBlue.png"];
    self.settingTable.backgroundColor = [UIColor colorWithPatternImage:bImage];
}
-(void)viewWillAppear:(BOOL)animated
{
  
}

- (void)viewDidUnload
{
    [self setAlarmTimePicker:nil];
    [self setSettingTable:nil];
    self.detailItem = nil;
    [self setSettingTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)AddAlarmTime:(id)sender  //save
{
    
   
                        
    if(self.detailItem == nil){
        alarmDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                           [alarmTimePicker date],@"AlarmTime",
                           [[NSNumber alloc] initWithBool:repeatIsON],@"Repeat",
                           [[NSNumber alloc] initWithBool:snoozeIsON],@"Snooze",
                           [[NSNumber alloc] initWithBool:YES],@"On",
                           repeatWhatDayArray,@"WhatDay",nil];
        [self.delegate AlarmDictionarySetDidFinish:alarmDictionary];
        NSLog(@"detail == nil");
    }else{
        //詳細から来た場合
        alarmDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                           [alarmTimePicker date],@"AlarmTime",
                           [[NSNumber alloc] initWithBool:repeatIsON],@"Repeat",
                           [[NSNumber alloc] initWithBool:snoozeIsON],@"Snooze",
                           [[NSNumber alloc] initWithBool:YES],@"On",
                           [[NSNumber alloc] initWithInt:switchTag],@"switchTag",
                           repeatWhatDayArray,@"WhatDay",nil];

                
        [self.delegate AlarmEditDictionarySetDidFinish:alarmDictionary indexPath:detailIndexPath];
        NSLog(@"detail != nil");

    }
    [self.navigationController popViewControllerAnimated:YES];//画面戻り
    NSLog(@"もどり");


}

#pragma mark -Table View Data Source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 3;
}
- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return 58;
}
//テーブルの行数

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
  //NSDate *object = [alarmTimeList objectAtIndex:indexPath.row];
    imageView = [[UIImageView alloc] initWithImage:cellImage];
    cell.backgroundView = imageView;
    cell.textLabel.opaque = NO;
    cell.textLabel.backgroundColor = [UIColor clearColor];
        
    NSString *object = [alarmSettingList objectAtIndex:indexPath.row];
    cell.textLabel.text = object;
    
    
    if(indexPath.row == 0)
        {   //Repeat
            /*
            repeatUISwitch = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 90, 24.0)];
            cell.accessoryView = repeatUISwitch;
            repeatUISwitch.on = repeatIsON;
            [(UISwitch *)cell.accessoryView addTarget:self action:@selector(repeatSwitchChanged:)
                             forControlEvents:(UIControlEventValueChanged | UIControlEventTouchDragInside)];
             */
            if(!(repeatWhatDayArray == nil)){
                NSMutableString *whatDayString;
                whatDayString = [[NSMutableString alloc]init];
                for(int i = 0; i <repeatWhatDayArray.count;i++){
                    NSString *dayStr = [[NSString alloc] initWithString:[repeatWhatDayArray objectAtIndex:i]];
                    if([dayStr isEqual:@"Sunday"]){
                    [whatDayString appendString:@" Sun"];
                    }else if([dayStr isEqual:@"Monday"]){
                        [whatDayString appendString:@" Mon"];
                    }else if([dayStr isEqual:@"Tuesday"]){
                        [whatDayString appendString:@" Tue"];
                    }else if([dayStr isEqual:@"Wednesday"]){
                        [whatDayString appendString:@" Wed"];
                    }else if([dayStr isEqual:@"Thursday"]){
                        [whatDayString appendString:@" Thu"];
                    }else if([dayStr isEqual:@"Friday"]){
                        [whatDayString appendString:@" Fri"];
                    }else if([dayStr isEqual:@"Saturday"]){
                        [whatDayString appendString:@" Sat"];
                    }                        
                }
            cell.detailTextLabel.text = whatDayString;
            }
    }else if(indexPath.row == 1)//Snooze
        {
            snoozeUISwitch = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 90, 24.0)];
            cell.accessoryView = snoozeUISwitch;
            snoozeUISwitch.on = snoozeIsON;
            [(UISwitch *)cell.accessoryView addTarget:self action:@selector(snoozeSwitchChanged:)
                                 forControlEvents:(UIControlEventValueChanged | UIControlEventTouchDragInside)];

        }
    return cell;
}
-(void)repeatSwitchChanged:(id)sender
{
   
    if ([(UISwitch *)sender isOn]) {
        NSLog(@"Repeat is ON");
        repeatIsON = YES;
    } else {
        NSLog(@"Repeat is OFF");
        repeatIsON = NO;
    }
}
-(void)snoozeSwitchChanged:(id)sender
{
    if ([(UISwitch *)sender isOn]) {
        NSLog(@"Snooze is ON");
        snoozeIsON = YES;
    } else {
        NSLog(@"Snooze is OFF");
        snoozeIsON = NO;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //セル選択状態の解除
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //遷移先（Navi2）クラスのインスタンスを生成
    AlarmSoundTableViewCotroller *alarmSoundTableViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SoundList"];
    AlarmWhatDayViewController *alarmWhatDayViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"WhatDay"];
    if(indexPath.row == 2){
        
        alarmSoundTableViewController.delegate = self;
        if(!(self.detailItem == nil)){
            
        }
        [[self navigationController] pushViewController:alarmSoundTableViewController animated:YES];
        
    }
    if(indexPath.row == 0){
        alarmWhatDayViewController.delegate = self;
        if(!(self.detailItem == nil)){
            if(!(repeatWhatDayArray == nil)){
                [alarmWhatDayViewController setReselectDay:repeatWhatDayArray];
            }else{
            [alarmWhatDayViewController setDetailItem:self.detailItem];
            }
        }else if(!(repeatWhatDayArray == nil)){
            [alarmWhatDayViewController setReselectDay:repeatWhatDayArray];

        }
    [[self navigationController] pushViewController:alarmWhatDayViewController animated:YES];
    }
}
     //曜日選択からのもどり
-(void)whatDaySelectDidFinish:(NSMutableArray *)whatDayArray
{
    repeatWhatDayArray = [[NSMutableArray alloc] init];

    repeatWhatDayArray = whatDayArray;
    [settingTable reloadData];

}


@end
