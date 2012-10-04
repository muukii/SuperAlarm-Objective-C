//
//  AlarmTableViewController.m
//  SuperAlarm
//
//  Created by むーきー on 2012/07/31.
//  Copyright (c) 2012年 むーきー. All rights reserved.
//

#import "AlarmTableViewController.h"
#import "AlarmAppDelegate.h"
#import "AddAlarmViewController.h"

@interface AlarmTableViewController ()
{
    NSIndexPath *selectedSwitch;
    NSInteger switchTag;
    UIImage *cellImage,*alarmImage;
    UIImageView *imageView;
}
@end

@implementation AlarmTableViewController



@synthesize sortDate,sortDescArray,_alarmTimeList,alarmTimeList;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
+(void)initWithAlarmTimeList{
   // alarmTimeList = [[NSMutableArray alloc]init];
 //   alarmDictionaryUserDefaults = [NSUserDefaults standardUserDefaults];
   // alarmTimeList = [NSMutableArray arrayWithArray:[alarmDictionaryUserDefaults arrayForKey:@"alarmTimeList"]];
   // NSLog(@"load  %@",alarmTimeList);
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [ClockViewController alloc];
    alarmTimeList = [[NSMutableArray alloc]init];
    alarmTimeList = [NSMutableArray arrayWithArray:(NSMutableArray*)[ClockViewController getAlarmTimeList]];
    NSLog(@"AlarmTableViewController:alarmTimeList : %@",alarmTimeList);
    _alarmTimeList = [[NSMutableArray alloc]init];
    //背景を指定
    UIImage *bImage = [UIImage imageNamed:@"skyBlue.png"];
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:bImage];
    
    
    //alarmAppDelegate = (AlarmAppDelegate *)[[UIApplication sharedApplication] delegate];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    
    
    
    
    cellImage = [UIImage imageNamed:@"cellGros.png"];
    alarmImage = [UIImage imageNamed:@"alarmOn.png"];
    [[CustomUISwitch alloc]initAlarmImage];
    [self sortAlarmTimeList];
}
-(void)viewWillAppear:(BOOL)animated
{
    //alarmTimeList = alarmAppDelegate.alarmTimeList;
    [self.tableView reloadData];
    alarmTimeList = [NSMutableArray arrayWithArray:(NSMutableArray*)[ClockViewController getAlarmTimeList]];
   
}
-(BOOL)sortAlarmTimeList{
    
        sortDate = [[NSSortDescriptor alloc] initWithKey:@"AlarmTime" ascending:YES];
        sortDescArray = [NSMutableArray arrayWithObjects:sortDate, nil];
    
    _alarmTimeList = [NSMutableArray arrayWithArray:alarmTimeList];
        alarmTimeList = [NSMutableArray arrayWithArray:[_alarmTimeList sortedArrayUsingDescriptors:sortDescArray]];
    
    
    //NSLog(@"%@",alarmTimeList.description);
    //NSLog(@"%d",alarmTimeList.count);
   
    [self sendAlarmTimeList];

    return YES;
    
}
-(void)switchTagReset
{
    NSLog(@"switchTag初期化");
    switchTag = 0;
}
-(void)sendAlarmTimeList{
    [ClockViewController setAlarmTimeList:alarmTimeList];
    NSLog(@"送信");
}

-(void)saveUserDefaults
{
    
   // alarmAppDelegate.alarmTimeList = alarmTimeList;
    
    [alarmDictionaryUserDefaults setObject:alarmTimeList forKey:@"alarmTimeList"];
    if([alarmDictionaryUserDefaults synchronize]){
    NSLog(@"同期完了");
    }
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"DetailView"]) {
        AddAlarmViewController *addAlarmViewController = segue.destinationViewController;
        addAlarmViewController.delegate = self;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDictionary *dictionary = [alarmTimeList objectAtIndex:indexPath.row];
        [[segue destinationViewController] setDetailItem:dictionary indexPath:indexPath switchTag:
         [[[alarmTimeList objectAtIndex:indexPath.row] objectForKey:@"switchTag"] intValue]];

        //NSLog(@"詳細へ");
    }else if ([[segue identifier] isEqualToString:@"Add"])
    {
        AddAlarmViewController *addAlarmViewController = segue.destinationViewController;
        addAlarmViewController.delegate = self;
       // NSLog(@"追加");
    }
}
- (void)AddAlarmViewControllerDidFinish:(AddAlarmViewController *)controller
{
   
    [self dismissModalViewControllerAnimated:YES];
   
}
 

//ADDAlarmViewControllerから受け取り

-(void)AlarmDictionarySetDidFinish:(NSDictionary *)alarmDictionary
{
     //NSLog(@"追加受け取り");
     [self insertNewDictionary:alarmDictionary];
   // alarmAppDelegate.alarmTime = [[alarmTimeList objectAtIndex:0] objectForKey:@"AlarmTime"];
   
}
-(void)AlarmEditDictionarySetDidFinish:(NSDictionary *)alarmDictionary indexPath:(NSIndexPath *)indexPath
{
   // NSLog(@"編集受け取り");
    [self editDictionary:alarmDictionary indexPath:indexPath];
   // alarmAppDelegate.alarmTime = [[alarmTimeList objectAtIndex:0] objectForKey:@"AlarmTime"];
    

}


