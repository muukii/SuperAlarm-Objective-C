//
//  AlarmViewController.m
//  UltimateAlarm
//
//  Created by  on 12/07/05.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AlarmViewController.h"
#import "AlarmAppDelegate.h"

@interface AlarmViewController ()

@end

@implementation AlarmViewController
@synthesize alarmTimeTable;



//AddAlarmViewControllerからの戻り
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    AddAlarmViewController *addAlarmViewController = segue.destinationViewController;
    addAlarmViewController.delegate = self;
}
- (void)AddAlarmViewControllerDidFinish:(AddAlarmViewController *)controller
{
    [self dismissModalViewControllerAnimated:YES];
}
//ここまで
//ADDAlarmViewControllerから受け取り
- (void)AlarmTimeSetDidFinish:(NSDate *)alarmTime
{
    alarmAppDelegate.alarmTime = alarmTime;
}
//
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
    [super viewDidLoad];
    alarmTimeTable.delegate = self;
    alarmTimeTable.dataSource = self;
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;


    
    alarmAppDelegate = (AlarmAppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (void)viewDidUnload
{


    [self setAlarmTimeTable:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//テーブルの行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}
//行に表示するデータ
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"行=%d",indexPath.row];
    return cell;
}

-(void)loadView{
    [super loadView];
}


- (IBAction)EditButton:(id)sender {
    [self setEditing:YES animated:YES];
    
}



@end
