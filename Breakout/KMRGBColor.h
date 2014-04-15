//
//  RGBColor.h
//  Breakout
//
//  Created by Matthew Newell on 2014-04-12.
//  Copyright (c) 2014 mjn874@mun.ca. All rights reserved.
//

@interface KMRGBColor : NSObject

@property (nonatomic) GLfloat red;
@property (nonatomic) GLfloat green;
@property (nonatomic) GLfloat blue;
@property (nonatomic) GLfloat alpha;

- (id)initWithRed:(GLfloat)red green:(GLfloat)green blue:(GLfloat)blue alpha:(GLfloat)alpha;

@end
