//
//  Mediator.mm
//  Breakout
//
//  Created by Matthew Newell on 2014-04-12.
//  Copyright (c) 2014 mjn874@mun.ca. All rights reserved.
//

#import "Mediator.h"

@implementation Mediator

- (id)initWithViewController:(UIViewController*)viewController gameController:(GameController*)gameController physicsController:(PhysicsController*)physicsController
{
    view = viewController;
    game = gameController;
    physics = physicsController;
    
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

@end
