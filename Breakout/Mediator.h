//
//  Mediator.h
//  Breakout
//
//  Created by Matthew Newell on 2014-04-12.
//  Copyright (c) 2014 mjn874@mun.ca. All rights reserved.
//

#import "GameController.h"
#import "PhysicsController.h"
#import "ViewController.h"

@class Ball;
@class Paddle;

@interface Mediator : NSObject
{
    UIViewController *view;
    GameController *game;
    PhysicsController *physics;
}

@property NSMutableArray* balls;
@property NSMutableArray* paddles;
@property NSMutableArray* blocks;

@property CGSize screenSize;
@property Ball* currentBall;
@property Paddle* paddle;

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

@end