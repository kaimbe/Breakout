//
//  KMBall.m
//  Breakout
//
//  Created by Matthew Newell on 2014-03-11.
//  Copyright (c) 2014 Minglun Gong. All rights reserved.
//

#import "KMBall.h"

@implementation KMBall

- (id)initWithRadius:(CGFloat)radius position:(CGPoint)position color:(KMRGBColor*)color {
    [self setRadius: radius];
    [self setPosition: position];
    [self setColor: color];
    
    return self;
}

@end
