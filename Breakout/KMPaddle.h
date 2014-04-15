//
//  Paddle.h
//  Breakout
//
//  Created by Matthew Newell on 2014-04-01.
//  Copyright (c) 2014 mjn874@mun.ca. All rights reserved.
//

#import "KMSprite.h"

@interface KMPaddle : KMSprite

@property (nonatomic) CGSize size;

- (id)initWithSize:(CGSize)size;

@end

