//
//  Mediator.h
//  Breakout
//
//  Created by Matthew Newell on 2014-04-12.
//  Copyright (c) 2014 mjn874@mun.ca. All rights reserved.
//

@class GameController;
@class PhysicsController;
@class MotionController;

@class Ball;
@class Paddle;

@interface Mediator : NSObject
{
    UIViewController *view;
    GameController *game;
    PhysicsController *physics;
    MotionController *motion;
}

@property NSMutableArray* balls;
@property NSMutableArray* paddles;
@property NSMutableArray* blocks;

@property CGSize screenSize;
@property Ball* currentBall;
@property Paddle* paddle;

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
- (void)looseLife;
- (void)setUpMotionController;
- (void)updateAccelerationX:(CGFloat)accelerationX;

@end