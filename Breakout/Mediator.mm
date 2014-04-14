//
//  Mediator.mm
//  Breakout
//
//  Created by Matthew Newell on 2014-04-12.
//  Copyright (c) 2014 mjn874@mun.ca. All rights reserved.
//

#import "Mediator.h"
#import "ViewController.h"
#import "GameController.h"
#import "PhysicsController.h"
#import "MotionController.h"

@implementation Mediator

+ (id)sharedInstance
{
    static Mediator *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init
{
    if (self = [super init])
    {
        game = [[GameController alloc] init];
        physics = [[PhysicsController alloc] init];
        motion = [[MotionController alloc] init];
    }
    
    return self;
}

- (void)setUpGameController
{
    [game setScreen_size:_screenSize];
    [game setUpGameController];
}
- (void)removeBlockAtPosition:(CGPoint)position
{
    [game removeBlockAtPosition:position];
}

- (void)setUpPhysicsController
{
    [physics setScreenSize:_screenSize];
    [physics setUpPhysicsController];
}

- (void)createBallAtPosition:(CGPoint)position radius:(CGFloat)radius
{
    [physics createBallAtPosition:position radius:radius];
}

- (void)createPaddleAtPosition:(CGPoint)position width:(CGFloat)width height:(CGFloat)height
{
    [physics createPaddleAtPosition:position width:width height:height];
}

- (void)createBlockAtPosition:(CGPoint)position width:(CGFloat)width height:(CGFloat)height
{
    [physics createBlockAtPosition:position width:width height:height];
}

- (void)touchesBeganPhysics:(CGPoint)touchPoint
{
    [physics touchesBeganPhysics:touchPoint];
}

- (void)touchesMovedPhysics:(CGPoint)touchPoint
{
    [physics touchesMovedPhysics:touchPoint];
}

- (void)looseLife
{
    [game looseLife];
}

- (void)setUpMotionController
{
    [motion setUpMotionController];
}

- (void)updateAccelerationX:(CGFloat)accelerationX
{
    _accX = accelerationX;
}

- (void)updateScore
{
    [[_view scoreLabel] setText:[NSString stringWithFormat: @"%d", [game currentScore]]];
}

- (void)updateLives
{
    [[_view lifeLabel] setText:[NSString stringWithFormat: @"%d", [game currentNumberOfLives]]];
}

@end
