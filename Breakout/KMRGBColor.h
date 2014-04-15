//
//  RGBColor.h
//  Breakout
//
//  Created by Matthew Newell on 2014-04-12.
//  Copyright (c) 2014 mjn874@mun.ca. All rights reserved.
//

@interface KMRGBColor : NSObject

@property GLfloat red;
@property GLfloat green;
@property GLfloat blue;
@property GLfloat alpha;

- (id)initWithRed:(GLfloat)red green:(GLfloat)green blue:(GLfloat)blue alpha:(GLfloat)alpha;

@end
