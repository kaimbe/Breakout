//
//  Level.h
//  Breakout
//
//  Created by Matthew Newell on 2014-04-12.
//  Copyright (c) 2014 mjn874@mun.ca. All rights reserved.
//

@interface Level : NSObject

@property NSMutableArray* blocks;
@property NSArray* rowColors;
@property CGSize screenSize;
@property NSInteger numberOfLives;

- (void)setUpLevel;

@end
