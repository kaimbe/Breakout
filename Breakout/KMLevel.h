//
//  Level.h
//  Breakout
//
//  Created by Matthew Newell on 2014-04-12.
//  Copyright (c) 2014 mjn874@mun.ca. All rights reserved.
//

@interface KMLevel : NSObject

@property NSMutableArray* blocks;
@property NSArray* rowColors;
@property CGSize screenSize;
@property NSInteger numberOfLives;
@property CGFloat headerHeight;

- (void)setUpLevel;

@end
