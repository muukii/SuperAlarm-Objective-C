//
//  PlayAlarm.h
//  UltimateAlarm
//
//  Created by 寛 木村 on 12/07/24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AudioUnit/AudioUnit.h>

@interface PlayAlarm : NSObject <AVAudioPlayerDelegate>
{
        BOOL playing;
}
-(void)play;
-(void)stop;
@property BOOL playing;
@property (strong) AVAudioPlayer *player;
@end
