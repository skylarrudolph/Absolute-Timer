//
//  AbsoluteTimer.h
//  Analyzer
//
//  Created by Skylar Rudolph on 1/18/13.
//  Copyright (c) 2013 Temple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <mach/mach_time.h>
@interface AbsoluteTimer : NSObject
{
//    This is a custom struct that converts the current time by a multiplier with a numerator and a denominator. 
    mach_timebase_info_data_t timeBase;
//    Our base initial time.
    uint64_t initialTime;
}

-(id)init;
-(void)setInitialTime;
-(uint64_t)convertWithTimeBase: (uint64_t) time;
-(uint64_t)getInitialTime;
-(uint64_t)getLap;
-(NSNumber*)elapsedTimeInSeconds: (uint64_t)duration;

@end
