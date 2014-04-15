//
//  MotionController.m
//  Breakout
//
//  Created by Matthew Newell on 2014-04-06.
//  Copyright (c) 2014 mjn874@mun.ca. All rights reserved.
//

#import "KMMotionController.h"
#import "KMMediator.h"

@implementation KMMotionController

-(void)setUpMotionController
{
    self.motionManager = [[CMMotionManager alloc] init];
    self.motionManager.accelerometerUpdateInterval = .2;
    [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue]
                                             withHandler:^(CMAccelerometerData  *accelerometerData, NSError *error) {
                                                 [self updateAcceleration:accelerometerData.acceleration];
                                                 if(error){ NSLog(@"%@", error); }
                                             }];
    
    theMediator = [KMMediator sharedInstance];
    NSLog(@"Motion Controller Loaded");
}

-(void)updateAcceleration:(CMAcceleration)acceleration
{
    // filter
    float alpha = 0.1;
    avgX = alpha*acceleration.x + (1-alpha)*avgX;
    
    _accX = acceleration.x - avgX;
    //_accX = acceleration.x;
    
    // raw
    //NSLog(@"%f", acceleration.x);
    
    // filtered
     //NSLog(@"%f", _accX);
    
    [theMediator updateAccelerationX:_accX];
}

@end
