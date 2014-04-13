//
//  Paddle.h
//  Breakout
//
//  Created by Matthew Newell on 2014-04-01.
//  Copyright (c) 2014 mjn874@mun.ca. All rights reserved.
//

@class RGBColor;

@interface Paddle : NSObject

@property CGPoint position;
@property RGBColor* color;
@property CGSize size;

- (id)initWithSize:(CGSize)size;

@end

