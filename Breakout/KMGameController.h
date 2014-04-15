//
//  GameController.h
//  Breakout
//
//  Created by Matthew Newell on 2014-04-10.
//  Copyright (c) 2014 mjn874@mun.ca. All rights reserved.
//

@class KMBall;
@class KMPaddle;
@class KMLevel;
@class KMMediator;

@interface KMGameController : NSObject
{
    KMLevel* _currentLevel;
    KMMediator* _theMediator;
}

@property CGSize screenSize;
@property CGFloat headerHeight;

@property NSInteger currentScore;
@property NSInteger currentNumberOfLives;
@property NSInteger currentLevelNumber;

- (void)setUpGameController;
- (void)removeBlockAtPosition:(CGPoint)position;
- (void)looseLife;
- (void)reset;

@end