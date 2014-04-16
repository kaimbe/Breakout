//
//  KMGameController.mm
//  Breakout
//
//  Created by Matthew Newell on 2014-04-10.
//  Copyright (c) 2014 mjn874@mun.ca. All rights reserved.
//

#import "KMGameController.h"
#import "KMMediator.h"

#import "KMBall.h"
#import "KMPaddle.h"
#import "KMBlock.h"
#import "KMLevel1.h"
#import "KMLevel2.h"

#import "KMRGBColor.h"
#import "KMConstants.h"

@implementation KMGameController

- (void)setUpGameController
{
    // get the mediator and initialize the arrays
    _theMediator = [KMMediator sharedInstance];
    
    _theMediator.balls = [[NSMutableArray alloc] init];
    _theMediator.paddles = [[NSMutableArray alloc] init];
    _theMediator.blocks = [[NSMutableArray alloc] init];
    
    // reset score to 0
    _currentScore = 0;
    [_theMediator updateScore];
    
    // set the ball at the center of the screen
    CGPoint ball_start_point = CGPointMake(_screenSize.width/2, _screenSize.height/2);
    
    // define colors
    KMRGBColor *blue = [[KMRGBColor alloc] initWithRed:70.0f green:70.0f blue:255.0f alpha:255.0f];
    KMRGBColor *lightGrey = [[KMRGBColor alloc] initWithRed:220.0f green:220.0f blue:220.0f alpha:255.0f];
    
    // create a ball
    KMBall *aBall = [[KMBall alloc] initWithRadius: (_headerHeight * 0.5f) position:ball_start_point color:blue];
    [_theMediator.balls addObject: aBall];
    
    // create balls in the physics world
    for (int i = 0; i < [_theMediator.balls count]; i++) {
        KMBall *temp = [_theMediator.balls objectAtIndex:i];
        [_theMediator createBallAtPosition:[temp position] radius:[temp radius]];
    }
    
    // create a paddle
    KMPaddle *aPaddle = [[KMPaddle alloc] initWithSize:CGSizeMake(_headerHeight * 3, _headerHeight * 0.8f)];
    [aPaddle setPosition:CGPointMake(_screenSize.width/2, _headerHeight * 1.7)];
    [aPaddle setColor:lightGrey];
    [_theMediator.paddles addObject:aPaddle];
    
    // create paddles in the physics world
    for (int i = 0; i < [_theMediator.paddles count]; i++) {
        KMPaddle *temp = [_theMediator.paddles objectAtIndex:i];
        [_theMediator createPaddleAtPosition:[temp position] width:[temp size].width height:[temp size].height];
    }
    
    // set the correct level. advance to a new level after a screen is cleared
    if (_currentLevelNumber == 0) {
        _currentLevelNumber = 1;
    }
    
    switch (_currentLevelNumber) {
        case 0:
            _currentLevel = [[KMLevel1 alloc] init];
            break;
        case 1:
            _currentLevel = [[KMLevel1 alloc] init];
            break;
        case 2:
            _currentLevel = [[KMLevel2 alloc] init];
            break;
        default:
            _currentLevel = [[KMLevel1 alloc] init];
            _currentLevelNumber = 1;
            break;
    }
    
    [_theMediator updateLevel];
    
    // set up the level
    [_currentLevel setScreenSize:_screenSize];
    [_currentLevel setHeaderHeight:[self headerHeight]];
    [_currentLevel setBlocks:_theMediator.blocks];
    [_currentLevel setUpLevel];
    
    // get and set the number of lives. number of lives are defined for each level
    _currentNumberOfLives = [_currentLevel numberOfLives];
    [_theMediator updateLives];
    
    // create the blocks in the physics world
    for (int i = 0; i < [_theMediator.blocks count]; i++) {
        KMBlock *temp = [_theMediator.blocks objectAtIndex:i];
        [_theMediator createBlockAtPosition:[temp position] width:[temp size].width height:[temp size].height];
    }
    
    NSLog(@"Game Controller Loaded");
}

// remove a block from the graphics world
- (void)removeBlockAtPosition:(CGPoint)position
{
    float xPos = roundf(position.x * 10) / 10;
    float yPos = roundf(position.y * 10) / 10;
    
    for (int i = 0; i < [_theMediator.blocks count]; i++) {
        KMBlock *temp = [_theMediator.blocks objectAtIndex:i];
        float tempXPos = roundf([temp position].x * 10) / 10;
        float tempYPos = roundf([temp position].y * 10) /10;
        
        if (tempXPos == xPos && tempYPos == yPos) {
            [_theMediator.blocks removeObjectAtIndex:i];
            _currentScore += [temp scoreValue];
            [_theMediator updateScore];
            NSLog(@"Score: %d", _currentScore);
        }
    }
    
    // complete a level
    if ([_theMediator.blocks count] == 0) {
        _currentLevelNumber++;
        [self resetLevel];
    }
}

// loose a life
- (void)looseLife
{
    if (_currentNumberOfLives <= 1)
    {
        [self setCurrentLevelNumber: 1];
        [self resetLevel];
    }
    else if (_currentNumberOfLives > 1)
    {
        _currentNumberOfLives--;
        [_theMediator updateLives];
        NSLog(@"Number of Lives Remaining: %d", _currentNumberOfLives);
        
        // pause the physics and create a delay
        [_theMediator toggleTimer];
        [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(fireLooseLifeDelay:) userInfo:nil repeats:NO];
    }
}

// reset the level
- (void)resetLevel
{
    [_theMediator toggleTimer];
    [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(fireLevelDelay:) userInfo:nil repeats:NO];
}

// method that gets fired by timer. resets physics and resets the game controller
- (void)fireLevelDelay:(NSTimer *)timer
{
    [_theMediator resetPhysics];
    [_theMediator setUpPhysicsController];
    [self setUpGameController];
}

// method that gets fired by timer. resets the balls location to the center of the screen
- (void)fireLooseLifeDelay:(NSTimer *)timer
{
    [_theMediator toggleTimer];
    [_theMediator resetBallPosition];
}

@end
