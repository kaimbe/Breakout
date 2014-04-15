//
//  GameController.mm
//  Breakout
//
//  Created by Matthew Newell on 2014-04-10.
//  Copyright (c) 2014 mjn874@mun.ca. All rights reserved.
//

#import "GameController.h"
#import "Mediator.h"

#import "Ball.h"
#import "Paddle.h"
#import "GameBlock.h"
//#import "Level.h"
#import "Level1.h"
#import "Level2.h"

#import "RGBColor.h"
#import "Constants.h"

@implementation GameController

- (void)setUpGameController
{
    _theMediator = [Mediator sharedInstance];
    
    _theMediator.balls = [[NSMutableArray alloc] init];
    _theMediator.paddles = [[NSMutableArray alloc] init];
    _theMediator.blocks = [[NSMutableArray alloc] init];
    
    _currentScore = 0;
    [_theMediator updateScore];
    
    CGPoint ball_start_point = CGPointMake(_screen_size.width/2, _screen_size.height/2);
    
    RGBColor *blue = [[RGBColor alloc] initWithRed:255.0f green:118.0f blue:0.0f alpha:255.0f];
    RGBColor *lightGrey = [[RGBColor alloc] initWithRed:220.0f green:220.0f blue:220.0f alpha:255.0f];
    
    Ball *aBall = [[Ball alloc] initWithRadius: 0.2f*PTM_RATIO position:ball_start_point color:blue];
    //[_theMediator setCurrentBall: aBall];
    [_theMediator.balls addObject: aBall];
    //[_theMediator setBalls:_balls];
    
    for (int i = 0; i < [_theMediator.balls count]; i++) {
        Ball *temp = [_theMediator.balls objectAtIndex:i];
        [_theMediator createBallAtPosition:[temp position] radius:[temp radius]];
    }
    
    Paddle *aPaddle = [[Paddle alloc] initWithSize:CGSizeMake(75.0f, 15.0f)];
    CGFloat paddle_height = 40.0;
    [aPaddle setPosition:CGPointMake(_screen_size.width/2, paddle_height)];
    [aPaddle setColor:lightGrey];
    //[_theMediator setPaddle:_paddle];
    [_theMediator.paddles addObject:aPaddle];
    //[_theMediator setPaddles:_paddles];
    
    for (int i = 0; i < [_theMediator.paddles count]; i++) {
        Paddle *temp = [_theMediator.paddles objectAtIndex:i];
        [_theMediator createPaddleAtPosition:[temp position] width:[temp size].width height:[temp size].height];
    }
    
    if (_currentLevelNumber == 0) {
        _currentLevelNumber = 1;
    }
    
    [_theMediator updateLevel];
    
    switch (_currentLevelNumber) {
        case 0:
            _currentLevel = [[Level1 alloc] init];
            break;
        case 1:
            _currentLevel = [[Level1 alloc] init];
            break;
        case 2:
            _currentLevel = [[Level2 alloc] init];
            break;
        default:
            _currentLevel = [[Level1 alloc] init];
            break;
    }
    
    [_currentLevel setScreenSize:_screen_size];
    [_currentLevel setHeaderHeight:[self headerHeight]];
    [_currentLevel setBlocks:_theMediator.blocks];
    [_currentLevel setUpLevel];
    
    _currentNumberOfLives = [_currentLevel numberOfLives];
    [_theMediator updateLives];
    
    for (int i = 0; i < [_theMediator.blocks count]; i++) {
        GameBlock *temp = [_theMediator.blocks objectAtIndex:i];
        [_theMediator createBlockAtPosition:[temp position] width:[temp size].width height:[temp size].height];
    }
    
    NSLog(@"Game Controller Loaded");
}

- (void)removeBlockAtPosition:(CGPoint)position
{
    float xPos = roundf(position.x * 10) / 10;
    float yPos = roundf(position.y * 10) / 10;
    
    for (int i = 0; i < [_theMediator.blocks count]; i++) {
        GameBlock *temp = [_theMediator.blocks objectAtIndex:i];
        //NSLog(@"%f %f", [temp position].x, [temp position].y);
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
        [self reset];
    }
}

- (void)looseLife
{
    if (_currentNumberOfLives <= 1)
    {
        [self setCurrentLevelNumber:1];
        [self reset];
    }
    else if (_currentNumberOfLives > 1)
    {
        _currentNumberOfLives--;
        [_theMediator updateLives];
        NSLog(@"Number of Lives Remaining: %d", _currentNumberOfLives);
    }
}

- (void)reset
{
    [_theMediator toggleTimer];
    [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:NO];
}

- (void)timerFireMethod:(NSTimer *)timer
{
    [_theMediator resetPhysics];
    [_theMediator setUpPhysicsController];
    [self setUpGameController];
    //[_theMediator toggleTimer];
}

@end
