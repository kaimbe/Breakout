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
#import "Level.h"
#import "Level0.h"

#import "RGBColor.h"
#import "Constants.h"

@implementation GameController

- (id)init
{
    _balls = [[NSMutableArray alloc] initWithObjects: nil];
    _paddles = [[NSMutableArray alloc] initWithObjects: nil];
    _blocks = [[NSMutableArray alloc] initWithObjects: nil];
    
    _currentScore = 0;
    
    //_theMediator = [Mediator sharedInstance];
    
    return self;
}

- (void)setUpGameController
{
    CGPoint ball_start_point = CGPointMake(_screen_size.width/2, _screen_size.height/2);
    
    RGBColor *blue = [[RGBColor alloc] initWithRed:255.0f green:118.0f blue:0.0f alpha:255.0f];
    RGBColor *lightGrey = [[RGBColor alloc] initWithRed:220.0f green:220.0f blue:220.0f alpha:255.0f];
    
    _currentBall = [[Ball alloc] initWithRadius: 0.2f*PTM_RATIO position:ball_start_point color:blue];
    [_theMediator setCurrentBall:_currentBall];
    [_balls addObject:_currentBall];
    [_theMediator setBalls:_balls];
    
    for (int i = 0; i < [_balls count]; i++) {
        Ball *temp = [_balls objectAtIndex:i];
        [_theMediator createBallAtPosition:[temp position] radius:[temp radius]];
    }
    
    _paddle = [[Paddle alloc] initWithSize:CGSizeMake(75.0f, 15.0f)];
    CGFloat paddle_height = 40.0;
    [_paddle setPosition:CGPointMake(_screen_size.width/2, paddle_height)];
    [_paddle setColor:lightGrey];
    [_theMediator setPaddle:_paddle];
    [_paddles addObject:_paddle];
    [_theMediator setPaddles:_paddles];
    
    for (int i = 0; i < [_paddles count]; i++) {
        Paddle *temp = [_paddles objectAtIndex:i];
        [_theMediator createPaddleAtPosition:[temp position] width:[temp size].width height:[temp size].height];
    }
    
    // test with level 0 for now
    _currentLevel = [[Level0 alloc] init];
    [_currentLevel setScreenSize:_screen_size];
    [_currentLevel setBlocks:_blocks];
    [_currentLevel setUpLevel];
    
    _currentNumberOfLives = [_currentLevel numberOfLives];
    
    [_theMediator setBlocks:_blocks];
    
    for (int i = 0; i < [_blocks count]; i++) {
        GameBlock *temp = [_blocks objectAtIndex:i];
        [_theMediator createBlockAtPosition:[temp position] width:[temp size].width height:[temp size].height];
    }
    
    NSLog(@"Game Controller Loaded");
}

- (void)removeBlockAtPosition:(CGPoint)position
{
    //NSLog(@"removeBlockAtPosition X:%f Y:%f", position.x, position.y);
    float xPos = roundf(position.x * 10) / 10;
    float yPos = roundf(position.y * 10) / 10;
    //NSLog(@"removeBlockAtPosition X:%f Y:%f", xPos, yPos);
    
    for (int i = 0; i < [_blocks count]; i++) {
        GameBlock *temp = [_blocks objectAtIndex:i];
        //NSLog(@"temp %f %f", temp.position.x, temp.position.y);
        if ([temp position].x == xPos && [temp position].y == yPos) {
            [_blocks removeObjectAtIndex:i];
            
            _currentScore += [temp scoreValue];
            NSLog(@"Score: %d", _currentScore);
        }
    }
}

- (void)looseLife
{
    if (_currentNumberOfLives != 0)
    {
        _currentNumberOfLives--;
        NSLog(@"Number of Lives Remaining: %d", _currentNumberOfLives);
    }
    else if (_currentNumberOfLives == 0)
    {
        //[self gameOver];
    }
}
/*
- (void)gameOver
{
    
}
*/
@end
