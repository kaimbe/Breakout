//
//  Level.h
//  Breakout
//
//  Created by Matthew Newell on 2014-04-12.
//  Copyright (c) 2014 mjn874@mun.ca. All rights reserved.
//

@interface KMLevel : NSObject

@property (strong, nonatomic) NSMutableArray* blocks;
@property (strong, nonatomic) NSArray* rowColors;
@property (nonatomic) CGSize screenSize;
@property (nonatomic) NSInteger numberOfLives;
@property (nonatomic) CGFloat headerHeight;

- (void)setUpLevel;

@end
