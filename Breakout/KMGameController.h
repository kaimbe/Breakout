//
//  KMGameController.h
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
    KMLevel *_currentLevel;
    KMMediator *_theMediator;
}

@property (nonatomic) CGSize screenSize;
@property (nonatomic) CGFloat headerHeight;

@property (nonatomic) NSInteger currentScore;
@property (nonatomic) NSInteger currentNumberOfLives;
@property (nonatomic) NSInteger currentLevelNumber;

- (void)setUpGameController;
- (void)removeBlockAtPosition:(CGPoint)position;
- (void)looseLife;
- (void)resetLevel;

@end