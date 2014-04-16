//
//  GLDraw.m
//  Breakout
//
//  Created by Matthew Newell on 2014-04-06.
//  Copyright (c) 2014 mjn874@mun.ca. All rights reserved.
//
#import "KMGLDraw.h"
#import "KMConstants.h"

@implementation KMGLDraw

+ (void) GLDrawEllipseAtCenter:(CGPoint)center segments:(NSInteger)segments width:(CGFloat)width height:(CGFloat)height filled:(BOOL)filled {
    glPushMatrix();
    glTranslatef(center.x, center.y, 0.0);
    GLfloat vertices[segments*2];
    
    int count=0;
    for (GLfloat i = 0; i < 360.0f; i+=(360.0f/segments))
    {
        vertices[count++] = cosf(DEGREES_TO_RADIANS(i))*width;
        vertices[count++] = sinf(DEGREES_TO_RADIANS(i))*height;
    }

    glVertexPointer (2, GL_FLOAT , 0, vertices);
    //glTexCoordPointer(2, GL_FLOAT, 0, tex);
    glDrawArrays ((filled) ? GL_TRIANGLE_FAN : GL_LINE_LOOP, 0, segments);
    glPopMatrix();
}

+ (void) GLDrawCircleAtCenter:(CGPoint)center segments:(NSInteger)segments circleSize:(CGFloat)circleSize filled:(BOOL) filled {
    [self GLDrawEllipseAtCenter:center segments:segments width:circleSize height:circleSize filled:filled];
}

+ (void) GLDrawRectangleAtCenter:(CGPoint) center width:(GLfloat) width height:(GLfloat) height filled:(BOOL) filled {
    GLfloat neg_x = center.x - (width/2);
    GLfloat neg_y = center.y - (height/2);
    GLfloat pos_x = center.x + (width/2);
    GLfloat pos_y = center.y + (height/2);
    
    GLfloat center_x = center.x;
    GLfloat center_y = center.y;
    
    const GLfloat vertices[] = {
        center_x, center_y,
        neg_x, neg_y,
        neg_x, pos_y,
        pos_x, pos_y,
        pos_x, neg_y,
        neg_x, neg_y
    };
    
    const GLfloat tex[] = {
        0.5, 0.5,
        0.0, 0.0,
        0.0, 1.0,
        1.0, 1.0,
        1.0, 0.0,
        0.0, 0.0
    };
    
    glPushMatrix();
    //glTranslatef(center.x, center.y, 0.0);
    glVertexPointer (2, GL_FLOAT , 0, vertices);
    glTexCoordPointer(2, GL_FLOAT, 0, tex);
    
    glDrawArrays((filled) ? GL_TRIANGLE_FAN : GL_LINE_LOOP, 0, 6);
    glPopMatrix();
}

@end
