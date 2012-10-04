//
//  PlayAlarm.m
//  UltimateAlarm
//
//  Created by 寛 木村 on 12/07/24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PlayAlarm.h"

@implementation PlayAlarm
@synthesize player;
@synthesize playing;

-(void)play
{
   
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"bell" ofType:@"m4a"];
    NSLog(@"%@",path);
    NSURL *fileURL = [NSURL fileURLWithPath:path];
     NSLog(@"%@",fileURL);
    NSError * error = nil;
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:&error];
    NSLog(@"%@",player);
    if(error){
        NSLog(@"error");
        return;
    }
    
    player.delegate = self;
    if([player play])
    {
        
        NSLog(@"play");
    }
        playing = YES;
}
-(void)stop{
    [player stop];
    playing = NO;
}
-(void) audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    
   playing = NO;
    NSLog(@"played  %d",playing);
}

@end
