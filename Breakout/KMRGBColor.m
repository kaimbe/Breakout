//
//  RGBColor.m
//  Breakout
//
//  Created by Matthew Newell on 2014-04-12.
//  Copyright (c) 2014 mjn874@mun.ca. All rights reserved.
//

#import "KMRGBColor.h"
#import "KMConstants.h"

@implementation KMRGBColor

- (id)initWithRed:(GLfloat)red green:(GLfloat)green blue:(GLfloat)blue alpha:(GLfloat)alpha
{
    [self setRed:red/RGB_MAX];
    [self setGreen:green/RGB_MAX];
    [self setBlue:blue/RGB_MAX];
    [self setAlpha:alpha/RGB_MAX];
    return self;
}
@end
