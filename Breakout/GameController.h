//
//  GameController.h
//  Breakout
//
//  Created by Matthew Newell on 2014-04-10.
//  Copyright (c) 2014 mjn874@mun.ca. All rights reserved.
//

@class Ball;
@class Paddle;
@class Level;
@class Mediator;

@interface GameController : NSObject

@property Level* currentLevel;
//@property Ball *currentBall;
//@property Paddle *paddle;

@property Mediator *theMediator;

//@property NSMutableArray* balls;
//@property NSMutableArray* paddles;
//@property NSMutableArray* blocks;

@property CGSize screen_size;

@property NSInteger currentScore;
@property NSInteger currentNumberOfLives;
@property NSInteger currentLevelNumber;

@property CGFloat headerHeight;

- (void)setUpGameController;
- (void)removeBlockAtPosition:(CGPoint)position;
- (void)looseLife;
- (void)reset;

@end