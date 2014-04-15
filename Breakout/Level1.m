//
//  Level0.m
//  Breakout
//
//  Created by Matthew Newell on 2014-04-12.
//  Copyright (c) 2014 mjn874@mun.ca. All rights reserved.
//

#import "Level1.h"

#import "RGBColor.h"
#import "GameBlock.h"

@implementation Level1

- (void)setUpLevel
{
    const int numberOfRows = 8;
    const int numberOfBlocksPerRow = 3;
    const CGFloat brickHeight = self.headerHeight * 0.75f;
    
    RGBColor *red = [[RGBColor alloc] initWithRed:255.0f green:0.0f blue:0.0f alpha:255.0f];
    RGBColor *orange = [[RGBColor alloc] initWithRed:255.0f green:150.0f blue:0.0f alpha:255.0f];
    RGBColor *yellow = [[RGBColor alloc] initWithRed:255.0f green:255.0f blue:0.0f alpha:255.0f];
    RGBColor *green = [[RGBColor alloc] initWithRed:0.0f green:255.0f blue:0.0f alpha:255.0f];
    RGBColor *lightGreen = [[RGBColor alloc] initWithRed:0.0f green:255.0f blue:150.0f alpha:255.0f];
    RGBColor *teal = [[RGBColor alloc] initWithRed:0.0f green:255.0f blue:255.0f alpha:255.0f];
    RGBColor *blue = [[RGBColor alloc] initWithRed:0.0f green:0.0f blue:255.0f alpha:255.0f];
    RGBColor *purple = [[RGBColor alloc] initWithRed:255.0f green:0.0f blue:255.0f alpha:255.0f];

    self.rowColors = @[red, lightGreen, yellow, blue, purple, orange, green, teal];
    
    self.numberOfLives = 5;
    
    for (int yPos = 0; yPos < numberOfRows; yPos++) {
        CGFloat yOffset = (self.screenSize.height - self.headerHeight) - (brickHeight/2 + yPos*brickHeight);
        RGBColor *rowColor = [[self rowColors] objectAtIndex:yPos];
        int rowScoreValue = powf(2.0f, numberOfRows - yPos);
        for(int xPos = 0; xPos < numberOfBlocksPerRow; xPos++) {
            GameBlock *currentBlock = [[GameBlock alloc] initWithSize:CGSizeMake(self.screenSize.width/numberOfBlocksPerRow, brickHeight)];
            [currentBlock setColor:rowColor];
            [currentBlock setScoreValue:rowScoreValue];
            CGFloat xOffset = ((self.screenSize.width/numberOfBlocksPerRow)/2)+(xPos*(self.screenSize.width/numberOfBlocksPerRow));
            [currentBlock setPosition:CGPointMake(xOffset, yOffset)];
            [self.blocks addObject:currentBlock];
        }
    }
}

@end
