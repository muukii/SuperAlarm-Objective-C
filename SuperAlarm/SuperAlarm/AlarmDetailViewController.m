//
//  AlarmDetailViewController.m
//  k
//
//  Created by むーきー on 2012/07/31.
//  Copyright (c) 2012年 むーきー. All rights reserved.
//

#import "AlarmDetailViewController.h"

@interface AlarmDetailViewController ()
- (void)configureView;
@end

@implementation AlarmDetailViewController

#pragma mark - Managing the detail item
@synthesize managedObjectContext = _managedObjectContext;

@synthesize repeatSwitch;
@synthesize snoozeSwitch;
@synthesize soundsLabel;
@synthesize detailItem = _detailItem;

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
/*
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
 */
    
        // Update the user interface for the detail item.
        [self becomeFirstResponder];
        if (self.detailItem) {
            self.alarmTimePicker.date = self.detailItem.alarmTime;
            self.repeatSwitch.on = *(self.detailItem.alarmSettings.repeat);
            self.snoozeSwitch.on = *(self.detailItem.alarmSettings.snooze);
            //self.soundsLabel.text = [[[self detailItem] alarmSettings]sounds];
        } else {
            self.alarmTimePicker = nil;
            self.repeatSwitch = nil;
            self.snoozeSwitch = nil;
        }
}
- (void)done
    {
        if (!self.detailItem) {
            _detailItem = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([AlarmTime class])
                                                        inManagedObjectContext:self.managedObjectContext];
            _detailItem.alarmSettings = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([AlarmSettings class])
                                                                inManagedObjectContext:self.managedObjectContext];
        }
        self.detailItem.alarmTime = self.alarmTimePicker.date;
        *(self.detailItem.alarmSettings.repeat) = self.repeatSwitch.on;
        *(self.detailItem.alarmSettings.snooze) = self.snoozeSwitch.on;
        
        NSError *error = nil;
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        [self.view endEditing:YES];
    }

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                           target:self
                                                                                           action:@selector(done)];
   // self.scrollView.contentSize = CGSizeMake(320, 800);
    [self configureView];
}

- (void)viewDidUnload
{
    [self setRepeatSwitch:nil];
    [self setSnoozeSwitch:nil];
    [self setSoundsLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


@end
