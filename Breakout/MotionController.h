//
//  MotionController.h
//  Breakout
//
//  Created by Matthew Newell on 2014-04-06.
//  Copyright (c) 2014 mjn874@mun.ca. All rights reserved.
//
#import <CoreMotion/CoreMotion.h>

@class Mediator;

@interface MotionController : NSObject {
    CGFloat avgX;
}

@property (strong, nonatomic) CMMotionManager *motionManager;
@property CGFloat accX;
@property Mediator *theMediator;

-(void)setUpMotionController;
-(void)updateAcceleration:(CMAcceleration)acceleration;

@end