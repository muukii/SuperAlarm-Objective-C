//
//  AlarmWhatDayViewController.m
//  SuperAlarm
//
//  Created by むーきー on 2012/08/26.
//  Copyright (c) 2012年 むーきー. All rights reserved.
//

#import "AlarmWhatDayViewController.h"

@interface AlarmWhatDayViewController ()
{
    UIImage *cellImage;
    UIImageView *imageView;
    NSMutableArray *whatDayArray;
    NSMutableArray *fromDetailSelectedDayArray;
}
@end

@implementation AlarmWhatDayViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)setDetailItem:(id)detailItem{
    _detailItem = detailItem;
    fromDetailSelectedDayArray = [[NSMutableArray alloc]init];
    fromDetailSelectedDayArray = [self.detailItem objectForKey:@"WhatDay"];
    NSLog(@"%@",[self.detailItem description]);
}
-(void)setReselectDay:(id)reselectDay
{
    fromDetailSelectedDayArray = [[NSMutableArray alloc]init];
    fromDetailSelectedDayArray = reselectDay;

}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    cellImage = [UIImage imageNamed:@"cellGros.png"];
    UIImage *bImage = [UIImage imageNamed:@"skyBlue.png"];
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:bImage];
    whatDayArray = [[NSMutableArray alloc] initWithObjects:@"Sunday",@"Monday",@"Tuesday",@"Wednesday",@"Thursday",@"Friday",@"Saturday", nil];
}

- (void)viewDidUnload
{
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
    return whatDayArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
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
    

    cell.textLabel.text = [whatDayArray objectAtIndex:indexPath.row];
    if(!(fromDetailSelectedDayArray == nil)){
        for(int i = 0 ; i<[fromDetailSelectedDayArray count]; i++){
            if([[whatDayArray objectAtIndex:indexPath.row] isEqual:[fromDetailSelectedDayArray objectAtIndex:i]]){
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
        }
    }
    return cell;

}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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
    //選択されたセルを取得
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //セルにチェックが付いている場合はチェックを外し、付いていない場合はチェックを付ける
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark)
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
}

- (IBAction)saveButtonPushed:(id)sender {
    NSMutableArray *selectedDayArray = [[NSMutableArray alloc]init];
    NSIndexPath *indexPath = [[NSIndexPath alloc]init];;
    for(NSInteger i = 0 ; i < whatDayArray.count;i++){
        indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        if(cell.accessoryType == UITableViewCellAccessoryCheckmark){
            [selectedDayArray addObject:cell.textLabel.text];
        }
    }
    
    [self.delegate whatDaySelectDidFinish:selectedDayArray];
    NSLog(@"%@",selectedDayArray);
    
    [self.navigationController popViewControllerAnimated:YES];//画面戻り

}
@end
