//
//  Mediator.h
//  Breakout
//
//  Created by Matthew Newell on 2014-04-12.
//  Copyright (c) 2014 mjn874@mun.ca. All rights reserved.
//

@class BreakoutViewController;
@class KMGameController;
@class KMPhysicsController;
@class KMMotionController;

@interface KMMediator : NSObject
{
    KMGameController *game;
    KMPhysicsController *physics;
    KMMotionController *motion;
}

@property BreakoutViewController *view;

@property NSMutableArray* balls;
@property NSMutableArray* paddles;
@property NSMutableArray* blocks;

@property CGSize screenSize;
@property CGFloat headerHeight;

@property CGFloat accX;

+ (id)sharedInstance;
- (id)init;
- (void)setUpGameController;
- (void)removeBlockAtPosition:(CGPoint)position;
- (void)setUpPhysicsController;
- (void)createBallAtPosition:(CGPoint)position radius:(CGFloat)radius;
- (void)createPaddleAtPosition:(CGPoint)position width:(CGFloat)width height:(CGFloat)height;
- (void)createBlockAtPosition:(CGPoint)position width:(CGFloat)width height:(CGFloat)height;
- (void)touchesBeganPhysics:(CGPoint)touchPoint;
- (void)touchesMovedPhysics:(CGPoint)touchPoint;
- (void)touchesEndedPhysics:(CGPoint)touchPoint;
- (void)looseLife;
- (void)setUpMotionController;
- (void)updateAccelerationX:(CGFloat)accelerationX;
- (void)updateLevel;
- (void)updateScore;
- (void)updateLives;
- (void)toggleTimer;
- (void)resetPhysics;

@end