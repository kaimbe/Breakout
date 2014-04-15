//
//  Level0.m
//  Breakout
//
//  Created by Matthew Newell on 2014-04-12.
//  Copyright (c) 2014 mjn874@mun.ca. All rights reserved.
//

#import "KMLevel1.h"

#import "KMRGBColor.h"
#import "KMBlock.h"

@implementation KMLevel1

- (void)setUpLevel
{
    const int numberOfRows = 8;
    const int numberOfBlocksPerRow = 3;
    const CGFloat brickHeight = self.headerHeight * 0.75f;
    
    KMRGBColor *red = [[KMRGBColor alloc] initWithRed:255.0f green:0.0f blue:0.0f alpha:255.0f];
    KMRGBColor *orange = [[KMRGBColor alloc] initWithRed:255.0f green:150.0f blue:0.0f alpha:255.0f];
    KMRGBColor *yellow = [[KMRGBColor alloc] initWithRed:255.0f green:255.0f blue:0.0f alpha:255.0f];
    KMRGBColor *green = [[KMRGBColor alloc] initWithRed:0.0f green:255.0f blue:0.0f alpha:255.0f];
    KMRGBColor *lightGreen = [[KMRGBColor alloc] initWithRed:0.0f green:255.0f blue:150.0f alpha:255.0f];
    KMRGBColor *teal = [[KMRGBColor alloc] initWithRed:0.0f green:255.0f blue:255.0f alpha:255.0f];
    KMRGBColor *blue = [[KMRGBColor alloc] initWithRed:0.0f green:0.0f blue:255.0f alpha:255.0f];
    KMRGBColor *purple = [[KMRGBColor alloc] initWithRed:255.0f green:0.0f blue:255.0f alpha:255.0f];

    self.rowColors = @[red, lightGreen, yellow, blue, purple, orange, green, teal];
    
    self.numberOfLives = 5;
    
    for (int yPos = 0; yPos < numberOfRows; yPos++) {
        CGFloat yOffset = (self.screenSize.height - self.headerHeight) - (brickHeight/2 + yPos*brickHeight);
        KMRGBColor *rowColor = [[self rowColors] objectAtIndex:yPos];
        int rowScoreValue = powf(2.0f, numberOfRows - yPos);
        for(int xPos = 0; xPos < numberOfBlocksPerRow; xPos++) {
            KMBlock *currentBlock = [[KMBlock alloc] initWithSize:CGSizeMake(self.screenSize.width/numberOfBlocksPerRow, brickHeight)];
            [currentBlock setColor:rowColor];
            [currentBlock setScoreValue:rowScoreValue];
            CGFloat xOffset = ((self.screenSize.width/numberOfBlocksPerRow)/2)+(xPos*(self.screenSize.width/numberOfBlocksPerRow));
            [currentBlock setPosition:CGPointMake(xOffset, yOffset)];
            [self.blocks addObject:currentBlock];
        }
    }
}

@end
