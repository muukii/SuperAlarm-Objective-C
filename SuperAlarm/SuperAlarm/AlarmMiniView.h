//
//  AlarmMiniView.h
//  SuperAlarm
//
//  Created by むーきー on 2012/08/18.
//  Copyright (c) 2012年 むーきー. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlarmMiniView : UIView
@property int __sec,__min,__hour;
@property double ovalLineWidth,ovalX,ovalY,ovalWidth,ovalHeight;
@property UIImage* iconImage;
@property UIImageView *iconImageView;
@property (strong,nonatomic) id delegate;
@property NSString *str;
@property BOOL showIs;
@end

@protocol alarmMiniViewTouchUpDelegate <NSObject>
-(void)touchUp;
@end

