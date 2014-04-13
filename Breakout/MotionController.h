//
//  MotionController.h
//  Breakout
//
//  Created by Matthew Newell on 2014-04-06.
//  Copyright (c) 2014 mjn874@mun.ca. All rights reserved.
//
#import <CoreMotion/CoreMotion.h>

@interface MotionController : NSObject {
    float avgX;
}

@property (strong, nonatomic) CMMotionManager *motionManager;
@property float accX;
-(void)setUpMotionController;
-(void)updateAcceleration:(CMAcceleration)acceleration;

@end