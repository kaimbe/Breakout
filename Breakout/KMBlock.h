//
//  Block.h
//  Breakout
//
//  Created by Matthew Newell on 2014-04-13.
//  Copyright (c) 2014 mjn874@mun.ca. All rights reserved.
//

#import "KMSprite.h"

@interface KMBlock : KMSprite

@property (nonatomic) CGSize size;
@property (nonatomic) NSInteger scoreValue;

- (id)initWithSize:(CGSize)size;

@end
