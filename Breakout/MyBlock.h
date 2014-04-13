//
//  Block.h
//  Breakout
//
//  Created by Matthew Newell on 2014-04-13.
//  Copyright (c) 2014 mjn874@mun.ca. All rights reserved.
//

@class RGBColor;

@interface MyBlock : NSObject

@property CGPoint position;
@property RGBColor* color;
@property CGSize size;
@property NSInteger scoreValue;

- (id)initWithSize:(CGSize)size;

@end
