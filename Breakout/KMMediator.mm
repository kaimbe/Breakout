//
//  Mediator.mm
//  Breakout
//
//  Created by Matthew Newell on 2014-04-12.
//  Copyright (c) 2014 mjn874@mun.ca. All rights reserved.
//

#import "KMMediator.h"
#import "BreakoutViewController.h"
#import "KMGameController.h"
#import "KMPhysicsController.h"
#import "KMMotionController.h"

@implementation KMMediator

+ (id)sharedInstance
{
    static KMMediator *sharedInstance = nil;
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
        game = [[KMGameController alloc] init];
        physics = [[KMPhysicsController alloc] init];
        motion = [[KMMotionController alloc] init];
    }
    
    return self;
}

- (void)setUpGameController
{
    [game setScreenSize:_screenSize];
    [game setHeaderHeight:[_view headerHeight]];
    [game setUpGameController];
}

- (void)removeBlockAtPosition:(CGPoint)position
{
    [game removeBlockAtPosition:position];
}

- (void)setUpPhysicsController
{
    [physics setScreenSize:_screenSize];
    [physics setHeaderHeight:[_view headerHeight]];
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

- (void)touchesEndedPhysics:(CGPoint)touchPoint
{
    [physics touchesEndedPhysics:touchPoint];
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

- (void)updateLevel
{
    [[_view levelLabel] setText:[NSString stringWithFormat: @"Level: %d", [game currentLevelNumber]]];
}

- (void)updateScore
{
    [[_view scoreLabel] setText:[NSString stringWithFormat: @"Score: %d", [game currentScore]]];
}

- (void)updateLives
{
    [[_view lifeLabel] setText:[NSString stringWithFormat: @"Lives: %d", [game currentNumberOfLives]]];
}

- (void)toggleTimer
{
    [physics toggleTimer];
}

- (void)resetPhysics
{
    physics = [[KMPhysicsController alloc] init];
}

- (void)resetBallPosition
{
    [physics resetBallPosition];
}

@end
