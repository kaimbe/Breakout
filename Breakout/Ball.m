//
//  Ball.m
//  TemplateOpenGL
//
//  Created by Matthew Newell on 2014-03-11.
//  Copyright (c) 2014 Minglun Gong. All rights reserved.
//

#import "Ball.h"

@implementation Ball

- (id)initWithRadius:(CGFloat)radius position:(CGPoint)position color:(MyRGBColor*)color {
    [self setRadius: radius];
    [self setPosition: position];
    [self setColor: color];
    
    return self;
}

@end
