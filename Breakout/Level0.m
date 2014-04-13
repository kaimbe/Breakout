//
//  Level0.m
//  Breakout
//
//  Created by Matthew Newell on 2014-04-12.
//  Copyright (c) 2014 mjn874@mun.ca. All rights reserved.
//

#import "Level0.h"

#import "MyRGBColor.h"
#import "MyBlock.h"

@implementation Level0

- (void)setUpLevel
{
    const int numberOfRows = 8;
    const int numberOfBlocksPerRow = 4;
    const CGFloat brickHeight = 15.0f;
    
    MyRGBColor *red = [[MyRGBColor alloc] initWithRed:255.0f green:0.0f blue:0.0f alpha:255.0f];
    MyRGBColor *orange = [[MyRGBColor alloc] initWithRed:255.0f green:150.0f blue:0.0f alpha:255.0f];
    MyRGBColor *yellow = [[MyRGBColor alloc] initWithRed:255.0f green:255.0f blue:0.0f alpha:255.0f];
    MyRGBColor *green = [[MyRGBColor alloc] initWithRed:0.0f green:255.0f blue:0.0f alpha:255.0f];
    MyRGBColor *lightGreen = [[MyRGBColor alloc] initWithRed:0.0f green:255.0f blue:150.0f alpha:255.0f];
    MyRGBColor *teal = [[MyRGBColor alloc] initWithRed:0.0f green:255.0f blue:255.0f alpha:255.0f];
    MyRGBColor *blue = [[MyRGBColor alloc] initWithRed:0.0f green:0.0f blue:255.0f alpha:255.0f];
    MyRGBColor *purple = [[MyRGBColor alloc] initWithRed:255.0f green:0.0f blue:255.0f alpha:255.0f];

    self.rowColors = @[red, lightGreen, yellow, blue, purple, orange, green, teal];
    
    self.numberOfLives = 3;
    
    for (int yPos = 0; yPos < numberOfRows; yPos++) {
        CGFloat yOffset = self.screenSize.height - (brickHeight/2 + yPos*brickHeight);
        MyRGBColor *rowColor = [[self rowColors] objectAtIndex:yPos];
        int rowScoreValue = powf(2.0f, numberOfRows - yPos);
        for(int xPos = 0; xPos < numberOfBlocksPerRow; xPos++) {
            MyBlock *currentBlock = [[MyBlock alloc] initWithSize:CGSizeMake(self.screenSize.width/numberOfBlocksPerRow, brickHeight)];
            [currentBlock setColor:rowColor];
            [currentBlock setScoreValue:rowScoreValue];
            CGFloat xOffset = ((self.screenSize.width/numberOfBlocksPerRow)/2)+(xPos*(self.screenSize.width/numberOfBlocksPerRow));
            [currentBlock setPosition:CGPointMake(xOffset, yOffset)];
            [self.blocks addObject:currentBlock];
        }
    }
}

@end
