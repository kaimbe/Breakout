//
//  Mediator.h
//  Breakout
//
//  Created by Matthew Newell on 2014-04-12.
//  Copyright (c) 2014 mjn874@mun.ca. All rights reserved.
//

@class ViewController;
@class GameController;
@class PhysicsController;
@class MotionController;

@class Ball;
@class Paddle;

@interface Mediator : NSObject
{
    GameController *game;
    PhysicsController *physics;
    MotionController *motion;
}

@property ViewController *view;

@property NSMutableArray* balls;
@property NSMutableArray* paddles;
@property NSMutableArray* blocks;

@property CGSize screenSize;

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