//
//  Ball.h
//  Breakout
//
//  Created by Matthew Newell on 2014-04-10.
//  Copyright (c) 2014 mjn874@mun.ca. All rights reserved.
//

#import "Sprite.h"

@interface Ball : Sprite

@property CGFloat radius;

- (id)initWithRadius:(CGFloat)radius position:(CGPoint)position color:(RGBColor*)color;

@end
