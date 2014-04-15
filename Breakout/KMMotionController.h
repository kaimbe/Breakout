//
//  MotionController.h
//  Breakout
//
//  Created by Matthew Newell on 2014-04-06.
//  Copyright (c) 2014 mjn874@mun.ca. All rights reserved.
//
#import <CoreMotion/CoreMotion.h>

@class KMMediator;

@interface KMMotionController : NSObject {
    CGFloat avgX;
    KMMediator *theMediator;
}

@property (strong, nonatomic) CMMotionManager *motionManager;
@property CGFloat accX;

-(void)setUpMotionController;
-(void)updateAcceleration:(CMAcceleration)acceleration;

@end