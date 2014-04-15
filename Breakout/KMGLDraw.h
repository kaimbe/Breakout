//
//  GLDraw.h
//  Breakout
//
//  Created by Matthew Newell on 2014-04-06.
//  Copyright (c) 2014 mjn874@mun.ca. All rights reserved.
//
#import <GLKit/GLKit.h>

@interface KMGLDraw:NSObject

+ (void) GLDrawEllipseAtCenter:(CGPoint)center segments:(NSInteger)segments width:(CGFloat)width height:(CGFloat)height filled:(BOOL)filled;
+ (void) GLDrawCircleAtCenter:(CGPoint)center segments:(NSInteger)segments circleSize:(CGFloat)circleSize filled:(BOOL) filled;
+ (void) GLDrawRectangleAtCenter:(CGPoint) center width:(GLfloat) width height:(GLfloat) height filled:(BOOL) filled;

@end