- (void)insertNewDictionary:(NSDictionary *)alarmDictionary
{
   // [self sortAlarmTimeList];
    
    [alarmDictionary setValue:[[NSNumber alloc] initWithInt:[alarmTimeList count]] forKey:@"switchTag"];
     
        

    //NSLog(@"テーブル追加");
    if (!alarmTimeList)
    {
        alarmTimeList = [[NSMutableArray alloc] init];
    }
    [alarmTimeList insertObject:alarmDictionary atIndex:0];
    
    NSIndexPath *indexPath2 = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath2] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self sortAlarmTimeList];
    [self.tableView reloadData];
    
    

    
}
- (void)editDictionary:(NSDictionary *)alarmDictionary indexPath:(NSIndexPath *)indexPath
{
    
    // NSLog(@"編集追加");
    
    
    [alarmTimeList replaceObjectAtIndex:indexPath.row withObject:alarmDictionary];
    [self sortAlarmTimeList];

    [self.tableView reloadData];

}
//
- (void)viewDidUnload
{
    [self setTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return alarmTimeList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *repeatWhatDayArray = [[NSMutableArray alloc]initWithArray:[[alarmTimeList objectAtIndex:indexPath.row] objectForKey:@"WhatDay"]];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.accessoryView.opaque = NO;
    cell.accessoryView.backgroundColor = [UIColor clearColor];
    
    CustomUISwitch *uiSwitch = [CustomUISwitch buttonWithType:UIButtonTypeCustom];
    
    uiSwitch.frame = CGRectMake(250.0, 25.0, alarmImage.size.height ,alarmImage.size.width);
    
    imageView = [[UIImageView alloc] initWithImage:cellImage];
    cell.backgroundView = imageView;
    cell.textLabel.opaque = NO;
    cell.textLabel.backgroundColor = [UIColor clearColor];
    if(cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        NSLog(@"cell = nil");
    }
    //[cell.contentView addSubview:uiSwitch];
    cell.accessoryView = uiSwitch;
    
    
    //NSLog(@"%d",switchTag);
    uiSwitch.tag = [[[alarmTimeList objectAtIndex:indexPath.row] objectForKey:@"switchTag"] intValue];
    //CustomUISwitchのOnを設定
    [uiSwitch AlarmOn:[[[alarmTimeList objectAtIndex:indexPath.row] objectForKey:@"On"] boolValue]];
    
    //NSLog(@"%d",switchTag);
    
    
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"HH:mm"];
    NSString *dateString = [outputFormatter stringFromDate:[[alarmTimeList objectAtIndex:indexPath.row] objectForKey:@"AlarmTime"]];
    [[cell contentView] addSubview:uiSwitch];
    
    NSString *repeat,*snooze,*alarmOn;
    if([[[alarmTimeList objectAtIndex:indexPath.row] objectForKey:@"Repeat"] boolValue])
    {
        repeat = @"ON ";
    }else{
        repeat = @"OFF";
    }
    
    if([[[alarmTimeList objectAtIndex:indexPath.row] objectForKey:@"Snooze"] boolValue])
    {
        snooze = @"ON ";
    }else{
        snooze = @"OFF";
    }
    if([[[alarmTimeList objectAtIndex:indexPath.row] objectForKey:@"On"] boolValue])
    {
        alarmOn = @"ON ";
    }else{
        alarmOn = @"OFF";
    }
    NSMutableString *whatDayString;
    whatDayString = [[NSMutableString alloc]init];
    if(!(repeatWhatDayArray == nil)){
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
    }
    
    cell.textLabel.text = [dateString description];
    uiSwitch.titleLabel.text = [dateString description];
    cell.detailTextLabel.text = [[NSString alloc] initWithFormat:@"Repeat : %@",whatDayString];
    [uiSwitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventTouchUpInside];
    //[self sortAlarmTimeList];
   // alarmAppDelegate.alarmTimeList = alarmTimeList;

    return cell;
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
	NSLog(@"scroll end");
    
}

-(void)switchChanged:(id)sender
{
     
    NSLog(@"%d",[(CustomUISwitch *)sender tag]);
   // NSLog(@"%@",[[alarmTimeList objectAtIndex:[(UISwitch *)sender tag] ]objectForKey:@"On"]);
    int objAtIndex = [[alarmTimeList valueForKeyPath:@"switchTag"] indexOfObject:[[NSNumber alloc] initWithInt:[(UISwitch *)sender tag]]];
   // NSLog(@"UIswitchTag = %d",[(UISwitch *)sender tag]); //UISwitchのTag
    //NSLog(@"objAtIndex = %d",objAtIndex); //配列の場所
    if ([(CustomUISwitch *)sender alarmOn]) {
        NSLog(@"on");
     
        [[alarmTimeList objectAtIndex:objAtIndex] setObject:[[NSNumber alloc] initWithBool:NO] forKey:@"On" ];
    } else {
        //NSLog(@"switch is OFF");
        NSLog(@"off");
        [[alarmTimeList objectAtIndex:objAtIndex] setObject:[[NSNumber alloc] initWithBool:YES] forKey:@"On" ];
        
    }
    [self.tableView reloadData];
    [self sendAlarmTimeList];
    
    
}


/*
// Override to support conditional editing of the table view.
 */
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSInteger)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


/*
// Override to support editing the table view.
 */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
         [alarmTimeList removeObjectAtIndex:indexPath.row];// Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self sendAlarmTimeList];

        [self.tableView reloadData];

    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     
     */
    NSLog(@"%d",indexPath.row);
}


@end
