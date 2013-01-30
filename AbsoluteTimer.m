//
//  AbsoluteTimer.m
//  Analyzer
//
//  Created by Skylar Rudolph on 1/18/13.
//  Copyright (c) 2013 Temple. All rights reserved.
//

#define NANO 1000000000;

#import "AbsoluteTimer.h"

@implementation AbsoluteTimer

// When we initialize we will find out the mach_timebase_info. This will change depending on platform being run on. 
-(id)init {
    self = [super init];
    mach_timebase_info(&timeBase);
    return self;
}

// should be started at the proper time and is independent of initialization. 
-(void)setInitialTime {
    if(initialTime){
        NSLog(@"initialTime is already set for this object.");
        return;
    }
    initialTime = mach_absolute_time();
    initialTime = [self convertWithTimeBase:initialTime];
}

// get initial time
-(uint64_t)getInitialTime {
    return initialTime;
}

// This will allow us to get the most accurate time from mach kernel.
-(uint64_t)getTime{
    return mach_absolute_time();
}

// This will give us a lap time in nanoseconds from initial time;
-(uint64_t)getLap{
    if(!initialTime){
        NSLog(@"initialTime had not been set!");
        return 0;
    }
    uint64_t duration = mach_absolute_time() - initialTime;
    duration = [self convertWithTimeBase:duration];
    return duration;
}

// Depending on the ratio for timebase, we need to convert this.
-(uint64_t)convertWithTimeBase:(uint64_t)time{
    if(time){
        time *= timeBase.numer;
        time /= timeBase.denom;
        return time;
    }
    else {
        NSLog(@"time duration parameter is null.");
        return 0;
    }
}

// Utility to convert to seconds. Note: Must be converted with timeBase.
-(NSNumber*)elapsedTimeInSeconds:(uint64_t)duration {
    return [NSNumber numberWithDouble:(double)duration/1000000000];
}

@end
